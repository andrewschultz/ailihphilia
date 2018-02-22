Version 1/171220 of Put it Up debug Tables by Andrew Schultz begins here.

volume random names of people and places

[use dbh.py to generate debug table version of this file]

chapter random names

table of random palindrome names
person-name
"Abe Keba"
"Adam Imada"

chapter random businesses

table of businesses
biz-name
"Derby Bred"
"Skooby Books"

volume random responses

part the code

to next-rand (t - a table name):
	choose row with tabnam of t in table of all randoms;
	increment tabidx entry;
	if tabidx entry > number of rows in tabnam entry:
		say "(Cycling) ";
		now tabidx entry is 1;
	let Q be tabidx entry;
	let lb be lbrk entry;
	choose row Q in tabnam entry;
	say "[randtxt entry][if lb is true][line break][end if]";

table of all randoms
tabnam	tabidx	lbrk	desc
table of altbooks	0	false	"extra books in the Tract Cart"
table of attackings	0	true	"responses to ATTACK"

part the tables

[arranged alphabetically]

table of altbooks
randtxt
"Eponymy? Nope"
"Gigolo Gig"

table of attackings
randtxt
"D00d!"
"Dude! Dud."

table of burnies
randtxt
"Burn! Rub!"
"Igniting, I!"

[the Diktat Kid insults you. The Yuge Guy puffs himself up.]
table of diktat taunts
randtxt
"Dire! Rid!"
"Resoldered loser!"

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
"Ode? Redo!"
"Rock! Cor!"

[?? tafl.pl sort so parentheses as well as a/an/the don't affect alphabetization]
table of swearstuff
randtxt
"(R)rude! Dur(r)!"
"Bad? A dab!"

table of waittxt
randtxt
"Camp, mac!"
"Deed, deed, deed!"

table of yessies
randtxt
"Hosannas, Oh!"
"Laud-ual!"

table of yuge taunts
randtxt
"Main, I am!"
"Soros! Soros!"

Put it Up debug Tables ends here.

---- DOCUMENTATION ----
