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

main_dir = "c:/games/inform/ailihphilia.inform/source"
main_source = main_dir + "/story.ni"
main_thru = main_dir + "/walkthrough.txt"
triz_flow = "c:/games/inform/triz/mine/ailihphilia-flow.trizbort"
invis_raw = "c:/writing/scripts/invis/ai.txt"
test_file = "c:/Program Files (x86)/Inform 7/Inform7/Extensions/Andrew Schultz/Ailihphilia Tests.i7x"

obj_name_hash = {
  "ti": "TO IDIOT",
  "go by bog": "GO-BY BOG",
}

reg_to_border = { "yelpley": "dash", "dim mid": "solid", "grebeberg": "dot" }

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
nontable_totals = defaultdict(int)
table_totals = defaultdict(int)
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
trizflow_llp_rooms = defaultdict(int)

invis_points = defaultdict(int)
invis_region_points = defaultdict(int)
source_region = defaultdict(str)
flow_region = defaultdict(str)

llp_commands = defaultdict(int)
ignore_points = defaultdict(int)

col_names = defaultdict(str)

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

# this reads through the file twice, but otherwise the file parsing gets too confusing. It's already probably more tangled than it should be.

def check_source_rule_order():
    line_count = 0
    last_rule = ""
    rule_search = False
    errs = 0
    extra_lines = 0
    rule_sections = 0
    last_line = 0
    in_table = False
    alfcheck = defaultdict(lambda: defaultdict(bool))
    ignorables = defaultdict(bool)
    extra_rules = 0
    current_table = ''
    with open(main_source) as file:
        for (line_count, line) in enumerate(file, 1):
            if line.startswith("table"):
                current_table = line.strip()
                in_table = True
                continue
            if not line.strip() or line.startswith("["):
                in_table = False
                continue
            lary = re.split("\t+", line.strip())
            if in_table and 'goodacts' in current_table:
                if lary[col_names['use1']] == '--' and lary[col_names['use2']] == '--':
                    if 'rule' in lary[col_names['preproc']]:
                        alfcheck['xxrr'][re.sub(" rule.*", "", lary[col_names['preproc']].lower())] = True
                if 'rule' in lary[col_names['preproc']]:
                    alfcheck['xxpre'][re.sub(" rule.*", "", lary[col_names['preproc']].lower())] = True
                if 'rule' in lary[col_names['postproc']]:
                    alfcheck['xxpost'][re.sub(" rule.*", "", lary[col_names['postproc']].lower())] = True
            if line.startswith("section"):
                if 'post-use rules' in line or 'pre-use rules' in line or 'section rev rules' in line:
                    rule_search = True
                    rule_sections += 1
                    last_rule = ""
                    to_check = re.sub(".*\[", "", line.strip())
                    to_check = re.sub("\].*", "", to_check)
                    continue
            if re.search("^(chapter|section|book|part|volume)", line.lower()):
                rule_search = False
                continue
            if rule_search and line.startswith("this is the") and not '[ignore rule check]' in line.lower():
                cur_rule = re.sub("^this is the ", "", line.strip().lower())
                cur_rule = re.sub(" rule.*", "", cur_rule)
                if cur_rule not in alfcheck[to_check].keys() and cur_rule not in ignorables.keys():
                    print(cur_rule, "in", to_check, "may be extraneous, line", line_count)
                    extra_rules += 1
                if cur_rule < last_rule:
                    print("ERROR: Line", line_count, "rule", cur_rule, "alphabetically before", last_rule, "line", last_line)
                    errs += 1
                last_rule = cur_rule
                last_line = line_count
    print((errs if errs > 0 else "no"), "rule order errors for table of goodacts.")
    print((extra_lines if extra_lines > 0 else "no"), "extra rules post-table of goodacts.")
    if rule_sections != 3: # hard coded ?? can we list the sections we want?
        print("Have", rule_sections, "rules but should have 3.")

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
            cur_dif += 1
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
            cr += 1
        else:
            out_dif_string = out_dif_string + "."
            cr += 1
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
                count += 1
                test_order[x.upper()] = count
    for x in sorted(source_cmd_order, key=source_cmd_order.get):
        if x not in test_order.keys():
            print("Need test_order entry for", x, "as it doesn't appear in the tests file.")
            test_file_errs += 1
    for x in sorted(test_order.keys()):
        if x not in source_cmd_order.keys() and x not in llp_commands.keys():
            print("Oops! Test command", x, "does not appear in the source commands.")
            test_file_errs += 1
    cmdval = 0
    oops = 0
    look_again = True
    while look_again:
        look_again = False
        cmdval += 1
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
            oops += 1
            print(cmdval, oops, str1, source_cmd_order[str1], "< test source >", str2, source_cmd_order[str2])
            test_file_errs += 1
    print("Total source table vs. test file errors:", test_file_errs, "with", oops, "being order errors.")

