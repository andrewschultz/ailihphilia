#
#revit.py
#
# convert the walkthrough to test files for REV OVER
#
# sample usage
#
# revit.py -l0 -l1 d0,1 ad0,1
#
# revit.py -wr = tries one instance of WRW (creates skip-step files)
# revit.py -e = recopies all the thru-east files
# revit.py -w = recopies all the thru-east files
# revit.py -wr -s2,4 -e5,7 = creates 2-5, 2-6, 2-7, 3-5, 3-6, 3-7, 4-5, 4-6, 4-7
# revit.py -wrr2 = creates 2 random skipping test files

import glob
import random
import i7
import os
import sys
import re
from collections import defaultdict
from filecmp import cmp
from shutil import copy

files_to_run = defaultdict(str)

this_cmd = defaultdict(str)
what_skipped = defaultdict(str)
destinations = defaultdict(str)

first_line = "# created with the revit.py python tool\n"

post_copy_just_this = False
print_chunk_list = False
chunk_list_to_file = False
launch_chunk_list = False
write_wrw = False

post_prt = False
do_rev_over = False
# starting range for do_rev_over
start_low = start_high = 0
end_low = end_high = 0

random_wrw_to_write = 0

speed_low = speed_high = 0

launch_first = launch_last = False

prt_over = prt_ignore = 0

end_str = ">n\n>use me gem on knife fink\n>use taboo bat on verses rev\n>use yard ray on redivider\n>s\n>use x-ite tix on tix exit\nYes, it's time to go. You put the X-Ite Tix in the Tix Exit and walk through.\nRoxor!\n"

line_nums = []

def usage():
    print("List of arguments:")
    print('=' * 40)
    print("a = all (0..74)")
    print("m/e/w=min/east/west")
    print("s# = start (CSV), e# = end (CSV) for REV OVER")
    print("l/l1 = launch first, ll/l0 = launch last")
    print("r = rev-over on, nr/rn = rev-over off")
    print("p = run PRT post-revit")
    print("j = just copy generated files")
    print("pc = print chunk list, cf = chunk list to file, cl = to file and launch")
    exit()

def show_post_prt():
    if post_prt: print(prt_over, "copied over, ", prt_ignore, "unchanged and ignoring")
    exit()

def last_of(a):
    b = a.strip().split("\n")
    for j in b[::-1]:
        if j.startswith('>'): return j + "\n"
    if 'endwrw' in a:
        return ">wrw\nendgame\n"
    return "(undefined command: {:s})\n".format(a.strip())

def final_line(q, q2):
    if q >= q2 - 1: return "You're already near the endgame."
    if q == q2 - 2: return "You use the epicer recipe you found in the Trapeze Part to build a north-tron that destroys the KOAS Oak to the north! And with that, your REV OVER journey ends, so close to saving Yelpley and Grebeberg."
    return "Anyway, you tear up the epicer recipe and throw it in the air to make confetti as celebration. You must be close now!"

def write_single_wrw(start_val, end_val, block_dict, collapse_if_1):
    if start_val == end_val and collapse_if_1:
        fname = "reg-ai-wrw-skip-step-{:02d}.txt".format(start_val)
    else:
        fname = "reg-ai-wrw-skip-from-{:02d}-to-{:02d}.txt".format(start_val, end_val)
    if not post_prt: print('Writing', start_val, end_val, fname)
    f = open(fname, "w")
    f.write("# {:s}\n#\n# unit tester for wrw skipping step{:s} {:d}{:s}\n#\n** game: /home/andrew/prt/debug-ailihphilia.ulx\n** interpreter: /home/andrew/prt/glulxe -q\n\n* warpthrough\n\n".format(fname, 's' if start_val != end_val else '', start_val, '' if start_val == end_val else '-{:d}'.format(end_val)))
    for y in range (0, len(block_dict)):
        if y >= start_val and y <= end_val:
            f.write("\n>wrw\n")
            f.write("#replacement for ")
            f.write(last_of(block_dict[y]))
            if 'by one point' not in block_dict[y]: f.write("!")
            f.write("1 point to go\n")
        else: f.write(block_dict[y])
    f.write(final_line(end_val, len(block_dict)) + "\n")
    f.close()
    if post_prt:
        global prt_over
        global prt_ignore
        prt_name = os.path.join(i7.prt,fname)
        if not cmp(fname, prt_name):
            print("Copying", fname, "to", prt_name)
            copy(fname, prt_name)
            prt_over += 1
        else:
            print("No change in", fname, "/", prt_name)
            prt_ignore += 1

