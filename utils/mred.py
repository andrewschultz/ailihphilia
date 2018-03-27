# mred.py
#
# map redactor for testers for Ailihphilia
#
# note I'd like to send this to codereview.stackexchange.com
#
# the RE's look a bit shaky. I can do them in perl but not python.
#

import re
import i7

red_char = "?"
redact_all = True

def obj_redact(b, red_char):
    return re.sub("[A-Z]", ".", b)

def redact(a):
    splitz = re.split("[<>]", a.strip())
    if redact_all:
        unsplitz = ""
    else:

        bars = splitz[2].split("|")
        for x in range (0,len(bars)):
            if bars[x] and bars[x] == bars[x].upper():
                bars[x] = obj_redact(bars[x], red_char)
        unsplitz = '|'.join(bars)
    return "\t\t\t" + splitz[0] + "<" + splitz[1] + ">" + unsplitz + "<" + splitz[3] + ">" + "\n"

orig = "c:/games/inform/triz/mine/ailihphilia.trizbort"
reda = "c:/games/inform/triz/mine/ailihphilia-redact.trizbort"

fout = open(reda, "w")

with open(orig) as file:
    for line in file:
        if '<line' in line:
            if redact_all:
                line = re.sub("(start|mid|end)text=\"[^\"]*\"", "", line, 0, re.IGNORECASE)
        if '<objects' not in line:
            fout.write(line)
            continue
        fout.write(redact(line))

i7.npo(reda)