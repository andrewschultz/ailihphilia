# utw.py: use test writer
#
# takes the table of specific rejects and goes through each combination
#

import re

in_use_table = False
header_next = False

reg = open("reg-ail-use-unit-tests.txt", "w")
au3 = open("utw.au3", "w")

au3_header = "Opt(\"SendKeyDelay\", 0)\n\nOpt(\"WinTitleMatchMode\", -2)\nWinActivate(\"Ailihphilia.inform \")\nWinWaitActive(\"Ailihphilia.inform \")\n\nMouseMove(1640,972)\n\nSleep(500)\n\n";

au3.write(au3_header)

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
            cmd = "uu {:s} on {:s}".format(la[0].lower(), la[1].lower())
            reg.write("> {:s}\n".format(cmd))
            actual_text = re.sub("^'", "\"", la[2][1:-1])
            actual_text = re.sub("'$", "\"", actual_text)
            reg.write("{:s}\n\n".format(actual_text))
            au3.write("send(\"{:s}{{enter}}\")\n\n".format(cmd))
            au3.write("sleep(500)\n\n".format(cmd))

au3.close()
reg.close()