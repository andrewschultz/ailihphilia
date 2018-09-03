#
# curpal.py: looks for current palindromes in the source of Ailihphilia
#
# based on one word read in

from collections import defaultdict
import re
import i7
import sys

global_count = 0
palcomp = defaultdict(int)
my_word = 'eh'
track_nothing = False

if len(sys.argv) > 1: my_word = sys.argv[1]

def is_palindrome(q):
    return q == q[::-1]

def scour_file(f):
    this_file = 0
    with open(f) as file:
        for (line_count, line) in enumerate(file, 1):
            l2 = re.sub("'", "", line.lower().strip())
            lws = re.split("[^a-z]+", l2)
            ll = len(lws)
            for x in range(0, ll):
                if lws[x] == my_word:
                    if x > 0 and is_palindrome(lws[x-1] + lws[x]):
                        print(lws[x-1],lws[x], line_count, l2)
                        this_file += 1
                        palcomp[lws[x-1]] += 1
                    if x < ll - 1 and is_palindrome(lws[x] + lws[x+1]):
                        print(lws[x], lws[x+1], line_count, l2)
                        this_file += 1
                        palcomp[lws[x+1]] += 1
    if this_file: print(f, "found", this_file, "palindrome{:s}.".format(i7.plur(this_file)))
    elif track_nothing: print(f, "found nothing")
    return this_file

for q in i7.i7f['ailihphilia']:
    global_count +=  scour_file(q)

if global_count: print("Total pals found for", my_word + ":", global_count)
else: sys.exit("Nothing found for", my_word)

ones = []

for q in sorted(palcomp.keys(), key=palcomp.get):
    if palcomp[q] > 1: print(my_word, q, palcomp[q])
    else: ones.append(q)

if len(ones): print("Singletons:", ', '.join(sorted(ones)))