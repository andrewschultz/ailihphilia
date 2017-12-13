# 2pal.py
# 2 word combo palindromes
#
# usage examples
# 2pal.py -m the -tf (sends to file)
# 2pal.py -s i

import re
import sys
import time
import argparse
import os.path

from string import ascii_lowercase
from collections import defaultdict

twiddle_words = False
twiddle_first = False
twiddle_last = False
need_words = False

# all_at_once compares all word pairs. It's slower.
# if it is FALSE, then we only compare words that start with a with words that end with a.
# that's up to 26x (676x) faster (Cauchy's Inequality says it can't be more than that)
brute_force_hashing = False

# this determines whether or not we should go with the first two letters or just the first one, when brute_force_hashing is false
twosies = True
# this is for a quick dumb test
dumb_test = False

to_file = False
overwrite_file = False

# we show what group of letters we're on by default if brute_force_hashing is FALSE
suppress_progress = False

word_dict = defaultdict(bool)
twolist = []
ends = {}
starts = {}

mid_string = ''
start_string = ''
custom_file_string = ''

def get_words(a, new_adding_candidates = True):
    print("Getting words from",a, ['without', 'and'][new_adding_candidates], 'putting them in candidate array.')
    with open(a) as file:
        for line in file:
            l = line.strip().lower()
            word_dict[l] = True
            if new_adding_candidates:
                if twosies:
                    ends[l[-2:]][l] = True
                    starts[l[:2]][l] = True
                else:
                    u = l[-1:]
                    v = l[:1]
                    ends[u][l] = True
                    starts[v][l] = True
    print("Done with", a)

def all_at_once():
    start = time.time()
    print(start)
    for x in words:
        for y in words:
            z = x + y
            if z in words and z == z[::-1]:
                print(x, '+', y, '=', z, 'is a palindrome.')
    end = time.time()
    print(end-start, 'total seconds')

def one_at_a_time():
    out_file = "pals-out-"
    if custom_file_string != '':
        out_file = out_file + '-cus-' + custom_file_string
    if start_string != '':
        out_file = out_file + '-start-' + start_string
    if mid_string != '':
        out_file = out_file + '-mid-' + mid_string
    if twiddle_words:
        out_file = out_file + 'w'
    if twiddle_first:
        out_file = out_file + 'f'
    if twiddle_last:
        out_file = out_file + 'l'
    out_anag = out_file + "-ana.txt"
    out_file = out_file + ".txt"
    fout = None
    fouta = None
    if to_file:
        if os.path.isfile(out_file):
            if overwrite_file:
                print("Overwriting already-present file", out_file)
            else:
                print("Need -o or -of to overwrite already-present", out_file)
                return
        print("Writing to", out_file)
        fout = open(out_file, "w")
        fouta = open(out_anag, "w")
        if fout is None:
            print("Unable to open", out_file, "for writing.")
            return
        if fouta is None:
            print("Unable to open", out_file, "for writing.")
            return
    count = 0
    totals = 0
    my_stuff = []
    if dumb_test:
        my_stuff = ['ad']
    elif twosies:
        my_stuff = list(twolist)
    else:
        my_stuff = list(ascii_lowercase)
    start = time.time()
    for l in my_stuff:
        l2 = l[::-1]
        poss_combos = len(starts[l].keys()) # * len(ends[l2].keys())
        if not suppress_progress:
            stderr_string = '{:s} ({:>5d}) {:s} ({:>5d}) total = {:>10d}.\n'.format(l, len(starts[l].keys()), l2, len(ends[l2].keys()), poss_combos)
            sys.stderr.write(stderr_string)
        totals = totals + poss_combos
        for x in starts[l].keys():
            for y in ends[l2].keys():
                z = start_string + x + mid_string + y
                if z == z[::-1]:
                    pal = (x == y[::-1])
                    count = count + 1
                    this_line = '{:>5d} {:s} + {:s} ~ {:s}.'.format(count,
                    (start_string + ' + ' if start_string != '' else '') + x,
                    (mid_string + ' + ' if mid_string != '' else '') + y,
                    (' WORDY' if z in words else '') + (' ANAGRAM' if pal else 'PALINDROME'))
                    if to_file:
                        if pal:
                            fouta.write(this_line +'\n')
                        else:
                            fout.write(this_line + '\n')
                    else:
                        print(this_line)
    poss_found = str(count) + ' possible palindromes found.'
    if fout:
        fout.write(poss_found + '\n')
    else:
        print(poss_found)
    if fout:
        fout.close()
    if fouta:
        fouta.close()
    end = time.time()
    print(end-start, 'total seconds', totals, 'total comparisons')

