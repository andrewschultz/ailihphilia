import re
import os
import sys

q = [x for x in sys.argv[1:] if re.search("^[a-z]+$", x.lower())]

if len(q) == 0: sys.exit("You need to put palindrome-halves in the command line.")

finds = r'({:s})'.format("|".join([r + "." + r[::-1] for r in q]))
start = r'\b({:s})'.format("|".join(q))

print(start)

def find_one(file_name):
	print(file_name)
	with open(file_name) as file:
		for (line_count, line) in enumerate(file, 1):
			l = line.lower().strip()
			lc = re.sub("[^a-z]", "", l)
			if re.search(finds, lc):
				j = []
				for q2 in q:
					if re.search('\b{:s}'.format(q2), l):
						j.append(q2)
				q3 = "<" + "/".join(j) + ">" if len(j) else "<split word>"
				print(line_count, q3, line.strip())

find_one("story.ni")