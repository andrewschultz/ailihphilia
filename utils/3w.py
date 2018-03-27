# 3w.py
#
# attempts to read in all possible 3 word palindromes
#
# usage() lists command line options
#
# technical details:
#
# end_pal is a two-dimensional hash of all the possible words that can have a word at the end...
# for instance, CAN and DAN and AN will be in end_pal[AN]
#
# start_pal is a two-dimensional hash of all the possible words that can have a word at the start...
# for instance, AND and ANT will be in start_pal[AN]
#
# silly_test is a unit test to check these hashes for one word, TRUE bails after
#
# 3w-ok.txt has a list of 1 or 2 letter words that are okay and popular enough.
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
last_1_or_2 = defaultdict(lambda: defaultdict(bool))
first_1_or_2 = defaultdict(lambda: defaultdict(bool))

end_pal = defaultdict(lambda: defaultdict(bool))
start_pal = defaultdict(lambda: defaultdict(bool))

i7.go_proj("up")

sorted_file = "3w-sorted.txt"
edited_output_file = "3w-sorted-edit.txt"

def usage():
    print("============3 word palindrome searcher.")
    print("-0  = edit the current generated 3-pal file.")
    print("-2  = edit file of okay 2-length words.")
    print("-a  = array (specific) CSV for words to find eg mo,my")
    print("-e  = write progress to STDERR, useful when piping output to a file. (-en/ne turns it off, default is on)")
    print("-f  = find in 3w2.txt.")
    print("-g  = group by start/end words, -ng/-gn = don't group by start/end words.")
    print("-i = ignore 2-letter words")
    print("-h = hash tests")
    print("-l  = pick up where 3w(2).txt left off")
    print("-m  = maximum word length (minimum = 2)")
    print("-n  = names not words, -nw/-wn = both")
    print("-o  = order results by last word, -no/-on turns this off")
    print("-q  = quick search. Skip begin/end palindromes e.g. ACISODIS/ISODICA.")
    print("-s  = skip uneven palindromes e.g. top X spot. Speedup, but may miss a few.")
    print("-x3 = extract specific word from file of 3-palindromes (x3w/x3o = only that word)")
    print("-w  = warn every X new words (default = {:d}).".format(warning_every_x))
    print("any word = what word to start with.")
    print("For specific test cases, -m 4 -o can make things pop up easier.")
    print("-? = this function.")
    exit()

def start_end_hash_unit(look_string, bail=False):
    print("=" * 40, "start/end hashes for", look_string)
    print(look_string, "start hash", start_pal[look_string])
    print(look_string, "end hash", end_pal[look_string])
    print(look_string[::-1], "start hash", start_pal[look_string[::-1]])
    print(look_string[::-1], "end hash", end_pal[look_string[::-1]])
    if bail: exit()

def start_end_array_unit(look_string, bail=False):
    print("=" * 40, "start/end arrays for", look_string)
    print(look_string, "start array", start_array(look_string))
    print(look_string, "end array", end_array(look_string))
    if bail: exit()

def should_print(a, b, c):
    if no_fixed_array: return True
    return a in fixed_array or b in fixed_array or c in fixed_array

def is_pal(x):
    return x == x[::-1]

def leftover(a, b):
    if len(a) < len(b):
        return b[:len(b)-len(a)][::-1] + '-'
    elif len(b) < len(a):
        return '-' + a[len(b):]
    else:
        return '-'

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
        return last_1_or_2[x[1::-1]] if not order_results else sorted(last_1_or_2[x[1::-1]])
    return last_1_or_2[x[-1:]] if not order_results else sorted(last_1_or_2[x[-1:]])

def start_array(x):
    if len(x) >= 2:
        return first_1_or_2[x[:2]]
    return first_1_or_2[x[:1]]

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

def two_words_in_pal_test(a, b):
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

