# sc2.py
#
# attempts to isolate how many points you can score in each region
#
# replaces msc.py
#

import i7
import sys
import re
from collections import defaultdict

# options
verbose = False
semi_verbose = False

# variables

main_source = "c:/games/inform/put-it-up.inform/source/story.ni"
use_ons = False

line_to_open = 0
warning_line = 0

undef_use_points = 0

current_region = "None"

region_def_line = defaultdict(int)
base_reg_incs = defaultdict(int)
directed_incs = defaultdict(int)
totals = defaultdict(int)
in_source = defaultdict(int)
machine_uses = defaultdict(int)
machine_uses_in_source = defaultdict(int)
machine_actions = defaultdict(str)

use_in_source = defaultdict(int)
use_in_invisiclues = defaultdict(int)

func_list = ''

argval = 1
while argval < len(sys.argv):
    noh = sys.argv[argval].lower()
    if noh[0] == '-':
        noh = noh[1:]
    if noh == 'v':
        verbose = True
        semi_verbose = True
    if noh == 's':
        semi_verbose = True
    argval = argval + 1

def detect_region(a, b):
    if '[+' not in a:
        return b
    temp = re.sub(".*\[\+", "", a.strip())
    temp = re.sub("\].*", "", temp)
    return temp.lower()

def source_vs_invisiclues():
    with open("c:/writing/scripts/invis/pu.txt") as file:
        for line in file:
            if line.startswith("1 point if you USE"):
                ll = re.sub(".* USE", "USE", line.strip())
                ll = re.sub("\..*", "", ll)
                use_in_invisiclues[ll] = True
    for x in list(set(use_in_invisiclues.keys()) | set(use_in_source.keys())):
        if x not in use_in_invisiclues.keys():
            print("Need this line in invisiclues:", x)
        elif x not in use_in_source.keys():
            print("Need this line in table of useons:", x)
        elif verbose:
            print("Synced:", x)

with open(main_source) as file:
    line_count = 0
    for line in file:
        line_count = line_count + 1
        ll = line.strip().lower()
        if ll:
            func_list = func_list + line
        else:
            func_list = ''
        if 'workable. useleft' in ll:
            mname = re.sub(" is a workable.*", "", ll)
            mname = re.sub("^the ", "", mname)
            muses = re.sub(".* is ", "", ll)
            muses = re.sub("\..*", "", muses)
            machine_uses_in_source[mname] = int(muses)
        if ll.startswith("volume"):
            current_region = "None"
        if 'is a region. max-score' in line:
            l2 = re.sub(" is a region.*", "", line.lower().strip())
            sco = re.sub(".*is ", "", line.lower().strip())
            sco = re.sub("\..*", "", sco)
            in_source[l2] = int(sco)
            region_def_line[l2] = line_count
            if semi_verbose: print("Noting region", l2)
            continue
        if 'score-inc' in line and '\t' in line:
            temp_region = detect_region(line, current_region)
            if temp_region == current_region and '[+' in line:
                print("WARNING temp_region not a change from current_region", current_region, "line", line_count, "in story.ni")
                warning_line = line_count
            if temp_region == 'ignore':
                continue
            if verbose:
                if temp_region not in region_def_line.keys():
                    print("ERROR: no region", temp_region, "at line", line_count)
                else:
                    print ("temp region", temp_region, "for line", line_count)
            if verbose:
                print(current_region)
                print(func_list)
            if temp_region == "None":
                print("ERROR: region not defined yet at line", line_count)
            if temp_region == current_region:
                base_reg_incs[temp_region] = base_reg_incs[temp_region] + 1
            else:
                directed_incs[temp_region] = directed_incs[temp_region] + 1
        if ll.startswith('part ') and 'region' in ll:
            myreg = re.sub("^part ", "", ll)
            myreg = re.sub(" *?region.*", "", myreg)
            current_region = myreg.lower()
            if myreg not in region_def_line.keys():
                print("WARNING", ll, "defines start of invalid region.")
        if line.startswith("table of useons") and 'continued' not in line:
            use_ons = True
            continue
        elif use_ons and not line.strip():
            use_ons = False
            continue
        if line.startswith('\t') and "reg-inc" in ll and "reg-inc reg-plus entry" not in ll:
            l2 = re.sub(".*reg-inc ", "", ll.lower())
            l2 = re.sub(";.*", "", l2)
            if l2 == 'mrlp':
                continue
            directed_incs[l2] = directed_incs[l2] + 1
        if use_ons:
            x = ll.split("\t")
            if len(x) < 6: continue
            if x[1] == 'reifier' or x[1] == 'reviver' or x[1] == 'rotator':
                machine_uses[x[1]] = machine_uses[x[1]] + 1
                machine_actions[x[1]] = machine_actions[x[1]] + "    {:s} -> {:s}\n".format(x[0], x[2])
            if len(x) != 10:
                print("ERROR: Line", line_count, "has the wrong # of tabs for use-table.", len(x), "should be 10.")
            if x[5] == 'true':
                cmd = "USE {:s} ON {:s}".format(x[0].upper(), x[1].upper())
                use_in_source[cmd] = line_count
                temp_region = ""
                if x[8] and x[8] != '--' and x[8] != 'reg-plus': # a bit hacky, but basically, check for entry 10 in useon table being a proper region
                    temp_region = x[8].lower()
                if temp_region:
                    directed_incs[temp_region] = directed_incs[temp_region] + 1
                else:
                    if not temp_region:
                        print("Blank temp region at line", line_count, "in use table.")
                    elif temp_region not in region_def_line.keys():
                        print(temp_region, "at line", line_count, " in use table not a valid region.")
                    elif verbose:
                        print(temp_region, "at line", line_count, " in use table given extra point.")
                    undef_use_points = undef_use_points + 1

source_vs_invisiclues()

for x in base_reg_incs.keys():
    if semi_verbose or verbose:
        print('BASE', x, base_reg_incs[x])
    totals[x] = totals[x] + base_reg_incs[x]

for x in directed_incs.keys():
    if semi_verbose or verbose:
        print('DIRECTED', x, directed_incs[x])
    totals[x] = totals[x] + directed_incs[x]

for x in totals.keys():
    if totals[x] != in_source[x]:
        print("ERROR: region", x, "has", totals[x], "but source lists", in_source[x])
        line_to_open = region_def_line[x]
    print(x, totals[x])

for x in sorted(machine_uses.keys()):
    if machine_uses[x] != machine_uses_in_source[x]:
        print("Machine", x, "has", machine_uses[x], "uses in table but", machine_uses_in_source[x], "uses listed in the source.")

if semi_verbose:
    for x in sorted(machine_uses.keys()):
        print("Machine", x, "used to score", machine_uses[x], "points. Flips below:")
        print(machine_actions[x], end="")

t2 = sum(totals.values())

if undef_use_points:
    print("ERROR: undef use points =", undef_use_points)

if line_to_open:
    i7.npo("story.ni", line_to_open, True)
elif warning_line:
    i7.npo("story.ni", warning_line, True)

print("Total =", t2)