# sc2.py
#
# attempts to isolate how many points you can score in each region
#
# replaces msc.py
#
# todo: if I forgot a +1, fill it in
#
# todo: invisiclues order vs walkthrough order
#
# this is a bit tricky because of regions -- however, it is worthwhile

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
test_file = "c:/Program Files (x86)/Inform 7/Inform7/Extensions/Andrew Schultz/Put it Up Tests.i7x"

source_line_to_open = 0
warning_story_line = 0
warning_walkthrough_line = 0
invis_line_to_open = 0

undef_use_points = 0

max_dif = 0

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

llp_commands = defaultdict(int)
ignore_points = defaultdict(int)

test_ary = []
test_order = defaultdict(int)
walkthrough_order = defaultdict(int)
source_cmd_order = defaultdict(int)

# constants
ignore_cmd_array = { 'N': True, 'S': True, 'E': True, 'W': True, 'GET': True }
dupes = { "WORK ROW": True, "WORD ROW": True, "PACE CAP": True }

def usage():
    print("-v for verbose")
    print("-s for semi verbose")
    print("-h to show hash values")
    print("-md for maximum difference in walkthrough files. default = 0, which means don't run.")
    exit()

def best_guess(ll):
    closest_under = "START"
    closest_over = "END"
    for x in sorted(test_order.keys(), key=test_order.get):
        if source_region[x] != source_region[ll]:
            continue
        if test_order[x] < test_order[ll]:
            closest_under = x
        if test_order[x] > test_order[ll]:
            closest_over = x
            break
    return "between {:s}({:d}) and {:s}({:d})".format(closest_under, test_order[closest_under], closest_over, test_order[closest_over])

def read_test_file_order():
    with open(test_file) as file:
        for line in file:
            if not re.search(r"^\[?test part", line): continue
            qary = line.strip().upper().split('"')
            cmd_ary = re.sub("\/$", "", qary[1]).split("/")
            for x in cmd_ary:
                if x not in llp_commands.keys():
                    test_ary.append(x)
    for a in range(0, len(test_ary)):
        if test_ary[a] not in dupes.keys():
            test_order[test_ary[a]] = a + 1

def walkthrough_vs_test_file(maxdif):
    if not maxdif:
        print("Skipping walkthrough vs test file comparison. Run -md(#) or -md (#) to try this.")
        return
    wthru_ary = []
    count = 0
    with open(main_thru) as file:
        for line in file:
            if '>' not in line: continue
            if 'grep -i' in line: continue
            ll = re.sub(".*> ?", "", line.strip())
            cmd_ary = ll.split(".")
            for x in cmd_ary:
                wthru_ary.append(x)
    up_to = min(len(test_ary), len(wthru_ary))
    if len(test_ary) != len(wthru_ary):
        print("WARNING test/walkthrough are different sizes:", len(test_ary), "<test wthru>", len(wthru_ary))
    cur_dif = 0
    dif_ary = []
    walk_test_mismatch_yet = False
    for i in range(0, up_to):
        if test_ary[i] != wthru_ary[i]:
            if not walk_test_mismatch_yet:
                walk_test_mismatch_yet = True
                print("Showing (up to) first", up_to, "differences.")
            cur_dif = cur_dif + 1
            print(i, cur_dif, test_ary[i], "< test ary, wthru ary >", wthru_ary[i])
            dif_ary.append(test_ary[i])
            if cur_dif == max_dif:
                break
    if cur_dif == 0:
        print("No differences! Walkthrough matches test file.")
    out_dif_string = ""
    cr = 0
    for i in range(0, len(dif_ary)):
        if dif_ary[i].startswith("USE"):
            out_dif_string = out_dif_string + "\n(+1) >";
            cr = 0
        elif cr % 5 == 0:
            out_dif_string = out_dif_string + "\n>"
            cr = cr + 1
        else:
            out_dif_string = out_dif_string + "."
            cr = cr + 1
        out_dif_string = out_dif_string + dif_ary[i]
    if out_dif_string: print(out_dif_string)

