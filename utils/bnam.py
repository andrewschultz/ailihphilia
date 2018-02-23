import sys
import re
from collections import defaultdict

in_pal_table = False
need_no_unique = False
count = 0
low_limit = 5

blocks_found = 0
blocks_expected = 3

names_so_far = defaultdict(bool)
dupes = defaultdict(bool)

def uniq_l(x):
    if need_no_unique: return True
    lets = defaultdict(bool)
    for y in x:
        if y in lets.keys(): return False
        lets[y] = True
    return True

def start_name_list(l):
    ll = l.lower().strip()
    if ll.startswith("table of random palindrome"): return True
    if ll.endswith("below"):
        if "===full" in ll:
            return True
    return False

def get_good_pals(fi):
    global count
    global blocks_found
    print("Reading", fi)
    short = re.sub(".*[\\\/]", "", fi)
    loc_count = 0
    in_pal_table = False
    line_count = 0
    print("Checking", short)
    with open(fi) as file:
        for line in file:
            line_count = line_count + 1
            if start_name_list(line):
                blocks_found = blocks_found + 1
                in_pal_table = True
                continue
            if not line.strip():
                in_pal_table = False
                continue
            if in_pal_table:
                ls = line.strip()
                ls = re.sub("^.*?\"", "", line.strip())
                ls = re.sub("\".*?", "", ls)
                x = re.sub("[^a-z]", "", line.strip().lower())
                x = re.sub(".*\"", "", x)
                y = (len(x)+1) // 2
                x2 = x[:y]
                if len(x2) >= low_limit and uniq_l(x2):
                    if x2 in names_so_far.keys():
                        print("Duplicate (ish) name", ls, short, line_count)
                        print("DUPE", line.strip(), '/', ls)
                        dupes[ls] = True
                        continue
                    names_so_far[x2] = True
                    loc_count = loc_count + 1
                    count = count + 1
                    print(count, line.strip(), "seems like a cool name." + ( " newfile {:s}".format(fi) if loc_count == 1 else ""))
    count = count + loc_count

while count < len(sys.argv):
    ar = sys.argv[count].lower()
    if ar[0] == '-':
        ar = ar[1:]
    if ar == 'a':
        need_no_unique = True
    elif ar == 'b':
        blocks_expected = int(ar[1:])
    elif ar == 'n':
        need_no_unique = False
    elif ar[0] == 'l':
        low_limit = int(ar[1:])
    count = count + 1

count = 0

get_good_pals("c:/Program Files (x86)/Inform 7/Inform7/Extensions/Andrew Schultz/Put it Up tables.i7x")
get_good_pals("c:/games/inform/put-it-up.inform/source/notes.txt")

if blocks_found != blocks_expected:
    print("Found", blocks_found, "blocks but expected", blocks_expected)

if len(dupes.keys()):
    print("DUPLICATE-ISH:", ', '.join(sorted(dupes.keys())))