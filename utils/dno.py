#
# dno.py
#
# debug notes: check if something has already been used and can be wiped

import re
from collections import defaultdict

pals = defaultdict(int)
twice = defaultdict(bool)

# options (unimplemented yet)
twice_okay = False

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
                    twice[q] = True
                    xtranote = xtranote + 1
    if xtranote + dupes == 0:
        print("Notes file has no duplicates/extras.")
    else:
        print(xtranote, "extra notes", dupes, "duplicates")

check_notes("put-it-up")
