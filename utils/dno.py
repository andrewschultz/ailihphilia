#
# dno.py
#
# debug notes: check if something has already been used and can be wiped
#
# -b can bowdlerize automatically
# -m modify notes from output file format e.g. with a number before it all

import sys
import i7
import os
import re
import filecmp
from collections import defaultdict
from shutil import copy

pals = defaultdict(int)
twice = defaultdict(bool)

# options
modify_notes = True
twice_okay = False
launch_after = True
ignore_word_bounds = False
open_first = False
verbose = False
last_lines_first = True
bowdlerize_notes = False
bowdlerize_test = False
read_colons = False
colons_max = 0
colons_start = 0

colon_string = ""

def modify_notes(s):
    lines_changed = 0
    notetmp = "c:/games/inform/{:s}.inform/source/notes-temp.txt".format(s)
    f2 = open(notetmp, "w")
    notes_file_to_read = "c:/games/inform/{:s}.inform/source/notes.txt".format(s)
    with open(notes_file_to_read) as file:
        for line in file:
            if re.search("^ *[0-9]{2,} +[a-z]", line):
                # print("Futzing with", line.strip())
                ll = re.sub("^ *[0-9]+ +", "", line)
                ll = re.sub(" ~ PALINDROME.", "", ll)
                ll = re.sub(" \+ ", " ", ll)
                f2.write(ll)
                lines_changed = lines_changed + 1
            else:
                f2.write(line)
    f2.close()
    if filecmp.cmp(notetmp, notes_file_to_read):
        print("No modification of possible cut/pasted lines for notes file.")
    else:
        print(lines_changed, "lines changed scanning", notes_file_to_read)
        copy(notetmp, notes_file_to_read)
    if modify_only:
        print("Bailing.")
        exit()

def usage():
    print("USAGE" + '=' * 40)
    print("-v = verbose")
    print("-m = modify notes file before starting, -mo = modify only")
    print("-2 = report appearance of notes.txt stirng in story.ni/put it up tables.i7x more than once.")
    print("    -2n/-n2 = negation. Default = off.")
    print("-l = launch after.")
    print("    -ln/-nl = don't. Default = on.")
    print("-i = ignore word boundaries. To catch stuff like 'da bad' with 'neda baden'.")
    print("    -in/-ni = don't. Default = off.")
    print("-f = open first repetition, -fn/-nf = open last.")
    print("-o = print first lines first (last lines first lets you follow line numbers for deletion more easily).")
    print("-b = bowdlerize duplicates in notes. -bt only copies to notes2.txt, for testing purposes.")
    print("-c = show lines with colons in them, which are likely to be good ideas to work on. On which to work. (-co)")
    print("  You can also specify a number, but not as a separate argument. (Also, -q = -c10)")
    print("-?/-u = this usage statement")
    exit()

def pally(s):
    s = re.sub("[=:].*", "", s)
    # print(s, "!", s.upper(), s.lower())
    if not (s.upper() or s.lower()):
        # print("No letters.")
        return False
    s2 = re.sub("[^a-z\/]", "", s, 0, re.IGNORECASE)
    a = s2.lower().split("/")
    for b in a:
        if b != b[::-1]:
            return False
    return True

