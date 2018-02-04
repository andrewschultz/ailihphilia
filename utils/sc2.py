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
triz_flow = "c:/games/inform/triz/mine/put-it-up-flow.trizbort"
invis_raw = "c:/writing/scripts/invis/pu.txt"

source_line_to_open = 0
warning_story_line = 0
warning_walkthrough_line = 0
invis_line_to_open = 0

undef_use_points = 0

current_region = "None"

region_def_line = defaultdict(int)
base_reg_incs = defaultdict(int)
directed_incs = defaultdict(int)
totals = defaultdict(int)
in_source = defaultdict(int)
machine_uses = defaultdict(int)
machine_uses_in_source = defaultdict(int)
machine_def = defaultdict(int)
machine_actions = defaultdict(str)

use_in_source = defaultdict(int)
use_in_invisiclues_main = defaultdict(int)
use_in_invisiclues_summary = defaultdict(int)
use_in_walkthrough = defaultdict(int)
use_in_trizflow = defaultdict(int)
invis_points = defaultdict(int)
invis_region_points = defaultdict(int)
source_region = defaultdict(str)

def usage():
    print("-v for verbose")
    print("-s for semi verbose")
    print("-h to show hash values")
    exit()

def detect_region(a, b):
    if '[' not in a:
        return ('ignore', b)
    temp = re.sub(".*\[", "", a.strip())
    temp = re.sub("\].*", "", temp)
    if semi_verbose: print("DEBUG:", temp)
    if 'odd do' in a.lower():
        return('odd do', temp)
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
    this_line = 0
    summary_region = ''
    with open(invis_raw) as file:
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
                invis_region_points[ll] = this_line
            if line.strip() == '#summary below':
                in_summary = True
                continue
            if in_summary:
                if line.startswith('?How do I get all the'):
                    summary_region = re.sub(".*points for ", "", line.lower().strip())
                    summary_region = re.sub("\?", "", summary_region)
                    # print("Starting region", summary_region)
                    continue
                elif line.strip() == ';' or line.startswith('?What is unsorted'):
                    summary_region = ''
                    continue
                if line.startswith("1 point if you ") or line.startswith("1 point for "): # obviously this needs to be cleaned up for custom commands
                    ll = re.sub("^1 point (for|if you) ", "", line.strip())
                    ll = re.sub("\..*", "", ll)
                    ll = re.sub(" [a-z].*", "", ll)
                    if source_region[ll] != summary_region:
                        summary_err = summary_err + 1
                        print("Command", ll, "has conflicting source and summary regions. Source={:s}, Summary={:s}.".format(source_region[ll], summary_region))
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
            if source_region[x] == 'odd do': continue
            if not main_err: print("=" * 40)
            print("ERROR: Need this source line in invisiclues main:", x)
            main_err = main_err + 1
        elif x not in use_in_source.keys():
            if source_region[x] == 'odd do': continue
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


def source_vs_trizbort_flow():
    summary_err = 0
    line_count = 0
    plus_one = 0
    with open(triz_flow) as file:
        for line in file:
            line_count = line_count + 1
            if not "room id=" in line: continue
            if "No Points" in line: continue
            # if "Misc Points" in line: continue # we may wish to turn this spigot back on later if there's an easy way to integrate this check. But right now, there isn't.
            rn = re.sub(r".* name=\"([^\"]*)\".*", r'\1', line.strip())
            use_in_trizflow[rn] = line_count
            # print("Adding", rn)
    for x in list(set(use_in_trizflow.keys()) | set(use_in_source.keys())):
        if x not in sorted(use_in_trizflow.keys()):
            print("ERROR: source not flow", x, "in source but not in trizbort flow file", triz_flow)
            summary_err = summary_err + 1
    for x in list(set(use_in_trizflow.keys()) | set(use_in_source.keys())):
        if x not in sorted(use_in_source.keys()):
            if "USE " + x in use_in_source.keys():
                print("TIP: Need USE before", x)
            print("ERROR: flow not source", x, "in trizbort flow file", triz_flow, "but not source")
            summary_err = summary_err + 1
    print(summary_err, "trizbort flow/source sync violations.")

