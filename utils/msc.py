#
# msc.py
#
# checks that maximum score in the source is in tune with other areas
#
# replaced by sc2.py which looks in the code to see what the max score should be
#

from collections import defaultdict

import re

mscore = defaultdict(int)
mokay = defaultdict(int)

with open("c:/games/inform/ailihphilia.inform/source/story.ni") as file:
    for line in file:
        if line.lower().startswith('the maximum score is'):
            l2 = re.sub(".* ", "", line.lower().strip())
            l2 = re.sub("\.", "", l2)
            max_total = int(l2)
        if 'is a region. max-score of' in line:
            l2 = re.sub(".* of ", "", line.strip().lower())
            l2 = re.sub("\.", "", l2)
            la = l2.split(" is ")
            mscore[la[0]] = int(la[1])

with open("c:/writing/scripts/invis/pu.txt") as file:
    for line in file:
        ll = re.sub("\.", "", line.lower().strip())
        if ll.startswith("there are") and 'total points in' in ll:
            ll = re.sub("there are ", "", ll)
            l2 = ll.split(" total points in ")
            mokay[l2[1]] = int(l2[0])

mlist = list(set(mokay.keys()) | set(mscore.keys()))

if max_total == sum(mscore.values()):
    print("Max score vs region scores check out.")
else:
    print("Max score is", max_total, "but by-region scores are", sum(mscore.values()), "total")

for x in mlist:
    if x not in mokay.keys():
        print(x, "not in walkthrough file.")
    elif x not in mscore.keys():
        print(x, "not in source file.")
    elif mscore[x] != mokay[x]:
        print(x, "has different values:", mscore[x], "in source," , mokay[x], "in walkthrough.")

    else:
        print(x, "matches source and walkthrough with", mscore[x])