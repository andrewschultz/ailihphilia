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

end_pal = defaultdict(lambda: defaultdict(bool))
start_pal = defaultdict(lambda: defaultdict(bool))

def usage():
    print("3 word palindrome searcher.")
    print("-l = pick up where 3w.txt left off")
    print("-m = maximum word length")
    print("-s = skip uneven palindromes e.g. top X spot. Speedup, but may miss a few.")
    print("-e = write progress to STDERR, useful when piping output to a file. (-ne turns it off, default is on)")
    print("-w = warn every X new words (default = {:d}).".format(warning_every_x))
    print("any word = what word to start with.")
    print("-? = this function.")
    exit()

def end_array(x):
    if len(x) >= 2:
        return lasty[x[-2:]]
    return lasty[x[-1:]]

def start_array(x):
    if len(x) >= 2:
        return firsty[x[:2]]
    return firsty[x[:1]]

def pal_conv_hash(a, b):
    if len(a) > len(b):
        if a.startswith(b[::-1]):
            return end_pal[a[len(b):][::-1]]
    elif len(a) < len(b):
        if b.endswith(a[::-1]):
            return start_pal[b[:-len(a)][::-1]]

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

def silly_test(a, b):
    count = 0
    print('=' * 40, a, "to", b)
    for x in pal_conv_hash(a, b):
        u = a + x + b
        count = count + 1
        print(count, "frato", x, "arf")
        if u != u[::-1]:
            print ("Bad palindrome above!")
            exit()
    print('=' * 40, b[::-1], "to", a[::-1])
    for x in pal_conv_hash(b[::-1], a[::-1]):
        u = b[::-1] + x + a[::-1]
        count = count + 1
        print(count, "fra", x, "otarf")
        if u != u[::-1]:
            print ("Bad palindrome above!")
            exit()
    exit()

# default values
words_listed_yet = False
ignored = 0
overall_word_count = 0

# options
ignore_2_letter_words = True
start_val = ''
look_for_last = False
skip_uneven_palindromes = False
progress_to_stderr = True
warning_every_x = 10
max_word_length = 13

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
        elif sys.argv[count].lower() == '-m':
            try:
                temp = int(sys.argv[count+1])
                if temp < 5:
                    sys.stderr.write("WARNING max word length should be at least 5.")
                else:
                    max_word_length = temp
            except:
                print("No valid number after -m. Going to default of", max_word_length)
        elif sys.argv[count].lower() == '-w':
            try:
                temp = int(sys.argv[count + 1])
                if temp < 1:
                    sys.stderr.write("WARNING the progress-every-X must be at least 1.\n")
                    # raise Exception("WARNING the progress-every-X must be at least 1.")
                else:
                    warning_every_x = temp
            except:
                print("No valid number after -w. Going to default of", warning_every_x)
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
    if len(x) > 1:
        firsty[x[:2]][x] = True
        lasty[x[-2:]][x] = True

endpals = 0
startpals = 0

time_before_read_word_file = time.time()

with open("c:/writing/dict/brit-1word.txt") as file:
    for line in file:
        ll = line.lower().strip()
        if len(ll) > max_word_length:
            continue # we could just break given brit-1word.txt is sorted by length but that's iffy coding
        if len(ll) < 3 and ignore_2_letter_words:
            continue
        wordy[ll] = True
        firsty[ll[0]][ll] = True
        lasty[ll[-1]][ll] = True
        firsty[ll[:2]][ll] = True
        lasty[ll[-2:]][ll] = True
        for i in range (1,len(ll)):
            if ll[i:] == ll[i:][::-1]:
                start_pal[ll[:i]][ll] = True
                startpals = startpals + 1
                if len(ll[i:]) > 3:
                    continue
                    print("remove", ll[:i], "of", len(ll), "from", ll, "to get", ll[i:], i, "start partial anagram")
            if ll[:i] == ll[:i][::-1]:
                end_pal[ll[i:]][ll] = True
                endpals = endpals + 1
                if len(ll[:i]) > 3:
                    continue
                    print("remove", ll[i:], "from", ll, "to get", ll[:i], i, "end partial anagram")
                # print(ll[:-i], ll, i, "end partial anagram")

time_after_read_word_file = time.time()

sys.stderr.write("Time to read word file and put stuff into hashes: {:.4f} seconds.\n".format(time_after_read_word_file - time_before_read_word_file))
sys.stderr.write("{:2d} partial start-anagrams, {:2d} partial end-anagrams.\n".format(startpals, endpals))

# uncomment this to test any code changes. One word should anagram the start of the other.
# silly_test("frato", "arf")

sk = sorted(wordy.keys())

t3 = time.time()
# print(t3)

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
        sys.stderr.write("{:d} starting words considered this run. Currently at {:s} after {:.3f} seconds, delta = {:.3f}, average = {:.6f}.\n".format(overall_word_count, a, time_taken, time_taken - last_delt, (time_taken - last_delt) / overall_word_count));
        last_delt = time_taken
    this_word_count = 0
    for b in end_array(a):
        q = pal_conv_hash(a, b)
        if q:
            # print(a, b, q)
            for c in sorted(q):
                this_word_count = this_word_count + 1
                print(this_word_count, count, a, c, b, "=", a + c + b)

t3 = time.time() - bt
print(t3, "seconds for all 3-word palindromes.")