def write_random_wrw(blox, num_of):
    for n in range (0, num_of):
        file_string = "reg-ai-wrw-random-"
        rand_ary = []
        string_to_dump = ""
        my_total = 0
        for i in range (0, len(blox)-1):
            to_add = random.randint(0,1)
            my_total += to_add
            rand_ary.append(to_add)
            file_string += str(to_add)
            if to_add: string_to_dump += last_of(blox[i])
            else: string_to_dump += blox[i]
            if 'by one point' not in blox[i]: string_to_dump += ("!")
            string_to_dump += ("1 point to go\n")
        string_to_dump += '>wrw\nendgame\n'
        file_string += "-{:d}-skips.txt".format(my_total)
        f = open(file_string, "w")
        f.write("# {:s}\n#\n# randomly generated WRW tester** game: /home/andrew/prt/debug-ailihphilia.ulx\n** interpreter: /home/andrew/prt/glulxe -q\n\n* warpthrough\n\n".format(file_string))
        f.write(string_to_dump)
        f.close()
        print("Wrote", file_string)
    exit()

def write_wrw_files():
    only_one_wrw = (end_high == 0 and start_high == 0)
    as_n = "reg-ai-thru-as-needed.txt"
    wrw_blocks = []
    cmd_yet = False
    cur_cmd = ''
    with open(as_n) as file:
        for line in file:
            if not cmd_yet and not line.startswith('>'): continue
            if not cmd_yet: cmd_yet = True
            cur_cmd += line
            if 'by one point' in cur_cmd or '#force-revit-cmd' in cur_cmd:
                wrw_blocks.append(cur_cmd)
                cur_cmd = ''
            if '#endwrw' in cur_cmd: break
    if cur_cmd: wrw_blocks.append(cur_cmd)
    if random_wrw_to_write:
        write_random_wrw(wrw_blocks, random_wrw_to_write)
    elif only_one_wrw:
        for x in range(0, len(wrw_blocks)):
            write_single_wrw(x, x, wrw_blocks, True)
    else:
        for st in range(start_low, start_high):
            for en in range (end_low, end_high):
                write_single_wrw(st, en, wrw_blocks, False)
    if post_prt: show_post_prt()
    exit()

def create_speed_thru(base_file, base_out_str, idx):
    file_name = base_out_str.format(idx)
    f = open(file_name, "w")
    f.write(first_line)
    f.write("# {:s}\n\n".format(file_name))
    f.write("** game: /home/andrew/prt/debug-ailihphilia.ulx\n** interpreter: /home/andrew/prt/glulxe -q\n\n* runthrough\n\n".format(idx))
    buffer = ''
    cmd_idx = 0
    force_revit = False
    ignore_point = False
    any_cmd_yet = False
    with open(base_file) as file:
        for (line_count, line) in enumerate(file, 1):
            if not any_cmd_yet:
                if not line.startswith(">"): continue
                any_cmd_yet = True
            buffer += line
            if 'gem' in line.lower() and 'fink' in line.lower(): break
            if 'bat' in line.lower() and 'rev' in line.lower(): break
            if line.startswith('#force-revit-cmd'):
                force_revit = True
                continue
            if line.startswith('#ignorepoint'):
                ignore_point = True
                continue
            if 'by one point' in line or force_revit:
                force_revit = False
                if ignore_point:
                    ignore_point = False
                    continue
                cmd_idx += 1
                if cmd_idx > idx: break
                f.write(buffer)
                buffer = ''
                continue
            #f.write(line)
    f.write(">deep speed\n\n")
    f.write(end_str)
    f.close()
    print("Wrote", file_name)

def create_speed(idx):
    file_name = "reg-ai-deepspeed-{:d}.txt".format(idx)
    f = open(file_name, "w")
    f.write(first_line)
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
    orb_ever = False
    with open("walkthrough.txt") as file:
        cmd_count = 0
        for (line_count, line) in enumerate(file, 1):
            if line.startswith("(+1)") or 'use puce cup on liar grail' in line.lower():
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
            elif 'use stir writs on bro orb' in line.lower(): orb_next = orb_ever = True
            elif line.startswith(">"): cur_cmd += line
    if not orb_ever: print("Uh oh, we didn't have a division for getting the orb.")
    if print_chunk_list or chunk_list_to_file:
        if chunk_list_to_file: f = open("revit-chunk-list.txt", "w")
        for x in range(0, retval):
            this_segment = "{:s}{:d} (line {:d})\n{:s}\n".format('=' * 40, x, line_nums[x], this_cmd[line_nums[x]])
            if chunk_list_to_file: f.write(this_segment)
            if print_chunk_list: print(this_segment)
        if chunk_list_to_file: f.close()
        if launch_chunk_list: os.system("revit-chunk-list.txt")
        exit()
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

