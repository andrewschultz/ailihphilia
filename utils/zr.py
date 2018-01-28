# zr.py
#
# trivial capitalizations fixer
#
# can/should be generalized
#
# named zr.py because ZeroRez is the original.
#

from shutil import copy
from filecmp import cmp
import os
import re

fout = open("story.ni2", "w")

difs = 0
line_count = 0

with open("story.ni") as file:
    for line in file:
        line_count = line_count + 1
        if 'zerorez' in line.lower():
            ll = re.sub("zerorez", "ZeroRez", line)
            if ll != line:
                difs = difs + 1
                print("Line", line_count, "is different:", line.strip())
        else:
            ll = line
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
