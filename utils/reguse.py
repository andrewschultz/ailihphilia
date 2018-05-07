import sys
import re
from collections import defaultdict

start_on_next = False
in_table = False
table_name = ""
line_count = 0
sort_by_object = False
short_note = True
debug = False

expand = { "ti":"to idiot" }

cmds = defaultdict(int)
cmdline = defaultdict(int)
got = defaultdict(bool)
i1 = defaultdict(str)
i2 = defaultdict(str)

count = 1
while count < len(sys.argv):
    arg = sys.argv[count]
    if arg == 'no': sort_by_object = False
    elif arg == 'o': sort_by_object = True
    elif arg == 's': short_note = True
    elif arg == 'l': short_note = False
    elif arg == 'd': debug = True
    else: print("Unknown argument", arg)
    count += 1

def expa(a):
    return (expand[a] if a in expand.keys() else a)

def which_alf(a):
    return i2[a] if sort_by_object else i1[a]

def right_table_start(x):
    if not x.startswith('table'): return ""
    x2 = re.sub(" *\[.*", "", x.lower())
    return x2

in_table = False

with open("story.ni") as file:
    for line in file:
        line_count = line_count + 1
        if line.startswith('table') and not in_table:
            table_name = right_table_start(line.strip())
        if start_on_next:
            start_on_next = False
            in_table = True
            continue
        if table_name and not in_table:
            start_on_next = True
            if debug: print("Starting table:", table_name + ".")
            continue
        if not in_table: continue
        if line.startswith('[') and '\t' not in line:
            in_table = False
            table_name = ""
            continue
        if not line.strip():
            in_table = False
            table_name = ""
            continue
        tc = [expa(x) for x in line.lower().strip().split('\t')]
        if table_name == 'table of specific use rejects':
            my_cmd = '>use {:s} on {:s}'.format(tc[0], tc[1])
            i1[my_cmd] = tc[0]
            i2[my_cmd] = tc[1]
        elif table_name == 'table of shiftables':
            my_cmd = '>use {:s} on {:s}'.format(tc[1], tc[2])
            if debug:
                print("Adding shiftable", tc[0], "to", tc[2])
                print("Command is", my_cmd)
            i1[my_cmd] = tc[1]
            i2[my_cmd] = tc[2]
        else:
            # print(table_name, line_count, "table ignored")
            #print("Uh oh not sure what to do with", table_name)
            continue
        # print("Line", line_count, "Adding", my_cmd)
        cmds[my_cmd.lower()] += 1
        cmdline[my_cmd.lower()] = line_count

next_needs_content = False
last_line = ()

with open("rbr-ail-thru.txt") as file:
    for (lc, line) in enumerate(file):
        ll = line.strip().lower()
        if next_needs_content and (ll.startswith('use') or not ll): print("Line", lc, "should not be blank/new command:", last_line)
        next_needs_content = line.startswith(">use")
        last_line = ll
        if ll in cmds.keys():
            got[ll] = True

oops = 0
for x in sorted(cmds.keys(), key = which_alf):
    if x not in got.keys():
        if short_note:
            print("Need to add test for", cmdline[x], cmds[x], x)
        else:
            print("==t5")
            print(x)
            print("WRONG")
            # print()
        oops += 1

print(oops, "total errors")