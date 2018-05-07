from collections import defaultdict

depends = defaultdict(lambda: defaultdict(bool))

def depends_add(result, needed, line=-1):
	depends[result][needed] = True
	if result in depends[needed].keys():
		print("Oops circular loop for what item needs what:", result, "<=>", needed, "at line", line)
		exit()
	for x in depends[needed].keys():
		if result in depends[x]:
			print("Oops (complex) circular loop for what item needs what:", result, "<=>", x, "via", needed, "at line", line)
			exit()
		depends[result][x] = True
	for x in depends.keys():
		if result in depends[x].keys():
			for y in depends[result].keys():
				if x in depends[y].keys():
					print("Oops (complex) circular loop for what item needs what:", result, "<=>", x, "/", y, "via", needed, "at line", line)
					exit()
				depends[x][y] = True



verbose = False


in_table = False
header_next = False
line_count = 0

with open("story.ni") as file:
	for line in file:
		line_count += 1
		if 'xxuse' in line:
			header_next = True
			in_table = True
			continue
		if header_next:
			header_next = False
			continue
		if in_table:
			if '\t' not in line.strip():
				in_table = False
				continue
			ary = line.lower().strip().split("\t")
			if ary[2] == '--':
				continue
			# print(ary[2], "needs", ary[1], "and", ary[0])
			if ary[2] != ary[1]:
				depends_add(ary[2], ary[1], line_count)
			if ary[2] != ary[0]:
				depends_add(ary[2], ary[0], line_count)

in_table = False
header_next = False
line_count = 0

with open("rely.txt") as file:
	for line in file:
		line_count += 1
		if line.startswith(";"):
			last
		if line.startswith("#"):
			continue
		if '/' not in line:
			print("Warning line", line_count, "needs slash")
			continue
		ary = line.lower().strip().split("/")
		needers = ary[0].split(",")
		neededs = ary[1].split(",")
		for n1 in needers:
			for n2 in neededs:
				depends_add(n1, n2, line_count)

totals = 0

for x in sorted(depends.keys()):
	if len(depends[x].keys()):
		totals = totals + len(depends[x].keys())
		print(x, "requires", len(depends[x].keys()), ":", ', '.join(sorted(depends[x].keys())))
	else:
		if verbose:
			print(x, "has no requirements")

print(totals, "total dependencies.")
