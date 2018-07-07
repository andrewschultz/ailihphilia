#
# tcount.py
#
# offers basic metrics on random table size
#

from datetime import datetime
from shutil import copyfile
from collections import defaultdict
import math
import os
import re
import i7
import sys

def print_geo_mean(a):
    c = []
    try:
        c = [int(x) for x in a.split(",")]
    except:
        sys.exit("CSV in cmd line must separate numbers.")
    lo = 0
    for x in c: lo += math.log(x)
    lo /= len(c)
    sys.exit("Geometric mean of {:s} is {:.4f}".format(a, math.exp(lo)))


# options
biggest_first = True
verbose = False
zap_highest = 0
zap_lowest = 0
update_log_file = False
test_log = False
write_backup = False

# variables
table_sizes = defaultdict(int)

in_table = False
get_header = False

def usage():
    print("========COMMANDS (with or without dash)========")
    print("-v/-nv = verbose on/off")
    print("-ba/-b = write backup")
    print("-lt/-tl = test log")
    print("-bf/-fb = biggest first. -1b/-b1 = turns this off.")
    print("zh/h = zap highest (#), nzh disables. nzl/zl/l does same for lowest.")
    print()
    print("In a pinch you can use CSV to get a geometric mean of that.")
    print("-u = update log file = main option. -nu/-un = don't update")
    exit()

argcount = 1

while argcount < len(sys.argv):
    arg = sys.argv[argcount]
    if arg[0] == '-': arg = arg[1:]
    if ',' in arg: print_geo_mean(arg)
    elif arg == 'v': verbose = True
    elif arg == 'nv': verbose = False
    elif arg == 'ba' or arg == 'b': write_backup = True
    elif arg == 'tl' or arg == 'lt': test_log = True
    elif arg == 'bf' or arg == 'fb': biggest_first = True
    elif arg == 'bl' or arg == 'lb' or arg == 'b1' or arg == '1b': biggest_first = False
    elif arg == 'u': update_log_file = True
    elif arg == 'un' or arg == 'nu': update_log_file = False
    elif arg[:2] == 'zh': zap_highest = int(arg[2:])
    elif arg[0] == 'h': zap_highest = int(arg[1:])
    elif arg == 'nzh': zap_highest = 0
    elif arg[:2] == 'zl': zap_lowest = int(arg[2:])
    elif arg[0] == 'l': zap_lowest = int(arg[1:])
    elif arg == 'nzl': zap_lowest = 0
    elif arg == '?': usage()
    else:
        print("Unknown command", sys.argv[argcount], "usage below:")
        usage()
    argcount += 1

with open(i7.tafi('ai')) as file:
    for (line_count, line) in enumerate(file, 1):
        if get_header:
            get_header = False
            if line.startswith('tabnam'): in_table = False
            continue
        if line.startswith('table') and '\t' not in line:
            # print(line_count, line)
            in_table = True
            get_header = True
            table_start = line_count + 1
            table_name = re.sub(" *\[.*", "", line.lower().strip())
        if in_table and not line.strip():
            in_table = False
            table_sizes[table_name] = line_count - table_start - 1
            if verbose: print(table_name, table_sizes[table_name], "rows")

i7.go_proj('ai')

amean = gmean = gmeanp = 0

data_file = "tcount.txt"
log_file = "tcount-log.txt"
log_back = "tcount-log-backup.txt"
log_test_file = "tcount-log-test.txt"

if os.path.exists(data_file):
    with open(data_file) as file:
        for line in file:
            ll = line.lower().strip()
            if ll.startswith(';'): break
            if ll.startswith('#'): continue
            if ll.startswith('-'):
                l2 = ll[1:]
                if l2 in table_sizes.keys():
                    if verbose: print(l2, "discounted.")
                    table_sizes.pop(l2)
                else:
                    print("Tried to zap <{:s}>, but it's not a valid table key in tcount.txt.".format(l2))
else:
    print("No", data_file, "so we won't do anything special.")

if zap_lowest:
    print("Zapping", zap_lowest, "lowest values.")
    for i in range (0, zap_lowest):
        q = min(table_sizes, key=table_sizes.get)
        table_sizes.pop(q)

if zap_highest:
    print("Zapping", zap_highest, "highest values.")
    for i in range (0, zap_highest):
        q = max(table_sizes, key=table_sizes.get)
        table_sizes.pop(q)

tsize = len(table_sizes.keys())

for x in table_sizes.keys():
    amean += table_sizes[x]
    gmean += math.log(table_sizes[x])
    gmeanp += math.log(table_sizes[x]+1)

count = 0

amean /= tsize
gmean /= tsize
gmeanp /= tsize

gmean = math.exp(gmean)
gmeanp = math.exp(gmeanp)

for x in sorted(table_sizes, key=table_sizes.get, reverse=biggest_first):
    gmtweak = gmean * ((table_sizes[x] + 1) / table_sizes[x]) ** (1/tsize)
    count += 1
    print(count, x, table_sizes[x], gmtweak)

print("{:4f} arithmetic mean".format(amean))
print("{:4f} geometric mean".format(gmean))
print("{:4f} geometric mean (1 added each), delta={:4f}".format(gmeanp, gmeanp-gmean))

if update_log_file:
    last_table_line = ''
    last_num_line = ''
    print("Looking if we can/should update...")
    my_ary = [table_sizes[x] for x in sorted(table_sizes.keys())]
    if os.path.exists(log_file) and os.stat(log_file).st_size:
        out_file = log_test_file if test_log else log_file
        if write_backup:
            copyfile(log_file, log_back)
            print("Copied to backup", log_back)
        table_check = defaultdict(bool)
        changed_array = False
        sts = sorted(table_sizes.keys())
        for x in sts: table_check[x] = False
        with open(log_file) as file:
            for (line_count, line) in enumerate(file, 1):
                l = line.lower().strip()
                if l.startswith("#table"):
                    last_table_line = l[1:]
                    continue
                if l and re.search("^[,0-9]+$", l):
                    last_num_line = l
                    continue
        for x in last_table_line.split(','):
            if x not in table_check.keys(): changed_array = True
            table_check[x] = True
        for x in table_check.keys():
            if not table_check[x]: changed_array = True
        old_vals = [int(q) for q in last_num_line.split(",")]
        got_dif = False
        if not changed_array:
            for j in range(0, len(my_ary)):
                if my_ary[j] != old_vals[j]: got_dif = True
        if changed_array or got_dif:
            flog = open(out_file, "a")
            flog.write("#{:s}\n".format(str(datetime.now())))
            if changed_array: flog.write('#' + ','.join(sorted(sts)) + "\n")
            if got_dif:
                flog.write('#delta: ' + ','.join([str(my_ary[q] - old_vals[q]) for q in range(0, len(old_vals))]) + "\n")
            flog.write(','.join([str(x) for x in my_ary]) + "\n")
            print("Updated", log_file)
            flog.close()
        else:
            print("No change, nothing new written.")
    else:
        flog = open(log_file, "w")
        flog.write("#{:s}\n".format(str(datetime.now())))
        flog.write("#")
        flog.write(','.join(sorted(table_sizes.keys())))
        flog.write("\n")
        flog.write("#no changes to start\n{:s}\n".format(','.join([str(x) for x in my_ary]) + "\n"))
        print("Created", log_file)