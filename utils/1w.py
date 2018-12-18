# 1w.py
#
# finds (prospective) palindromes that build on one word
#
# usage: 1w.py bVn = ban bin ben bon bun
# -of = only first
# -ol = only last
# -(wfl)+ = words/firsts/lasts any combo

import i7
import time
import sys
import re
from collections import defaultdict
from string import ascii_lowercase

file_array = [ i7.f_dic ]

found = defaultdict(int)
last_found = defaultdict(int)

pal_list = defaultdict(lambda: defaultdict(str))

check_possible_max = 25
check_possible = True
only_stdin = False
read_file = False
generate_palindromes = False

max_mult_checks = 4000

get_firsts = True
get_lasts = True
print_possible = True

macro_letter = { 'V': 'aeiouy', 'C': 'bcdfghjklmnpqrstvwxyz', 'A': 'abcdefghijklmnopqrstuvwxyz' }

every_cr = 4

pals = []

word_cand = defaultdict(bool)
end_cand = defaultdict(lambda: defaultdict(bool))
start_cand = defaultdict(lambda: defaultdict(bool))

hdr = "=" * 30

def to_poss_pal(x, y):
    if y == True:
        next_pal = 0
        for j in range(1, len(x)):
            if x[:j] == x[:j][::-1]: next_pal = j
        return x[next_pal:][::-1] + x
    else:
        next_pal = len(x) - 1
        for j in range(len(x)-1, -1, -1):
            if x[j:] == x[j:][::-1]: next_pal = j
        return x + x[:next_pal][::-1]
    return "Hastur hastur hastur"

def character_range(a, b, inclusive=True):
    back = chr
    # if isinstance(a,unicode) or isinstance(b,unicode): back = unicode
    for c in range(ord(a), ord(b) + int(bool(inclusive))): yield back(c)

def let_group_count(a, b, exponent=True):
    s = len(re.findall(r'[{:s}]'.format(a), b))
    if exponent: return len(a) ** s
    return s

def branch_from(x):
    my_ary = []
    got_one = False
    for g in macro_letter.keys():
        if g in x:
            got_one = True
            for q in macro_letter[g]:
                temp = re.sub(g, q, x, 1)
                my_ary += branch_from(temp)
    if got_one: return my_ary
    return [x]

def num_checks(x):
    retval = 1
    for g in macro_letter.keys():
        if g in x:
            retval *= len(macro_letter[g]) ** x.count(g)
    return retval
    
def alph_dash_string_to_list(q):
    if re.search("[^a-z-]", q): sys.exit(q + " cannot contain anything besides letters or a dash.")
    qd = q
    ary = []
    while "-" in qd:
        qf = qd.find('-')
        if qf == 0 or qf == len(qd) - 1: sys.exit(q + " Cannot end or begin with a dash. Or have -a-.")
        if qd[qf-1] == '-' or qd[qf+1] == '-': sys.exit("Cannot have 2 dashes in a row.")
        for qr in character_range (qd[qf-1], qd[qf+1]):
            ary.append(qr)
        qd = re.sub(".-.", "", qd, 1)
    for a in qd: ary.append(a)
    return sorted(list(set(ary)))

def wrong_letters(a):
    l = len(a) - 1
    retval = ""
    for i in range(0, len(a)):
        retval = retval + (a[i] if a[i] == a[l-i] else '*')
    return retval

def read_it_all():
    got_what = defaultdict(int)
    with open('c:/games/inform/ailihphilia.inform/Source/1w.txt') as file:
        for line in file:
            if line.startswith('#'): continue
            if line.startswith(';'): break
            q = line.strip().lower().split()
            for z in q: got_what[z] += 1
    return sorted(got_what.keys())

def read_in(a):
    with open(a) as file:
        for line in file:
            ll = line.strip().lower()
            word_cand[ll] = True
            end_cand[ll[-1]][ll] = True
            start_cand[ll[0]][ll] = True

