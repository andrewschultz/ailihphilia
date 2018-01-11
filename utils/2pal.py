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
from shutil import copyfile

file_hash = { "f":"c:/writing/dict/firsts.txt",
  "l":"c:/writing/dict/lasts.txt",
  "d":"c:/writing/dict/brit-1word.txt",
  "a":"c:/writing/dict/name-and-word.txt"
  }
caps_hash = { "f": True, "l": True, "d": False }

# all_at_once compares all word pairs. It's slower.
# if it is FALSE, then we only compare words that start with a with words that end with a.
# that's up to 26x (676x) faster (Cauchy's Inequality says it can't be more than that)
brute_force_hashing = False

one_letter_jazz = False

edit_files = False
sort_output = False

# this determines whether or not we should go with the first two letters or just the first one, when brute_force_hashing is false
twosies = True
# this is for a quick dumb test
dumb_test = False

to_file = False
overwrite_file = False

PALINDROME = 0
ANAGRAM = 1

# we show what group of letters we're on by default if brute_force_hashing is FALSE
suppress_progress = False
# when showing progress, do we show combinations that have 0 of one starting/ending letter combo? Default is NO
show_zeros = False

# tracking total words used at start/end
track_run_total = False

word_dict = defaultdict(bool)
caps_dict = defaultdict(bool)
twolist = []
ends = {}
starts = {}

mid_string = ''
begin_string = ''
end_string = ''

custom_file_string = ''

start_words = defaultdict(bool)
end_words = defaultdict(bool)

def optcaps(z):
    if caps_dict[z] == True:
        return z[0].upper() + z[1:].lower()
    else:
        return z

def usage():
    print("This is a list of parameters you can send to 2pal.py.")
    print("")
    print("-f = start/end files, -fs = start files, -fe = end files. The file hash is below:")
    print('   ', ', '.join([x + "=" + file_hash[x] for x in sorted(file_hash.keys())]))
    print("-co provides a concordance of commands that still need to be run.")
    print("-b -m -e = begin, middle, end string")
    print("-v = view file in notepad")
    print("-sp suppresses progress in stdout, -s0 shows zero-ish e.g. zg/gz will have no possible matches")
    print("-tf/-fi sends output to file, -o/-of overwrites if it's there, -eo sends to edit file.")
    print("-c/-cf tacks on a custom file string.")
    print("-ol processes one-letter words in palindromes, start/end/middle. It is a long test.")
    print("-ca creates name-and-word.txt from the other files.")
    print("-co = concordance of all file combinations and commands.")
    print("-trt = debug flag to track run totals of first/last words checked so far.")
    print("-d dumb test")
    print("-2 quicken things by using hash tables to match only words with same 2 first/last letters")
    print("-? this usage")
    exit()

def create_all_file():
    temp_hash = defaultdict(bool)
    print("Reading from file hash...")
    for x in file_hash.keys():
        if x == 'a':
            continue
        print("Reading file", file_hash[x])
        with open(file_hash[x]) as file:
            for line in file:
                temp_hash[line.upper().strip()] = True
    print("Writing to", file_hash['a'])
    fout = open(file_hash['a'], "w")
    for x in sorted(temp_hash.keys(), key=lambda x: (len(x), x)):
        fout.write("{:s}\n".format(x.upper()))
    fout.close()
    print("Finished writing to", file_hash['a'])
    exit()

def get_words(a, add_start = True, add_end = True, use_caps = False):
    w_wo = ['without', 'with']
    print("Getting words from", a, w_wo[add_start], 'starting candidates', w_wo[add_end], 'ending candidates')
    with open(a) as file:
        for line in file:
            l = line.strip().lower()
            word_dict[l] = True
            caps_dict[l] = use_caps
            if add_start:
                start_words[l] = True
                if twosies:
                    starts[l[:2]][l] = True
                else:
                    v = l[:1]
                    starts[v][l] = True
            if add_end:
                end_words[l] = True
                if twosies:
                    ends[l[-2:]][l] = True
                    u = l[-1:]
                else:
                    ends[u][l] = True
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

