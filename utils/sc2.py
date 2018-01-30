# sc2.py
#
# attempts to isolate how many points you can score in each region
#
# replaces msc.py
#
# todo: if I forgot a +1, fill it in

import i7
import sys
import re
from collections import defaultdict

# options
verbose = False
semi_verbose = False
show_hash = False

# variables

main_dir = "c:/games/inform/put-it-up.inform/source"
main_source = main_dir + "/story.ni"
main_thru = main_dir + "/walkthrough.txt"

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
use_in_invisiclues_main = defaultdict(int)
use_in_invisiclues_summary = defaultdict(int)
use_in_walkthrough = defaultdict(int)
invis_points = defaultdict(int)

def usage():
    print("-v for verbose")
    print("-s for semi verbose")
    print("-h to show hash values")
    exit()

def detect_region(a, b):
    if '[' not in a:
        return b
    temp = re.sub(".*\[", "", a.strip())
    temp = re.sub("\].*", "", temp)
    if semi_verbose: print("DEBUG:", temp)
    ary = temp.split("/")
    if len(ary) == 1:
        return (ary[0].lower(), None)
    elif len(ary) > 2:
        print("TOO MANY SLASHES:", a)
        exit()
    return (ary[0].lower(), ary[1].upper())

# these two could be lumped together, but it was quicker to C&P for the moment

def source_vs_invisiclues():
    main_err = 0
    summary_err = 0
    in_summary = False
    in_odd = False
    this_line = 0
    with open("c:/writing/scripts/invis/pu.txt") as file:
        for line in file:
            this_line = this_line + 1
            if 'total points in' in line:
                ll = re.sub(".*total points in *", "", line.strip().lower())
                ll = re.sub("\..*", "", ll)
                pts = re.sub(" *total points.*", "", line.strip())
                pts = re.sub(".* ", "", pts)
                print(ll, "has", pts, "points in InvisiClues.")
                try:
                    invis_points[ll] = int(pts)
                except:
                    print("Non integer points", pts, "getting region points from line", this_line, ":", line.strip())
                    exit()
            if line.strip() == '#summary below':
                in_summary = True
                continue
            if in_summary:
                if 'all the Odd Do' in line:
                    in_odd = True
                    continue
                if in_odd:
                    if line.startswith('?'):
                        in_odd = False
                    continue
                if line.startswith("1 point if you ") or line.startswith("1 point for "): # obviously this needs to be cleaned up for custom commands
                    ll = re.sub("^1 point (for|if you) ", "", line.strip())
                    ll = re.sub("\..*", "", ll)
                    ll = re.sub(" [a-z].*", "", ll)
                    if ll in use_in_invisiclues_summary.keys(): print("WARNING line", this_line,"has duplicate command:", ll)
                    use_in_invisiclues_summary[ll] = True
            else:
                if line == line.upper() and not line.startswith('?') and not line.startswith('#') and not line.startswith('>'):
                    ll = re.sub("\..*", "", line.strip())
                    # print("Found in invisiclues main:", ll)
                    if ll in use_in_invisiclues_main.keys(): print("WARNING line", this_line,"has duplicate command:", ll)
                    use_in_invisiclues_main[ll] = True
    for x in list(set(use_in_invisiclues_main.keys()) | set(use_in_source.keys())):
        if x not in use_in_invisiclues_main.keys():
            if not main_err: print("=" * 40)
            print("ERROR: Need this source line in invisiclues main:", x)
            main_err = main_err + 1
        elif x not in use_in_source.keys():
            if not main_err: print("=" * 40)
            print("ERROR: Need this invisiclues main line in source(table of useons or [region/command]:", x)
            main_err = main_err + 1
        elif verbose:
            print("Synced to main:", x)
    if in_summary:
        if main_err: print("=" * 40)
        for x in list(set(use_in_invisiclues_summary.keys()) | set(use_in_source.keys())):
            if x not in use_in_invisiclues_summary.keys():
                if not main_err and not summary_err: print ("=" * 40)
                print("ERROR: Need this source line in invisiclues summary:", x)
                summary_err = summary_err + 1
            elif x not in use_in_source.keys():
                if not main_err and not summary_err: print ("=" * 40)
                print("ERROR: Need this invisiclues summary line in source(table of useons or [region/command]:", x)
                summary_err = summary_err + 1
            elif verbose:
                print("Synced to summary:", x)
    else:
        print('Uh oh, we need a line like #summary below in order to indicate we are in the ')
    if summary_err + main_err :
        print(main_err, "total invisiclues main sync errors")
        print(summary_err, "total invisiclues summary sync errors")
    else:
        print("InvisiClues sync test passed.")


