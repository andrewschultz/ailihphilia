README for Put It Up

Possible 2018 IFComp candidate

It's about, well, palindromes.

To-do:

* Create the beginning, talking about the Diktat Kid, Yuge Guy and Madam.
* Create a trizbort file with a (preferred) walkthrough
* look at f-d and l-d for business names

Utils:

* 1j.py = super quick word-on-its-own palindromes, with possible end or start.
* 1w.py = 1 word and all the others that match it for palindromes. Can take space or comma separated values.
* 2pal.py = 2 word palindromes with optional first, last or middle string added, along with any combo of first/last name or word list
* 3w.py = 3 word combo checker. Takes a while. Can skip uneven first/last palindromes e.g. stab bat.
* 32.py = sped up combo checker (30 sec vs 1 hour). It tracks the difference between a starting word and an ending word and puts the possible different words in a hash.
* dno.py = searches the notes file for names and concepts that are reused in the source. Split by slashes, or anything right of a colon is deleted. Potentially not palindrome specific: we could use ! to start a line to say it's something we want to look a, since spoonerisms aren't as obvious.
* dnm.py = searches the table file for names that are reused in the source. Not palindrome specific, as it is used for Spell Woken too.
* palver.py = trivial palindrome verifier for source
* sc2.py = does internal code verification of maximum score byregion. Supersedes the weaker msc.py.
