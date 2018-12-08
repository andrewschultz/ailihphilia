# rely.py
#
# this lists which items depend on what
#
# or which command depends on what
#
# e.g. rep popper relies on mr arm
#
# stir writs rely on guru rug, sharp rahs
# guru rug relies on sage gas, tame mat
#
# -i = items
#
# -c = commands
#

import re
import os
import sys
from collections import defaultdict

verbose = False
line_count = 0
do_items = False
do_commands = False
print_warning = True
print_requirements = True
standard_input = False
do_combo = True

sort_by_importance = False
show_verbs = False

depends = defaultdict(lambda: defaultdict(bool))
depend_rev = defaultdict(lambda: defaultdict(bool))
need_all = defaultdict(bool)
starter_items = defaultdict(bool)
commands = defaultdict(bool)

item_file = "rely-items.txt"
command_file = "rely-cmds.txt"
combo_file = "rely-combo.txt"

def usage():
    print("-c = commands")
    print("-i = commands")
    print("-ic/-ci = both")
    print("-v = verbose")
    print("-r/-rn/-nr = print requirements or not")
    print("-w/-wn/-nw = print warnings or not")
    print("-s = standard input, -ns/-sn = no standard input")
    exit()

def cmdx(a):
    return "{:s}-V".format(a.upper()) if a in commands.keys() else a

def depends_items(x):
    return len([y for y in depends[x] if not y.startswith("(")])

def items_from_depends():
    print("Getting dependency information from source.")
    header_next = False
    in_table = False
    with open("story.ni") as file:
        for (line_count, line) in enumerate(file, 1):
            if 'xxuse' in line:
                header_next = True
                in_table = True
                continue
            if header_next:
                header_next = False
                continue
            if in_table:
                if '\t' not in line.strip():
                    in_table = False
                    continue
                ary = line.lower().strip().split("\t")
                if ary[2] == '--':
                    continue
                # print(ary[2], "needs", ary[1], "and", ary[0])
                if ary[2] != ary[1]:
                    depends_add(ary[2], ary[1], line_count)
                if ary[2] != ary[0]:
                    depends_add(ary[2], ary[0], line_count)

def plow_through(file_name):
    depends.clear()
    need_all.clear()
    totals = 0
    if file_name == item_file: items_from_depends()
    with open(file_name) as file:
        for (line_count, line) in enumerate(file, 1):
            if line.startswith(";"): break
            if line.startswith("#"): continue
            if line.startswith("--"):
                print("WARNING fix line", line_count, "starting with --")
                continue
            if line.startswith("needall:"):
                need_all[line[8:].strip()] = True
                continue
            if line.startswith("commands"):
                cmd = line[9:].strip().lower().split(",")
                for x in cmd:
                    commands[x] = True
            if line.startswith("starter:"):
                start_array = line[8:].strip().lower().split(",")
                for x in start_array:
                    if x in depends.keys():
                        print("WARNING", x, "defined as depending on something but also a starter item.")
                    starter_items[x] = True
            if '/' not in line:
                print("Warning line", line_count, "needs slash")
                continue
            if re.search(".#", line): # we could also use (?<!^)# to get rid of comments not at start. In fact, we don't really need this, due to the CONTINUE on STARTSWITH #, but I want to have this comment in place in case I forget how and need to search for it later.
                line = re.sub(" #.*", "", line.strip().lower())
            ary = line.lower().strip().split("/")
            needers = ary[0].split(",")
            neededs = ary[1].split(",")
            for n1 in neededs:
                for n2 in neededs:
                    if n2 in depends[n1].keys(): print("WARNING", needers[0], ":", n1, "already needs", n2)
                    if n1 in depends[n2].keys(): print("WARNING", needers[0], ":", n2, "already needs", n1)
            for n1 in needers:
                for n2 in neededs:
                    depends_add(n1, n2, line_count)
    totals = 0
    final_array = sorted(depends.keys()) if not sort_by_importance else sorted(depends.keys(), key=lambda x: len(depends[x]))
    for x in final_array:
        if len(depends[x].keys()):
            totals = totals + len(depends[x].keys())
            if print_requirements:
                print(x, "requires", len(depends[x].keys()), '/', depends_items(x), ":", ', '.join([cmdx(a) for a in sorted(depends[x].keys()) if show_verbs or not a.startswith("(")]))
        else:
            if verbose:
                print(x, "has no requirements")
    for x in need_all.keys():
        need_count = 0
        for y in sorted(depends.keys()):
            if y != x and y not in depends[x].keys():
                need_count += 1
                print("Need-all command/item", x, "needs", y, "({:d})".format(need_count))
    print(totals, "total dependencies in", file_name, "for", len([x for x in depends.keys() if not x.startswith("(")]), "items")