with open("2pal-short.txt") as file:
	for line in file:
		if line.startswith(';'):
			break
		if line.startswith('#'):
			continue
		l = line.strip().lower()
		l2 = line.split(",")
		if not os.path.isfile(l2[1]):
			print("Could not find file", l2[1])
			exit()
		file_hash[l2[0]] = l2[1]

parser = argparse.ArgumentParser(description='palindrome looker upper', formatter_class=argparse.RawTextHelpFormatter)

# parser.add_argument("x", type=bool, help="2 letters in hash array or 1")
# parser.add_argument('b', action='store_true', dest='brute_force', help='!')
parser.add_argument('-d', action='store_true', dest='dumb_test', help='run dumb test focusing on specific letters')
parser.add_argument('-2', action='store_false', dest='twosies')
parser.add_argument('-w', action='store_true', dest='twiddle_words')
parser.add_argument('-f', action='store_true', dest='twiddle_first')
parser.add_argument('-l', action='store_true', dest='twiddle_last')
parser.add_argument('-lf', '-fl', action='store_true', dest='twiddle_first_last')
parser.add_argument('-sp', action='store_true', dest='suppress_progress')
parser.add_argument('-m', type=str, help="middle string", dest='mid_string')
parser.add_argument('-n', '-nw', type=str, help="need words", dest='need_words')
parser.add_argument('-s', type=str, help="start string", dest='start_string')
parser.add_argument('-c', '-cf', type=str, help="custom file string", dest='custom_file_string')
parser.add_argument('-tf', '-fi', action="store_true", help="to file", dest='to_file')
parser.add_argument('-o', '-of', action="store_true", help="overwrite file", dest='overwrite_file')

args = parser.parse_args()

if args.suppress_progress:
    suppress_progress = True

if args.to_file:
    to_file = args.to_file

if args.overwrite_file:
    overwrite_file = args.overwrite_file

if args.mid_string:
    mid_string = args.mid_string

if args.start_string:
    start_string = args.start_string

if args.custom_file_string:
    custom_file_string = args.custom_file_string

if args.twiddle_words:
    twiddle_words = args.twiddle_words

if args.twiddle_first:
    twiddle_first = args.twiddle_first

if args.twiddle_last:
    twiddle_last = args.twiddle_last

if args.twiddle_first_last:
    twiddle_last = True
    twiddle_first = True

if args.need_words:
    need_words = args.need_words

if args.twosies:
    twosies = args.twosies

if args.dumb_test:
    dumb_test = args.dumb_test

for x in ascii_lowercase:
    ends[x] = defaultdict(bool)
    starts[x] = defaultdict(bool)
    for y in ascii_lowercase:
        ends[x+y] = defaultdict(bool)
        starts[x+y] = defaultdict(bool)
        twolist.append(x+y)

if not (twiddle_first or twiddle_last or twiddle_words):
    print("You need to set -w, -l, -f or -lf.")

if twiddle_words:
    get_words("c:\\writing\\dict\\brit-1word.txt", True)
else:
    get_words("c:\\writing\\dict\\brit-1word.txt", False)

if twiddle_first:
    get_words("c:\\writing\\dict\\firsts.txt", True)

if twiddle_last:
    get_words("c:\\writing\\dict\\lasts.txt", True)

words = sorted(word_dict.keys())

if brute_force_hashing:
    brute_force_hashing()
else:
    one_at_a_time()