def source_table_vs_test_file():
    in_test = defaultdict(bool)
    test_order = defaultdict(int)
    test_file_short = re.sub(".*[\\\/]", "", test_file)
    test_file_errs = 0
    count = 0
    test_source_order_yet = False
    with open(test_file) as file:
        for line in file:
            if not re.search(r"^\[?test part", line): continue
            qary = line.strip().split('"')
            cmd_ary = re.sub("\/$", "", qary[1]).split("/")
            for x in cmd_ary:
                w1 = re.sub(" .*", "", x)
                if w1.upper() in ignore_cmd_array.keys(): continue
                if x.upper() in llp_commands.keys(): continue
                if x.upper() in dupes.keys() and x in in_test.keys(): continue
                if x in in_test.keys():
                    print("WARNING", x, "duplicated in", qary[0])
                    continue
                in_test[x] = True
                count = count + 1
                test_order[x.upper()] = count
    for x in sorted(source_cmd_order, key=source_cmd_order.get):
        if x not in test_order.keys():
            print("Need test_order entry for", x)
            test_file_errs = test_file_errs + 1
    for x in sorted(test_order.keys()):
        if x not in source_cmd_order.keys() and x not in llp_commands.keys():
            print("Oops! Test command", x, "does not appear in the source commands.")
            test_file_errs = test_file_errs + 1
    cmdval = 0
    oops = 0
    look_again = True
    while look_again:
        look_again = False
        cmdval = cmdval + 1
        str1 = 'N/A'
        str2 = 'N/A'
        for x in test_order.keys():
            if test_order[x] == cmdval:
                look_again = True
                str1 = x
        for x in source_cmd_order.keys():
            if source_cmd_order[x] == cmdval:
                look_again = True
                str2 = x
        if str1 != str2:
            if not test_source_order_yet:
                print("NOTE: The #s on the right are the order found in the source.")
                test_source_order_yet = True
            oops = oops + 1
            print(cmdval, oops, str1, source_cmd_order[str1], "< test source >", str2, source_cmd_order[str2])
            test_file_errs = test_file_errs + 1
    print("Total source table vs. test file errors:", test_file_errs, "with", oops, "being order errors.")

def bonus_mistake_check():
    count = 0
    line_count = 0
    with open(main_source) as file:
        for line in file:
            line_count = line_count + 1
            if re.search("understand.*as a mistake", line, re.IGNORECASE):
                print("ERROR: line", line_count, "should be relocated to mistakes.i7x:", line.strip())
                count = count + 1
    if count:
        print(count, "total error" + ("" if count == 1 else "s"))
    else:
        print("No 'understand as a mistake' errors in source. Trivial test passed.")

def detect_region(a, b):
    if '[' not in a:
        return ('ignore', b)
    temp = re.sub(".*\[", "", a.strip())
    temp = re.sub("\].*", "", temp)
    if semi_verbose: print("DEBUG:", temp)
    if 'odd do' in a.lower() or 'abide by the llp rule' in a.lower():
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
    last_test = 0
    ooo_this_region = 0
    ooo_test = 0
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
                    if ooo_this_region:
                        print(summary_region, "had", ooo_this_region, "out of order in invisiclues.")
                        ooo_this_region = 0
                    summary_region = re.sub(".*points for ", "", line.lower().strip())
                    summary_region = re.sub("\?", "", summary_region)
                    # print("Starting region", summary_region)
                    last_test = 0
                    continue
                elif line.strip() == ';' or line.startswith('?What is unsorted'):
                    summary_region = ''
                    continue
                if line.startswith("1 point if you ") or line.startswith("1 point for "): # obviously this needs to be cleaned up for custom commands
                    ll = re.sub("^1 point (for|if you) ", "", line.strip())
                    ll = re.sub("\..*", "", ll)
                    ll = re.sub(" [a-z].*", "", ll)
                    if ll in test_order.keys():
                        if test_order[ll] < last_test and source_region[ll] != 'odd do':
                            print("Out of order", test_order[ll], ll, "in invisiclues point summary region", source_region[ll])
                            print("        Best guess:", best_guess(ll))
                            ooo_this_region = ooo_this_region + 1
                            ooo_test = ooo_test + 1
                        else:
                            pass
                            # print(ll, test_order[ll])
                        last_test = test_order[ll]
                    if ll not in source_region and ll not in llp_commands.keys():
                        summary_err = summary_err + 1
                        print("Command", ll, "is in summary but not source. Summary region={:s}.".format(summary_region))
                    elif source_region[ll] != summary_region:
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
    if ooo_test:
        print("Test/invisiclues total out of order =", ooo_test)
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
            if x not in use_in_invisiclues_summary.keys() and x not in llp_commands.keys() and x not in ignore_points.keys():
                if not main_err and not summary_err: print ("=" * 40)
                print("ERROR: Need this source line in invisiclues summary:", x)
                summary_err = summary_err + 1
            elif x not in use_in_source.keys() and x not in llp_commands.keys():
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
    asterisked = defaultdict(int)
    with open(triz_flow) as file:
        for line in file:
            line_count = line_count + 1
            if not "room id=" in line: continue
            if 'secondFill="#80FFFF"' in line:
                print("WARNING line", line_count, "has the wrong color blue. Yeah, trivial, but...")
                print(line)
            if "No Points" in line: continue
            # if "Misc Points" in line: continue # we may wish to turn this spigot back on later if there's an easy way to integrate this check. But right now, there isn't.
            rn = re.sub(r".* name=\"([^\"]*)\".*", r'\1', line.strip())
            if re.search(r"^USE (REIFIER|ROTATOR|REVIVER)", rn):
                print("ERROR: swap 1st/2nd nouns in trizbort flow element", rn)
            if rn.endswith('*'):
                rn2 = re.sub("\*$", "", rn)
                asterisked[rn2] = line_count
            else:
                use_in_trizflow[rn] = line_count
            # print("Adding", rn)
    for x in asterisked.keys():
        if x not in use_in_trizflow.keys():
            print(x, "has an asterisked flowchart entry but not a non-asterisked.")
    for x in list(set(use_in_trizflow.keys()) | set(use_in_source.keys())):
        if x not in sorted(use_in_trizflow.keys()):
            print("ERROR: source not flow", x, "in source but not in trizbort flow file", triz_flow)
            summary_err = summary_err + 1
    for x in list(set(use_in_trizflow.keys()) | set(use_in_source.keys())):
        if x not in use_in_source.keys() and x not in llp_commands.keys():
            if "USE " + x in use_in_source.keys():
                print("TIP: Need USE before", x)
            print("ERROR: flow not source", x, "in trizbort flow file", triz_flow, "but not source")
            summary_err = summary_err + 1
    print(summary_err, "trizbort flow/source sync violations.")

