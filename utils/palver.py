
import i7
import re

def letonly(x):
	t2 = x.strip().lower()
	t2 = re.sub(r"^(the|a) ", "", t2, 0, re.IGNORECASE)
	temp = re.sub("[^a-z]", "", t2)
	return temp

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
				if ll.startswith("["): continue
				if ll.startswith("understand"): continue
				if ll.startswith("does the player mean"): continue
				if ll.startswith("description of"): continue
				if ll.startswith("rule for"): continue
				if ll.startswith("when play begins"): continue
				if ll.startswith("definition:"): continue
				if ll.startswith("to decide"): continue
				if ll.startswith("civic level"): continue
				if ll.startswith("a thing can be"): continue
				if ll.startswith("the release number"): continue
				if ll.startswith("printed name of"): continue
				if ll.startswith("the story headline"): continue
				if re.search("^(madam sniffins|dave|ian|ned|curt) is a person", ll, re.IGNORECASE): continue
				if ll.startswith("the eels are people"): continue
				if ll.startswith("check") or ll.startswith("instead") or ll.startswith("before") or ll.startswith("after"): continue
				if 'rule:' in line: continue
				if 'is an activity' in line: continue
				if 'are cappy' in line: continue
				if 'rule is listed' in line: continue
				if 'is a kind' in line: continue
				if 'is a truth state' in line: continue
				if 'is a direction' in line: continue
				if 'is a number' in line: continue
				if 'is an action' in line: continue
				if 'rule for printing' in line: continue
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

for x in i7.i7f["put-it-up"]:
	pal_ver(x)