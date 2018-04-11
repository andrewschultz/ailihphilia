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

# constants
on_off = [ "off", "on" ]

# options
notes_file_order = False
notes_file_reverse = False
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
read_last = 0
comments_too = False
list_sections = False
do_detail = False

notes_array = []

# variables
colon_string = ""

def notes_file_sort(x):
    y = re.sub(".*Notes line ", "", x, 0, re.IGNORECASE)
    y = re.sub(" .*", "", y)
    return(int(y))

def check_detail_notes(s):
    notes_file_to_read = "c:/games/inform/{:s}.inform/source/notes.txt".format(s)
    source_files = [ "c:/games/inform/{:s}.inform/source/story.ni".format(s),
      "c:/Program Files (x86)/Inform 7/Inform7/Extensions/Andrew Schultz/{:s} mistakes.i7x".format(re.sub("-", " ", s)),
      "c:/Program Files (x86)/Inform 7/Inform7/Extensions/Andrew Schultz/{:s} tables.i7x".format(re.sub("-", " ", s)) ]
    line_count = 0
    matches = defaultdict(list)
    with open(notes_file_to_read) as file:
        for line in file:
            line_count = line_count + 1
            if line.startswith('='): continue
            line = re.sub("-", "", line.lower().strip())
            line = re.sub("[^a-z ]", "", line)
            ary = line.split(" ")
            if len(ary) == 2:
                matches[line_count] = ary
    dupe = 0
    poss = 0
    eq = "=" * 20
    for x in source_files:
        short = re.sub(".*[\\\/]", "", x)
        with open(x) as file:
            line_count = 0
            for line in file:
                line_count = line_count + 1
                ll = line.lower()
                l2 = re.sub("[^a-z ]", "", ll)
                for x in matches.keys():
                    if matches[x][0] in l2 and matches[x][1] in l2:
                        if re.search(r"\b{:s} {:s}\b".format(matches[x][0], matches[x][1]), l2, re.IGNORECASE):
                            dupe = dupe + 1
                            format_string = "{:s} dupe {:d} Notes Line {:d} {:s} line {:d} matches {:s}/{:s}\n        {:s}".format(eq, dupe, x, short, line_count, matches[x][0], matches[x][1], ll.strip())
                            if not notes_file_order:
                                print(format_string)
                            else:
                                notes_array.append(format_string)
                        elif re.search(r"\b{:s}\b".format(matches[x][0]), l2, re.IGNORECASE) and re.search(r"\b{:s}\b".format(matches[x][1]), l2, re.IGNORECASE):
                            poss = poss + 1
                            format_string = "{:s} poss-dupe {:d} Notes Line {:d} {:s} line {:d} matches {:s}/{:s}\n        {:s}".format(eq, poss, x, short, line_count, matches[x][0], matches[x][1], ll.strip())
                            if notes_file_order:
                                notes_array.append(format_string)
                            else:
                                print(format_string)
                        #print(x, "line", line_count, "takes from", '/'.join(matches[x]), "at line", x)
    if notes_file_order:
        if len(notes_array) == 0:
            print("No possible matches!")
        else:
            na2 = sorted(notes_array, key=notes_file_sort, reverse=notes_file_reverse)
            print('\n'.join(na2))
    exit()

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
    print("-d = do detailed search e.g. anything with 2 words is searched")
    print("-2 = report appearance of notes.txt stirng in story.ni/ailihphilia tables.i7x more than once.")
    print("    -2n/-n2 = negation. Default = off.")
    print("-l = launch after.")
    print("    -ln/-nl = don't. Default = on.")
    print("-i = ignore word boundaries. To catch stuff like 'da bad' with 'neda baden'.")
    print("    -in/-ni = don't. Default = off.")
    print("-f = open first repetition, -fn/-nf = open last.")
    print("-no = notes file order for source duplicates of notes.")
    print("-o = print first lines first (last lines first lets you follow line numbers for deletion more easily).")
    print("-b = bowdlerize duplicates in notes. -bt only copies to notes2.txt, for testing purposes.")
    print("-c = show lines with colons in them, which are likely to be good ideas to work on. On which to work. (-co)")
    print("  You can also specify a number, but not as a separate argument. (Also, -q = -c10)")
    print("-a = count all lines with colons, even commented")
    print("-ls/-sl = list sections, -ln/-nl = don't, default =", on_off[list_sections])
    print("-?/-u = this usage statement")
    exit()

