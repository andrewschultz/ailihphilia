# sc2.py
#
# attempts to isolate how many points you can score in each region
#
# replaces msc.py
#

import re
from collections import defaultdict

# options
verbose = False

# variables

use_ons = False

use_points = 0

current_region = "None"

is_region = defaultdict(bool)
base_reg_incs = defaultdict(int)
directed_incs = defaultdict(int)

func_list = ''

with open("story.ni") as file:
    for line in file:
        if line.strip():
            func_list = func_list + line
        else:
            func_list = ''
        if 'is a region. max-score' in line:
            l2 = re.sub(" is a region.*", "", line.lower().strip())
            is_region[l2] = True
            # print("Noting region", l2)
            continue
        if 'score-inc' in line and '\t' in line:
            if verbose:
                print(current_region)
                print(func_list)
            base_reg_incs[current_region] = base_reg_incs[current_region] + 1
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
                use_points = use_points + 1

totals = 0

for x in base_reg_incs.keys():
    print('BASE', x, base_reg_incs[x])
    totals = totals + base_reg_incs[x]

for x in directed_incs.keys():
    print('DIRECTED', x, directed_incs[x])
    totals = totals + directed_incs[x]

print("Use points =", use_points)
print("Total =", totals + use_points)