#
#revit.py
#
# convert the walkthrough to test files for REV OVER
#

import i7
import os
import sys
import re
from collections import defaultdict

this_cmd = defaultdict(str)
what_skipped = defaultdict(str)
destinations = defaultdict(str)

start_low = start_high = 0
end_low = end_high = 0
deep_low = deep_high = 0
alt_low = alt_high = 0
launch_first = launch_last = False
create_deep_speed = False

end_str = ">use ME gem on Knife Fink\nby one point\n\n>use taboo bat on Verses Rev\nby one point\n\n>use yard ray on redivider\nby one point\n\n>s\n\n>use x-ite tix on tix exit\nby one point\n\ns\n"

line_nums = []

def create_alt_speed(idx):
    file_name = "reg-ai-altspeed-{:d}.txt".format(idx)
    f = open(file_name, "w")
    f.write("# reg-ai-altspeed-{:d}.txt\n\n** game: /home/andrew/prt/debug-ailihphilia.ulx\n** interpreter: /home/andrew/prt/glulxe -q\n\n* runthrough\n\n".format(idx))
    buffer = ''
    altpoint = False
    ignorepoint = False
    with open("reg-ai-alt-thru.txt") as file:
        for (line_count, line) in enumerate(file, 1):
            if not any_cmd_yet:
                if not line.startswith(">"): next
                any_cmd_yet = True
            buffer += line
            if line.startswith('#altpoint'):
                altpoint = True
                continue
            if line.startswith('#ignorepoint'):
                ignorepoint = True
                continue
            if 'by one point' in line:
                if ignore_point:
                    ignore_point = False
                    continue
                cmd_idx += 1
                if cmd_idx > idx: break
                f.write(buffer)
                buffer = ''
                continue
            f.write(line)
    f.write(end_str)
    f.close()

def create_speed(idx):
    file_name = "reg-ai-deepspeed-{:d}.txt".format(idx)
    f = open(file_name, "w")
    f.write("# reg-ai-deepspeed-{:d}.txt\n\n** game: /home/andrew/prt/debug-ailihphilia.ulx\n** interpreter: /home/andrew/prt/glulxe -q\n\n* runthrough\n\n".format(idx))
    with open("walkthrough.txt") as file:
        for (line_count, line) in enumerate(file, 1):
            if line_count == line_nums[idx]:
                f.write(">deep speed\n\n")
                for x in range(max_stuff, len(line_nums)):
                    f.write(this_cmd[line_nums[x]] + '\n')
                f.write("Yes, it's time to go. You put the X-Ite Tix in the Tix Exit and walk through.\n")
                f.close()
                print("Wrote", file_name)
                return
            if '>' in line and not line.startswith("If you are"):
                line = re.sub("^\(\+1\) *", "", line)
                f.write(line + "\n")
                continue

def read_walkthrough_chunks(): # returns the number of walkthrough chunks
    orb_next = False
    global line_nums
    retval = 0
    cur_cmd = ''
    with open("walkthrough.txt") as file:
        cmd_count = 0
        for (line_count, line) in enumerate(file, 1):
            if line.startswith("(+1)"):
                line_nums.append(line_count)
                cur_cmd += re.sub(".*> *", ">", line.strip())
                cur_cmd = re.sub("\.", "\n>", cur_cmd)
                # print(line_count, cur_cmd)
                skip_str = re.sub(".*> *", ">", line.strip())
                this_cmd[line_count] = cur_cmd
                what_skipped[line_count] = re.sub("\n+>", ".", this_cmd[line_count])
                cur_cmd = ''
                if 'tnt on ore zero' in line.lower(): retval = len(line_nums) # everything before USE TNT ON ORE ZERO is useful.
            elif '>get all' in line.lower() and orb_next: # this is a hack for getting the orb, which doesn't give a point.
                orb_next = False
                line_nums.append(line_count)
                cur_cmd = ''
                what_skipped[line_count] = line.strip()
            elif 'use tenet on bro orb' in line.lower(): orb_next = True
            elif line.startswith(">"): cur_cmd += line
    return retval

def my_file(s, e):
    return "reg-ai-revthru-start-{:d}-end-{:d}.txt".format(s, e)

def read_destinations():
    global max_stuff
    count = 0
    to_table = -1
    idx = 0
    # for i in range (0, len(line_nums)): print(i, line_nums[i])
    with open("story.ni") as file:
        for line in file:
            if line.startswith('table of goodacts'):
                to_table = 1
                continue
            if to_table == -1: continue
            if to_table > 0:
                to_table -= 1
                continue
            if '\t' not in line: return
            ary = line.strip().split("\t")
            # print(len(ary), idx, len(line_nums), ary)
            destinations[line_nums[idx]] = 0
            destinations[line_nums[idx]] = ary[9]
            # print(idx, line_nums[idx], ary[9], max_stuff)
            idx += 1
            if idx == max_stuff: return

