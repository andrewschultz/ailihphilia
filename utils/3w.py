# 3w.py
#
# attempts to read in all possible 3 word palindromes
#
# usage() lists command line options
#

import time
import sys
import re
import os

from collections import defaultdict

wordy = defaultdict(bool)
lasty = defaultdict(lambda: defaultdict(bool))
firsty = defaultdict(lambda: defaultdict(bool))

def usage():
    print("3 word palindrome searcher.")
    print("-l = pick up where 3w.txt left off")
    print("-s = skip uneven palindromes e.g. top X spot. Speedup, but may miss a few.")
    print("-e = write progress to STDERR, useful when piping output to a file. (-ne turns it off, default is on)")
    print("-w = warn every X new words (default = {:d}).".format(warning_every_x))
    print("any word = what word to start with.")
    print("-? = this function.")
    exit()

def get_last_word_tried():
    fname = "3w.txt"
    if not os.path.exists(fname):
        print("3w.txt is not present, so we can't pick up where we left off.")
        exit()
    with open(fname, 'rb') as fh:
        first = next(fh).decode()
        fh.seek(-1024, 2)
        x = fh.readlines()
    for a in range(0, len(x)):
        a1 = -1 - a
        # print(a1)
        last = x[a1].decode()
        # print(a, last.strip())
        if '=' in last:
            ary = last.strip().lower().split(" ")
            for count in range(0,len(ary)):
                if ary[count].isalpha():
                    # print(count, ary[count])
                    return ary[count]
    print("Bad last line(s) in", fname, "... modify it manually.")
    print("Dump of last 1024 chars of file:")
    for a in range(-1, -len(x), -1):
        print(a, ':', x[a].decode().strip())
    exit()

def can_palindrome_2(a, b):
    if a == b:
        return False
    if len(b) > len(a):
        return b.startswith(a[::-1])
    else:
        return a.startswith(b[::-1])

def can_palindrome_mid(a, b):
    c = a + b
    if a == b[::-1]:
        return False
    if skip_uneven_palindromes and c == c[::-1]:
        d = len(a) - len(b)
        if abs(d) < 2:
            return False
    if len(a) < len(b):
        return a == b[-len(a):][::-1]
    return b == a[:len(b)][::-1]

# default values
words_listed_yet = False
ignored = 0
overall_word_count = 0

# options
start_val = ''
look_for_last = False
skip_uneven_palindromes = False
progress_to_stderr = True
warning_every_x = 10

# start initialization stuff

if len(sys.argv) > 1:
    count = 1
    while count < len(sys.argv):
        if sys.argv[count].isalpha():
            start_val = sys.argv[count].tolower()
        elif sys.argv[count].lower() == '-?' or sys.argv[count].lower() == '?':
            usage()
        elif sys.argv[count].lower() == '-s':
            skip_uneven_palindromes = True
        elif sys.argv[count].lower() == '-l':
            look_for_last = True
        elif sys.argv[count].lower() == '-e':
            progress_to_stderr = True
        elif sys.argv[count].lower() == '-ne':
            progress_to_stderr = False
        elif sys.argv[count].lower() == '-w':
            try:
                temp = int(sys.argv[count + 1])
                if temp < 1:
                    sys.stderr.write("WARNING the progress-every-X must be at least 1.\n")
                    # raise Exception("WARNING the progress-every-X must be at least 1.")
                else:
                    warning_every_x = temp
            except:
                print("No number after -w. Going to default of", warning_every_x)
            count = count + 2
            continue
        else:
            if sys.argv[count].lower()[0] == '-':
                print("Bad flag.")
                print()
                usage()
            else:
                print("The parameter must be a word. It says which word the palindrome search starts on, alphabetically.")
            exit()
        count = count + 1

if look_for_last:
    if start_val:
        print("Defined start_val and look_for_last, so you gave conflicting options. Bailing.")
        exit()
    start_val = get_last_word_tried()

# end initialization stuff

t1 = time.time()

okay_2_letter_words = [ "a", "an", "in", "on", "of", "or", "to", "my", "it"]

for x in okay_2_letter_words:
    wordy[x] = True
    firsty[x[0]][x] = True
    lasty[x[-1]][x] = True

with open("c:/writing/dict/brit-1word.txt") as file:
    for line in file:
        ll = line.lower().strip()
        if len(ll) < 3:
            continue
        wordy[ll] = True
        firsty[ll[0]][ll] = True
        lasty[ll[-1]][ll] = True

sk = sorted(wordy.keys())

t3 = time.time()
print(t3)

count = 0

t2 = time.time() - t1
sys.stderr.write('{:4f} seconds to read dict file.\n'.format(t2))

bt = time.time()

last_delt = 0
time_taken = 0

if progress_to_stderr:
    sys.stderr.write("Printing progress every {:d} starting words.\n".format(warning_every_x))

for a in sk:
    if a < start_val:
        ignored = ignored + 1
        continue
    if ignored > 0 and words_listed_yet is False:
        words_listed_yet = True
        sys.stderr.write("{:d} of {:d} words ignored to start. Starting with {:s}.\n".format(ignored, len(sk), a))
    overall_word_count = overall_word_count + 1
    if progress_to_stderr and overall_word_count % warning_every_x == 0:
        time_taken = time.time() - bt
        sys.stderr.write("{:d} starting words considered this run. Currently at {:s} after {:3f} seconds, delta = {:3f}.\n".format(overall_word_count, a, time_taken, time_taken - last_delt));
        last_delt = time_taken
    this_word_count = 0
    for b in lasty[a[0]]:
        if can_palindrome_mid(a, b):
            # for c in sk: # this appears to be slower than a more targeted list of anagrams
            for c in (lasty[a[len(b)]] if len(a) > len(b) else firsty[b[-len(a)-1]]):
                d = a + c + b
                if d == d[::-1]:
                    this_word_count = this_word_count + 1
                    count = count + 1
                    print(this_word_count, count, a, c, b, "=", d)

t3 = time.time() - t2
print(t3, "seconds for all 3-word palindromes.")
