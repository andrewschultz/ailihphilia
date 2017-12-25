import time
import sys

from collections import defaultdict

wordy = defaultdict(bool)
lasty = defaultdict(lambda: defaultdict(bool))
firsty = defaultdict(lambda: defaultdict(bool))

def can_palindrome_mid(a, b):
    c = a + b
    if c == c[::-1]:
        d = len(a) - len(b)
        if abs(d) < 2:
            return False
    if len(a) < len(b):
        return a == b[-len(a):][::-1]
    return b == a[:len(b)][::-1]

t1 = time.time()

okay_2_letter_words = [ "a", "an", "in", "on", "of", "or", "to", "my", "it"]

for x in okay_2_letter_words:
    wordy[x] = True
    firsty[x[0]][x] = True
    lasty[x[-1]][x] = True

with open("c:/writing/dict/brit-1word.txt") as file:
    for line in file:
        ll = line.lower().strip()
        if len(ll) < 3:
            continue
        wordy[ll] = True
        firsty[ll[0]][ll] = True
        lasty[ll[-1]][ll] = True

sk = sorted(wordy.keys())

count = 0

t2 = time.time() - t1
print(t2, 'seconds to read dict file')

start_val = 'a'

if len(sys.argv) > 1:
    if sys.argv[1].isalpha():
        start_val = sys.argv[1].tolower()
    else:
        print("The parameter must be a word. It says which word the palindrome search starts on, alphabetically.")
        exit()

for a in sk:
    if a < start_val:
        continue
    this_word_count = 0
    if count % 1000 == 0:
        print(a, count);
    for b in sk:
        if can_palindrome_mid(a, b):
            for c in sk:
                d = a + c + b
                if d == d[::-1]:
                    this_word_count = this_word_count + 1
                    count = count + 1
                    print(this_word_count, count, a, c, b, "=", d)

t3 = time.time() - t2
print(t3, "seconds for all 3-word palindromes.")
