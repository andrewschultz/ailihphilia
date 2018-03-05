# aam.py
#
# add all mistakes: adds a number [mis of #] to each line that doesn't have it

import sys
import os
import re
from collections import defaultdict
from shutil import copy
from filecmp import cmp

def usage():
    print("-c / -nc = copy over / don't, default =", on_off[copy_back])
    print("-d / -nd = show differences / don't, default =", on_off[difs])
    print("-r / -nr = reorder / don't, default =", on_off[reorder])
    exit()

def my_mistake(a):
    x = a.split('"')
    return x[1]

def num_of(a):
    temp = re.sub(".*mis of ", "", a)
    temp = re.sub("\].*", "", temp)
    return int(temp)

on_off = ['off', 'on']
difs = True
copy_back = False
count = 1
reorder = False

while count < len(sys.argv):
    arg = sys.argv[count]
    if arg[0] == '-': arg = arg[1:]
    if arg == 'c':
        copy_back = True
    elif arg == 'nc':
        copy_back = False
    elif arg == 'd':
        difs = True
    elif arg == 'nd':
        difs = False
    elif arg == 'r':
        reorder = True
    elif arg == 'nr':
        reorder = False
    else:
        usage()
    count = count + 1

def change_mis(my_str, my_num):
    return re.sub("(\[[^\]]*\])?\"\)", "[mis of {:d}]\")".format(my_num), my_str, 0)

def insert_num(my_str, my_num): # this may be more complex in the future
    return re.sub("\"\)", "[mis of {:d}]\")".format(my_num), my_str, 0)

got = defaultdict(bool)

mis = 'c:\Program Files (x86)\Inform 7\Inform7\Extensions\Andrew Schultz\Put It Up Mistakes.i7x'
mis2 = "temp.i7x"
# mis2 = mis + '2'

fout = open(mis2, "w", newline='\n')

last_num_of = 0
last_mist = ""
this_mist = ""

with open(mis) as file:
    for line in file:
        if re.search("mis of [0-9]+", line):
            nol = num_of(line)
            if nol in got.keys():
                print("WARNING", nol, "pops up twice in mistake file.")
            got[nol] = True
            this_mist = my_mistake(line)
            if nol - last_num_of != 1:
                print("WARNING bad delta from", last_mist, last_num_of, "to", this_mist, nol)
            last_num_of = nol
            last_mist = this_mist

if len(got.keys()) > 0:
    x = max(got, key=int)
    for i in range(1, x+1):
        if i not in got.keys():
            print("Skipped", i, "in mistake cues.")
    print("maximum value of", x, "in mistake cues")
else:
    print("First run...")

cur_num = (0 if reorder else x)


with open(mis) as file:
    for line in file:
        if re.search("^understand.*as a mistake", line):
            if reorder:
                cur_num = cur_num + 1
                line = change_mis(line, cur_num)
            else:
                if not re.search("mis of [0-9]+", line):
                    cur_num = cur_num + 1
                    line = insert_num(line, cur_num)
        elif re.search("is a list of truth state", line):
            line = "checkoffs is a list of truth states variable. checkoffs is {{ {:s} }}.\n".format(', '.join(['false'] * cur_num))
        fout.write(line)

fout.close()

if difs:
    if cmp(mis, mis2):
        print("No changes. No compare shown.")
    else:
        os.system("wm \"{:s}\" \"{:s}\"".format(mis, mis2))

if copy_back:
    if cmp(mis, mis2):
        print("No changes needed in mistakes file. Not copying over.")
    else:
        copy(mis2, mis)