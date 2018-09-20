# aam.py
#
# add all mistakes: adds a number [mis of #] to each line that doesn't have it
#

import i7
import sys
import os
import re
from collections import defaultdict
from shutil import copy
from filecmp import cmp

proj = 'ai'

def usage():
    print("-a  / -q              = all opts (copy, no dif, fill/reorder)")
    print("-c  / -nc             = copy over / don't, default =", on_off[copy_back])
    print("-d  / -nd             = show differences / don't, default =", on_off[difs])
    print("-co / -do / -oc / -od = only copy/show differences, not both")
    print("-f  / -fr / -rf       = fill and reorder, trumps other options (-nr/-rn turns it off)", on_off[reorder])
    print("-m(#)                 = maximum number of errors to ignore before reassigning numbers to mistakes. mn = max notify. Default = {:d}".format(max_errs))
    print("                        0 = always reassign, -1 (or x) = never")
    exit()

def my_mistake(a):
    x = a.split('"')
    return x[1]

def change_mis(my_str, my_num):
    return re.sub("(\[[^\]]*\])?\"\)", "[mis of {:d}]\")".format(my_num), my_str, 0)

def insert_num(my_str, my_num): # this may be more complex in the future
    return re.sub("\"\)", "[mis of {:d}]\")".format(my_num), my_str, 0)

def num_of(a):
    temp = re.sub(".*mis of ", "", a)
    temp = re.sub("\].*", "", temp)
    try:
        return int(temp)
    except:
        return 0

def mistake_check(reord):
    line_count = 0
    bail_after = False
    old_school_yet = False
    local_copy_back = True
    cur_num = (0 if reord else x)
    filre = ['fill', 'reorder']
    fout = open(mis2, "w", newline='\n')
    with open(mis) as file:
        for (line_count, line) in enumerate(file, 1):
            if 'volume old school' in line:
                old_school_yet = True
                print("Ignoring all past line", line_count)
            if old_school_yet is False:
                if re.search("^understand.*as a mistake", line):
                    if not re.search("\) +when", line) and "[okall]" not in line: print("NEED-WHEN WARNING line", line_count, "needs conditional when or [okall].")
                    if re.search("mis of [0-9]+", line) and not re.search("mis of [0-9]+\]\"", line):
                        bail_after = True
                        print("ERROR: 'mis of' syntax needs quote after parenthesis in line", line_count)
                    # print(reord, line_count, line)
                    if reord:
                        cur_num += 1
                        line = change_mis(line, cur_num)
                    else:
                        if not re.search("mis of [0-9]+", line):
                            cur_num += 1
                            line = insert_num(line, cur_num)
                elif re.search("is a list of truth state", line):
                    line = "checkoffs is a list of truth states variable. checkoffs is {{ {:s} }}.\n".format(', '.join(['false'] * cur_num))
            fout.write(line)
    fout.close()
    if bail_after: sys.exit("Fix mistakes to rerun.")
    print("RESULTS FOR", filre[reord], "operations........")
    if difs:
        if cmp(mis, mis2):
            print("No changes", mis, "vs", mis2 + ". No compare shown.")
        else:
            print("Comparing")
            os.system("wm \"{:s}\" \"{:s}\"".format(mis, mis2))
    if copy_back:
        if not local_copy_back:
            print("Not copying back. Fix bugs first.")
        if cmp(mis, mis2):
            print("No changes needed in mistakes file. Not copying over.")
        else:
            print("Copying back modified file.")
            copy(mis2, mis)
    elif not cmp(mis, mis2):
        print("Run -c to copy changes over.")


on_off = ['off', 'on']
difs = True
copy_back = False
count = 1
reorder = False
max_err_default = 5
max_errs = max_err_default
max_errs_not = 20

while count < len(sys.argv):
    arg = sys.argv[count]
    if arg[0] == '-': arg = arg[1:]
    if arg == 'a' or arg == 'q':
        copy_back = True
        difs = False
        reorder = True
    elif arg == 'c': copy_back = True
    elif arg == 'nc': copy_back = False
    elif arg == 'co' or arg == 'oc':
        copy_back = True
        difs = False
    elif arg == 'd': difs = True
    elif arg == 'do' or arg == 'od':
        copy_back = False
        difs = True
    elif arg == 'nd': difs = False
    elif arg == 'r' or arg == 'fr' or arg == 'f': reorder = True
    elif arg == 'nr' or arg == 'rn': reorder = False
    elif arg == 'mx': max_errs = -1
    elif arg[:2] == 'm-': sys.exit("Instead of {:s}, try mx to disable rearrangement regardless of the number of errors.".format(arg))
    elif arg[:2] == 'mn': max_errs_not = int(arg[2:])
    elif arg[0] == 'm':
        try:
            if len(arg[0]) > 1: max_errs = int(arg[0][1:])
            else: max_errs = int(sys.argv[count+1])
        except:
            sys.exit("Need positive number argument after m, or mx (alone) to disable reshuffling.")
    else:
        usage()
    count += 1

got = defaultdict(bool)

mis = i7.mifi(proj)
mis2 = i7.sdir(proj) + "\\temp.i7x"
# mis2 = mis + '2'

last_num_of = 0
last_mist = ""
this_mist = ""

errs = 0

with open(mis) as file:
    for (line_count, line) in enumerate(file, 1):
        if line.startswith("volume old school verbs"):
            break
        if line.startswith("understand"):
            nol = num_of(line)
            if nol in got.keys() and nol > 0:
                print("WARNING", nol, "pops up twice in mistake file.")
                errs += 1
            got[nol] = True
            this_mist = my_mistake(line)
            if nol - last_num_of != 1:
                if (errs <= max_errs_not or max_errs_not == 0):
                    if nol:
                        print("WARNING bad " + ("start at" if last_num_of == 0 else "delta from {:s} {:d} to".format(last_mist, last_num_of)), this_mist, nol)
                    else:
                        print("WARNING blank number for", this_mist, nol)
                errs += 1
            last_num_of = nol
            last_mist = this_mist
        elif line.startswith("u") and 'mistake' in line:
            print("******** Line {:d} has understand-typo ********".format(line_count))
            print("************ FIX BEFORE CONTINUING ************".format(line_count))
            i7.npo(mis, line_count, True)
            exit()

if len(got.keys()) > 0:
    x = max(got, key=int)
    skips = 0
    for i in range(1, x+1):
        if i not in got.keys():
            skips += 1
            if skips == 11:
                print("Skipping all remaining notifications...")
            elif skips <= 10:
                if skips == 1: print("LIST OF SKIPPED NUMBERED CUES IN FILE E.G. MIS OF ###")
                print(skips, "Skipped", i, "in mistake cues.")
    print("maximum value of", x, "in mistake cues")
else:
    print("First run...")

if max_errs > -1 and errs > max_errs and not reorder:
    print("Forcing reorder since there are more than", max_errs, "numbering errors: to be precise,", errs)
    reorder = True

if max_errs_not and errs > max_errs_not: print("Got", errs, "errors but only listed", max_errs_not)

if not reorder and errs > 0:
    if max_errs > 0:
        print("Use -f to reorder fully. Only found", errs, "out of", max_errs, "errors necessary for automatic reorder.")
    else:
        print("Use -f to reorder fully. There are", errs, "errors to reorder.")

mistake_check(reorder)
os.remove(mis2)