# note we usually need both files created, anagram and non, so let's make them
def custom_munge(my_str, suffix):
    temp = my_str
    if custom_file_string != '':
        temp = temp + '-cus-' + custom_file_string
    if begin_string != '':
        temp = temp + '-xs-' + begin_string
    if mid_string != '':
        temp = temp + '-xm-' + mid_string
    if end_string != '':
        temp = temp + '-xe-' + end_string
    t1 = temp
    t1 = t1 + '-ana'
    temp = temp + '.' + suffix
    t1 = t1 + '.' + suffix
    return (temp, t1)

def pal_to_edit(a):
    x = a.replace("pals-", "edit-")
    if os.path.isfile(a):
        copyfile(a, x)
        print("Copied", a, "to", x)
    else:
        print("No", a, "to copy to", x)

def one_at_a_time():
    base_file = "pals-out-1-{:s}-2-{:s}".format('-'.join(start_files), '-'.join(end_files))
    out_files = custom_munge(base_file, 'txt')
    if one_letter_jazz:
        print(out_files)
        return
    fout = None
    fouta = None
    if to_file:
        if os.path.isfile(out_files[PALINDROME]):
            if overwrite_file:
                print("Overwriting already-present palindrome file", out_files[PALINDROME])
            else:
                print("Need -o or -of to overwrite already-present palindrome file", out_files[PALINDROME])
                return
        if os.path.isfile(out_files[ANAGRAM]):
            if overwrite_file:
                print("Overwriting already-present anagram file", out_files[ANAGRAM])
            else:
                print("Need -o or -of to overwrite already-present anagram file", out_files[ANAGRAM])
                return
        print("Writing palindromes to", out_files[PALINDROME])
        print("Writing anagrams to", out_files[ANAGRAM])
        fout = open(out_files[PALINDROME], "w")
        fouta = open(out_files[ANAGRAM], "w")
        if fout is None:
            print("Unable to open", out_file, "for writing.")
            return
        if fouta is None:
            print("Unable to open", out_file, "for writing.")
            return
        head_string = "# Munging " + '/'.join(start_files) + " to " + '/'.join(end_files) + '\n'
        head_string = head_string + "# Extra start string = " + (begin_string if begin_string else "none") + '\n'
        head_string = head_string + "# Extra middle string = " + (mid_string if mid_string else "none") + '\n'
        fout.write(head_string)
        fouta.write(head_string)
        fout.write("# Palindromes (non-anagram) results\n")
        fouta.write("# Palindromes (anagram) results\n")
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
    run_total = [0, 0]
    for l in my_stuff:
        l2 = l[::-1]
        poss_combos = len(starts[l].keys()) * len(ends[l2].keys())
        if track_run_total:
            run_total[0] = run_total[0] + len(starts[l].keys())
            run_total[1] = run_total[1] + len(ends[l2].keys())
            print('total', run_total[0], run_total[1])
        if not suppress_progress:
            if show_zeros or (len(starts[l].keys()) and len(ends[l2].keys())):
                stderr_string = '{:s} ({:>5d}) < START END > {:s} ({:>5d}) combos = {:>10d}.\n'.format(l, len(starts[l].keys()), l2, len(ends[l2].keys()), poss_combos)
                sys.stderr.write(stderr_string)
        totals = totals + poss_combos
        for x in (starts[l].keys() if sort_output is False else sorted(starts[l].keys())):
            for y in (ends[l2].keys() if sort_output is False else sorted(ends[l2].keys())):
                z = begin_string + x + mid_string + y
                if z == z[::-1]:
                    pal = (x == y[::-1])
                    count = count + 1
                    this_line = '{:>5d} {:s} + {:s} ~ {:s}.'.format(count,
                    (begin_string + ' + ' if begin_string != '' else '') + optcaps(x),
                    (mid_string + ' + ' if mid_string != '' else '') + optcaps(y),
                    ('WORDY ' if z in words else '') + ('ANAGRAM' if pal else 'PALINDROME'))
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
    if edit_files:
        pal_to_edit(out_files[0])
        pal_to_edit(out_files[1])
    print(end-start, 'total seconds', totals, 'total comparisons')

def turn_the_crank():
    if brute_force_hashing:
        brute_force_hashing()
    else:
        one_at_a_time()

