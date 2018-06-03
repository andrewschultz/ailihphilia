# rely.py
#
# this lists which items depend on what
#
# or which commands depend on what
#
# -i = items
#
# -c = commands
#

import os
import sys
from collections import defaultdict

verbose = False
line_count = 0
do_items = True
do_commands = False
print_warning = True
print_requirements = True

depends = defaultdict(lambda: defaultdict(bool))

item_file = "rely.txt"
command_file = "rely-cmd.txt"

def usage():
    print("-c = commands")
    print("-i = commands")
    print("-ic/-ci = both")
    print("-v = verbose")
    print("-r/-rn/-nr = print requirements or not")
    print("-w/-wn/-nw = print warnings or not")
    exit()

def items_from_depends():
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
    totals = 0
    if file_name == item_file: items_from_depends()
    with open(file_name) as file:
        for (line_count, line) in enumerate(file, 1):
            if line.startswith(";"):
                break
            if line.startswith("#"):
                continue
            if '/' not in line:
                print("Warning line", line_count, "needs slash")
                continue
            ary = line.lower().strip().split("/")
            needers = ary[0].split(",")
            neededs = ary[1].split(",")
            for n1 in needers:
                for n2 in neededs:
                    depends_add(n1, n2, line_count)
    totals = 0
    for x in sorted(depends.keys()):
        if len(depends[x].keys()):
            totals = totals + len(depends[x].keys())
            if print_requirements:
                print(x, "requires", len(depends[x].keys()), ":", ', '.join(sorted(depends[x].keys())))
        else:
            if verbose:
                print(x, "has no requirements")
    print(totals, "total dependencies in", file_name, "for", len(depends.keys()), "items")

def depends_add(result, needed, line=-1):
    if print_warning:
        if needed not in depends.keys(): print("Warning: line", line, needed.upper(), "is not previously referred to.")
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

count = 1

while count < len(sys.argv):
    arg = sys.argv[count].lower()
    if arg[0] == '-': arg = arg[1:]
    if arg == 'i':
        do_items = True
        do_commands = False
    elif arg == 'c':
        do_items = False
        do_commands = True
    elif arg == 'v': verbose = True
    elif arg == 'nv': verbose = False
    elif arg == 'r': print_requirements = True
    elif arg == 'nr' or arg == 'rn': print_requirements = False
    elif arg == 'w': print_warnings = True
    elif arg == 'nw' or arg == 'wn': print_warnings = False
    elif arg == 'ic' or arg == 'ci': do_items = do_commands = True
    else: usage()
    count += 1

if do_items: plow_through(item_file)
if do_commands: plow_through(command_file)
