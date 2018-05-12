# utw.py: use test writer
#
# takes the table of specific rejects and goes through each combination
#

import re
from collections import defaultdict

in_source = defaultdict(bool)
in_unit = defaultdict(bool)

figure_out = True
compfile = "reg-ail-use-unit-tests.txt"

in_use_table = False
header_next = False

writestr = ""

au3 = open("utw.au3", "w")

au3_header = "Opt(\"SendKeyDelay\", 0)\n\nOpt(\"WinTitleMatchMode\", -2)\nWinActivate(\"Ailihphilia.inform \")\nWinWaitActive(\"Ailihphilia.inform \")\n\nMouseMove(1640,972)\n\nSleep(500)\n\n";

au3.write(au3_header)

def compare_unit_and_source():
    print('Comparing story.ni with', compfile)
    eu = 0
    mu = 0
    with open(compfile) as file:
        for line in file:
            if line.startswith('>uu'):
                in_unit[line.strip().lower()] = True
    ins = list(set(in_unit.keys()) | set(in_source.keys()))
    for x in ins:
        if x not in in_source.keys():
            print("Errant unit test", x)
            eu += 1
    for x in ins:
        if x not in in_unit.keys():
            print("Missing unit test", x)
            mu += 1
    print(eu, 'errant')
    print(mu, 'missing')

with open("story.ni") as file:
    for line in file:
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
                in_source[cmd] = True
                continue
            writestr += "{:s}\n".format(cmd)
            writestr += "{:s}\n\n".format(actual_text)
            actual_text = re.sub("^'", "\"", la[2][1:-1])
            actual_text = re.sub("'$", "\"", actual_text)
            au3.write("send(\"{:s}{{enter}}\")\n\n".format(cmd))
            au3.write("sleep(500)\n\n".format(cmd))

au3.close()

if figure_out:
    compare_unit_and_source()
else:
    reg = open("raw-ail-use-unit-tests.txt", "w")
    reg.write(writestr)
    reg.close()