def make_wthru(start_num, end_num):
    rev_part = False
    cmd_yet = False
    file_name = my_file(start_num, end_num)
    f = open(file_name, "w")
    f.write("# {:s}\n\n".format(file_name))
    f.write("** game: /home/andrew/prt/debug-ailihphilia.ulx\n** interpreter: /home/andrew/prt/glulxe -q\n\n* runthrough\n\n")
    with open("walkthrough.txt") as file:
        for (line_count, line) in enumerate(file, 1):
            if not cmd_yet:
                if not line.startswith('>') and not line.startswith('(+1)'):
                    # print("Skipping", line.strip())
                    continue
                cmd_yet = True
            if line_count == line_nums[start_num]:
                rev_part = True
                if start_num == end_num:
                    f.write(">rv {:d}\n#skipping point scoring command {:d}\n\n". format(1, start_num))
                else:
                    f.write(">rv {:d}\n#skipping point scoring commands {:d} to {:d}\n\n". format(end_num - start_num + 1, start_num, end_num))
                f.write("#{:d}/{:d}/{:d}\nDEBUG: going to {:s}\n\n".format(start_num, end_num, line_nums[end_num], destinations[line_nums[end_num]]))
            line_mod = re.sub("\(\+1\) *", "", line)
            if '>' in line and not rev_part:
                if line_count in line_nums: f.write("#point-part {:d} line {:d}\n\n".format(line_nums.index(line_count), line_count))
                f.write(line_mod + "\n")
            elif rev_part and line_count in line_nums: f.write("#{:s} (skipped)\n\n".format(what_skipped[line_count]))
            if line_count == line_nums[end_num]:
                rev_part = False
            if line_count == line_nums[max_stuff-1]: f.write("#endgame begins here\n\n")
    f.write("Yes, it's time to go. You put the X-Ite Tix in the Tix Exit and walk through.\n")
    f.close()
    print("Wrote", file_name)

count = 0
do_all = False

while count < len(sys.argv):
    arg = sys.argv[count]
    if arg[0] == '-': arg = arg[1:]
    if arg[0].isdigit():
        ary = [int(x) for x in re.split("[,-]", arg[1:])]
        if len(ary) == 1: start_low = start_high = end_low = end_high = ary[0]
        else:
            start_low = end_low = ary[0]
            start_high = end_high = ary[1]
    elif arg[0] == 's':
        ary = [int(x) for x in re.split("[,-]", arg[1:])]
        if len(ary) == 1: start_low = start_high = ary[0]
        else:
            start_low = ary[0]
            start_high = ary[1]
    elif arg[0] == 'e':
        ary = [int(x) for x in re.split("[,-]", arg[1:])]
        if len(ary) == 1: end_low = end_high = ary[0]
        else:
            end_low = ary[0]
            end_high = ary[1]
    elif arg[0] == 'a': do_all = True
    elif arg == 'l' or arg == 'l1': launch_first = True
    elif arg == 'll' or arg == 'l0': launch_last = True
    elif arg.startswith('d'):
        create_deep_speed = True
        arg2 = re.sub("^ds?", "", arg)
        if arg2:
            try:
                poss_array = sorted([int(x) for x in arg2.split(',')])
            except:
                sys.exit("Need integer value(s), if any, after d/ds")
            if len(poss_array) == 1:
                deep_low = deep_high = poss_array[0]
            else:
                deep_low = poss_array[0]
                deep_high = poss_array[1]
        else:
            deep_low = 0
            deep_high = -1
    elif arg.startswith('ad'):
        alt_deep_speed = True
        arg2 = re.sub("^ad", "", arg)
        if arg2:
            try:
                poss_array = sorted([int(x) for x in arg2.split(',')])
            except:
                sys.exit("Need integer value(s), if any, after d/ds")
            if len(poss_array) == 1:
                alt_low = alt_high = poss_array[0]
            else:
                alt_low = poss_array[0]
                alt_high = poss_array[1]
        else:
            alt_low = 0
            alt_high = -1
    count += 1

if start_low > start_high:
    (start_low, start_high) = (start_high, start_low)
    print("Flipping start-low and start-high.")

if end_low > end_high:
    (end_low, end_high) = (end_high, end_low)
    print("Flipping end-low and end-high.")

i7.go_proj('ai')

max_stuff = read_walkthrough_chunks()

# for x in line_nums: print(x, what_skipped[x])

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

read_destinations()

if alt_deep_speed:
    print("Working from ALT walkthrough file to create deep speed tests.")
    if alt_high == -1: alt_high = max_stuff
    for x in range(alt_low, alt_high + 1): create_alt_speed(x)
    exit()

if create_deep_speed:
    print("Working from standard walkthrough to create deep speed tests.")
    if deep_high == -1: deep_high = max_stuff
    for x in range(deep_low, deep_high + 1): create_speed(x)
    exit()

if do_all:
    start_low = end_low = 0
    start_high = end_high = max_stuff

for x in range (start_low, start_high + 1):
    for y in range (end_low, end_high + 1):
        if x > y: continue
    make_wthru(x, y)

if launch_first: os.system(my_file(start_low, end_low))
if launch_last: os.system(my_file(start_high, end_high))