def pally(s):
    s = re.sub(" *[=:].*", "", s)
    # print(s, "!", s.upper(), s.lower())
    if not (s.upper() or s.lower()):
        # print("No letters.")
        return False
    s2 = re.sub("[^a-z\/]", "", s, 0, re.IGNORECASE).lower()
    if '/' in s2:
        s3 = re.sub("/", "", s2, 0, re.IGNORECASE)
        if s3 == s3[::-1]:
            if verbose: print("Full line palindrome for", s)
            return True
    a = s2.split("/")
    anypal = False
    retval = True
    for b in a:
        if b != b[::-1]:
            retval = False
        else:
            anypal = True
    if anypal and retval == False: print(s, "has some palindromes, some not with slash(es)")
    return retval

def check_notes(s):
    global colon_string
    open_line = 0
    pal_count = 0
    line_count = 0
    dupes = 0
    xtranote = 0
    colons = 0
    seen = 0
    this_section = ""
    last_noted_section = ""
    notes_file_to_read = "c:/games/inform/{:s}.inform/source/notes.txt".format(s)
    source_files = [ "c:/games/inform/{:s}.inform/source/story.ni".format(s),
      "c:/Program Files (x86)/Inform 7/Inform7/Extensions/Andrew Schultz/{:s} mistakes.i7x".format(re.sub("-", " ", s)),
      "c:/Program Files (x86)/Inform 7/Inform7/Extensions/Andrew Schultz/{:s} tables.i7x".format(re.sub("-", " ", s)) ]
    shorts = {}
    dupe_dict = defaultdict(bool)
    colon_ary = []
    for x in source_files:
        shorts[x] = re.sub(".*[\\\/]", "", x)
    with open(notes_file_to_read) as file:
        for line in file:
            line_count = line_count + 1
            ll = line.strip()
            if ll.startswith("="):
                this_section = ll
                continue
            if ll.startswith('#'):
                if not comments_too: continue
                ll = re.sub("^#+", "", ll)
            if ":" in ll:
                if read_last:
                    colon_ary.append(ll)
                    continue
                if read_colons:
                    colons = colons + 1
                    if (colons_max == 0 and colons_start == 0) or (colons_max == 0 and colons >= colons_start) or (colons >= colons_start and colons <= colons_max + colons_start):
                        if list_sections and this_section != last_noted_section:
                            colon_string = colon_string + this_section + "\n"
                            last_noted_section = this_section
                        colon_string = colon_string + str(colons) + ": " + line
                        seen = seen + 1
            if pally(ll):
                l2 = re.sub("[:=].*", "", line.strip().lower(), 0, re.IGNORECASE)
                l2 = re.sub("-", " ", l2, 0, re.IGNORECASE)
                l2 = re.sub("[^a-z \-/]", "", l2, 0, re.IGNORECASE)
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
                        q2 = re.sub("-", " ", q2, 0, re.IGNORECASE)
                        q2 = re.sub("\"", "", q2, 0, re.IGNORECASE)
                        pals[q2] = line_count
                        pal_count = pal_count + 1
                        # print(count, q2)
    if read_last:
        print('\n'.join("{:d}: {:s}".format(rl, colon_ary[rl]) for rl in range(len(colon_ary)-read_last, len(colon_ary))))
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
                elif not line.strip() or line.startswith('['):
                    table_name = ''
                count = count + 1
                ll = re.sub("[\.\",!\?]", "", line.lower())
                ll = re.sub("-", " ", line.lower())
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
        print("Notes file has no duplicates/extras." + ("" if do_detail else " Try -d for extra duplicates"))
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
        modify_notes("ailihphilia")
        exit()
    elif l == 'v':
        verbose = True
    elif l == 'd':
        do_detail = True
    elif l == 'f':
        open_first = True
    elif l == 'ls' or l == 'sl':
        list_sections = True
    elif l == 'nl' or l == 'ln':
        list_sections = False
    elif l == 'q':
        read_colons = True
        colons_max = 10
    elif l == 'fn' or l == 'nf':
        open_first = False
    elif l == 'no':
        notes_file_order = True
    elif l == 'nor':
        notes_file_order = True
        notes_file_reverse = True
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
    elif l == 'l':
        read_last = 10
    elif l == '?' or l == 'u':
        usage()
    else:
        print("Unknown option", l)
        usage()
    count = count + 1

if do_detail:
    check_detail_notes("ailihphilia")
else:
    check_notes("ailihphilia")

if colon_string:
    print(colon_string.strip())