def usage(opt_err = ""):
    print(opt_err + hdr + "USAGE")
    print()
    print("Any word sent in is scoured for palindromes. CSV or space. Options require a dash.")
    print("-c checks possible palindromes for longer sentences. -nc forces it off. Default is", ["off", "on"][check_possible])
    print("-e checks errors in one word sequence.")
    print("V=try all vowels+y, C=try all consonants+y, A=C+V, D= defines a custom set of letters.")
    print("-i uses stdin.")
    print("-m adjusts the maximum possible palindromes we check for.")
    print("-r reads data from 1w.txt which has all the game critical stuff.")
    print("-? shows this usage without telling you you wrote in a bad flag")
    print("-(flw) lets you choose among first names, last names, words or any combination.")
    print("-np suppresses possible palindromes, -of prints only when the input text appears first, -ol only when it is last.")
    print()
    print("PROTIP: sending several words on the command line at once can save time.")
    print("  That way, the program doesn't need to load the master word list.")
    print("SAMPLE USAGE: 1w.py breC -nc / 1w.py rVt -m 40")
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
        if get_firsts:
            for l in sorted(loc_end[st], key=lambda x: (len(x), x)):
                x = st + l
                if x == x[::-1]:
                    found[st] += 1
                    found[st + "FIRST"] += 1
                    if found[st] % every_cr == 1 and found[st + "FIRST"] > 1:
                        pal_list["FIRST"][st] = pal_list["FIRST"][st] + "\n  "
                    else:
                        pal_list["FIRST"][st] = pal_list["FIRST"][st] + " /"
                    pal_list["FIRST"][st] = pal_list["FIRST"][st] + " *{:s}* + {:s} = {:s}".format(st, l, x)
                    continue
                    # print("Added", st, l)
                if check_possible:
                    if count <= check_possible_max and l.endswith(st[::-1]):
                        if count < check_possible_max:
                            possible_starts[st] = possible_starts[st] + " " + l
                        else:
                            can_increase = True
                        count += 1
        count = 0
        if get_lasts:
            for l in sorted(loc_start[st], key=lambda x: (len(x), x)):
                y = l + st
                if y == y[::-1]:
                    found[st] += 1
                    found[st + "LAST"] += 1
                    if found[st + "LAST"] % every_cr == 1 and found[st + "LAST"] > 1:
                        pal_list["LAST"][st] = pal_list["LAST"][st] + "\n  "
                    else:
                        pal_list["LAST"][st] = pal_list["LAST"][st] + " /"
                    pal_list["LAST"][st] = pal_list["LAST"][st] + " {:s} + *{:s}* = {:s}".format(l, st, y)
                    # print("Added", l, st)
                    continue
                if check_possible:
                    if count <= check_possible_max and l.startswith(st[::-1]):
                        if count < check_possible_max:
                            possible_ends[st] = possible_ends[st] + " " + l
                        else:
                            can_increase = True
                        count += 1
    for x in sorted(found.keys()):
        if 'T' in x: continue
        got_something = False
        if found[x] or possible_ends[x] or possible_starts[x]:
            got_something = True
            print(hdr, x, hdr)
            if x in pal_list["FIRST"].keys():
                print("FIRST" + pal_list["FIRST"][x])
            if x in pal_list["LAST"].keys():
                print("LAST" + pal_list["LAST"][x])
            if print_possible:
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
    print("Total time taken to extract", len(pals), "palindrome sets: {:.4f} seconds.".format(end_time - start_time))

argcount = 1

while argcount < len(sys.argv):
    xr = sys.argv[argcount]
    xl = xr.lower()
    if xl == "-a": file_array = [i7.f_f, i7.f_l, i7.f_dic]
    elif xl[:2] == "d=":
        if "D" in macro_letter.keys(): sys.exit("Custom letters (D/user defined) defined twice on command line.")
        macro_letter["D"] = alph_dash_string_to_list(xl[2:])
    elif xl[:2] == "-r":
        read_file = True
        check_possible = False
    elif re.match("^-[wfl]+$", xl):
        file_array = []
        if 'f' in xl: file_array.append(i7.f_f)
        if 'l' in xl: file_array.append(i7.f_l)
        if 'w' in xl: file_array.append(i7.f_dic)
    elif xl == "-m":
        try:
            check_possible_max = int(sys.argv[argcount+1])
            print("New max", check_possible_max)
            argcount += 1
        except:
            sys.exit("Tried to change maximum # of listings but didn't give a valid number.")
    elif xl == "-e":
        j = ''.join(sys.argv[argcount+1:]).lower()
        j = re.sub(r"[^a-z]", "", j, re.IGNORECASE)
        print("Palindrome check", "succeeded." if j == j[::-1] else "failed:\n  {:s}\n  {:s}\n  {:s}".format(j, j[::-1], wrong_letters(j)))
        exit()
    elif xl == "-c": check_possible = True
    elif xl == "-nc": check_possible = False
    elif xl == "-of":
        get_lasts = False
        get_firsts = True
    elif xl == "-ol":
        get_lasts = True
        get_firsts = False
    elif xl == "-np": print_possible = False
    elif xl == "-g": generate_palindromes = True
    elif xl == "-i": only_stdin = True
    elif xl == "-?" or xl == "?": usage()
    elif not xl.replace(",", "").isalpha(): usage("Invalid flag {:s}\n\n".format(xl))
    else:
        for y in xr.split(","):
            ncy = num_checks(y)
            if  ncy > max_mult_checks:
                print(y, "has too many checks--", ncy, "to be specific.")
                continue
            elif ncy > 1:
                print(y, "has", ncy, "branches.")
            if 'D' in y and 'D' not in macro_letter.keys(): sys.exit("You need to define a custom array before using D.")
            pals += branch_from(y)
    argcount += 1

if generate_palindromes:
    while True:
        finish = input("Palindrome stuff here:")
        if not finish.strip(): break
        for q in re.split("[ ,]+", finish):
            print(q, 'start', to_poss_pal(q, True), 'last', to_poss_pal(q, False))
    sys.exit("Bye!")

start_time = time.time()
if read_file:
    pals = read_it_all()

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
