Version 1/171220 of Put it Up debug Tables by Andrew Schultz begins here.

volume random names

table of random palindrome names
person-name
"Adam Imada"
"Agnus Unga"

volume random responses

part the code

to next-rand (t - a table name):
	choose row with tabnam of t in table of all randoms;
	increment tabidx entry;
	if tabidx entry > number of rows in tabnam entry:
		say "(Cycling) ";
		now tabidx entry is 1;
	let Q be tabidx entry;
	choose row Q in tabnam entry;
	say "[randtxt entry][line break]";

table of all randoms
tabnam	tabidx
table of attackings	0
table of burnies	0
table of noesies	0
table of nothings	0
table of swearstuff	0
table of waittxt	0
table of yessies	0

part the tables

[arranged alphabetically]

table of attackings
randtxt
"Harm! Rah!"
"Ole! Lo!"

table of burnies
randtxt
"Burn! Rub!"
"Rah! Char!"

table of noesies
randtxt
"Emo, me."
"Hm. SMH."

table of nothings
randtxt
"Dud!"
"Eh, the..."

table of swearstuff
randtxt
"(R)rude! Dur(r)!"
"Bad? A dab!"

table of waittxt
randtxt
"Don't nod!"
"Gall! Lag!"

table of yessies
randtxt
"Nod on!"
"Plus? Ulp."

Put it Up debug Tables ends here.

---- DOCUMENTATION ----
