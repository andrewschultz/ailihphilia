# 1w.py
#
# finds (prospective) palindromes that build on one word
#

import time
import sys
import re
from collections import defaultdict

wordfile = "c:/writing/dict/brit-1word.txt"
firstfile = "c:/writing/dict/firsts.txt"
lastfile = "c:/writing/dict/lasts.txt"

file_array = [ wordfile ]

found = defaultdict(int)
last_found = defaultdict(int)

pal_list = defaultdict(str)

check_possible_max = 25
check_possible = True
only_stdin = False

every_cr = 4

pals = []

word_cand = defaultdict(bool)
end_cand = defaultdict(lambda: defaultdict(bool))
start_cand = defaultdict(lambda: defaultdict(bool))

hdr = "=" * 30

def read_in(a):
    with open(a) as file:
        for line in file:
            ll = line.strip().lower()
            word_cand[ll] = True
            end_cand[ll[-1]][ll] = True
            start_cand[ll[0]][ll] = True

def usage():
    print(hdr + "USAGE")
    print()
    print("Any word sent in is scoured for palindromes. CSV or space.")
    print("-c checks possible palindromes for longer sentences. -nc forces it off. Default is", ["off", "on"][check_possible])
    print("(Capital) V means try all vowels e.g. bVg = big bag bog bug beg byg")
    print("(Capital) C means try all consonants e.g. bVg = big bag bog bug beg byg")
    print("-i uses stdin.")
    print("-m adjusts the maximum possible palindromes we check for.")
    print("-? shows this usage without telling you you wrote in a bad flag")
    print()
    print("PROTIP: sending several words on the command line at once can save time.")
    print("  That way, the program doesn't need to load the master word list.")
    print("SAMPLE USAGE: 1w.py breC -nc / 1w.py fVt -m 40")
    exit()

def palz(pals):
    can_increase = False
    possible_starts = {}
    possible_ends = {}
    start_time = time.time()
    for x in pals:
        found[x] = 0
        last_found[x] = 0
        possible_starts[x] = ""
        possible_ends[x] = ""
    loc_end = {}
    loc_start = {}
    for st in pals:
        loc_end[st] = sorted(end_cand[st[0]].keys())
        loc_start[st] = sorted(start_cand[st[-1]].keys())
    for st in sorted(pals):
        count = 0
        for l in sorted(loc_end[st], key=lambda x: (len(x), x)):
            x = st + l
            if x == x[::-1]:
                found[st] = found[st] + 1
                if found[st] == 1:
                    pal_list[st] = "FIRST"
                elif found[st] % every_cr == 1:
                    pal_list[st] = pal_list[st] + "\n  "
                else:
                    pal_list[st] = pal_list[st] + " /"
                pal_list[st] = pal_list[st] + " *{:s}* + {:s} = {:s}".format(st, l, x)
                continue
                # print("Added", st, l)
            if check_possible:
                if count <= check_possible_max and l.endswith(st[::-1]):
                    if count < check_possible_max:
                        possible_starts[st] = possible_starts[st] + " " + l
                    else:
                        can_increase = True
                    count = count + 1
        count = 0
        for l in sorted(loc_start[st], key=lambda x: (len(x), x)):
            y = l + st
            if y == y[::-1]:
                last_found[st] = last_found[st] + 1
                if last_found[st] == 1:
                    if found[st]:
                        pal_list[st] = pal_list[st] + "\n"
                    pal_list[st] = pal_list[st] + "LAST"
                elif last_found[st] % every_cr == 1:
                    pal_list[st] = pal_list[st] + "\n  "
                else:
                    pal_list[st] = pal_list[st] + " /"
                pal_list[st] = pal_list[st] + " {:s} + *{:s}* = {:s}".format(l, st, y)
                found[st] = found[st] + 1
                # print("Added", l, st)
                continue
            if check_possible:
                if count <= check_possible_max and l.startswith(st[::-1]):
                    if count < check_possible_max:
                        possible_ends[st] = possible_ends[st] + " " + l
                    else:
                        can_increase = True
                    count = count + 1
    for x in sorted(found.keys()):
        got_something = False
        if found[x] or possible_ends[x] or possible_starts[x]:
            got_something = True
            print(hdr, x, hdr)
            if found[x]:
                print(pal_list[x])
            if possible_ends[x]:
                print("Words allowing {:s} at end of long palindrome:{:s}".format(x, possible_ends[x]))
            if possible_starts[x]:
                print("Words at end of long palindrome starting with {:s}:{:s}".format(x, possible_starts[x]))
        if not found[x]:
            print("No direct palindromes for", x)
        elif not got_something:
            print("Nothing found for", x)
    if can_increase: print("Use -m to increase maximum # of results, currently", check_possible_max)
    end_time = time.time()
    print("Total time taken to extract palindromes: {:.4f} seconds.".format(end_time - start_time))

argcount = 0

while argcount < len(sys.argv) - 1:
    argcount = argcount + 1
    xr = sys.argv[argcount]
    xl = xr.lower()
    if xl == "-a":
        file_array = [firstfile, lastfile, wordfile]
        continue
    if re.match("^-[wfl]+$", xl):
        file_array = []
        if 'f' in xl: file_array.append(firstfile)
        if 'l' in xl: file_array.append(lastfile)
        if 'w' in xl: file_array.append(wordfile)
        continue
    if xl == "-m":
        try:
            check_possible_max = int(sys.argv[argcount+1])
            argcount = argcount + 1
        except:
            print("Tried to change maximum # of listings but didn't give a valid number.")
        continue
    if xl == "-c":
        check_possible = True
        continue
    if xl == "-nc":
        check_possible = False
        continue
    if xl == "-i":
        only_stdin = True
        continue
    if xl == "-?" or xl == "?":
        usage()
        exit()
    if not xl.replace(",", "").isalpha():
        print("Invalid flag", xl)
        usage()
        exit()
    for y in xr.split(","):
        if "V" in y:
            for z in ['a','e','i','o','u', 'y']:
                temp = re.sub("V", z, y)
                pals.append(temp)
        elif 'C' in y:
            for z in ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z']:
                temp = re.sub("C", z, y)
                pals.append(temp)
        else:
            pals.append(y)

start_time = time.time()
for x in file_array:
    read_in(x)
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
