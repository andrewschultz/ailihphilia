#
#revit.py
#
# convert the walkthrough to test files for REV OVER
#

import re
from collections import defaultdict

what_skipped = defaultdict(str)

orb_next = False
line_nums = []

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
            line_mod = re.sub("\(\+1\)", "", line)
            if not rev_part: f.write(line_mod)
            elif rev_part and line_count in line_nums: f.write("#{:s}".format(what_skipped[line_count]))
    f.close()
    print("Wrote", file_name)

with open("walkthrough.txt") as file:
    cmd_count = 0
    for (line_count, line) in enumerate(file, 1):
        if line.startswith("(+1)"): line_nums.append(line_count)
        elif '>get all' in line.lower() and orb_next:
            orb_next = False
            line_nums.append(line_count)
            what_skipped[line_count] = line
        elif 'tenet on orb' in line.lower(): orb_next = True

print(line_nums)

make_wthru(3, 4)