import time
import sys
import re
from collections import defaultdict

found = defaultdict(int)

pal_list = defaultdict(str)

check_possible = True
only_stdin = False

pals = []

word_cand = defaultdict(bool)
end_cand = defaultdict(lambda: defaultdict(bool))
start_cand = defaultdict(lambda: defaultdict(bool))

def usage():
    print("any word sent in is scoured for palindromes. CSV or space.")
    print("(Capital) V means try all vowels e.g. bVg = big bag bog bug beg byg")
    print("-i uses stdin.")
    print("-? shows this usage without telling you you wrote in a bad flag")
    print("Word candidate lists save time as the program doesn't need to load the master word list.")
    exit()

def palz(pals):
    possible_starts = {}
    possible_ends = {}
    start_time = time.time()
    for x in pals:
        found[x] = 0
        possible_starts[x] = ""
        possible_ends[x] = ""
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
                continue
                # print("Added", st, l)
            if check_possible:
                if l.endswith(st[::-1]):
                    possible_starts[st] = possible_starts[st] + " " + l
        for l in loc_start[st]:
            y = l + st
            if y == y[::-1]:
                if pal_list[st]:
                    pal_list[st] = pal_list[st] + "\n"
                pal_list[st] = pal_list[st] + "LAST {:s} + *{:s}* = {:s}".format(l, st, y)
                found[st] = found[st] + 1
                # print("Added", l, st)
                continue
            if check_possible:
                if l.startswith(st[::-1]):
                    possible_ends[st] = possible_ends[st] + " " + l
    for x in sorted(found.keys()):
        got_something = False
        if found[x] or possible_ends[x] or possible_starts[x]:
            print(x, "================")
            if found[x]:
                print(pal_list[x])
            if possible_ends[x]:
                print("Words allowing {:s}x at end of long palindrome:{:s}", possible_ends[x])
            if possible_starts[x]:
                print("Words at end of long palindrome starting with {:s}:{:s}", possible_starts[x])
        if not got_something:
            print("Nothing found for", x)
    end_time = time.time()
    print("Total time taken: {:.4f} seconds.".format(end_time - start_time))

for x in sys.argv[1:]:
    xl = x.lower()
    if x == "-c":
        check_possible = True
        continue
    if x == "-i":
        only_stdin = True
        continue
    if x == "-?" or x == "?":
        usage()
    if not x.replace(",", "").isalpha():
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
    start_time = time.time()
    for line in file:
        ll = line.strip().lower()
        word_cand[ll] = True
        end_cand[ll[-1]][ll] = True
        start_cand[ll[0]][ll] = True
    end_time = time.time()
    print(end_time-start_time, "seconds to read in file/define word arrays.")

if len(pals) == 0 and only_stdin == False:
    print("Need -i or a CSV of words.")
    exit()

if len(pals) > 0:
    palz(pals)

if only_stdin:
    while True:
        finish = input("Palindrome stuff here:")
        palz(pals(finish.split(" ")))
