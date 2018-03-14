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
import i7

from collections import defaultdict

# variables

wordy = defaultdict(bool)
ok_2 = defaultdict(bool)
lasty = defaultdict(lambda: defaultdict(bool))
firsty = defaultdict(lambda: defaultdict(bool))

end_pal = defaultdict(lambda: defaultdict(bool))
start_pal = defaultdict(lambda: defaultdict(bool))

i7.go_proj("up")

def usage():
    print("3 word palindrome searcher.")
    print("-g = group by start/end words.")
    print("-f = find in 3w2.txt.")
    print("-q = quick search. Skip begin/end palindromes e.g. ACISODIS/ISODICA.")
    print("-l = pick up where 3w(2).txt left off")
    print("-m = maximum word length")
    print("-o = order results by last word, -no/-on turns this off")
    print("-s = skip uneven palindromes e.g. top X spot. Speedup, but may miss a few.")
    print("-e = write progress to STDERR, useful when piping output to a file. (-ne turns it off, default is on)")
    print("-x3 = extract specific word from file of 3-palindromes (x3w/x3o = only that word)")
    print("-w = warn every X new words (default = {:d}).".format(warning_every_x))
    print("any word = what word to start with.")
    print("-? = this function.")
    exit()

def is_pal(x):
    return x == x[::-1]

def search_output(x):
    output_file = '3w2.txt'
    count = 0
    with open(output_file) as file:
        q = ' ' + x + ' '
        for line in file:
            if q in line:
                print(line.strip())
                count = count + 1
    if count == 0:
        print("Nothing found.")
    else:
        print(x, "found", count, "times.")
    exit()

def extract_from_file(x, y = True):
    any_yet = False
    exact_word = y
    with open("3w-sorted.txt") as file:
        for line in file:
            if x in line:
                if exact_word and not re.search(r"\b{:s}\b".format(x), line, re.IGNORECASE): continue
                if not any_yet: fout = open("3w-part.txt", "w")
                any_yet = True
                fout.write(line)
    if any_yet:
        fout.close()
        os.system("3w-part.txt")
    else:
        print("No matches found, not creating 3w-part.txt")


def end_array(x):
    if len(x) >= 2:
        return lasty[x[-2::-1]] if not order_results else sorted(lasty[x[-2::-1]])
    return lasty[x[-1:]] if not order_results else sorted(lasty[x[-1:]])

def start_array(x):
    if len(x) >= 2:
        return firsty[x[:2]]
    return firsty[x[:1]]

# return the end-pal or start-pal stuff between the two end words
# note that if a and b are reverses, I ignore things, because we already have all the palindromes in another file, so that is just duplicate work.
#
def pal_conv_hash(a, b):
    if skip_beginend_palindrome and abs(len(a)-len(b)) < 2:
        c = a + b
        if c == c[::-1]:
            return
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

group_by_start_end = False

# options
skip_beginend_palindrome = False
ignore_2_letter_words = True
start_val = ''
look_for_last = False
skip_uneven_palindromes = False
progress_to_stderr = True
warning_every_x = 100
max_word_length = 13
find_string = ''

# start initialization stuff

order_results = False

if len(sys.argv) > 1:
    count = 1
    while count < len(sys.argv):
        ll = sys.argv[count].lower()
        if sys.argv[count].isalpha():
            start_val = sys.argv[count].tolower()
        elif ll == '-?' or ll == '?':
            usage()
        elif ll == '-s':
            skip_uneven_palindromes = True
        elif ll == '-o':
            order_results = True
        elif ll == '-on' or ll == 'no':
            order_results = False
        elif ll == '-q':
            skip_beginend_palindrome = True
        elif ll == '-x3':
            try:
                to_extract = sys.argv[count+1]
            except:
                print("You need a string to extract.")
            extract_from_file(to_extract, False)
            exit()
        elif ll == '-x3w' or ll == '-x3o':
            try:
                to_extract = sys.argv[count+1]
            except:
                print("You need a string to extract.")
            extract_from_file(to_extract, True)
            exit()
        elif ll == '-l':
            look_for_last = True
        elif ll == '-f':
            find_string = sys.argv[count+1].lower()
            search_output(find_string)
        elif ll == '-g':
            group_by_start_end = True
        elif ll == '-e':
            progress_to_stderr = True
        elif ll == '-ne':
            progress_to_stderr = False
        elif ll == '-m':
            try:
                temp = int(sys.argv[count+1])
                if temp < 5:
                    sys.stderr.write("WARNING max word length should be at least 5.")
                else:
                    max_word_length = temp
            except:
                print("No valid number after -m. Going to default of", max_word_length)
        elif ll == '-w':
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
            if ll[0] == '-':
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