# end functions

# start parsing stuff below

parser = argparse.ArgumentParser(description='palindrome looker upper', formatter_class=argparse.RawTextHelpFormatter)

# parser.add_argument("x", type=bool, help="2 letters in hash array or 1")
# parser.add_argument('b', action='store_true', dest='brute_force', help='!')
parser.add_argument('-co', action='store_true', dest='concordance', help='run concordance of all possible file combinations')
parser.add_argument('-trt', action='store_true', dest='track_run_total', help='tracking the run total of first/last letters so far')
parser.add_argument('-d', action='store_true', dest='dumb_test', help='run dumb test focusing on specific letters')
parser.add_argument('-2', action='store_false', dest='twosies')
parser.add_argument('-?', action='store_true', dest='usage')
parser.add_argument('-f', type=str, help="start and end arrays", dest='file_array')
parser.add_argument('-fs', type=str, help="start array", dest='start_array')
parser.add_argument('-fe', type=str, help="end array", dest='end_array')
parser.add_argument('-sy', action="store_true", dest="sort_output_on")
parser.add_argument('-ol', action="store_true", dest="one_letter_jazz")
parser.add_argument('-sn', action="store_true", dest="sort_output_off")
parser.add_argument('-sp', action='store_true', help="suppress progress of what anagram is being checked", dest='suppress_progress')
parser.add_argument('-s0', action='store_true', help="show zeros in progress", dest='show_zeros')
parser.add_argument('-b', type=str, help="begin string", dest='begin_string')
parser.add_argument('-m', type=str, help="middle string", dest='mid_string')
parser.add_argument('-e', type=str, help="end string", dest='end_string')
parser.add_argument('-hc', action="store_true", dest="create_html")
parser.add_argument('-hl', action="store_true", dest="create_launch_html")
parser.add_argument('-v', type=str, help="view in notepad", dest='notepad_open_string')
parser.add_argument('-c', '-cf', type=str, help="custom file string", dest='custom_file_string')
parser.add_argument('-ca', action="store_true", dest="rewrite_all_file")
parser.add_argument('-tf', '-fi', action="store_true", help="to file", dest='to_file')
parser.add_argument('-eo', action="store_true", help="to edit file(s)", dest='edit_files')
parser.add_argument('-o', '-of', action="store_true", help="overwrite file", dest='overwrite_file')

args = parser.parse_args()

if args.usage:
    usage()

if args.one_letter_jazz:
    one_letter_jazz = True

if args.rewrite_all_file:
    print("Ignoring all other flags. Rewriting", file_hash['a'])
    create_all_file()
    exit()

if args.notepad_open_string:
    ed_ary = args.notepad_open_string.split(",")
    if len(ed_ary) != 2:
        print("The notepad open string must have one comma.")
        exit()
    base_file = "edit-out-1-{:s}-2-{:s}.txt".format(ed_ary[0], ed_ary[1])
    print("Opening", base_file)
    os.system(base_file)

if args.sort_output_on or args.sort_output_off:
    if args.sort_output_on and args.sort_output_off:
        print("Can't set sort output on AND off.")
        exit()
    if args.sort_output_on:
        sort_output = True
    elif args.sort_output_on:
        sort_output = False

if args.begin_string:
    begin_string = args.begin_string

if args.end_string:
    end_string = args.end_string

if args.mid_string:
    mid_string = args.mid_string

def write_file_cell(fout, flink)
    fout.write("<td>")
    if os.path.exists(temp):
        fout.write("<a href={:s}>{:s}</a></td>\n".format(flink, flink))
    else:
        fout.write("NO {:s}".format(flink.upper()))

