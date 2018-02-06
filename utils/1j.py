# 1j.py
# "1 just"
# this checks for palindromes just one word long

from collections import defaultdict
from string import ascii_lowercase
import re

rem_str = ''

rl = len(rem_str)

tack_start_on_end = True
tack_end_on_start = True
print_standard_palindrome = True
strict_reverse = False

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
            if strict_reverse and temp_words[ll[::-1]] == True:
                src = src + 1
                print(src, ll, "<==>", ll[::-1])
            temp_words[ll] = True
        if strict_reverse: return
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
                count = count + 1
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

one_pal("firsts")
one_pal("lasts")
one_pal("brit-1word")