def source_vs_walkthrough():
    any_err = 0
    xo = False
    line_count = 0
    plus_one = 0
    xxx = { 'N': True, 'S': True, 'E': True, 'W': True, 'GET': True }
    with open(main_thru) as file:
        for line in file:
            line_count = line_count + 1
            if not line.startswith('>'): continue
            ll = re.sub("^> *", "", line.strip())
            ll2 = re.sub(" *\(\+1\).*", "", ll)
            cmd_ary = ll2.split(".")
            if cmd_ary[0] not in xxx.keys():
                if ll == ll2 and use_in_source[ll]:
                    if ll2 in use_in_walkthrough.keys():
                        print(ll2, "duplicate non-points command, may not be error.")
                    else:
                        print("WARNING: may need +1 at line", line_count, "of walkthrough:", ll)
                        plus_one = plus_one + 1
                use_in_walkthrough[ll2] = True
    for x in list(set(use_in_walkthrough.keys()) | set(use_in_source.keys())):
        if x not in use_in_walkthrough.keys():
            print("ERROR: Need this line in walkthrough:", x)
            any_err = any_err + 1
        elif x not in use_in_source.keys():
            print("ERROR: Need this line in table of useons:", x)
            any_err = any_err + 1
        elif verbose:
            print("Synced:", x)
    if plus_one or any_err:
        print(plus_one, "walkthrough +1's needed")
        print(any_err, "total walkthrough sync errors")
    else:
        print("Walkthrough sync test passed.")

argval = 1
while argval < len(sys.argv):
    noh = sys.argv[argval].lower()
    if noh[0] == '-':
        noh = noh[1:]
    if noh == 'v':
        verbose = True
        semi_verbose = True
    elif noh == 's':
        semi_verbose = True
    elif noh == 'h':
        show_hash = True
    else:
        print(sys.argv[argval].lower(), "not recognized.")
        print()
        usage()
    argval = argval + 1


def get_stuff_from_source():
    use_ons = False
    func_list = ''
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
                (temp_region, this_cmd) = detect_region(line, current_region)
                if temp_region == 'ignore':
                    continue
                if this_cmd:
                    use_in_source[this_cmd] = line_count
                    if verbose: print("Tacking on", this_cmd)
                if temp_region == current_region and '[' in line:
                    if semi_verbose: print("WARNING temp_region not a change from current_region", current_region, "line", line_count, "in story.ni")
                    warning_line = line_count
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

get_stuff_from_source()

source_vs_invisiclues()
source_vs_walkthrough()

for x in base_reg_incs.keys():
    if semi_verbose or verbose:
        print('BASE', x, base_reg_incs[x])
    totals[x] = totals[x] + base_reg_incs[x]

for x in directed_incs.keys():
    if semi_verbose or verbose:
        print('DIRECTED', x, directed_incs[x])
    totals[x] = totals[x] + directed_incs[x]

print("List of points by region:")
for x in totals.keys():
    if totals[x] != in_source[x]:
        print("ERROR: region", x, "has", totals[x], "but source lists", in_source[x])
        line_to_open = region_def_line[x]
    if in_source[x] != invis_points[x]:
        print("ERROR: region", x, "has", in_source[x], "in source, but invisiclues list", invis_points[x])

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

if show_hash:
    print("Source hash")
    for x in sorted(use_in_source.keys()):
        print(x, use_in_source[x])
    print("Wthru hash")
    for x in sorted(use_in_walkthrough.keys()):
        print(x, use_in_walkthrough[x])
    print("Source hash")
    for x in sorted(use_in_invisiclues.keys()):
        print(x, use_in_invisiclues[x])

if line_to_open:
    i7.npo("story.ni", line_to_open, True)
elif warning_line:
    i7.npo("story.ni", warning_line, True)

print("Total =", t2)