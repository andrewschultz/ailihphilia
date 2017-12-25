import sys
import re
from collections import defaultdict

found = defaultdict(int)

pal_list = defaultdict(str)

only_stdin = False

pals = []

word_cand = defaultdict(bool)
end_cand = defaultdict(lambda: defaultdict(bool))
start_cand = defaultdict(lambda: defaultdict(bool))

def usage():
    print("any word sent in is scoured for palindromes. CSV or space.")
    print("(Capital) V means try all vowels e.g. bVg = big bag bog bug beg byg")
    print("-i uses stdin")
    print("-? shows this usage without telling you you wrote in a bad flag")
    exit()

def palz(pals):
    for x in pals:
        found[x] = 0
    loc_end = {}
    loc_start = {}
    for st in pals:
        loc_end[st] = sorted(end_cand[st[0]].keys())
        loc_start[st] = sorted(start_cand[st[-1]].keys())
    for st in sorted(pals):
        for l in loc_end[st]:
            x = st + l
            if x == x[::-1]:
                found[st] = found[st] + 1
                if pal_list[st]:
                    pal_list[st] = pal_list[st] + "\n"
                pal_list[st] = pal_list[st] + "FIRST *{:s}* + {:s} = {:s}".format(st, l, x)
                # print("Added", st, l)
        for l in loc_start[st]:
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
    xl = x.lower()
    if x == "-i":
        only_stdin = True
    elif x == "-?" or x == "?":
        usage()
    elif not x.replace(",", "").isalpha():
        print("Invalid flag", -x)
        usage()
    for y in x.split(","):
        if "V" in y:
            for z in ['a','e','i','o','u', 'y']:
                temp = re.sub("V", z, y)
                pals.append(temp)
        else:
            pals.append(y)

with open("c:/writing/dict/brit-1word.txt") as file:
    for line in file:
        ll = line.strip().lower()
        word_cand[ll] = True
        end_cand[ll[-1]][ll] = True
        start_cand[ll[0]][ll] = True

if len(pals) == 0 and only_stdin == False:
    print("Need -i or a CSV of words.")
    exit()

if len(pals) > 0:
    palz(pals)

if only_stdin:
    while True:
        finish = input("Palindrome stuff here:")
        pals(finish.split(" "))