def source_vs_walkthrough():
    any_err = 0
    line_count = 0
    plus_one = 0
    global warning_walkthrough_line
    xxx = { 'N': True, 'S': True, 'E': True, 'W': True, 'GET': True }
    with open(main_thru) as file:
        for line in file:
            line_count = line_count + 1
            if not line.startswith('>') and not line.startswith("(+1)"): continue
            ll = re.sub(".*> *", "", line.strip())
            cmd_ary = ll.split(".")
            if cmd_ary[0] not in xxx.keys():
                if use_in_source[ll]:
                    if ll in use_in_walkthrough.keys():
                        print(ll, "duplicate non-points command, may not be error.")
                    if "(+1)" not in line:
                        print("WARNING: may need +1 at line", line_count, "of walkthrough:", ll)
                        plus_one = plus_one + 1
                        warning_walkthrough_line = line_count
                if ll in use_in_walkthrough.keys():
                    print("WARNING line", line_count, "has duplicate command:", ll)
                    warning_walkthrough_line = line_count
                use_in_walkthrough[ll] = True
    for x in list(set(use_in_walkthrough.keys()) | set(use_in_source.keys())):
        if x not in use_in_walkthrough.keys() and source_region[x] != 'odd do':
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
    in_use_table = False
    use_ons = False
    func_list = ''
    need_true_score = False
    truth_array = [ 'false', 'true' ]
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
                machine_def[mname] = line_count
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
            if ('score-inc' in line or 'reg-inc odd do' in line.lower()) and '\t' in line:
                (temp_region, this_cmd) = detect_region(line, current_region)
                if temp_region == 'ignore':
                    continue
                if this_cmd:
                    source_region[this_cmd] = temp_region
                    use_in_source[this_cmd] = line_count
                    if verbose: print("Tacking on", this_cmd)
                if temp_region == current_region and '[' in line:
                    if semi_verbose: print("WARNING temp_region not a change from current_region", current_region, "line", line_count, "in story.ni")
                    warning_story_line = line_count
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
            if line.startswith("table of useons"):
                in_use_table = True
                if 'continued' not in line:
                    need_true_score = True
                    use_ons = True
                continue
            elif in_use_table and not line.strip():
                in_use_table = False
                use_ons = False
                need_true_score = False
                continue
            if in_use_table:
                x = ll.split("\t")
                if x[5] != truth_array[need_true_score] and x[5] != "sco":
                    print("WARNING: Line", line_count, "has wrong true/false for score. It is", x[5], "and should be", str(need_true_score).lower() + ".")
                    warning_story_line = line_count
                if use_ons:
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
                            source_region[cmd] = temp_region
                        else:
                            if not temp_region:
                                print("Blank temp region at line", line_count, "in use table.")
                            elif temp_region not in region_def_line.keys():
                                print(temp_region, "at line", line_count, " in use table not a valid region.")
                            elif verbose:
                                print(temp_region, "at line", line_count, " in use table given extra point.")
                            undef_use_points = undef_use_points + 1

get_stuff_from_source()

source_vs_trizbort_flow()
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
        source_line_to_open = region_def_line[x]
        if source_line_to_open:
            print("NOTE: this supersedes opening line", source_line_to_open)
    if in_source[x] != invis_points[x]:
        print("ERROR: region", x, "has", in_source[x], "in source, but invisiclues list", invis_points[x])
        if invis_line_to_open:
            print("NOTE: this supersedes opening line", invis_line_to_open)
        invis_line_to_open = invis_region_points[x]
    print(x, totals[x])

for x in sorted(machine_uses.keys()):
    if machine_uses[x] != machine_uses_in_source[x]:
        print("Machine", x, "has", machine_uses[x], "uses in table but", machine_uses_in_source[x], "uses listed in the source.")
        if source_line_to_open:
            print("NOTE: this supersedes opening line", source_line_to_open)
        source_line_to_open = machine_def[x]

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

if source_line_to_open:
    i7.npo(main_source, source_line_to_open, True)
elif warning_story_line:
    i7.npo(main_source, warning_story_line, True)

print("Total =", t2)

if invis_line_to_open:
    i7.npo(invis_raw, invis_line_to_open, True)
if warning_walkthrough_line:
    i7.npo(main_thru, warning_walkthrough_line, True)
