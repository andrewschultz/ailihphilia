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

# options
biggest_first = True
verbose = False
zap_first = False
zap_last = False
update_log_file = False
test_log = False
write_backup = True

# variables
table_sizes = defaultdict(int)

in_table = False
get_header = False

argcount = 1

while argcount < len(sys.argv):
    arg = sys.argv[argcount]
    if arg[0] == '-': arg = arg[1:]
    if arg == 'v': verbose = True
    elif arg == 'nv': verbose = False
    elif arg == 'ba' or arg == 'b': write_backup = True
    elif arg == 'tl' or arg == 'lt': test_log = True
    elif arg == 'bf' or arg == 'fb': biggest_first = True
    elif arg == 'bl' or arg == 'lb': biggest_first = False
    elif arg == 'u': update_log_file = True
    elif arg == 'un' or arg == 'nu': update_log_file = False
    elif arg == 'zf': zap_first = True
    elif arg == 'nzf' or arg == 'zfn': zap_first = False
    elif arg == 'zl': zap_last = True
    elif arg == 'nzl' or arg[0] == 'zln': zap_last = False
    argcount += 1

with open(i7.tafi('ai')) as file:
    for (line_count, line) in enumerate(file, 1):
        if get_header:
            get_header = False
            continue
        if line.startswith('table') and '\t' not in line:
            # print(line_count, line)
            in_table = True
            get_header = True
            table_start = line_count + 1
            table_name = re.sub(" *\[.*", "", line.lower().strip())
        if in_table and not line.strip():
            in_table = False
            table_sizes[table_name] = line_count - table_start
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

if zap_last:
    q = min(table_sizes, key=table_sizes.get)
    print("Zapping low value", q)
    table_sizes.pop(q)

if zap_first:
    q = max(table_sizes, key=table_sizes.get)
    print("Zapping high value", q)
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