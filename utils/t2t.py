# t2t.py = transcript to test
#

import re

from os import listdir
from os.path import isfile, join
from collections import defaultdict

alpha_flip = False
uselist = defaultdict(lambda: defaultdict(int))

may_need_space = defaultdict(bool)
single = defaultdict(bool)
ignore = defaultdict(bool)
one_to_two_maps = defaultdict(str)

def read_mapper_file():
    line_count = 0
    with open('t2t.txt') as file:
        for line in file:
            line_count = line_count + 1
            if line.startswith(';'): return
            if line.startswith('#'): continue
            ll = line.strip().lower()
            if line.startswith('map:') or line.startswith('m:'):
                ll = re.sub("^(map|m):", "", ll)
                la = ll.split('=')
                one_to_two_maps[la[0]] = la[1]
                continue
            if line.startswith('s:'):
                ll = ll[2:]
                single[ll] = True
                continue
            if line.startswith('i:'):
                ll = ll[2:]
                ignore[ll] = True
                continue
            la = ll.split(' ')
            for x in la:
                if x in one_to_two_maps.keys():
                    if ll == one_to_two_maps[x]:
                        print("WARNING duplication", x, "at line", line_count, "with", one_to_two_maps[x])
                    else:
                        print("WARNING redefining", x, "at line", line_count, "from", one_to_two_maps[x], "to", ll)
                one_to_two_maps[x] = ll
                # print(x, "to", ll)
    exit()

def space_check(x, line_in):
    if ' ' in x: return
    if x in ignore.keys(): return
    if x in single.keys(): return
    if x in one_to_two_maps.keys(): return
    if x in may_need_space.keys(): return
    print(x, line_in.strip())
    may_need_space[x] = True

def expanded_name(x):
    if x in one_to_two_maps.keys(): return one_to_two_maps[x]
    return x

def add_to_use_hash(file_name):
    with open(file_name) as file:
        for line in file:
            if re.search("> *use +", line, re.IGNORECASE):
                l2 = re.sub("> *use *", "", line.strip().lower())
                l2 = re.sub("-", " ", l2)
                l2 = re.sub("'", "", l2)
                # print(l2)
                l2 = re.sub(" with ", " on ", l2)
                la = re.split(" +on +", l2)
                if len(la) == 3:
                    la = la[0] + la[2]
                if len(la) != 2:
                    print("Bad use line:", line.strip())
                    continue
                lb = sorted(map(expanded_name, la))
                uselist[lb[0]][lb[1]] = uselist[lb[0]][lb[1]] + 1
                space_check(la[0], line)
                space_check(la[1], line)
                # print(la, lb)

mypath = 'C:/games/inform/ailihphilia.inform/Source/transcripts'
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]

read_mapper_file()

for x in onlyfiles:
    add_to_use_hash('transcripts/{:s}'.format(x))


for j in sorted(uselist.keys()):
    for l in sorted(uselist[j].keys()):
        continue
        if alpha_flip:
            print ("use", l, "on", j, uselist[j][l])
        else:
            print ("use", j, "on", l, uselist[j][l])


if len(may_need_space.keys()):
    print("May need space({:d}):".format(len(may_need_space.keys())), '/'.join(sorted(may_need_space.keys())))
else:
    print("All abbreviations defined, I think.")

# ??? what to do about ambiguous
# ??? what to do about 3-ish