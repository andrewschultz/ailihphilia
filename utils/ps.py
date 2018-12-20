# ps.py
#
# palindrome search: Looks for (A) + letter + (A reverse) or (A reverse) + letter + (A) 
#

import re
import os
import sys

print_finds_and_starts = False

q = [x for x in sys.argv[1:] if re.search("^[a-z]+$", x.lower())]

if len(q) == 0: sys.exit("You need to put palindrome-halves in the command line.")

finds = r'({:s})'.format("|".join([r + "." + r[::-1] + "|" + r[::-1] + "." + r for r in q]))
start = r'\b({:s})'.format("|".join(q))

if print_finds_and_starts:
    print("finds", finds)
    print("start", start)
    exit()

def find_one(file_name):
    print(file_name)
    count = 0
    with open(file_name) as file:
        for (line_count, line) in enumerate(file, 1):
            l = line.lower().strip()
            lc = re.sub("[^a-z]", "", l)
            if re.search(finds, lc):
                j = []
                k = []
                for q2 in q:
                    if re.search(r'\b{:s}\b'.format(q2), l):
                        j.append(q2)
                    if q2 in lc: k.append(q2)
                q3 = "<{:s}{:s}>".format("split word " if len(j) == 0 else "", '/'.join(k))
                count += 1
                print("{:5d}:{:3d}".format(line_count, count), q3, line.strip())

find_one("story.ni")