def bonus_mistake_check():
    count = 0
    line_count = 0
    with open(main_source) as file:
        for line in file:
            line_count += 1
            if re.search("understand.*as a mistake", line, re.IGNORECASE):
                print("ERROR: line", line_count, "should be relocated to mistakes.i7x:", line.strip())
                count += 1
    if count:
        print(count, "total error" + ("" if count == 1 else "s"))
    else:
        print("No 'understand as a mistake' errors in source. Trivial test passed.")

def detect_region(a, b, lc):
    if '[' not in a:
        return ('ignore', b)
    temp = re.sub(".*\[", "", a.strip().lower())
    temp = re.sub("\].*", "", temp)
    if semi_verbose: print("DEBUG:", temp)
    if 'odd do' in a.lower() or 'abide by the llp rule' in a.lower():
        return('odd do', temp)
    my_region = ""
    cmd = ""
    ary = temp.split("/")
    if 'reg-inc ' in a:
        my_region = re.sub(".*reg-inc ", "", a.strip().lower())
        my_region = re.sub(";.*", "", my_region)
        if (len(ary) > 1):
            print("Line", lc, "NO SLASHES WHEN REGION IS DEFINED BY REG-INC:", a.rstrip()) # also end=''
            exit()
        cmd = ary[0]
    else:
        if len(ary) == 1:
            return (ary[0].lower(), None)
        elif len(ary) > 2:
            print("TOO MANY SLASHES:", a)
            exit()
        my_region = ary[0]
        cmd = ary[1]
    return (my_region, cmd)

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
    last_cmd_tested = ""
    with open(invis_raw) as file:
        for line in file:
            this_line += 1
            if line.strip() == '#summary below':
                in_summary = True
                continue
            if line.startswith('#'): continue
            if line.startswith(';'): break
            if 'total points in' in line:
                ll = re.sub(".*total points in *", "", line.strip().lower())
                ll = re.sub("\..*", "", ll)
                pts = re.sub(" *total points.*", "", line.strip())
                pts = re.sub(".* ", "", pts)
                try:
                    invis_points[ll] = int(pts)
                except:
                    print("Non integer points", pts, "getting region points from line", this_line, ":", line.strip())
                    exit()
                invis_region_points[ll] = this_line
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
                            print("        Last command that worked:", last_cmd_tested, test_order[last_cmd_tested] if last_cmd_tested in test_order.keys else "????")
                            ooo_this_region += 1
                            ooo_test += 1
                        else:
                            pass
                            # print(ll, test_order[ll])
                        last_cmd_tested = ll
                    if ll not in source_region and ll not in llp_commands.keys():
                        summary_err += 1
                        print("Command", ll, "is in summary but not source. Summary region={:s}.".format(summary_region))
                    elif source_region[ll] != summary_region:
                        summary_err += 1
                        print("Command", ll, "has conflicting source and summary regions. Source={:s}, Summary={:s}.".format(source_region[ll], summary_region))
                    if ll in use_in_invisiclues_summary.keys(): print("WARNING line", this_line,"has duplicate command:", ll)
                    use_in_invisiclues_summary[ll] = True
            else:
                if line == line.upper() and not line.startswith('?') and not line.startswith('#') and not line.startswith('>'):
                    ll = re.sub("\..*", "", line.strip())
                    # print("Found in invisiclues main:", ll)
                    if ll in use_in_invisiclues_main.keys(): print("WARNING line", this_line,"has duplicate command:", ll)
                    use_in_invisiclues_main[ll] = True
    print("Invisiclues points:", ', '.join(['{:s} {:d}'.format(i, invis_points[i]) for i in invis_points.keys()]))
    if ooo_test:
        print("Test/invisiclues total out of order =", ooo_test)
    for x in list(set(use_in_invisiclues_main.keys()) | set(use_in_source.keys())):
        if x not in use_in_invisiclues_main.keys():
            if source_region[x] == 'odd do': continue
            if not main_err: print("=" * 40)
            print("ERROR: Need this source line in invisiclues main:", x)
            main_err += 1
        elif x not in use_in_source.keys():
            if source_region[x] == 'odd do': continue
            if not main_err: print("=" * 40)
            print("ERROR: Need this invisiclues main line in source(table of goodacts or [region/command]:", x)
            main_err += 1
        elif verbose:
            print("Synced to main:", x)
    if in_summary:
        if main_err: print("=" * 40)
        for x in list(set(use_in_invisiclues_summary.keys()) | set(use_in_source.keys())):
            if x not in use_in_invisiclues_summary.keys() and x not in llp_commands.keys() and x not in ignore_points.keys():
                if not main_err and not summary_err: print ("=" * 40)
                print("ERROR: Need this source line in invisiclues summary:", x)
                summary_err += 1
            elif x not in use_in_source.keys() and x not in llp_commands.keys():
                if not main_err and not summary_err: print ("=" * 40)
                print("ERROR: Need this invisiclues summary line in source(table of goodacts or [region/command]:", x)
                summary_err += 1
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
    flo_region_errs = 0
    asterisked = defaultdict(int)
    with open(triz_flow) as file:
        for line in file:
            line_count += 1
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
                if rn in trizflow_llp_rooms.keys() or rn in use_in_trizflow.keys():
                    print("Possible duplicate room", rn)
                if "Misc Points" in line:
                    trizflow_llp_rooms[rn] = line_count
                else:
                    use_in_trizflow[rn] = line_count
                    floreg = re.sub(".*region=\"", "", line.strip().lower())
                    floreg = re.sub("\".*", "", floreg)
                    if floreg != source_region[rn]:
                        print("Oops mismatched source/flow regions for {:s} flow={:s} source={:s}".format(rn, floreg if floreg else "NONE", source_region[rn] if source_region[rn] else "NONE"))
                        flo_region_errs += 1
            # print("Adding", rn)
    if flo_region_errs > 0:
        print(flo_region_errs, "region/border errors")
    for x in asterisked.keys():
        if x not in use_in_trizflow.keys():
            print(x, "has an asterisked flowchart entry but not a non-asterisked.")
    for x in list(set(use_in_trizflow.keys()) | set(use_in_source.keys())):
        if x not in use_in_trizflow.keys() and x not in ignore_points.keys():
            print("ERROR: source not flow", x, "in source but not in trizbort flow file", triz_flow)
            summary_err += 1
    for x in list(set(use_in_trizflow.keys()) | set(use_in_source.keys())):
        if x not in use_in_source.keys():
            if "USE " + x in use_in_source.keys():
                print("TIP: Need USE before", x)
            print("ERROR: flow not source", x, "in trizbort flow file", triz_flow, "but not source")
            summary_err += 1
    for x in list(set(trizflow_llp_rooms.keys()) | set(llp_commands.keys())):
        if x not in trizflow_llp_rooms.keys():
            print("Need", x, "as a Trizbort Flow LLP room.")
        elif x not in llp_commands.keys():
            print("Need", x, "as an LLP command, or delete from Trizbort Flow LLP.")
    print(summary_err, "trizbort flow/source sync violations.")

