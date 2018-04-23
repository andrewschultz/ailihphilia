# fu.py :oh no no no no no, people! It doesn't mean ... that.
# it means "find use..." it searches for an item in Table of Goodacts
# then says what it's used on or how it's created.

import sys

if len(sys.argv) == 1:
	print("You need an item to check for.")
	exit()

args = [x.lower() for x in sys.argv[1:]]

line_count = 0
table_count = 0
in_use_table = False

with open("story.ni") as file:
	for line in file:
		line_count = line_count + 1
		if line.startswith("table of goodacts"):
			in_use_table = True
			# print(line_count)
			continue
		ll = line.lower().strip()
		if '\t' not in ll:
			# if in_use_table: print("Not", line_count)
			in_use_table = False
		if in_use_table:
			table_count = table_count + 1
			x = ll.split("\t")[:3]
            if x[0] == '--': continue
			x2 = ' '.join(x)
			plus = "{:s} + {:s} = {:s}".format(x[0], x[1], x[2])
			# print(args, plus)
			for y in args:
				if y in x2:
					print(line_count, "/", table_count, "TO:" if y in x[2] else "FROM:", plus)
