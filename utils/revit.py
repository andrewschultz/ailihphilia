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
    f.write("# {:s}\n\n".format(file_name))
    f.write("** game: /home/andrew/prt/debug-ailihphilia.ulx\n** interpreter: /home/andrew/prt/glulxe -q\n\n* runthrough\n\n")
    with open("walkthrough.txt") as file:
        for (line_count, line) in enumerate(file, 1):
            if not cmd_yet:
                if not line.startswith('>') and not line.startswith('(+1)'):
                    print("Skipping", line.strip())
                    continue
                cmd_yet = True
            if line_count == line_nums[start_num]:
                rev_part = True
                f.write(">rv {:d}\n#skipping point scoring commands {:d} to {:d}\n\n". format(end_num - start_num + 1, start_num, end_num))
            if line_count == line_nums[end_num]:
                rev_part = False
            line_mod = re.sub("\(\+1\) *", "", line)
            if '>' in line and not rev_part: f.write(line_mod)
            elif rev_part and line_count in line_nums: f.write("#{:s} (skipped)\n\n".format(what_skipped[line_count]))
    f.write("Yes, it's time to go. You put the X-Ite Tix in the Tix Exit and walk through.\n")
    f.close()
    print("Wrote", file_name)

count = 0
do_all = False

while count < len(sys.argv):
    arg = sys.argv[count]
    if arg[0] == '-': arg = arg[1:]
    if arg[0].isdigit():
        ary = [int(x) for x in arg.split(',')]
        if len(ary) == 1: start_low = start_high = end_low = end_high = ary[0]
        else:
            start_low = end_low = ary[0]
            start_high = end_high = ary[1]
    elif arg[0] == 's':
        ary = [int(x) for x in arg[1:].split(',')]
        if len(ary) == 1: start_low = start_high = ary[0]
        else:
            start_low = ary[0]
            start_high = ary[1]
    elif arg[0] == 'e':
        ary = [int(x) for x in arg[1:].split(',')]
        if len(ary) == 1: end_low = end_high = ary[0]
        else:
            end_low = ary[0]
            end_high = ary[1]
    elif arg[0] == 'a': do_all = True
    count += 1

if start_low > start_high:
    (start_low, start_high) = (start_high, start_low)
    print("Flipping start-low and start-high.")

if end_low > end_high:
    (end_low, end_high) = (end_high, end_low)
    print("Flipping end-low and end-high.")

max_stuff = 0;

with open("walkthrough.txt") as file:
    cmd_count = 0
    for (line_count, line) in enumerate(file, 1):
        if line.startswith("(+1)"):
            line_nums.append(line_count)
            what_skipped[line_count] = re.sub(".*> *", ">", line.strip())
            if 'tnt on ore zero' in line.lower(): max_stuff = len(line_nums)
        elif '>get all' in line.lower() and orb_next: # this is a hack for getting the orb, which doesn't give a point.
            orb_next = False
            line_nums.append(line_count)
            what_skipped[line_count] = line.strip()
        elif 'use tenet on bro orb' in line.lower(): orb_next = True

for x in line_nums: print(x, what_skipped[x])

if start_low > end_high: sys.exit("Lowest start must be less than the highest end.")

went_over = False

if start_low > max_stuff:
    start_low = max_stuff
    went_over = True

if start_high > max_stuff:
    start_high = max_stuff
    went_over = True

if end_low > max_stuff:
    end_low = max_stuff
    went_over = True

if end_high > max_stuff:
    end_high = max_stuff
    went_over = True

if went_over: print("NOTE: One of your starting or ending values was too high, so I reduced everything to <=", max_stuff)

if do_all:
    start_low = end_low = 0
    start_high = end_high = max_stuff

for x in range (start_low, start_high + 1):
    for y in range (end_low, end_high + 1):
        if x > y: continue
    make_wthru(x, y)