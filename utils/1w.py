import sys
import re
from collections import defaultdict

found = defaultdict(int)

pal_list = defaultdict(str)

only_stdin = False

pals = []

word_cand = defaultdict(bool)

def palz(pals):
    for x in pals:
        found[x] = 0
    for l in word_cand.keys():
        for st in pals:
            x = st + l
            if x == x[::-1]:
                found[st] = found[st] + 1
                if pal_list[st]:
                    pal_list[st] = pal_list[st] + "\n"
                pal_list[st] = pal_list[st] + "FIRST *{:s}* + {:s} = {:s}".format(st, l, x)
                # print("Added", st, l)
            y = l + st
            if y == y[::-1]:
                if pal_list[st]:
                    pal_list[st] = pal_list[st] + "\n"
                pal_list[st] = pal_list[st] + "LAST {:s} + *{:s}* = {:s}".format(l, st, y)
                found[st] = found[st] + 1
                # print("Added", l, st)
    for x in sorted(found.keys()):
        if found[x]:
            print(x, "================")
            print(pal_list[x])
        else:
            print("Nothing found for", x)

for x in sys.argv[1:]:
    if x == "-i":
        only_stdin = True
    for y in x.split(","):
        if "V" in y:
            for z in ['a','e','i','o','u']:
                temp = re.sub("V", z, y)
                pals.append(temp)
        else:
            pals.append(y)

with open("c:/writing/dict/brit-1word.txt") as file:
    for line in file:
        word_cand[line.strip().lower()] = True

if len(pals) == 0 and only_stdin == False:
    print("Need -i or a CSV of words.")
    exit()

if len(pals) > 0:
    palz(pals)

if only_stdin:
    while True:
        finish = input("Palindrome stuff here:")
        pals(finish.split(" "))
