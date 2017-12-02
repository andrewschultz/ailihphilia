import sys
from collections import defaultdict

found = defaultdict(int)

pals = []

for x in sys.argv[1:]:
    pals.extend(x.split(","))
    print(pals)

count = 0

print(pals)

with open("c:/writing/dict/brit-1word.txt") as file:
    for line in file:
        l = line.strip().lower()
        for st in pals:
            x = st + l
            if x == x[::-1]:
                print('FIRST', st, '+' , l, '=', x)
                found[st] = found[st] + 1
            y = l + st
            if y == y[::-1]:
                print('LAST', l, '+' , l, '=', y)
                found[st] = found[st] + 1

for x in sorted(found.keys()):
    print("Found", found[x], "palindromes for", x)
