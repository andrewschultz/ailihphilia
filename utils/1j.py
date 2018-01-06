# 1j.py
# "1 just"
# this checks for palindromes just one word long

import re

rem_str = ''

rl = len(rem_str)

print_standard_palindrome = False

def one_pal(a):
    count = 0
    count1 = 0
    count2 = 0
    with open("c:/writing/dict/{:s}.txt".format(a)) as file:
        for line in file:
            ll = line.lower().strip()
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
            if ll == ll[::-1] and print_standard_palindrome:
                count = count + 1
                print(count, ll)
    print("start", count1, "end", count2, "for", a)

one_pal("firsts")
one_pal("lasts")
one_pal("brit-1word")