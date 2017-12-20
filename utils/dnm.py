# duplicate name finder

from collections import defaultdict
import re

def check_dupes(s):
	source_table = 0
	table_table = 0
	poss_dupes = defaultdict(int)
	s2 = re.sub("-", " ", s)
	print("Checking", s)
	table_file_to_read = "c:/program files (x86)/inform 7/inform7/extensions/Andrew Schultz/{:s} tables.i7x".format(s2)
	source_file = "c:/games/inform/{:s}.inform/source/story.ni".format(s)
	already_reading = False
	line_count = 0
	with open(table_file_to_read) as file:
		for line in file:
			line_count = line_count + 1
			if already_reading:
				if line.strip == '':
					already_reading = False
					continue
				if line.startswith("\""):
					l2 = re.sub("^\"", "", line.strip().lower())
					l2 = re.sub("\".*", "", l2)
					if l2 in poss_dupes:
						print(l2, "appears twice in", table_file_to_read, "at line", line_count)
						table_table = table_table + 1
					poss_dupes[l2] = line_count
			if line.startswith("table of random palindrome names") or line.startswith("table of random dirty spoonerism names"):
				already_reading = True
	line_count = 0
	with open(source_file) as file:
		for line in file:
			line_count = line_count + 1
			l2 = line.strip().lower()
			for q in poss_dupes.keys():
				if q in l2:
					print (q, "line", line_count, "in source matches with", l2, "originally line", poss_dupes[q])
					source_table = source_table + 1
	pdl = len(poss_dupes.keys())
	print(("No" if source_table == 0 else "{:d}".format(source_table)), " source/table conflicts with", s, "and", pdl, "total keys")
	print(("No" if table_table == 0 else "{:d}".format(table_table)), " table/table conflicts with", s, "and", pdl, "total keys")

check_dupes("put-it-up")
check_dupes("spell-woken")
