# utw.py: use test writer
#
# takes the table of specific rejects and goes through each combination
#

import i7
import sys
import re
from collections import defaultdict

in_source = defaultdict(int)
in_unit = defaultdict(int)

figure_out = figure_out_default = True
compfile = "reg-ail-use-unit-tests.txt"

in_use_table = False
header_next = False

open_line_source = 0
open_line_testfile = 0
open_after = open_after_default = False

writestr = ""

def usage(arg):
    print("Invalid option", arg)
    print()
    print("Viable options below")
    print("=" * 50)
    print("-f/-w to figure or write out (mutually exclusive, -nf/-fn/-nw/-wn reverse the option). Default is currently {:s}".format(['WRITE/-W', 'FIGURE/-F'][figure_out_default]))
    print("-l opens the first wrong line, or -nl/-ln disables this. Default is currently {:s}.".format(str(i7.oo[open_after_default])))
    exit()

def compare_unit_and_source():
    global open_line_source
    global open_line_testfile
    print('Comparing story.ni with', compfile)
    eu = 0
    mu = 0
    with open(compfile) as file:
        for (line_count, line) in enumerate(file, 1):
            if line.startswith('>uu'):
                in_unit[line.strip().lower()] = line_count
    ins = list(set(in_unit.keys()) | set(in_source.keys()))
    for x in ins:
        if x not in in_source.keys():
            print("(line {:05d}) Errant unit test".format(in_unit[x]), x)
            if not open_line_testfile: open_line_testfile = in_unit[x]
            eu += 1
    for x in ins:
        if x not in in_unit.keys():
            print("(line {:05d}) Missing unit test for command".format(in_source[x]), x)
            if not open_line_source: open_line_source = in_source[x]
            mu += 1
    print(eu, 'errant')
    print(mu, 'missing')

count = 1
while count < len(sys.argv):
    arg = sys.argv[count].lower()
    if arg[0] == '-': arg = arg[1:]
    if arg == 'l': open_after = True
    elif arg == 'nl' or arg == 'ln': open_after = False
    elif arg == 'nf' or arg == 'fn': figure_out = False
    elif arg == 'nw' or arg == 'wn': figure_out = True
    elif arg == 'f': figure_out = True
    elif arg == 'w': figure_out = False
    else:
        usage()
    count += 1

if not figure_out:
    au3 = open("utw.au3", "w")
    au3_header = "Opt(\"SendKeyDelay\", 0)\n\nOpt(\"WinTitleMatchMode\", -2)\nWinActivate(\"Ailihphilia.inform \")\nWinWaitActive(\"Ailihphilia.inform \")\n\nMouseMove(1640,972)\n\nSleep(500)\n\n";
    au3.write(au3_header)

with open("story.ni") as file:
    for (line_count, line) in enumerate(file, 1):
        if header_next:
            in_use_table = True
            header_next = False
            continue
        if 'xxrej' in line:
            header_next = True
            continue
        if in_use_table:
            if not line.strip() or '\t' not in line:
                in_use_table = False
                continue
            la = line.strip().split("\t")
            if la[0] == '--': continue
            cmd = ">uu {:s} on {:s}".format(la[0].lower(), la[1].lower())
            if figure_out:
                in_source[cmd] = line_count
                continue
            writestr += "{:s}\n".format(cmd)
            writestr += "{:s}\n\n".format(actual_text)
            actual_text = re.sub("^'", "\"", la[2][1:-1])
            actual_text = re.sub("'$", "\"", actual_text)
            au3.write("send(\"{:s}{{enter}}\")\n\n".format(cmd))
            au3.write("sleep(500)\n\n".format(cmd))


if figure_out:
    compare_unit_and_source()
else:
    au3.close()
    print("Writing to raw-ai-use-unit-tests.txt")
    reg = open("raw-ai-use-unit-tests.txt", "w")
    reg.write(writestr)
    reg.close()

if open_after:
    if not open_line_source and not open_line_testfile: print("No errors, so I'm not opening the source to find one.")
    else:
        if open_line_source: i7.npo(i7.src("ai"), open_line_source, bail=False)
        if open_line_testfile: i7.npo(compfile, open_line_testfile, bail=False)
else:
    if open_line_source or open_line_testfile: print("-l will launch the file(s) at the first errant line.")