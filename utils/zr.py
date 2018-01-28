# zr.py
#
# trivial capitalizations fixer
#
# can/should be generalized
#
# named zr.py because ZeroRez is the original.
#

from collections import defaultdict
from shutil import copy
from filecmp import cmp
import os
import re

if not os.path.exists("story.ni"):
    try:
        os.chdir("c:/games/inform/put-it-up.inform/source")
    except:
        print("No story.ni and no default directory path.")
        exit()

fout = open("story.ni2", "w", newline='\n') # STORY.NI files have unix line endings
difs = 0
line_count = 0
cap_search = defaultdict(bool)

with open("zr.txt") as file:
    for line in file:
        if line.startswith('#'): continue
        if line.startswith(';'): break
        cap_search[line.strip()] = True

cs = cap_search.keys()

with open("story.ni") as file:
    for line in file:
        line_count = line_count + 1
        ll = line
        if '[ic]' not in ll:
            for x in cs:
                if x.lower() in line.lower():
                    ll = re.sub(r'\b{:s}\b'.format(x), x, ll, 0, re.IGNORECASE)
                    if ll != line:
                        difs = difs + 1
                        print("Line", line_count, "is different:", line.strip())
        fout.write(ll)

fout.close()

if not cmp("story.ni", "story.ni2"):
    if difs == 0:
        print("There are no flagged differences, but story.ni is not story2.ni. This should not happen. Bailing.")
        exit()
    print(difs, "differences, copying back over")
    try:
        copy("story.ni2", "story.ni")
    except:
        print("Couldn't copy back to story.ni.")
        exit()
    try:
        os.remove("story.ni2")
    except:
        print("Tried and failed to remove story.ni2.")
        exit()
else:
    if difs:
        print("Oops! I should be copying back over, but I'm not.")
    else:
        print("No differences, no copying back over.")
