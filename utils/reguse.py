import re
from collections import defaultdict

start_on_next = False
in_tble = False
table_name = ""
line_count = 0

cmds = defaultdict(int)
cmdline = defaultdict(int)
got = defaultdict(bool)

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
            print("Starting table:", table_name + ".")
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
        tc = line.lower().strip().split('\t')
        if table_name == 'table of specific use rejects':
            my_cmd = '>use {:s} on {:s}'.format(tc[0], tc[1])
        elif table_name == 'table of shiftables':
            my_cmd = '>use {:s} on {:s}'.format(tc[1], tc[2])
        else:
            print(table_name, line_count, "table ignored")
            #print("Uh oh not sure what to do with", table_name)
            continue
        # print("Line", line_count, "Adding", my_cmd)
        cmds[my_cmd.lower()] += 1
        cmdline[my_cmd.lower()] = line_count

with open("rbr-ail-thru.txt") as file:
    for line in file:
        ll = line.strip().lower()
        # if line.startswith(">use"): print(ll)
        if ll in cmds.keys():
            got[ll] = True

oops = 0
for x in sorted(cmds.keys(), key = cmdline.get):
    if x not in got.keys():
        print("Need to add test for", cmdline[x], cmds[x], x)
        oops += 1

print(oops, "total errors")