# default 3w-ok = ['a', 'am', 'an', 'as', 'at', 'be', 'by', 'do', 'go', 'he', 'if', 'in', 'is', 'it', 'me', 'my', 'no', 'of', 'on', 'or', 'so', 'to', 'up', 'us', 'we']

dupes = False

two_word_file = "3w-ok.txt"
with open(two_word_file) as file:
    for line in file:
        ll = line.lower().strip()
        la = re.split(",( )?", ll)
        for li in la:
            if li in ok_2.keys():
                print(li, "is a duplicate")
                dupes = True
        ok_2[line.lower().strip()] = True

if dupes:
    print("Fix duplicates in 2-word file {:s} before continuing.".format(two_word_file))
    exit()

endpals = 0
startpals = 0

time_before_read_word_file = time.time()

# cheap and dirty
max_word_length = 4

#print('doc'[:-1])
#print(sorted(ok_2.keys()))
with open("c:/writing/dict/brit-1word.txt") as file:
    for line in file:
        ll = line.lower().strip()
        if len(ll) > max_word_length:
            continue # we could just break given brit-1word.txt is sorted by length but that's iffy coding
        if len(ll) < 3 and not ll in ok_2.keys():
            continue
        wordy[ll] = True
        firsty[ll[0]][ll] = True
        lasty[ll[-1]][ll] = True
        if len(ll) > 1:
            firsty[ll[:2]][ll] = True
            lasty[ll[-2:]][ll] = True
        if ll in wordy:
            end_pal[ll][ll] = True
            start_pal[ll][ll] = True
        if ll[:-1] in wordy:
            start_pal[ll][ll[:-1]] = True
        if ll[1:] in wordy:
            end_pal[ll][ll[1:]] = True
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
#print(start_pal['doc'])
#print(end_pal['wan'])
#exit()

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
    sys.stderr.write("Printing progress to STDERR every {:d} starting words.\n".format(warning_every_x))

last_start = ""
last_end = ""
last_group = ""

cur_array = []
cur_matches = 0

# change this for specific letter tests
sk = ['a']
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
    cur_array = []
    for b in end_array(a): # change this to test specific cases
        q = pal_conv_hash(a, b)
        if q:
            cur_matches = cur_matches + len(q)
            # print(a, b, q)
            for c in sorted(q):
                count = count + 1
                this_word_count = this_word_count + 1
                if group_by_start_end:
                    cur_array.append('"{:s} {:s} {:s}"'.format(a, c, b))
                else:
                    print(this_word_count, count, a, c, b, "=", a + c + b + ("" if a == last_start and b == last_end else " (*)"))
                last_start = a
                last_end = b
        if group_by_start_end and len(cur_array):
            if a != last_group:
                if last_group:
                    print(last_group, "had", cur_match, "matches.")
                cur_matches = 0
                print('=' * 40, a)
            last_group = a
            print('{:s} + ? + {:s} ({:d}{:s}) ='.format(a, b, len(cur_array), '/already' if is_pal(a+b) else ''), '  /  '.join(cur_array))
            cur_array = []

if len(cur_array): print(' / '.join(cur_array))

t3 = time.time() - bt
print(t3, "seconds for all 3-word palindromes.")
