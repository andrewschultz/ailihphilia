#
# dno.py
#
# debug notes: check if something has already been used and can be wiped

import sys
import i7
import os
import re
from collections import defaultdict

pals = defaultdict(int)
twice = defaultdict(bool)

# options
twice_okay = False
launch_after = True

def usage():
    print("-2 = report appearance of notes.txt stirng in story.ni/put it up tables.i7x more than once.")
    print("    -2n/-n2 = negation. Default = off.")
    print("-l = launch after.")
    print("    -ln/-nl = don't. Default = on.")
    print("-?/-u = this")
    exit()

def pally(s):
    s = re.sub("[=:].*", "", s)
    # print(s, "!", s.upper(), s.lower())
    if not (s.upper() or s.lower()):
        # print("No letters.")
        return False
    s2 = re.sub("[^a-z\/]", "", s, 0, re.IGNORECASE)
    a = s2.lower().split("/")
    for b in a:
        if b != b[::-1]:
            return False
    return True

def check_notes(s):
    open_line = 0
    pal_count = 0
    line_count = 0
    dupes = 0
    xtranote = 0
    notes_file_to_read = "c:/games/inform/{:s}.inform/source/notes.txt".format(s)
    source_file = "c:/games/inform/{:s}.inform/source/story.ni".format(s)
    with open(notes_file_to_read) as file:
        for line in file:
            line_count = line_count + 1
            ll = line.strip()
            if pally(ll):
                l2 = re.sub("[:=].*", "", line.strip().lower(), 0, re.IGNORECASE)
                l2 = re.sub("[^a-z \/]", "", l2, 0, re.IGNORECASE)
                # print("Looking for", l2)
                for q in l2.split("/"):
                    if q in pals.keys():
                        print("Duplicate", q, line_count, "from", pals[q], "in notes file")
                        if not open_line:
                            open_line = pals[q]
                        dupes = dupes + 1
                    else:
                        q2 = q.strip()
                        pals[q2] = line_count
                        pal_count = pal_count + 1
                        # print(count, q2)
    with open(source_file) as file:
        count = 0
        for line in file:
            count = count + 1
            for q in pals.keys():
                if q in line.lower() and (q not in twice.keys() or twice_okay):
                    print(q, "in notes line", pals[q], "and source line", count, ":", line.lower().strip())
                    if not open_line:
                        open_line = pals[q]
                    twice[q] = True
                    xtranote = xtranote + 1
    if xtranote + dupes == 0:
        print("Notes file has no duplicates/extras.")
    else:
        print(xtranote, "extra notes", dupes, "duplicates")
    if launch_after and open_line:
        print("Launching", notes_file_to_read, "at", open_line)
        cmd = "start \"\" {:s} {:s} -n{:d}".format(i7.np, notes_file_to_read, open_line)
        print(cmd)
        os.system(cmd)

count = 1
while count < len(sys.argv):
    l = sys.argv[count].lower()
    if l[0] == '-': l = l[1:]
    if l == '2n' or l == 'n2':
        twice_okay = False
    if l == '2' or l == '-2':
        twice_okay = True
    elif l == 'l':
        launch_after = True
    elif l == 'ln' or l == 'nl':
        launch_after = False
    elif l == '?' or l == 'u':
        usage()
    else:
        print("Unknown option", l)
        usage()
    count = count + 1

check_notes("put-it-up")

