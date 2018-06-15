#
# tcount.py
#
# offers basic metrics on random table size
#

from collections import defaultdict
import math
import re
import i7
import sys

# options
biggest_first = True
verbose = False
zap_first = False
zap_last = False

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
    elif arg == 'd': biggest_first = True
    elif arg == 'u': biggest_first = False
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

amean = gmean = gmeanp = 0

with open('tcount.txt') as file:
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