def hash_tweak(wd):
    global startpals
    global endpals
    if wd in wordy.keys(): return
    bkwd = wd[::-1]
    wordy[wd] = True
    first_1_or_2[wd[0]][wd] = True
    last_1_or_2[wd[-1]][wd] = True
    if len(wd) > 1:
        first_1_or_2[wd[:2]][wd] = True
        last_1_or_2[wd[-2:]][wd] = True
    end_pal[wd][wd] = True
    start_pal[wd][wd] = True
    if wd[:-1] in wordy:
        start_pal[wd][wd[:-1]] = True
    if wd[1:] in wordy:
        end_pal[wd][wd[1:]] = True
    for i in range (1,len(wd)):
        if wd[i:] == wd[i:][::-1]:
            start_pal[wd[:i]][wd] = True
            startpals = startpals + 1
            if len(wd[i:]) > 3:
                continue
                print("remove", wd[:i], "of", len(wd), "from", wd, "to get", wd[i:], i, "start partial anagram")
        if wd[:i] == wd[:i][::-1]:
            end_pal[wd[i:]][wd] = True
            endpals = endpals + 1
            if len(wd[:i]) > 3:
                continue
                print("remove", wd[i:], "from", wd, "to get", wd[:i], i, "end partial anagram")
            # print(wd[:-i], wd, i, "end partial anagram")

def hash_tweak_file(file_name):
    with open(file_name) as file:
        for line in file:
            hash_tweak(line.lower().strip())

# functions above, main program below

# default values
words_listed_yet = False
ignored = 0
overall_word_count = 0

group_by_start_end = True

# options
skip_beginend_palindrome = False
ignore_2_letter_words = False
start_val = ''
look_for_last = False
skip_uneven_palindromes = False
progress_to_stderr = True
warning_every_x = 100
max_word_length = 12
find_string = ''

extra_words = []

order_results = False

two_word_file = "3w-ok-words.txt"
fixed_array = []

hash_test_array = []

dupes = False

endpals = 0
startpals = 0

# end initialization stuff
# start command line reading

if len(sys.argv) > 1:
    count = 1
    while count < len(sys.argv):
        ll = sys.argv[count].lower()
        l2 = sys.argv[count+1].lower() if count < len(sys.argv) - 1 else ""
        lln = ll # most of the time we want to allow for 1 letter boundaries, but if there is a #/letter mix, forget it
        if lln[0] == '-':
            lln = lln[1:]
        if sys.argv[count].isalpha():
            start_val = sys.argv[count].lower()
        elif lln == '?':
            usage()
        elif lln == '0':
            os.system(edited_output_file)
            exit()
        elif lln == '2':
            os.system(two_word_file)
            exit()
        elif ll == '-a':
            if l2:
                fixed_array = sys.argv[count+1].lower().split(",")
                progress_to_stderr = False
            else:
                print("You need a valid argument (comma separated) after -a to test hash/array values.")
                exit()
            count = count + 2
            continue
        elif ll == '-e':
            progress_to_stderr = True
        elif ll == '-en' or ll == '-ne':
            progress_to_stderr = False
        elif ll == '-f':
            find_string = sys.argv[count+1].lower()
            search_output(find_string)
        elif ll == '-g':
            group_by_start_end = True
        elif ll == '-gn' or ll == 'ng':
            group_by_start_end = False
        elif ll == '-h':
            if l2:
                hash_test_array = l2.split(",")
            else:
                print("You need a valid argument (comma separated) after -h to test hash/array values.")
                exit()
            count = count + 2
            continue
        elif ll == '-i2' or ll == '-i':
            ignore_2_letter_words = True
        elif ll == '-l':
            look_for_last = True
        elif ll == '-m':
            try:
                max_word_length = int(sys.argv[count+1])
                if max_word_length < 2:
                    print("Max word length can't be less than 2.")
                    max_word_length = 2
                elif max_word_length > 12:
                    print("NOTE: a maximum word length of >12 doesn't find that much more and will slow things down a bit.")
                count = count + 2
                continue
            except:
                print("Need a number after -m for max word length.")
                exit()
        elif ll == '-n':
            do_dict_words = False
            do_names = True
            two_word_file = "3w-ok-names.txt"
        elif ll == '-nw' or ll == '-wn':
            do_dict_words = True
            do_names = True
        elif ll == '-o':
            order_results = True
        elif ll == '-on' or ll == '-no':
            order_results = False
        elif ll == '-q':
            skip_beginend_palindrome = True
        elif ll == '-s':
            skip_uneven_palindromes = True
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
            continue # I could just do count = count + 1 and count on the next, but that feels cutesy.
        elif ',' in ll:
            extra_words = extra_words + ll.lower().split(",")
        elif lln == 'x3':
            try:
                to_extract = sys.argv[count+1]
            except:
                print("You need a string to extract.")
            extract_from_file(to_extract, False)
            exit()
        elif lln == 'x3w' or lln == 'x3o':
            try:
                to_extract = sys.argv[count+1]
            except:
                print("You need a string to extract.")
            extract_from_file(to_extract, True)
            exit()
        else:
            if ll[0] == '-':
                print("Bad flag.")
                print()
                usage()
            else:
                print("Parameter", count, "/", sys.argv[count], "must be a word. It says which word the palindrome search starts on, alphabetically.")
            exit()
        count = count + 1

