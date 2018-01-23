# sc2.py
#
# attempts to isolate how many points you can score in each region
#
# replaces msc.py
#

import sys
import re
from collections import defaultdict

# options
verbose = False

# variables

use_ons = False

undef_use_points = 0

current_region = "None"

is_region = defaultdict(bool)
base_reg_incs = defaultdict(int)
directed_incs = defaultdict(int)

func_list = ''

argval = 1
while argval < len(sys.argv):
    noh = sys.argv[argval].lower()
    if noh[0] == '-':
        noh = noh[1:]
    if noh == 'v':
        verbose = True
    argval = argval + 1

def detect_region(a, b):
    if '[+' not in a:
        return b
    temp = re.sub(".*\[\+", "", a.strip())
    temp = re.sub("\].*", "", temp)
    return temp

with open("story.ni") as file:
    line_count = 0
    for line in file:
        line_count = line_count + 1
        if line.strip():
            func_list = func_list + line
        else:
            func_list = ''
        if 'is a region. max-score' in line:
            l2 = re.sub(" is a region.*", "", line.lower().strip())
            is_region[l2] = True
            if verbose: print("Noting region", l2)
            continue
        if 'score-inc' in line and '\t' in line:
            temp_region = detect_region(line, current_region)
            if temp_region == current_region and '[+' in line:
                print("WARNING temp_region not a change from current_region", current_region, "line", line_count)
            if temp_region == 'ignore':
                continue
            if verbose:
                if temp_region not in is_region.keys():
                    print("WARNING no region", temp_region, "at line", line_count)
                else:
                    print ("temp region", temp_region, "for line", line_count)
            if verbose:
                print(current_region)
                print(func_list)
            if temp_region == "None":
                print("Region not defined yet at line", line_count)
            base_reg_incs[temp_region] = base_reg_incs[temp_region] + 1
        ll = line.strip().lower()
        if line.startswith('part '):
            for x in is_region.keys():
                if x in ll:
                    current_region = x
        if line.startswith("table of useons"):
            use_ons = True
            continue
        elif not line:
            use_ons = False
            continue
        if line.startswith('\t') and "reg-inc" in ll:
            l2 = re.sub(".*reg-inc ", "", ll.lower())
            l2 = re.sub(";.*", "", l2)
            if l2 == 'mrlp':
                continue
            directed_incs[l2] = directed_incs[l2] + 1
        if use_ons:
            x = ll.split("\t")
            if len(x) < 6: continue
            if x[5] == 'true':
                undef_use_points = undef_use_points + 1

totals = 0

for x in base_reg_incs.keys():
    print('BASE', x, base_reg_incs[x])
    totals = totals + base_reg_incs[x]

for x in directed_incs.keys():
    print('DIRECTED', x, directed_incs[x])
    totals = totals + directed_incs[x]

print("Use points =", undef_use_points)
print("Total =", totals + undef_use_points)