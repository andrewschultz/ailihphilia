Utils:

* 1j.py = super quick word-on-its-own palindromes, with possible end or start.
* 1w.py = 1 word and all the others that match it for palindromes. Can take space or comma separated values.
* 2pal.py = 2 word palindromes with optional first, last or middle string added, along with any combo of first/last name or word list
* 32.py = sped up combo checker (30 sec vs 1 hour). It tracks the difference between a starting word and an ending word and puts the possible different words in a hash.
* 3w.py = 3 word combo checker. Takes a while. Can skip uneven first/last palindromes e.g. stab bat.
* aam.py = adjust all mistakes. This syncs the mistakes file so new "mistake" verbs contribute toward a hint.
* bnam.py = best names.py. Takes 2 arguments: min length and if you need unique lettering
* dnm.py = searches the table file for names that are reused in the source. Not palindrome specific, as it is used for (possible 2nd IFComp game name redacted) too.
* dno.py = searches the notes file for names and concepts that are reused in the source. Split by slashes, or anything right of a colon is deleted. Potentially not palindrome specific: we could use ! to start a line to say it's something we want to look at, since (redacted theme of possible 2nd IFComp game) aren't as obvious.
* fu.py = find-use, where we find if/when an item can be manipulated with the USE command.
* mred.py = minor utility that redacts the game map before sending it to testers (may be able to expand to others)
* palver.py = trivial palindrome verifier for source (palver.txt has list of stuff to ignore)
* rely.py = what relies on what to get through the game. Needs auxiliary file rely.txt
* sc2.py = does internal code verification of maximum score byregion. Also cross-checks invisiclues and trizbort flowchart.
    * Supersedes the weaker msc.py. msc.py did a much more trivial runthrough.
* zr.py = trivial utility that fixes capitalization for certain room names (should eventually be spun off somewhere more general)

To-do:

* rerun 3w.py to vacuum up special test cases and check off again 2 months later when my mind is fresh
    * is there a bug with, say, abcded needing cba in end_array and dedcba needing abc in start_array? If so, report an issue. This is minor, but I want to fix it before the next go-through.
* Also, refine CAPDIC.PY to see about questionable/variable capitalizations (m = re.findall("ufo tofu", xxx, re.IGNORECASE)) (may go to MISC utils since it is generally useful)