def check_notes(s):
    global colon_string
    open_line = 0
    pal_count = 0
    line_count = 0
    dupes = 0
    xtranote = 0
    colons = 0
    seen = 0
    notes_file_to_read = "c:/games/inform/{:s}.inform/source/notes.txt".format(s)
    source_files = [ "c:/games/inform/{:s}.inform/source/story.ni".format(s),
      "c:/Program Files (x86)/Inform 7/Inform7/Extensions/Andrew Schultz/{:s} tables.i7x".format(re.sub("-", " ", s)) ]
    shorts = {}
    dupe_dict = defaultdict(bool)
    for x in source_files:
        shorts[x] = re.sub(".*[\\\/]", "", x)
    with open(notes_file_to_read) as file:
        for line in file:
            line_count = line_count + 1
            ll = line.strip()
            if ":" in ll and read_colons:
                colons = colons + 1
                if read_colons:
                    if (colons_max == 0 and colons_start == 0) or (colons_max == 0 and colons >= colons_start) or (colons >= colons_start and colons <= colons_max + colons_start):
                        colon_string = colon_string + str(colons) + ": " + line
                        seen = seen + 1
            if pally(ll):
                l2 = re.sub("[:=].*", "", line.strip().lower(), 0, re.IGNORECASE)
                l2 = re.sub("[^a-z \/]", "", l2, 0, re.IGNORECASE)
                # print("Looking for", l2)
                for q in l2.split("/"):
                    if q in pals.keys():
                        print("Duplicate", q, line_count, "from", pals[q], "in notes file")
                        if not open_line:
                            open_line = pals[q] if open_first else line_count
                        dupes = dupes + 1
                        dupe_dict[line_count] = True
                    else:
                        q2 = q.strip()
                        pals[q2] = line_count
                        pal_count = pal_count + 1
                        # print(count, q2)
    if seen < colons:
        colon_string = colon_string + "(saw {:d} of {:d}, increase or remove colons_max/colons_start to see more...)".format(seen, colons)
    found_errs = defaultdict(str)
    for s in source_files:
        if verbose: print("Reading", s)
        with open(s) as file:
            table_name = ''
            count = 0
            for line in file:
                if line.startswith('table of'):
                    table_name = line.lower().strip()
                elif not line.strip():
                    table_name = ''
                count = count + 1
                ll = re.sub("[\.\",!\?]", "", line.lower())
                for q in pals.keys():
                    if q in ll and (q not in twice.keys() or twice_okay):
                        if q == 'say as' and 'say "as' in line.lower():
                            continue
                        if ignore_word_bounds or re.search(r'\b{:s}\b'.format(q), ll):
                            # here "da bad" does not flag "Neda Baden" unless we tell the program to
                            line_short = re.sub(":.*", "", q)
                            found_errs[pals[q]] = found_errs[pals[q]] + "Notes.txt line {:d} ({:s}) ~ {:s} line {:d}{:s}: {:s} {:s}\n".format(pals[q], line_short, shorts[s], count, '' if not table_name else ' ({:s})'.format(table_name), line.lower().strip(), ('' if not ignore_word_bounds else ' ~ ' + q))
                            if last_lines_first:
                                if not open_line or pals[q] < open_line:
                                    open_line = pals[q]
                            elif pals[q] > open_line:
                                open_line = pals[q]
                            twice[q] = True
                            xtranote = xtranote + 1
            if verbose: print(count, "total lines")
    if len(found_errs) > 0:
        for x in sorted(found_errs.keys(), reverse=last_lines_first):
            print(found_errs[x].strip())
    if xtranote + dupes == 0:
        print("Notes file has no duplicates/extras.")
    else:
        print(xtranote, "extraneous notes in source,", dupes, "duplicate notes")
    if bowdlerize_notes and len(found_errs) + len (dupe_dict) > 0: # automatically delete duplicates
        count = 0
        notes_file_backup = "notes-2.txt"
        f2 = open(notes_file_backup, "w")
        with open(notes_file_to_read) as file:
            for line in file:
                count = count + 1
                if count in found_errs.keys() or count in dupe_dict.keys():
                    continue
                f2.write(line)
        f2.close()
        if bowdlerize_test:
            print("Not copying", notes_file_backup, "back to", notes_file_to_read, "-- use -b and not -bt for that.")
        else:
            print("Copying", notes_file_backup, "back to", notes_file_to_read)
            copy(notes_file_backup, notes_file_to_read)
            print("Copying attempt complete.")
            os.remove(notes_file_backup)
            print("Deleted", notes_file_backup)
    elif bowdlerize_notes:
        print("Nothing to bowdlerize, so I am not recopying.")
    if launch_after and open_line:
        i7.npo(notes_file_to_read, open_line, True)

count = 1
modified_yet = False

while count < len(sys.argv):
    l = sys.argv[count].lower()
    if l[0] == '-': l = l[1:]
    if l == '2n' or l == 'n2':
        twice_okay = False
    if l == '2' or l == '-2':
        twice_okay = True
    elif l == 'l':
        launch_after = True
    elif l == 'ln' or l == 'nl':
        launch_after = False
    elif l == 'm' or l == 'mo':
        modify_only = (l == 'mo')
        if modified_yet:
            print("Already modified notes file or tried to.")
            exit()
        modified_yet = True
        modify_notes("put-it-up")
        exit()
    elif l == 'v':
        verbose = True
    elif l == 'f':
        open_first = True
    elif l == 'q':
        read_colons = True
        colons_max = 10
    elif l == 'fn' or l == 'nf':
        open_first = False
    elif l == 'i':
        ignore_word_bounds = True
    elif l == 'in' or l == 'ni':
        ignore_word_bounds = False
    elif l == 'o':
        last_lines_first = False
    elif l == 'b':
        bowdlerize_notes = True
    elif l == 'bt':
        bowdlerize_notes = True
        bowdlerize_test = True
    elif re.search("^(c|co)[0-9,]*$", l):
        read_colons = True
        if re.search("[0-9]", l):
            my_ary = [int(i) for i in re.sub("^(co|c)", "", l).split(",")]
            if len(my_ary) > 1:
                colons_max = my_ary[1]
                colons_start = my_ary[0]
            else:
                colons_max = my_ary[0]
    elif re.search("^s[0-9,]+$", l):
        read_colons = True
        my_ary = [int(i) for i in re.sub("^s", "", l).split(",")]
        if len(my_ary) > 1:
            colons_max = my_ary[1]
        colons_start = my_ary[0]
    elif l == '?' or l == 'u':
        usage()
    else:
        print("Unknown option", l)
        usage()
    count = count + 1

check_notes("put-it-up")

if colon_string:
    print(colon_string.strip())