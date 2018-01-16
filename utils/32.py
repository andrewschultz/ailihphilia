# 32.py
#
# quicker 3-word anagram detector
#
# keeps track of what is needed to anagram (starting word block) or (ending word block)
#

import sys
import time

from collections import defaultdict
from string import ascii_lowercase

starts = defaultdict(lambda: defaultdict(bool))
ends = defaultdict(lambda: defaultdict(bool))

allword = defaultdict(bool)

pals_with_start = defaultdict(str)
pals_with_end = defaultdict(str)
got_yet = defaultdict(bool)

min_length = 1
max_length = 5

two_word_pals_too = False

def chunk(a, b):
    if len(a) > len(b):
        if a[:len(b)] == b[::-1]:
            return (a[len(b):], None)
    elif len(b) > len(a):
        if b[:len(a)] == a[::-1]:
            return (b[len(a):], None)
    return(None, None)

t = time.time()

with open("c:/writing/dict/brit-1word.txt") as file:
    for line in file:
        ll = line.lower().strip()
        if len(ll) < min_length:
            continue
        if len(ll) > max_length:
            continue
        allword[ll] = True
        starts[ll[:2]][ll] = True
        ends[ll[-2:]][ll] = True

for a in ascii_lowercase:
    for b in ascii_lowercase:
        for x in sorted(starts[a+b].keys()):
            for y in sorted(ends[b+a].keys()):
                if (x+y) == (x+y)[::-1]:
                    print(x, '-', y)
                (s, e) = chunk(x, y)
                if not s and not e: continue
                if s:
                    if s not in pals_with_start.keys():
                        for w in allword.keys():
                            if (s + w) == (s + w)[::-1]:
                                pals_with_start[s] = pals_with_start[s] + ' ' + w
                        if not pals_with_start[s]:
                            pals_with_start[s] = ''
                    if pals_with_start[s]:
                        if pals_with_start[s][0] == ' ':
                            pals_with_start[s] = pals_with_start[s][1:]
                        print(x, '/', pals_with_start[s], '/', y)
                    continue
                if e:
                    if e not in pals_with_end.keys():
                        for w in allword.keys():
                            if (w + e) == (w + e)[::-1]:
                                pals_with_end[e] = pals_with_end[e] + ' ' + w
                        if not pals_with_end[e]:
                            pals_with_end[e] = ''
                    if pals_with_end[e]:
                        if pals_with_start[e][0] == ' ':
                            pals_with_start[e] = pals_with_start[e][1:]
                        print(x, '/', pals_with_end[e], '/', y)
                    continue

t = time.time() - t

out = "{:.2f} total seconds taken.".format(t)
sys.stderr.write(out + '\n')

exit()

check_string = "aid"

print(check_string, pals_with_end[check_string])
print(check_string, pals_with_start[check_string])
