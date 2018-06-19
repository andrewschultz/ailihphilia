# 1j.py
# "1 just"
# this checks for palindromes just one word long

from collections import defaultdict
from string import ascii_lowercase
import sys
import re

def usage():
    print("-se = tack letter on to end to see if it's a palindrome (a-z)")
    print("-es = tack letter on to start to see if it's a palindrome (a-z)")
    print("-sr = strict reverse eg EVADE DAVE won't work.")
    print("-p/-np = print standard palindrome (or don't) e.g. OTTO or PIP will print.")
    exit()

rem_str = ''

rl = len(rem_str)

tack_start_on_end = False
tack_end_on_start = False
print_standard_palindrome = True
strict_reverse = False

file_list = [ 'firsts', 'lasts', 'brit-1word' ]
count = 1

while count < len(sys.argv):
    arg = sys.argv[count].lower()
    if arg[0] == '-':
        arg = arg[1:]
    if arg == 'se':
        tack_start_on_end = True
    elif arg == 'es':
        tack_end_on_start = True
    elif arg == 'ta':
        tack_start_on_end = True
        tack_end_on_start = True
    elif arg == 'p':
        print_standard_palindrome = True
    elif arg == 'np':
        print_standard_palindrome = False
    elif arg == 'sr' or arg == 'rs':
        strict_reverse = True
    elif arg == 'nsr' or arg == 'nrs':
        strict_reverse = False
    elif re.search("^[flw]+$", arg):
        file_list = []
        if 'f' in arg: file_list.append('firsts')
        if 'l' in arg: file_list.append('lasts')
        if 'w' in arg: file_list.append('brit-1word')
    else:
        usage()
    count += 1

def one_pal(a):
    count = 0
    count1 = 0
    count2 = 0
    start_to_end = defaultdict(str)
    end_to_start = defaultdict(str)
    temp_words = defaultdict(bool)
    with open("c:/writing/dict/{:s}.txt".format(a)) as file:
        src = 0
        for line in file:
            ll = line.lower().strip()
            temp_words[ll] = True
            if strict_reverse and temp_words[ll[::-1]] == True and ll != ll[::-1]:
                src += 1
                print(src, ll, "<==>", ll[::-1])
                continue
        for ll in sorted(temp_words.keys(), key=lambda x:(len(x), x)):
            if rem_str:
                if ll.startswith(rem_str):
                    l2 = ll[rl:]
                    if l2 == l2[::-1]:
                        count1 = count1 + 1
                        print(count1, "palindrome w/o start", rem_str, l2, ll)
                if ll.endswith(rem_str) and rl:
                    l2 = (ll[:-rm] if rem_str else ll)
                    if l2 == l2[::-1]:
                        count2 = count2 + 1
                        print(count2, "palindrome w/o end", rem_str, l2, ll)
            if print_standard_palindrome and not rem_str and ll == ll[::-1]:
                count += 1
                print(count, ll)
            if tack_start_on_end:
                l2 = ll + ll[:1]
                if l2 == l2[::-1]:
                    start_to_end[ll[:1]] = start_to_end[ll[:1]] + ll + " + " + ll[:1] + " = " + l2 + "\n"
            if tack_end_on_start:
                l2 = ll[-1:] + ll
                if l2 == l2[::-1]:
                    end_to_start[ll[-1:]] = end_to_start[ll[-1:]] + ll[-1:] + " + " + ll + " = " + l2 + "\n"
    for q in ascii_lowercase:
        if start_to_end[q]:
            print("START TO END FOR", q)
            print(start_to_end[q].strip())
        if end_to_start[q]:
            print("END TO START FOR", q)
            print(end_to_start[q].strip())
    print("start", count1, "end", count2, "for", a)

for fname in file_list: one_pal(fname)