def source_vs_walkthrough():
    any_err = 0
    line_count = 0
    plus_one = 0
    walkthrough_count = 0
    global warning_walkthrough_line
    with open(main_thru) as file:
        for line in file:
            line_count += 1
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
                        plus_one += 1
                        warning_walkthrough_line = line_count
                if ll in use_in_walkthrough.keys() and ll.upper() not in dupes.keys():
                    print("WARNING line", line_count, "has duplicate command:", ll)
                    warning_walkthrough_line = line_count
                if ll not in use_in_walkthrough.keys():
                    use_in_walkthrough[ll] = line_count
                    walkthrough_count += 1
                    walkthrough_order[ll] = walkthrough_count
    for x in list(set(use_in_walkthrough.keys()) | set(use_in_source.keys())):
        if x not in use_in_walkthrough.keys() and source_region[x] != 'odd do':
            print("ERROR: Need this line in walkthrough:", x)
            any_err += 1
        elif x not in use_in_source.keys():
            print("ERROR: (from walkthrough) Need this line in table of goodacts:", x)
            any_err += 1
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
                print ("Need to add command in comments after goodacts entry:", x)
        else:
            if source_cmd_order[x] < last_source_got:
                print("Source commands/table of goodacts out of order with command", x, "walkthrough command", wtc, "last source index", last_source_got, "order in source", source_cmd_order[x])
                ooo += 1
            last_source_got = source_cmd_order[x]
    if ooo > 0: print(ooo, "walkthrough <=> table of goodacts order sync errors")
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
    goodact_idx = 0
    in_use_table = False
    use_ons = False
    func_list = ''
    need_true_score = False
    truth_array = [ 'false', 'true' ]
    source_cmd_count = 0
    must_have = [ 'sco', 'd1', 'd2' ]
    with open(main_source) as file:
        for (line_count, line) in enumerate(file, 1):
            ll = line.strip().lower()
            if ll:
                func_list = func_list + line
            else:
                func_list = ''
            if 'workable. useleft' in ll:
                mname = re.sub(" is a workable.*", "", ll)
                mname = re.sub("^the ", "", mname)
                muses = re.sub(".* useleft is ", "", ll)
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
            if ('score-inc' in line or 'abide by the llp rule' in line.lower()) and '\t' in line or 'reg-inc ' in line:
                (temp_region, this_cmd) = detect_region(line, current_region, line_count)
                if temp_region == 'ignore':
                    continue
                if temp_region == 'odd do':
                    llp_commands[this_cmd.upper()] = line_count
                    source_region[this_cmd.upper()] = temp_region
                    nontable_totals[temp_region] += 1
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
            if line.startswith("table of goodacts"):
                goodact_idx += 1
                table_start = line_count
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
                x = [re.sub(" ?\(.*", "", q) for q in ll.split("\t")]
                if line_count == table_start + 1:
                    for x1 in range (0, len(x)): col_names[x[x1]] = x1
                    for y in must_have:
                        if y not in col_names.keys(): sys.exit("Need {:s} in column headers.".format(y))
                    sco_col = col_names['sco']
                    u1_col = col_names['use1']
                    u2_col = col_names['use2']
                    d1_col = col_names['d1']
                    d2_col = col_names['d2']
                    done_col = col_names['done']
                    getit_col = col_names['getit']
                    preproc_col = col_names['preproc']
                    reg_col = col_names['reg-plus']
                    header_line = line.strip()
                    continue
                if len(x) != len(col_names.keys()):
                    print("ERROR: Line", line_count, "has the wrong # of tabs for use-table. Is {:d}, should be {:d}.".format(len(x), len(col_names.keys())))
                    print(x)
                    print(header_line)
                    print(col_names.keys())
                    exit()
                    continue # this should mean a rule
                if x[u1_col] in obj_name_hash.keys(): x[u1_col] = obj_name_hash[x[u1_col]]
                if goodact_idx > 1:
                    for idx in [ sco_col, d1_col, d2_col ]:
                        if x[idx] != 'false':
                            print("WARNING: Line", line_count, "must be false in non-scoring table of goodacts, column", (idx + 1))
                if x[u1_col] != '--' and x[u2_col] != '--':
                    if x[d1_col] != 'true' and x[d1_col] != 'false': print("WARNING: Line", line_count, "needs true/false in column {:d}.".format(d1_col))
                    if x[d2_col] != 'true' and x[d2_col] != 'false': print("WARNING: Line", line_count, "needs true/false in column {:d}.".format(d2_col))
                    if x[done_col] != 'true' and x[done_col] != 'false': print("WARNING: Line", line_count, "needs true/false in column {:d}.".format(done_col))
                    warning_story_line = line_count
                if use_ons:
                    if x[u2_col] == 'reifier' or x[u2_col] == 'reviver' or x[u2_col] == 'rotator':
                        machine_uses[x[u2_col]] = machine_uses[x[u2_col]] + 1
                        machine_actions[x[u2_col]] = machine_actions[x[u2_col]] + "    {:s} -> {:s}\n".format(x[u1_col], x[getit_col])
                    cmd = ""
                    if x[u1_col] != '--' and x[u2_col] != '--':
                        cmd = "USE {:s} ON {:s}".format(obj_name_hash[x[u1_col]] if x[u1_col] in obj_name_hash else x[u1_col].upper(),
                            obj_name_hash[x[u2_col]] if x[u2_col] in obj_name_hash else x[u2_col].upper())
                        new_cmd_ary = find_comment_cmds('b4', line)
                        new_cmd_ary.append(cmd)
                        new_cmd_ary = new_cmd_ary + find_comment_cmds('af', line)
                        for temp_cmd in new_cmd_ary:
                            source_cmd_count += 1
                            if temp_cmd in source_cmd_order.keys() and not temp_cmd.startswith("USE"): print("WARNING", temp_cmd, "is a duplicate in table of goodacts, line", line_count)
                            source_cmd_order[temp_cmd] = source_cmd_count
                        use_in_source[cmd] = line_count # we only track line count for "use" commands and not unusual point gainers
                    else:
                        cmd = x[preproc_col]
                    if x[sco_col] == 'false' or 'sc2-ignore' in ll:
                        ignore_points[cmd] = line_count
                        print("Ignoring points for", '/'.join(x[u1_col:u1_col+2]) if x[u1_col] != '--' else x[preproc_col])
                    elif x[sco_col] == 'true':
                        temp_region = ""
                        if x[reg_col] and x[reg_col] != '--' and x[reg_col] != 'reg-plus': # a bit hacky, but basically, check for 9th goodacts table entry being a proper region
                            temp_region = x[reg_col].lower()
                        if temp_region:
                            table_totals[temp_region] += 1
                            if x[u1_col] != '--':
                                directed_incs[temp_region] += 1
                                source_region[cmd] = temp_region
                        else:
                            if not temp_region:
                                print("Blank temp region at line", line_count, "in use table.")
                            elif temp_region not in region_def_line.keys():
                                print(temp_region, "at line", line_count, " in use table not a valid region.")
                            elif verbose:
                                print(temp_region, "at line", line_count, " in use table given extra point.")
                            undef_use_points += 1