count = 1
do_all = False

while count < len(sys.argv):
    arg = sys.argv[count]
    if arg[0] == '-': arg = arg[1:]
    if arg[0].isdigit():
        ary = [int(x) for x in re.split("[,-]", arg)]
        if len(ary) == 1: start_low = start_high = end_low = end_high = ary[0]
        else:
            start_low = end_low = speed_low = ary[0]
            start_high = end_high = speed_high = ary[1]
    elif arg == 'w': files_to_run["westfirst"] = True
    elif arg == 'e': files_to_run["eastfirst"] = True # must come before 'e' below
    elif arg == 'm': files_to_run["min"] = True
    elif arg == 'a':
        start_low = end_low = speed_low = 0
        start_high = end_high = speed_high = 74
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
    elif arg == 'l' or arg == 'l1': launch_first = True
    elif arg == 'll' or arg == 'l0': launch_last = True
    elif arg == 'r': do_rev_over = True
    elif arg == 'nr' or arg == 'rn': do_rev_over = False
    elif arg == 'p': post_prt = True
    elif arg == 'pc': print_chunk_list = True
    elif arg == 'cf': chunk_list_to_file = True
    elif arg == 'cl': launch_chunk_list = chunk_list_to_file = True
    elif arg == 'rd':
        tary = glob.glob("reg-ai-wrw-random-*")
        for q in tary: os.remove(q)
        print("Removed", len(tary), "random files")
    elif arg.startswith('wr') and arg[2:].isdigit():
        random_wrw_to_write = int(arg[2:])
        write_wrw = True
    elif arg == 'wr' or arg == 'rw' or arg == 'wrw': write_wrw = True
    elif arg == 'j': post_copy_just_this = True
    elif arg == '?': usage()
    else:
        print("Didn't understand the argument", sys.argv[count])
        usage()
    count += 1

if start_low > start_high:
    (start_low, start_high) = (start_high, start_low)
    print("Flipping start-low and start-high.")

if end_low > end_high:
    (end_low, end_high) = (end_high, end_low)
    print("Flipping end-low and end-high.")

i7.go_proj('ai')

if write_wrw: write_wrw_files()

max_stuff = read_walkthrough_chunks()

# for x in line_nums: print(x, what_skipped[x])

if start_low > end_high: sys.exit("Lowest start must be less than the highest end.")

went_over = False

def bound_it(x):
    global went_over
    if x > max_stuff:
        x = max_stuff
        went_over = True
    if x < 0:
        x = 0
        went_over = True
    return x

speed_high = bound_it(speed_high)
speed_low = bound_it(speed_low)
start_high = bound_it(start_high)
start_low = bound_it(start_low)
end_high = bound_it(end_high)
end_low = bound_it(end_low)

if went_over: print("NOTE: One of your starting or ending values was not between 0 and {:d}, so I reduced everything to that range.".format(max_stuff))

read_destinations()

if do_all:
    speed_low = start_low = end_low = 0
    speed_high = start_high = end_high = max_stuff

if not do_rev_over:
    if not len(files_to_run.keys()): sys.exit("Need to specify m(main min)/w(west first)/e(east first) for speed-testing.")
    for q in sorted(files_to_run.keys()):
        in_file = "reg-ai-thru-{:s}.txt".format(q)
        out_format = "reg-ai-speed-{:s}-{{:02d}}.txt".format(q)
        for x in range(speed_low, speed_high + 1): create_speed_thru(in_file, out_format, x)
else:
    for x in range (start_low, start_high + 1):
        for y in range (end_low, end_high + 1):
            if x > y: continue
        make_wthru(x, y)

if post_prt: show_post_prt()

if post_copy_just_this:
    of2 = re.sub("\{.*.}", "*", out_format)
    os.system("copy {:s} {:s}".format(of2, i7.prt))
    sys.exit("{:s} copied to {:s}".format(of2, i7.prt))

if launch_first: os.system(my_file(start_low, end_low))
if launch_last: os.system(my_file(start_high, end_high))
