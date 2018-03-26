Version 1/171220 of Put it Up debug Tables by Andrew Schultz begins here.

volume random names of people and places

[use dbh.py to generate debug table version of this file]

chapter random names

[NOTE: can-m + can-f = a unisex name. False/False should never happen.]
table of random authors
person-name	can-m	can-f
"Eliza Bazile"	false	true
"Kera Marek"	false	true
"Leta Patel"	false	true
"Marge Pegram"	false	true
"Mika Hakim"	false	true
"Norma Damron"	false	true
"Reiko Kier"	false	true
"Rhea Baehr"	false	true
"Blake DeKalb"	true	true
"Leigh Giel"	true	true
"Adam Imada"	true	false
"Eldon Odle"	true	false
"Elias Osaile"	true	false
"Emory Rome"	true	false
"Gino Konig"	true	false
"Levi Rivel"	true	false
"Mark Cockram"	true	false
"Neil Klien"	true	false

table of random palindrome names
person-name
"Abe Keba"
"Agnus Unga"

chapter random businesses

table of businesses
biz-name
"Dairy Myriad"
"Derby Bred"

volume random responses

part the code

to next-rand (t - a table name):
	choose row with tabnam of t in table of all randoms;
	increment tabidx entry;
	if debug-state is true and tabidx entry > number of rows in tabnam entry:
		say "(Cycling) ";
		now tabidx entry is 1;
	let Q be tabidx entry;
	let lb be lbrk entry;
	choose row Q in tabnam entry;
	say "[randtxt entry][if lb is true][line break][else][run paragraph on][end if]";

table of all randoms
tabnam	tabidx	lbrk	desc
table of altbooks	0	false	"extra books in the Tract Cart"
table of attackings	0	true	"responses to ATTACK"
table of burnies	0	true	"responses to BURN"
table of diktat taunts	0	true	"Diktat Kid taunts"
table of My Gym songs	0	false	"songs in My Gym (LISTEN)"
table of noesies	0	true	"responses to NO"
table of nothings	0	true	"responses to empty commands"
table of singstuff	0	true	"responses to SINGing"
table of swearstuff	0	true	"responses to SWEARing"
table of undoings	0	true	"UNDOing notifications"
table of waittxt	0	true	"responses to WAITing"
table of yessies	0	true	"responses to YES"
table of yuge taunts	0	true	"Yuge Guy taunts"

part the tables

[arranged alphabetically]

table of altbooks
randtxt
"D'oh, Serene, Reshod"
"D'oh, Temp Method"

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
"Dude(tte)! Dud!"

table of My Gym songs
randtxt
"Kazoo Zak"
"Krew Twerk"

table of noesies
randtxt
"Dash sad."
"Derided! Ired!"

table of nothings
randtxt
"Drown, word!"
"Dud!"

table of singstuff
randtxt
"Ode? Redo!"
"Rock! Cor!"

[?? tafl.pl sort so parentheses as well as a/an/the don't affect alphabetization]
table of swearstuff
randtxt
"(R)rude! Dur(r)!"
"Bad? A dab!"

table of undoings
randtxt
"'Redo-coder! Redo-coder!'"
"[']S poor. Oops!"

table of waittxt
randtxt
"Camp, mac!"
"Deed, deed, deed!"

table of wordy drow laments
randtxt
"'Deity...tied!'"
"'Die, id!'"

table of yessies
randtxt
"Hosannas, Oh!"
"Laud-ual!"

table of yuge taunts
randtxt
"Ahahahahahaha!"
"Gibe! Big!"

Put it Up debug Tables ends here.

---- DOCUMENTATION ----
