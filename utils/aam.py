# aam.py
#
# add all mistakes: adds a number [mis of #] to each line that doesn't have it

import os
import re
from collections import defaultdict
from shutil import copy
from filecmp import cmp

compare = True

def insert_num(my_str, my_num): # this may be more complex in the future
    return re.sub("\"\)", "[mis of {:d}]\")".format(my_num), my_str, 0)

got = defaultdict(bool)

mis = 'c:\Program Files (x86)\Inform 7\Inform7\Extensions\Andrew Schultz\Put It Up Mistakes.i7x'
mis2 = "temp.i7x"
# mis2 = mis + '2'

fout = open(mis2, "w", newline='\n')

with open(mis) as file:
    for line in file:
        if re.search("mis of [0-9]+", line):
            got[num_of(line)] = True


x = 0
if len(got.keys()) > 0:
    x = max(got, key=got.get)
    for i in range(1, x+1):
        if i not in got.keys():
            print("Skipped", i, "in mistake cues.")
    print("maximum value of", mis, "in mistake cues")
else:
    print("First run...")


cur_num = x

with open(mis) as file:
    for line in file:
        if re.search("^understand.*as a mistake", line):
            if not re.search("mis of [0-9]+", line):
                cur_num = cur_num + 1
                line = insert_num(line, cur_num)
        elif re.search("is a list of truth state", line):
            line = "checkoffs is a list of truth states variable. checkoffs is {{ {:s} }}.\n".format(', '.join(['false'] * cur_num))
        fout.write(line)

fout.close()

if compare:
    os.system("wm \"{:s}\" \"{:s}\"".format(mis, mis2))
else:
    if cmp(mis, mis2):
        print("No changes needed in mistakes file. Not copying over.")
    else:
        copy(mis2, mis)
