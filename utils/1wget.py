# no backdrops. We're lucky.

from collections import defaultdict
import re

scen_tot = 0
ppl_tot = 0
rms = 0
thingz = 0

stuff_in_game = defaultdict(int)
bad_start_dict = defaultdict(bool)

def to_check_hash(q):
	for q2 in q.split(' '):
		stuff_in_game[q] += 1

def read_bad_start():
	with open("1wget.txt") as file:
		for line in file:
			if line.startswith('#'): next
			if line.startswith(';'): last
			for j in line.lower().strip().split(','): bad_start_dict[j] = True
def has_dir(x):
	return re.search(" is (north|south|east|west) ", x)

def no_art(x):
	return re.sub("^(a|the|an) ", "", x, 0, re.IGNORECASE)

def cut_verb(x):
	return re.sub(" (is|are) .*", "", x, 0, re.IGNORECASE)

def bad_start(x):
	xl = x.lower()
	for b in bad_start_dict.keys():
		if xl.startswith(b + ' '): return True
	if xl.startswith('['): return True
	return False

read_bad_start()

with open("story.ni") as file:
	for (line_count, line) in enumerate(file, 1):
		if '\t' in line: continue
		sent1 = re.sub("\..*", "", line.strip().lower())
		if bad_start(sent1): continue
		if ' thing ' in sent1 or sent1.endswith('thing'):
			if 'is an action' in sent1: continue
			if 'is a kind of' in sent1: continue
			st = cut_verb(sent1)
			st = no_art(st)
			thingz += 1
			to_check_hash(st)
			# print(thingz, st)
		if ' room ' in sent1 or has_dir(sent1):
			if 'room in odd do' in sent1: continue
			st = cut_verb(sent1)
			rms += 1
			to_check_hash(st)
			# print(rms, st)
		if ' 	scenery' in sent1:
			scen_tot += 1
			st = no_art(sent1)
			st = cut_verb(st)
			to_check_hash(st)
			# print(scen_tot, st)
		if ' person' in sent1 or ' people' in sent1:
			ppl_tot += 1
			if 'kind of person' in sent1: continue
			st = no_art(sent1)
			st = cut_verb(st)
			to_check_hash(st)
			# print(ppl_tot, st)

outfile = "1wget-out.txt"
f2 = open(outfile, "w")

for x in stuff_in_game.keys():
	f2.write(x + '\n')

f2.close()

print("Wrote", len(stuff_in_game.keys()), "palindromes to test, to", outfile)