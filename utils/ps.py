# ps.py
#
# palindrome search: Looks for (A) + letter + (A reverse) or (A reverse) + letter + (A)
#

import re
import os
import sys

show_splits = True

print_finds_and_starts = False

count = 1

q = []

def usage():
    print("You need to put palindrome-halves in the command line. You can have more than one. They need to be of length at least 2.")
    print("ns and sn are reserved for finds and starts.")

while count < len(sys.argv):
    arg = sys.argv[count].lower()
    if sys.argv[count] == '-ns' or sys.argv[count] == '-sn': print_finds_and_starts = False
    elif sys.argv[count] == '-sy' or sys.argv[count] == '-ys': print_finds_and_starts = True
    elif arg == '?': usage()
    else:
        if arg[0] == '-': arg = arg[1:]
        if re.search("^[a-z]", arg): sys.exit("All search entries must be letters-only. Use spaces to separate them.")
        q.append(arg)

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
                        if re.search(r'\b(.{:s}|{:s}.)\b'.format(q2[::-1], q2[::-1]), l):
                            j.append(q2)
                    if q2 in lc: k.append(q2)
                if len(j) == 0 and not show_splits: continue
                q3 = "<{:s}{:s}>".format("split word " if len(j) == 0 else "", '/'.join(k))
                count += 1
                print("{:5d}:{:3d}".format(line_count, count), q3, line.strip())

find_one("story.ni")