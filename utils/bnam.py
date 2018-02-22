import re
from collections import defaultdict

in_pal_table = False
need_no_unique = True
count = 0
low_limit = 7

def uniq_l(x):
	if need_no_unique: return True
	lets = defaultdict(bool)
	for y in x:
		if y in lets.keys(): return False
		lets[y] = True
	return True

with open("c:\Program Files (x86)\Inform 7\Inform7\Extensions\Andrew Schultz\Put it Up tables.i7x") as file:
	for line in file:
		if line.startswith("table of random palindrome"):
			in_pal_table = True
			continue
		if not line.strip():
			in_pal_table = False
			continue
		if in_pal_table:
			x = re.sub("[^a-z]", "", line.strip().lower())
			x = re.sub(".*\"", "", x)
			y = (len(x)+1) // 2
			x = x[:y]
			if len(x) >= 7 and uniq_l(x):
				count = count + 1
				print(count, line.strip(), "seems like a cool name.")