def source_vs_walkthrough():
    any_err = 0
    line_count = 0
    plus_one = 0
    walkthrough_count = 0
    global warning_walkthrough_line
    with open(main_thru) as file:
        for line in file:
            line_count = line_count + 1
            if not line.startswith('>') and not line.startswith("(+1)"): continue
            ll = re.sub(".*> *", "", line.strip())
            cmd_ary = ll.split(".")
            verb1 = re.sub(" .*", "", cmd_ary[0])
            if verb1 not in ignore_cmd_array.keys():
                if ll in use_in_source.keys():
                    if ll in use_in_walkthrough.keys() and ll.upper() not in dupes.keys():
                        print(ll, "duplicate non-points command, may not be error.")
                    if ll.upper() not in dupes.keys() and "(+1)" not in line and ll.upper() not in ignore_points.keys():
                        print("WARNING: may need +1 at line", line_count, "of walkthrough:", ll)
                        plus_one = plus_one + 1
                        warning_walkthrough_line = line_count
                if ll in use_in_walkthrough.keys() and ll.upper() not in dupes.keys():
                    print("WARNING line", line_count, "has duplicate command:", ll)
                    warning_walkthrough_line = line_count
                if ll not in use_in_walkthrough.keys():
                    use_in_walkthrough[ll] = line_count
                    walkthrough_count = walkthrough_count + 1
                    walkthrough_order[ll] = walkthrough_count
    for x in list(set(use_in_walkthrough.keys()) | set(use_in_source.keys())):
        if x not in use_in_walkthrough.keys() and source_region[x] != 'odd do':
            print("ERROR: Need this line in walkthrough:", x)
            any_err = any_err + 1
        elif x not in use_in_source.keys():
            print("ERROR: (from walkthrough) Need this line in table of useons:", x)
            any_err = any_err + 1
        elif verbose:
            print("Synced:", x)
    last_source_got = 0
    ooo = 0
    for x in sorted(walkthrough_order.keys(), key=walkthrough_order.get):
        # print(x, walkthrough_order[x])
        wtc = walkthrough_order[x] # probably just increments but let's make sure
        if x not in source_cmd_order.keys():
            if x.startswith("USE"):
                print("Need use-line or af/b4 reference for command", x)
            else:
                print ("Need to add command in comments after useon entry:", x)
        else:
            if source_cmd_order[x] < last_source_got:
                print("Source commands/table of useons out of order with command", x, "walkthrough command", wtc, "last source index", last_source_got, "order in source", source_cmd_order[x])
                ooo = ooo + 1
            last_source_got = source_cmd_order[x]
    if ooo > 0: print(ooo, "walkthrough <=> table of useons order sync errors")
    if plus_one or any_err:
        print(plus_one, "walkthrough +1's needed")
        print(any_err, "total walkthrough ~ errors (non order)")
    else:
        print("Walkthrough sync test (non order) passed.")

