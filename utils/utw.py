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
in_unit_generic_x = defaultdict(int)
in_unit_generic_y = defaultdict(int)
use_mac = defaultdict(int)
sug_txt = defaultdict(str)

figure_out = figure_out_default = True
compfile = "reg-ai-use-unit-tests.txt"
rawfile = "raw-ai-use-unit-tests.txt"

in_use_table = False
header_next = False

open_line_source = 0
open_line_testfile = 0
open_after = open_after_default = False
print_err_lines = print_err_lines_default = True

writestr = ""

def usage(arg):
    print("Invalid option", arg)
    print()
    print("Viable options below")
    print("=" * 50)
    print("-p prints error lines, -np/-pn erases them. Default is currently {:s}.".format(i7.oo[print_err_lines_default]))
    print("-f/-w to figure or write out (mutually exclusive, -nf/-fn/-nw/-wn reverse the option). Default is currently {:s}".format(['WRITE/-W', 'FIGURE/-F'][figure_out_default]))
    print("-l opens the first wrong line, or -nl/-ln disables this. Default is currently {:s}.".format(i7.oo[open_after_default]))
    exit()

def compare_unit_and_source():
    global open_line_source
    global open_line_testfile
    print('Comparing story.ni with', compfile)
    eu = 0
    mu = 0
    ignore_block = False
    with open(compfile) as file:
        for (line_count, line) in enumerate(file, 1):
            if 'ignore-block' in line: ignore_block = True
            if ignore_block: continue
            if not line.strip(): ignore_block = False
            if line.startswith('>uu '): in_unit[line.strip().lower()] = line_count
            elif line.startswith('>uux '): in_unit_generic_x[line.strip().lower()] = line_count
            elif line.startswith('>uuy '): in_unit_generic_y[line.strip().lower()] = line_count
    ins = list(set(in_unit.keys()) | set(in_source.keys()))
    for x in ins:
        if x not in in_source.keys():
            if print_err_lines: print("(line {:05d}) Errant unit test".format(in_unit[x]))
            print(x)
            if not open_line_testfile: open_line_testfile = in_unit[x]
            eu += 1
    for x in ins:
        if x not in in_unit.keys():
            if print_err_lines: print("(line {:05d}) Missing unit test for command".format(in_source[x]))
            print(x)
            print(sug_txt[x])
            if not open_line_source: open_line_source = in_source[x]
            mu += 1
    ins = list(set(in_unit_generic_x.keys()) | set(in_unit_generic_y.keys()) | set(use_mac.keys()))
    for x in sorted(ins, key = lambda x: re.sub(">uu[a-z]+", "", x)):
        if x not in in_unit_generic_x.keys() and 'uux' in x:
            if print_err_lines: print("(line {:05d}) Missing generic unit test (uux) for command".format(use_mac[x]))
            print(x)
            if not open_line_testfile: open_line_testfile = use_mac[x]
            print(sug_txt[x])
            eu += 1
        if x not in in_unit_generic_y.keys() and 'uuy' in x:
            if print_err_lines: print("(line {:05d}) Missing generic unit test (uuy) for command".format(use_mac[x]))
            print(x)
            if not open_line_testfile: open_line_testfile = use_mac[x]
            print(sug_txt[x])
            eu += 1
        if x not in use_mac.keys():
            if print_err_lines: print("(line {:05d}) Errant generic unit test".format(in_unit_generic[x]))
            print(x)
            print(sug_txt[x])
            if not open_line_source: open_line_source = in_unit_generic[x]
            mu += 1
    print(eu, 'errant')
    print(mu, 'missing')

count = 1
while count < len(sys.argv):
    arg = sys.argv[count].lower()
    if arg[0] == '-': arg = arg[1:]
    if arg == 'l': open_after = True
    elif arg == 'nl' or arg == 'ln': open_after = False
    elif arg == 'p': print_err_lines = True
    elif arg == 'np' or arg == 'pn': print_err_lines = False
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

# this is the table of specific rejects

in_cant = False

with open("story.ni") as file:
    for (line_count, line) in enumerate(file, 1):
        if header_next:
            in_use_table = True
            header_next = False
            la = line.lower().strip().split("\t")
            babble_col = la.index('babble')
            continue
        if 'xxrej' in line:
            header_next = True
            continue
        if 'xxcant' in line:
            header_next = True
            in_cant = True
            continue
        if in_use_table:
            if not line.strip() or '\t' not in line:
                in_use_table = False
                in_cant = False
                continue
            la = line.strip().split("\t")
            if in_cant:
                l1 = ">uux {:s}".format(la[0].lower())
                l2 = ">uuy {:s}".format(la[0].lower())
                use_mac[l1] = use_mac[l2] = line_count
                sug_txt[l1] = sug_txt[l2] = re.sub("\"", "", la[babble_col])
            if la[0] == '--' or in_cant: continue
            cmd = ">uu {:s} on {:s}".format(la[0].lower(), la[1].lower())
            sug_txt[cmd] = re.sub("^\"", "", la[2])
            sug_txt[cmd] = re.sub("\".*", "", sug_txt[cmd])
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
    print("Writing to", rawfile)
    reg = open(rawfile, "w")
    reg.write(writestr)
    reg.close()

if open_after:
    if not open_line_source and not open_line_testfile: print("No errors, so I'm not opening the source to find one.")
    else:
        if open_line_source: i7.npo(i7.src("ai"), open_line_source, bail=False)
        if open_line_testfile: i7.npo(compfile, open_line_testfile, bail=False)
else:
    if open_line_source or open_line_testfile: print("-l will launch the file(s) at the first errant line.")