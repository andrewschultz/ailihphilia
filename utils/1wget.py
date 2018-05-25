#1wget.py
#
#extract all possible palindrome candidates from stuff in Ailihphilia
#
#usage: no args except edit source(c) or output(e)

from filecmp import cmp
from shutil import copy
from collections import defaultdict
import sys
import os
import re
import i7
import __main__ as main

scen_tot = 0
ppl_tot = 0
rms = 0
thingz = 0

stuff_in_game = defaultdict(int)
bad_start_dict = defaultdict(bool)

def get_printed_name(x):
    if 'pyx' in x: return
    x2 = re.sub(".*printed name.*?\"", "", x.strip().lower())
    x2 = re.sub("-", " ", x2)
    x2 = re.sub(",", "", x2)
    x2 = re.sub("\".*", "", x2)
    # this is for just extracting words
    x2 = re.sub("\[.*?\]", " ", x2)
    x2 = re.sub("^ +", "", x2)
    x2 = re.sub(" +$", "", x2)
    for x0 in re.split(" +", x2):
        stuff_in_game[x0] += 1
    # this is for full names
    return
    #x2 = re.sub("^\[.*?\]", "", x2)
    #x3 = re.split("\[end if\]", x2)
    #x4 = re.split("\[.*?\]", x3[0])
    # print(x)
    print(x4, '--', x3[1])

def to_check_hash(q):
    for q2 in q.split(' '):
        stuff_in_game[q2] += 1

def read_bad_start():
    with open("1wget.txt") as file:
        for line in file:
            if line.startswith('#'): next
            if line.startswith(';'): last
            for j in line.lower().strip().split(','): bad_start_dict[j] = True

def has_dir(x):
    return re.search(" is (north|south|east|west) ", x)

def no_art(x):
    return re.sub("^(a|the|an) ", "", x, 0, re.IGNORECASE)

def cut_verb(x):
    return re.sub(" (is|are) .*", "", x, 0, re.IGNORECASE)

def bad_start(x):
    xl = x.lower()
    for b in bad_start_dict.keys():
        if xl.startswith(b + ' '): return True
    if xl.startswith('['): return True
    return False

read_bad_start()

with open("story.ni") as file:
    for (line_count, line) in enumerate(file, 1):
        if '\t' in line: continue
        if re.search("printed name .*is \"\[", line) : get_printed_name(line)
        sent1 = re.sub("\..*", "", line.strip().lower())
        if bad_start(sent1): continue
        if ' thing ' in sent1 or sent1.endswith('thing'):
            if 'is an action' in sent1: continue
            if 'is a kind of' in sent1: continue
            st = cut_verb(sent1)
            st = no_art(st)
            thingz += 1
            to_check_hash(st)
            # print(thingz, st)
        if ' room ' in sent1 or has_dir(sent1):
            if 'room in odd do' in sent1: continue
            st = cut_verb(sent1)
            rms += 1
            to_check_hash(st)
            # print(rms, st)
        if ' scenery' in sent1:
            scen_tot += 1
            st = no_art(sent1)
            st = cut_verb(st)
            to_check_hash(st)
            # print(scen_tot, st)
        if ' person' in sent1 or ' people' in sent1:
            ppl_tot += 1
            if 'kind of person' in sent1: continue
            st = no_art(sent1)
            st = cut_verb(st)
            to_check_hash(st)
            # print(ppl_tot, st)

i7.go_proj('ai')
out_final = "1wget-out.txt"
out_temp = "1wget-out-temp.txt"

if len(sys.argv) > 1:
    if sys.argv[1] == 'e' or sys.argv[1] == '-e':
        print("Opening", out_final)
        os.system(out_final)
        exit()
    if sys.argv[1] == 'c' or sys.argv[1] == '-c':
        print("Opening", main.__file__)
        i7.npo(main.__file__)
        exit()

f2 = open(out_temp, "w")

for x in stuff_in_game.keys():
    f2.write(x + '\n')

f2.close()

if cmp(out_temp, out_final):
    print("No changes, no copying to", out_final)
else:
    print("Changes, copying over", len(stuff_in_game.keys()), "palindrome candidates to", out_final)
