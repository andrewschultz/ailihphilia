import sys
import re
from collections import defaultdict

found = defaultdict(int)

pal_list = defaultdict(str)

pals = []

for x in sys.argv[1:]:
    for y in x.split(","):
        if "V" in y:
            for z in ['a','e','i','o','u']:
                temp = re.sub("V", z, y)
                pals.append(temp)
        else:
            pals.append(y)

print(pals)

count = 0

for x in pals:
    found[x] = 0

with open("c:/writing/dict/brit-1word.txt") as file:
    for line in file:
        l = line.strip().lower()
        for st in pals:
            x = st + l
            if x == x[::-1]:
                found[st] = found[st] + 1
                if pal_list[st]:
                    pal_list[st] = pal_list[st] + "\n"
                pal_list[st] = pal_list[st] + "FIRST {:s} + {:s} = {:s}".format(st, l, x)
                # print("Added", st, l)
            y = l + st
            if y == y[::-1]:
                if pal_list[st]:
                    pal_list[st] = pal_list[st] + "\n"
                pal_list[st] = pal_list[st] + "LAST {:s} + {:s} = {:s}".format(st, l, y)
                found[st] = found[st] + 1
                # print("Added", l, st)

for x in sorted(found.keys()):
    if found[x]:
        print(x, "================")
        print(pal_list[x])
    else:
        print("Nothing found for", x)
