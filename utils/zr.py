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
import sys
import i7

if not os.path.exists("story.ni"):
    try:
        os.chdir("c:/games/inform/put-it-up.inform/source")
    except:
        print("No story.ni and no default directory path.")
        exit()

only_test = False

difs = 0
line_count = 0
always_adj = defaultdict(bool)
cap_search = defaultdict(bool)
regex_detail = defaultdict(str)

count = 1

def usage():
    print("Currently you can specify the project to change to, with a shortcut or full name.")
    print("c edits the source, though you can just type np zr.py instead.")
    print("e edits the text, though you can just type zr.txt instead.")
    print("t only tests things. It doesn't copy back over.")

while count < len(sys.argv):
    myarg = sys.argv[count].lower()
    if (myarg[0] == '-'):
        myarg = myarg[1:]
    if myarg == 'e':
        os.system("zr.txt")
        exit()
    elif myarg == 'c':
        i7.open_source()
    elif myarg == 't':
        only_test = True
    elif myarg in i7.i7x.keys():
        newdir = "c:/games/inform/{:s}.inform/source".format(i7.i7x[sys.argv[count]])
        os.chdir(newdir)
        print("Changing to", newdir)
    elif os.path.exists("c:/games/inform/{:s}.inform/source".format(myarg)):
        newdir = "c:/games/inform/{:s}.inform/source".format(myarg)
        os.chdir(newdir)
        print("Changing to", newdir)
    else:
        print("Bad argument", sys.argv[count])
        usage()
    count = count + 1

if not os.path.exists("zr.txt"):
    print("You need a zr.txt in ", os.getcwd(), "or you need to change the project.")

fout = open("story.ni2", "w", newline='\n') # STORY.NI files have unix line endings

with open("zr.txt") as file:
    for line in file:
        if line.startswith('#'): continue
        if line.startswith(';'): break
        always = False
        if line.startswith('a:'):
            line = re.sub('a:', '', line)
            always = True
        if not line.strip(): continue
        line_ary = line.strip().split("\t")
        cap_search[line_ary[0]] = True
        if always:
            always_adj[line_ary[0]] = True
        if len(line_ary) > 1:
            regex_detail[line_ary[0]] = line_ary[1]

cs = cap_search.keys()

with open("story.ni") as file:
    for line in file:
        line_count = line_count + 1
        ll = line
        if 'lalaland' in ll.lower():
            print("WARNING replacing lalaland with ZeroRez at line", line_count)
            ll = re.sub("lalaland", "ZeroRez", ll)
            difs = difs + 1
        if '[ic]' not in ll:
            for x in cs:
                if x.lower() in line.lower():
                    if always_adj[x] or (x.upper() not in line):
                        ll_old = ll
                        ll = re.sub(r'\b{:s}\b'.format(regex_detail[x] if x in regex_detail.keys() else x), x, ll, 0, re.IGNORECASE)
                        if ll != ll_old:
                            difs = difs + 1
                            print("Line", line_count, "miscapitalized", x + ":", line.strip())
        fout.write(ll)

fout.close()

if not cmp("story.ni", "story.ni2"):
    if difs == 0:
        print("There are no flagged differences, but story.ni is not story2.ni. This should not happen. Bailing.")
        exit()
    print(difs, "differences, copying back over")
    if only_test:
        print("Testing differences, so, not copying back over.")
        system("wm story.ni story.ni2")
        exit()
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
        print("No differences, no copying back over" + (", so not running diff" if only_test else "") + ".")
