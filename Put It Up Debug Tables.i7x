Version 1/171220 of Put it Up debug Tables by Andrew Schultz begins here.

volume random names

table of random palindrome names
person-name
"Abe Keba"
"Adam Imada"

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
table of singstuff	0
table of swearstuff	0
table of waittxt	0
table of yessies	0

part the tables

[arranged alphabetically]

table of attackings
randtxt
"D00d!"
"Dude! Dud."

table of burnies
randtxt
"Burn! Rub!"
"Igniting, I!"

table of noesies
randtxt
"Derided! Ired!"
"Emo, me."

table of nothings
randtxt
"Dud!"
"Eh, the..."

table of singstuff
randtxt
"Tone? Not!"
"Rock! Cor!"

table of swearstuff
randtxt
"(R)rude! Dur(r)!"
"Bad? A dab!"

table of waittxt
randtxt
"Deed, deed, deed!"
"Don't nod!"

table of yessies
randtxt
"Nod on!"
"Pip, pip!"

Put it Up debug Tables ends here.

---- DOCUMENTATION ----