if look_for_last:
    if start_val:
        print("Defined start_val and look_for_last, so you gave conflicting options. Bailing.")
        exit()
    start_val = get_last_word_tried()

# end command line reading

t1 = time.time()

if not ignore_2_letter_words:
    with open(two_word_file) as file:
        for line in file:
            ll = line.lower().strip()
            la = re.split(",( )?", ll)
            for li in la:
                if li in ok_2.keys():
                    print(li, "is a duplicate")
                    dupes = True
            hash_tweak(ll)

if len(extra_words):
    for xw in extra_words:
        if xw in wordy.keys():
            sys.stderr.write("WARNING: {:s} is already in the list of words.\n")
            dupes = True
        else:
            hash_tweak[xw]

if dupes:
    print("Fix duplicates in 2-word file {:s} before continuing.".format(two_word_file))
    exit()

time_before_read_word_file = time.time()

if do_dict_words:
    for x in range(3, max_word_length + 1):
        hash_tweak_file("c:/writing/dict/words-{:d}.txt".format(x))

if do_names:
    hash_tweak_file("c:/writing/dict/firsts.txt")
    hash_tweak_file("c:/writing/dict/lasts.txt")

time_after_read_word_file = time.time()

sys.stderr.write("Time to read word file and put stuff into hashes: {:.4f} seconds.\n".format(time_after_read_word_file - time_before_read_word_file))
sys.stderr.write("{:2d} partial start-anagrams, {:2d} partial end-anagrams.\n".format(startpals, endpals))

# uncomment this to test any code changes. One word should anagram the start of the other.
if len(hash_test_array):
    for h in hash_test_array:
        start_end_array_unit(h, False)
        start_end_hash_unit(h, False)
    exit()

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

# use -a to change fixed array
no_fixed_array = len(fixed_array) == 0

cur_words = 0

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
        in_mid = False
        q = pal_conv_hash(a, b)
        if q:
            cur_matches = cur_matches + len(q)
            cur_words = cur_words + 1
            # print(a, b, q)
            for c in sorted(q):
                if not no_fixed_array and c in fixed_array: in_mid = True
                count = count + 1
                this_word_count = this_word_count + 1
                if group_by_start_end:
                    cur_array.append('"{:s} {:s} {:s}"'.format(a, c, b))
                else:
                    if should_print(a, c, b):
                        print(this_word_count, count, a, c, b, "=", a + c + b + ("" if a == last_start and b == last_end else " (*)"))
                        last_group = a
                last_start = a
                last_end = b
        if group_by_start_end and len(cur_array):
            if should_print(a, '', b) or in_mid:
                if a != last_group:
                    if last_group and no_fixed_array:
                        print(last_group, "had", cur_matches, "/", cur_words, "matches.")
                        cur_matches = 0
                        cur_words = 0
                        print('=' * 40, a)
                    last_group = a
                # if a == 'set': print(cur_array, fixed_array)
                print('{:s} + {:s} + {:s} ({:d}{:s}) ='.format(a, leftover(a, b), b, len(cur_array), '/already' if is_pal(a+b) else ''), '  /  '.join(cur_array))
            cur_array = []

if len(cur_array): print(' / '.join(cur_array))

t3 = time.time() - bt
print(t3, "seconds for all 3-word palindromes.")