if args.create_html or args.create_launch_html:
    out_html = custom_munge('pals-out-1', 'htm')
    q = [ '-f', '-l', '-d' ]
    my_htm = open(out_html[0], 'w')
    my_htm.write("<html>\n<title>" + out_html[0] + "</title>\n<body>\n")
    my_htm.write("<center><table border=1>\n")
    my_htm.write("<th>PAL</th><th>ANA</th><th>EDIT-PAL</th><th>EDIT-ANA</th>")
    for i in q:
        for j in q:
            my_htm.write("<tr>")
            z = "pals-out-1{:s}-2{:s}".format(i, j)
            temp_ary = custom_munge(z, 'txt')
            z2 = "edit-out-1{:s}-2{:s}-ana".format(i, j)
            temp_ary_2 = custom_munge(z2, 'txt')
            write_file_cell(my_htm, temp_ary[0])
            write_file_cell(my_htm, temp_ary[1])
            write_file_cell(my_htm, temp_ary_2[0])
            write_file_cell(my_htm, temp_ary_2[1])
    my_htm.write("</table></center></body>\n</html>\n")
    my_htm.close()
    print(out_html)
    if args.create_launch_html:
        os.system(out_html[0])
    else:
        print("This only creates the HTML. If you want to run things, run the -hl flag and not the -hc flag.")
    exit()

if args.concordance:
    fh = sorted(file_hash.keys())
    print("LIST OF COMMANDS TO RUN:")
    for x in fh:
        for y in fh:
            print("2pal.py -fs", x, "-fe", y, "-tf -of")
    print("LIST OF FILES TO CREATE:")
    created = 0
    uncreated = 0
    cmds_to_run = []
    for x in fh:
        for y in fh:
            run_this = False
            z = "pals-out-1-{:s}-2-{:s}".format(x, y)
            temp_ary = custom_munge(z, 'txt')
            for t in temp_ary:
                if os.path.exists(t):
                    print("EXISTS", t)
                    created = created + 1
                else:
                    print(t, "DOESN'T EXIST")
                    uncreated = uncreated + 1
                    run_this = True
            if run_this:
                cmds_to_run.append("2pal.py -fs {:s} -fe {:s} -tf -of".format(x, y))
    print("Created", created, "Uncreated", uncreated)
    if len(cmds_to_run) > 0:
        print("Commands to run:")
        print('\n'.join(cmds_to_run))
    else:
        print("No commands needed to run.")
    exit()

if args.track_run_total:
    track_run_total = args.track_run_total

if args.file_array:
    if args.start_array or args.end_array:
        print("You can either define a file array or a start/end array, but not both (-fs&-fe or -f).")
        exit()
    args.start_array = args.file_array
    args.end_array = args.file_array
else:
    if not args.start_array or not args.end_array:
        print("You need to define start/end array or a file array (-fs&-fe or -f).")
        exit()

start_files = sorted(args.start_array.split(","))
end_files = sorted(args.end_array.split(","))

bail = False
file_list = []

all_files = list(set(start_files) | set(end_files))

for x in all_files:
    if x not in file_hash.keys():
        print(x,"is not a key in the file hash.")
        bail = True
    else:
        file_list.append(file_hash[x])

if bail:
    print("Valid keys in the file hash are", ', '.join([x + "=" + file_hash[x] for x in sorted(file_hash.keys())]))
    exit()

if args.suppress_progress:
    suppress_progress = True

if args.to_file:
    to_file = args.to_file

if args.overwrite_file:
    overwrite_file = args.overwrite_file

if args.custom_file_string:
    custom_file_string = args.custom_file_string

if args.twosies:
    twosies = args.twosies

if args.dumb_test:
    dumb_test = args.dumb_test

if args.show_zeros:
    show_zeros = True

if args.edit_files:
    edit_files = args.edit_files

for x in ascii_lowercase:
    ends[x] = defaultdict(bool)
    starts[x] = defaultdict(bool)
    for y in ascii_lowercase:
        ends[x+y] = defaultdict(bool)
        starts[x+y] = defaultdict(bool)
        twolist.append(x+y)

for f in all_files:
    get_words(file_hash[f], f in set(start_files), f in set(end_files), caps_hash[f])

words = sorted(word_dict.keys())

if one_letter_jazz:
    for x in ascii_lowercase: # yes the below is excruciatingly bad code but it'll do for now
        begin_string = x
        mid_string = ''
        end_string = ''
        turn_the_crank()
        begin_string = ''
        mid_string = ''
        end_string = x
        turn_the_crank()
        begin_string = ''
        mid_string = x
        end_string = ''
        turn_the_crank()
else:
    turn_the_crank()