def think_look_check():
    skip_header = False
    in_main_table = False
    reject_track = defaultdict(int)
    wipe_track = defaultdict(int)
    table_track = defaultdict(int)
    with open(main_source) as file:
        for (line_count, line) in enumerate(file, 1):
            if skip_header:
                skip_header = False
                continue
            if line.startswith('table of lateruses'):
                in_main_table = True
                skip_header = True
                continue
            if in_main_table:
                ll = line.lower().split("\t")
                if len(ll) < 2:
                    in_main_table = False
                    continue
                if ll[0] == '--': continue
                table_track[ll[0]] = line_count
                continue
            if 'get-rej of ' in line:
                if line.startswith("to say get-rej of"): continue
                ll = re.sub(".*get-rej of ", "", line.lower().strip())
                ll = re.sub("\].*", "", ll)
                reject_track[ll] = line_count
            if '\tget-reject' in line:
                ll = re.sub(".*get-reject ", "", line.lower().strip())
                ll = re.sub(";.*", "", ll)
                reject_track[ll] = line_count
            if '\tlater-wipe' in line:
                ll = re.sub(".*later-wipe ", "", line.lower().strip())
                ll = re.sub(";.*", "", ll)
                wipe_track[ll] = line_count
    think_check = 0
    wipes = laters = getrej = ""
    delete = defaultdict(bool)
    for x in wipe_track.keys():
        if x not in table_track and x not in reject_track:
            print(x, "has a later-wipe but is never in get-reject or table-track.")
            delete[x] = True
    for x in delete: wipe_track.pop(x)
    for x in sorted(list(set(wipe_track.keys()) | set(table_track.keys()) | set(reject_track.keys()))):
        # print(x, "===================")
        if x not in wipe_track.keys():
            wipes += "{0} needs to have a later-wipe line.\n".format(x)
            think_check += 1
        if x not in table_track.keys():
            laters += "{0} needs to have a table of lateruses line.\n".format(x)
            think_check += 1
        if x not in reject_track.keys():
            getrej += "{0} needs to have a get-reject line.\n".format(x)
            think_check += 1
    if wipes: print(wipes.rstrip())
    if laters: print(laters.rstrip())
    if getrej: print(getrej.rstrip())
    if think_check == 0:
        print("Think check (get-reject/later-wipe/table of later uses) passed")
    else:
        print(think_check, "think check (get-reject/later-wipe/table of later uses) errors")

