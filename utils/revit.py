#
#revit.py
#
# convert the walkthrough to test files for REV OVER
#

import sys
import re
from collections import defaultdict

what_skipped = defaultdict(str)

orb_next = False
line_nums = []
start_low = start_high = 0
end_low = end_high = 0

def make_wthru(start_num, end_num):
    rev_part = False
    cmd_yet = False
    file_name = "reg-ai-revthru-start-{:d}-end-{:d}.txt".format(start_num, end_num)
    f = open(file_name, "w")
    with open("walkthrough.txt") as file:
        for (line_count, line) in enumerate(file, 1):
            if not cmd_yet:
                if not line.startswith('>'): continue
                cmd_yet = True
            if line_count == line_nums[start_num]:
                rev_part = True
                f.write(">rv {:d}\n#skipping point scoring commands {:d} to {:d}\n\n". format(end_num - start_num + 1, start_num, end_num))
            if line_count == line_nums[end_num]:
                rev_part = False
            line_mod = re.sub("\(\+1\) *", "", line)
            if not rev_part: f.write(line_mod)
            elif rev_part and line_count in line_nums: f.write("#{:s} (skipped)\n\n".format(what_skipped[line_count]))
    f.close()
    print("Wrote", file_name)

count = 0
while count < len(sys.argv):
    arg = sys.argv[count]
    if arg[0] == '-': arg = arg[1:]
    if arg[0].isdigit():
        ary = [int(x) for x in arg.split(',')]
        if len(ary) == 1: start_low = start_high = end_low = end_high = ary[0]
        else:
            start_low = end_low = ary[0]
            start_high = end_high = ary[1]
    if arg[0] == 's':
        ary = [int(x) for x in arg[1:].split(',')]
        if len(ary) == 1: start_low = start_high = ary[0]
        else:
            start_low = ary[0]
            start_high = ary[1]
    if arg[0] == 'e':
        ary = [int(x) for x in arg[1:].split(',')]
        if len(ary) == 1: end_low = end_high = ary[0]
        else:
            end_low = ary[0]
            end_high = ary[1]
    count += 1

with open("walkthrough.txt") as file:
    cmd_count = 0
    for (line_count, line) in enumerate(file, 1):
        if line.startswith("(+1)"):
            line_nums.append(line_count)
            what_skipped[line_count] = re.sub(".*> *", ">", line.strip())
        elif '>get all' in line.lower() and orb_next: # this is a hack for getting the orb, which doesn't give a point.
            orb_next = False
            line_nums.append(line_count)
            what_skipped[line_count] = line.strip()
        elif 'use tenet on bro orb' in line.lower(): orb_next = True

for x in line_nums: print(x, what_skipped[x])

if start_low > end_high: sys.exit("Lowest start must be less than the highest end.")

for x in range (start_low, start_high + 1):
    for y in range (end_low, end_high + 1):
        if x > y: continue
    make_wthru(x, y)