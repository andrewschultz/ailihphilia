
import i7
import re

from collections import defaultdict

start_ignore_dict = defaultdict(bool)
include_ignore_dict = defaultdict(bool)

def read_ignore_file():
	ignore_file = "c:/games/inform/put-it-up.inform/source/palver.txt"
	with open(ignore_file) as file:
		for line in file:
			if line.startswith('#'):
				continue
			if line.startswith(';'):
				file.close()
				return
			ll = line.strip().lower()
			if ll.startswith('s:'):
				q = ll[2:]
				start_ignore_dict[q] = True
			if ll.startswith('i:'):
				q = ll[2:]
				include_ignore_dict[q] = True


def letonly(x):
	t2 = x.strip().lower()
	t2 = re.sub(r"^(the|a) ", "", t2, 0, re.IGNORECASE)
	temp = re.sub("[^a-z]", "", t2)
	return temp

def start_ignore(ll):
	for x in start_ignore_dict.keys():
		if ll.startswith(x):
			return True
	return False

def include_ignore(ll):
	for x in include_ignore_dict.keys():
		if x in ll:
			return True
	return False

def pal_ver(f):
	in_table = ""
	line_count = 0;
	err_count = 0;
	table_header = False
	print("Starting", f)
	with open(f) as file:
		for line in file:
			line_count = line_count + 1
			if line.startswith("\t") or not line.strip():
				in_table = ""
				continue
			if table_header:
				table_header = False
			if line.startswith("table of") and not '\t' in line:
				in_table = line.lower().strip()
				table_header = True
				continue
			if line.startswith("\"") and '\t' not in line:
				q = letonly(line)
				if 'by Andrew Schultz' in line: continue
				if q != q[::-1]:
					err_count = err_count + 1
					print("Bad line", line_count, "in", f, "--", line.strip())
				continue
			if ' is ' in line or ' are ' in line:
				if in_table != "": continue
				ll = line.lower().strip()
				if re.search("^(madam sniffins|dave|ian|ned|curt) is a person", ll, re.IGNORECASE): continue
				if start_ignore(ll) or include_ignore(ll):
					continue
				ll = re.sub(r" (is|are) .*", "", line.strip())
				ll = letonly(ll)
				if ll != ll[::-1]:
					err_count = err_count + 1
					print("Bad line", line_count, "/", err_count, "in", f, "--", line.strip())
					# print(ll, '/', ll[::-1], line)
	if err_count == 0:
		print("TEST SUCCEEDED:basic palindrome check for", f)
	else:
		print("TEST FAILED:", f, ",", err_count)

read_ignore_file()
for x in i7.i7f["put-it-up"]:
	pal_ver(x)