import time
import sys
import re

from collections import defaultdict

wordy = defaultdict(bool)
lasty = defaultdict(lambda: defaultdict(bool))
firsty = defaultdict(lambda: defaultdict(bool))

# options
look_for_last = False
skip_uneven_palindromes = False
progress_to_stderr = False

def get_last_word_tried():
    fname = "3w.txt"
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

count = 0

t2 = time.time() - t1
print(t2, 'seconds to read dict file')

start_val = 'a'

words_listed_yet = True
ignored = 0
overall_word_count = 0
warning_every_x = 10

if len(sys.argv) > 1:
    count = 1
    while count < len(sys.argv):
        if sys.argv[count].isalpha():
            start_val = sys.argv[count].tolower()
        elif sys.argv[count].lower() == '-s':
            skip_uneven_palindromes = True
        elif sys.argv[count].lower() == '-l':
            look_for_last = True
        elif sys.argv[count].lower() == '-e':
            progress_to_stderr = True
        elif sys.argv[count].lower() == '-w':
            try:
                warning_every_x = int(sys.argv[count + 1])
            except:
                print("No number after -w. Going to default of", warning_every_x)
            count = count + 2
            continue
        else:
            print("The parameter must be a word. It says which word the palindrome search starts on, alphabetically.")
            exit()
        count = count + 1

if look_for_last:
    if start_val:
        print("Defined start_val and look_for_last, so you gave conflicting options. Bailing.")
        exit()
    start_val = get_last_word_tried()

exit()

for a in sk:
    if a < start_val:
        ignored = ignored + 1
        continue
    if ignored > 0 and words_listed_yet is False:
        words_listed_yet = True
        sys.stderr.write("{:d} words ignored to start. Starting with {:s}.\n".format(ignored, a))
    if progress_to_stderr and overall_word_count % warning_every_x == 0:
        overall_word_count = overall_word_count + 1
        sys.stderr.write("STARTING WORD {:d}+{:d}: {:s}.\n", overall_word_count, ignored, a)
    this_word_count = 0
    if count % 1000 == 0:
        print(a, count);
    for b in sk:
        if can_palindrome_mid(a, b):
            for c in sk:
                d = a + c + b
                if d == d[::-1]:
                    this_word_count = this_word_count + 1
                    count = count + 1
                    print(this_word_count, count, a, c, b, "=", d)

t3 = time.time() - t2
print(t3, "seconds for all 3-word palindromes.")
