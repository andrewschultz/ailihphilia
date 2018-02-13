
import i7
import re

from collections import defaultdict

start_ignore_dict = defaultdict(bool)
include_ignore_dict = defaultdict(bool)
regex_ignore_dict = defaultdict(bool)

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
            if ll.startswith('r:'):
                q = ll[2:]
                regex_ignore_dict[q] = True

def zap_prefix(x):
    t2 = re.sub(r"^(the|a|some|there is a book called) ", "", x, 0, re.IGNORECASE)
    return t2

def letonly(x):
    t2 = x.strip().lower()
    temp = re.sub("[^a-z]", "", t2)
    return temp

def start_ignore(ll):
    for x in start_ignore_dict.keys():
        if ll.startswith(x): return True
    return False

def include_ignore(ll):
    for x in include_ignore_dict.keys():
        if x in ll: return True
    return False

def regex_ignore(ll):
    for x in regex_ignore_dict.keys():
        if re.search("{:s}".format(x), ll, re.IGNORECASE): return True
    return False

def pal_ver(f):
    in_table = ""
    line_count = 0;
    err_count = 0;
    in_comment = 0
    table_header = False
    print("Starting", f)
    with open(f) as file:
        for line in file:
            line_count = line_count + 1
            if line.startswith('[') and ']' not in line: # multi line comment check here and below
                in_comment = line_count
                continue
            if in_comment:
                if ']' in line:
                    in_comment = False
                continue
            if line.startswith("\t") or not line.strip():
                in_table = ""
                continue
            if table_header:
                table_header = False
            if line.startswith("table of") and not '\t' in line:
                in_table = line.lower().strip()
                table_header = True
                continue
            if in_table and line.startswith("\["):
                in_table = "" # allow for comments at the end of a table, e.g. [xxuse] [zzuse] define start and end of table
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
                if start_ignore(ll) or include_ignore(ll) or regex_ignore(ll):
                    continue
                ll = zap_prefix(line.strip())
                ll = re.sub(r"(\. it is|\. they are| is| are) .*", "", ll, 0, re.IGNORECASE)
                ll = letonly(ll)
                if ll != ll[::-1]:
                    err_count = err_count + 1
                    print("Bad line", line_count, "/", err_count, "in", f, "--", line.strip(), "->", ll)
                    # print(ll, '/', ll[::-1], line)
    if err_count == 0:
        print("TEST SUCCEEDED:basic palindrome check for", f)
    else:
        print("TEST FAILED:{:s},{:d}".format(f, err_count))
    if in_comment:
        print("ERROR: Oops runaway comment at", line_count)

read_ignore_file()

for x in i7.i7f["put-it-up"]:
    pal_ver(x)