def depends_add(result, needed, line=-1):
    if print_warning:
        # if needed not in depends.keys() and needed.lower() != "bros' orb": print("Warning: line", line, needed.upper(), "is not previously referred to.")
        if needed in depends[result].keys(): print("Warning: line", line, result.upper(), "already flagged (recursively) as needing", needed.upper())
    depends[result][needed] = True
    if result in depends[needed].keys():
        print("Oops circular loop for what item needs what:", result, "<=>", needed, "at line", line)
        exit()
    for x in depends[needed].keys():
        if result in depends[x]:
            print("Oops (complex) circular loop for what item needs what:", result, "<=>", x, "via", needed, "at line", line)
            exit()
        depends[result][x] = True
    for x in depends.keys():
        if result in depends[x].keys():
            for y in depends[result].keys():
                if x in depends[y].keys():
                    print("Oops (complex) circular loop for what item needs what:", result, "<=>", x, "/", y, "via", needed, "at line", line)
                    exit()
                depends[x][y] = True
                
def derive_basic_dependencies():
    in_table = 0
    with open("story.ni") as file:
        for (line_count, line) in enumerate(file, 1):
            if line.startswith("table of goodacts"):
                in_table = line_count
                continue
            if in_table and line_count - in_table < 2:
                continue
            if not in_table: continue
            if in_table:
                if not line.strip() or line.startswith("["): break
            q = line.strip().lower().split("\t")
            if q[0] == '--' or q[1] == '--':
                print("##blank row for", q[3])
            else:
                print("{:s}/{:s},{:s}".format(q[2], q[0], q[1]))
    exit()

count = 1

while count < len(sys.argv):
    arg = sys.argv[count].lower()
    if arg[0] == '-': arg = arg[1:]
    if re.search("^[ci]+", arg):
        do_combo = False
        do_items = 'i' in arg
        do_commands = 'c' in arg
    elif arg == 'derive':
        derive_basic_dependencies()
        exit()
    elif arg == 'v': verbose = True
    elif arg == 'nv': verbose = False
    elif arg == 'r': print_requirements = True
    elif arg == 'nr' or arg == 'rn': print_requirements = False
    elif arg == 'w': print_warnings = True
    elif arg == 'nw' or arg == 'wn': print_warnings = False
    elif arg == 's': standard_input = True
    elif arg == 'si': sort_by_importance = True
    elif arg == 'si': show_verbs = True
    elif arg == 'ns' or arg == 'sn': standard_input = False
    else: usage()
    count += 1

if do_combo:
    plow_through(combo_file)
    exit()
else:
    if do_items: plow_through(item_file)
    if do_commands: plow_through(command_file)

count = 0
for q in depends.keys():
    if len(depends[q].keys()) == 0:
        if q in starter_items.keys(): continue
        count += 1
        print(count, q, "does not depend on anything. We might want to look at this.")
        continue
    for j in depends[q].keys():
        depend_rev[j][q] = True

if standard_input:
    while True:
        mystr = input("Item to search for:")
        mystr = mystr.strip().lower()
        got_one = False
        for q in depends.keys():
            if re.search(r'\b{:s}\b'.format(mystr), q):
                got_one = True
                print(q, 'REQUIRES', ', '.join(sorted(depends[q].keys())))
        for q in depend_rev.keys():
            if re.search(r'\b{:s}\b'.format(mystr), q):
                got_one = True
                print(q, 'NEEDED FOR', ', '.join(sorted(depend_rev[q].keys())))
        if not got_one: print("Couldn't find anything for", mystr)