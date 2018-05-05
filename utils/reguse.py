import re
from collections import defaultdict

start_on_next = False
in_tble = False
table_name = ""
line_count = 0

cmds = defaultdict(int)
cmds = defaultdict(bool)

def right_table_start(x):
    if not x.startswith('table'): return ""
    x2 = re.sub(" *\[.*", "", x.lower())
    return x2

with open("story.ni") as file:
    for line in file:
        line_count = line_count + 1
        table_name = right_table_start(line.strip())
        if (table_name):
            start_on_next = True
            print("Starting table:", table_name)
            continue
        if start_on_next:
            start_on_next = False
            in_table = True
            continue
        if not line.strip():
            in_table = False
            table_name = ""
            continue
        if table_name == 'table of specific use rejects':
            my_cmd = '>use {:s} on {:s}'.format(tc[0], tc[1])
        elif table_name == 'table of shiftables':
            my_cmd = '>use {:s} on {:s}'.format(tc[1], tc[2])
        else:
            #print("Uh oh not sure what to do with", table_name)
            continue
        print("Adding", my_cmd)
        cmds[my_cmd.lower()] += 1

with open("reg-ail-thru-alt.txt") as file:
    for line in file:
        if line.lower() in cmds.keys():
            got[line.lower()] = True

oops = 0
for x in cmds.keys():
    if x not in got.keys():
        print("Need to add test for", x)
        oops += 1

print(oops, "total errors")