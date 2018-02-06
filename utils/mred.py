# mred.py
#
# map redactor for testers for Put It Up
#
# note I'd like to send this to codereview.stackexchange.com
#
# the RE's look a bit shaky. I can do them in perl but not python.
#

import re
import i7

def redact(a):
	red_char = "?"
	splitz = re.split("[<>]", line.strip())
	bars = splitz[2].split("|")
	for x in range (0,len(bars)):
		if bars[x] and bars[x] == bars[x].upper():
			count = 0
			while bars[x][count] != ' ':
				bars[x] = bars[x][0:count] + red_char + bars[x][count+1:]
				count = count + 1
	unsplitz = '|'.join(bars)
	return "\t\t\t" + splitz[0] + "<" + splitz[1] + ">" + unsplitz + "<" + splitz[3] + ">" + "\n"

orig = "c:/games/inform/triz/mine/put-it-up.trizbort"
reda = "c:/games/inform/triz/mine/put-it-up-redact.trizbort"

fout = open(reda, "w")

with open(orig) as file:
	for line in file:
		if '<objects' not in line:
			fout.write(line)
			continue
		fout.write(redact(line))

i7.npo(reda)