#
# start main code
#

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
                argval += 1
                max_dif = int(sys.argv[argval].lower())
        except:
                print("-md needs an integer after -- in the same argument, or with a space in between.")
                exit()
    else:
        print(sys.argv[argval].lower(), "not recognized.")
        print()
        usage()
    argval += 1

get_stuff_from_source()

check_source_rule_order()

read_test_file_order()

source_vs_trizbort_flow()
source_vs_invisiclues()
source_vs_walkthrough()

for x in base_reg_incs.keys():
    if semi_verbose or verbose:
        print('BASE', x, base_reg_incs[x])
    nontable_totals[x] = nontable_totals[x] + base_reg_incs[x]

for x in directed_incs.keys():
    if semi_verbose or verbose:
        print('DIRECTED', x, directed_incs[x])
    nontable_totals[x] = nontable_totals[x] + directed_incs[x]

print("List of points by region:", ', '.join(['{:s}={:d}'.format(x, nontable_totals[x]) for x in nontable_totals.keys()]) + ", total=" + str(sum(nontable_totals.values())))

for x in nontable_totals.keys():
    if x == 'odd do': continue
    if table_totals[x] != nontable_totals[x]:
        print("Incosistent table vs full source totals for region", x, "has table", table_totals[x], "vs nontable", nontable_totals[x], "without revover", directed_incs[x])

for x in nontable_totals.keys():
    if nontable_totals[x] != in_source[x]:
        print("ERROR: region", x, "has", nontable_totals[x], "but source lists", in_source[x])
        if source_line_to_open:
            print("NOTE: this supersedes opening line", source_line_to_open)
        source_line_to_open = region_def_line[x]
    if in_source[x] != invis_points[x]:
        print("ERROR: region", x, "has", in_source[x], "in source, but invisiclues list", invis_points[x])
        if invis_line_to_open:
            print("NOTE: this supersedes opening line", invis_line_to_open)
        invis_line_to_open = invis_region_points[x]

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

bonus_mistake_check()

source_table_vs_test_file()
walkthrough_vs_test_file(max_dif)

think_look_check()

if invis_line_to_open:
    i7.npo(invis_raw, invis_line_to_open, True)
if warning_walkthrough_line:
    i7.npo(main_thru, warning_walkthrough_line, True)