def find_comment_cmds(pattern, line):
    if '[{:s}'.format(pattern) not in line: return []
    temp = re.sub(".*{:s}:".format(pattern), "", line.strip())
    temp = re.sub("\].*", "", temp.upper())
    return temp.split("/")

def get_stuff_from_source():
    in_use_table = False
    use_ons = False
    func_list = ''
    need_true_score = False
    truth_array = [ 'false', 'true' ]
    source_cmd_count = 0
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
            if ('score-inc' in line or 'abide by the llp rule' in line.lower()) and '\t' in line:
                (temp_region, this_cmd) = detect_region(line, current_region)
                if temp_region == 'ignore':
                    continue
                if temp_region == 'odd do':
                    llp_commands[this_cmd.upper()] = line_count
                    source_region[this_cmd.upper()] = temp_region
                    totals[temp_region] = totals[temp_region] + 1
                    continue
                increment = 1
                if this_cmd:
                    this_cmd_ary = this_cmd.upper().split("&")
                    increment = len(this_cmd_ary)
                    for t in this_cmd_ary:
                        source_region[t] = temp_region
                        use_in_source[t] = line_count
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
                    base_reg_incs[temp_region] = base_reg_incs[temp_region] + increment
                else:
                    directed_incs[temp_region] = directed_incs[temp_region] + increment
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
            elif in_use_table and (not line.strip() or line.startswith('[')):
                in_use_table = False
                use_ons = False
                need_true_score = False
                continue
            if in_use_table:
                x = ll.split("\t")
                if x[5] == 'sco': continue # this is the header.
                if x[5] != 'true' and x[5] != 'false':
                    print("WARNING: Line", line_count, "needs true/false in column 5/6.")
                    warning_story_line = line_count
                if use_ons:
                    if len(x) < 6: continue
                    if x[1] == 'reifier' or x[1] == 'reviver' or x[1] == 'rotator':
                        machine_uses[x[1]] = machine_uses[x[1]] + 1
                        machine_actions[x[1]] = machine_actions[x[1]] + "    {:s} -> {:s}\n".format(x[0], x[2])
                    if len(x) != 10:
                        print("ERROR: Line", line_count, "has the wrong # of tabs for use-table.", len(x), "should be 10. Ignoring data in this line.")
                        continue
                    cmd = "USE {:s} ON {:s}".format(x[0].upper(), x[1].upper())
                    new_cmd_ary = find_comment_cmds('b4', line)
                    new_cmd_ary.append(cmd)
                    new_cmd_ary = new_cmd_ary + find_comment_cmds('af', line)
                    for temp_cmd in new_cmd_ary:
                        source_cmd_count = source_cmd_count + 1
                        if temp_cmd in source_cmd_order.keys() and not temp_cmd.startswith("USE"): print("WARNING", temp_cmd, "is a duplicate in table of useons, line", line_count)
                        source_cmd_order[temp_cmd] = source_cmd_count
                    use_in_source[cmd] = line_count # we only track line count for "use" commands and not unusual point gainers
                    if x[5] == 'false':
                        ignore_points[cmd] = line_count
                        print("Ignoring points for", '/'.join(x[0:2]))
                    if x[5] == 'true':
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
# start main

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
    elif noh.startswith('md'):
        try:
            if re.search("[0-9]", noh):
                max_dif = int(re.sub("^md", "", noh))
            else:
                argval = argval + 1
                max_dif = int(sys.argv[argval].lower())
        except:
                print("-md needs an integer after -- in the same argument, or with a space in between.")
                exit()
    else:
        print(sys.argv[argval].lower(), "not recognized.")
        print()
        usage()
    argval = argval + 1

get_stuff_from_source()

read_test_file_order()

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
        if source_line_to_open:
            print("NOTE: this supersedes opening line", source_line_to_open)
        source_line_to_open = region_def_line[x]
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
    elif verbose:
        print("Machine", x, "uses = in-source", machine_uses[x], machine_uses_in_source[x])

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
    for x in sorted(use_in_invisiclues_source.keys()):
        print(x, use_in_invisiclues_source[x])

if source_line_to_open:
    i7.npo(main_source, source_line_to_open, True)
elif warning_story_line:
    i7.npo(main_source, warning_story_line, True)

print("Total =", t2)

bonus_mistake_check()

source_table_vs_test_file()
walkthrough_vs_test_file(max_dif)

if invis_line_to_open:
    i7.npo(invis_raw, invis_line_to_open, True)
if warning_walkthrough_line:
    i7.npo(main_thru, warning_walkthrough_line, True)
