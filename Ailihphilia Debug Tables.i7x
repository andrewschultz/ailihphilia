Version 1/171220 of Ailihphilia debug Tables by Andrew Schultz begins here.

volume big random table

[use dbh.py to generate debug table version of this file]
[use palver.py to verify palindromes]
[use dno.py to detect duplicates]

part the code

table-freeze is a truth state that varies.

to next-rand (t - a table name):
	choose row with tabnam of t in table of all randoms;
	if table-freeze is true:
		now table-freeze is false;
	else:
		increment tabidx entry;
	if tabidx entry > number of rows in tabnam entry:
		if debug-state is true, say "(Cycling--debug note) ";
		now tabidx entry is 1;
		if thru-yet entry is 0:
			now thru-yet entry is 1;
			now rand-cycle is true;
	let Q be tabidx entry;
	let lb be lbrk entry;
	choose row Q in tabnam entry;
	say "[randtxt entry][if lb is true][line break][else][no line break][end if]";

to say next-rand-txt of (t - a table name):
	next-rand t;

to say same-rand-txt of (t - a table name):
	now table-freeze is true;
	next-rand t;

to say last-in-loop: say "This is just a note that you've seen all the current command's random responses, and they'll loop after this. Thanks for poking around so much."

table of all randoms
tabnam	tabidx	thru-yet	lbrk	desc	cycle-note
table of altbooks	0	0	false	"extra books in the Relate Taler"	"You've read all the books on the Relate Taler. Well, except for [i]Lives As Evil[r]. You'll skip that one."
table of attackings	0	0	true	"responses to ATTACK"	"[last-in-loop]."
table of babel babble	0	0	false	"babbles if you LISTEN in Le Babel"	"The most horrid whisper of all is of the NRA Barn. Ghastly!"
table of bad places	0	0	false	"places beyond Yell Alley"	"That has to be the last one. Boy, all that seediness!"
table of Bond Nob bars	0	0	false	"bars the Bond Nob visits"	"Your head reels from everywhere the Bond Nob's been."
table of burnies	0	0	true	"responses to BURN"	"I'm all burned out of clever random responses now. Ha ha."
table of businesses	0	0	false	"businesses in Day-Away Ad"	"... and wait! There'll even be a new Deft Fed, owned by a salt-of-the-earth type named Treffert, now that Sniffins/Smuggums totally sold out!"
table of diktat taunts	0	0	false	"Diktat Kid taunts"	"'BOSS SOB!' the Diktat Kid yells, finally free from the shackles of political correctness."
table of King Nik ancestors	0	0	false	"King Nik ancestors (TALK to King Nik)"	"So much to live up to for King Nik. Listening's good, but maybe you can take action."
table of machines	0	0	false	"machines in Work Row post-test set"	"You stop and think a moment. None of those machines were as useful as the original three."
table of Moo Room animals	0	0	false	"Moo Room animals (LISTEN)"	"Finally, you hear a single ewe, which you're surprised you didn't hear earlier."
table of Ms Ism pals	0	0	false	"Ms Ism's pals (TALK to Ms Ism)"	"Whoah! She's had a lot to say, and she's going to say it again. Surely there must be a way to deal with her."
table of My Gym songs	0	0	false	"songs in My Gym (LISTEN)"	"The final tune as the set abates is surprisingly catchy: [i][']S ADIDAS[r]. As it fades, you also realize you heard nothing by ABBA! Low class, low class." [yes, Run-DMC's My Adidas]
table of noesies	0	0	true	"responses to NO"	"An epony-NOPE rings through your ears to push back against your negativity in grand fashion."
table of nothings	0	0	true	"responses to empty commands"	"[last-in-loop]."
table of npc mistakes	0	0	false	"CALL/PHONE random NPC text"	"That's all there is. You [if aid-LLP-yet is false]can't help wondering if there's something better to dial for help, or a hint, or something[else]find this all less fruitful than when you decided to DIAL AID[end if]."
table of political stuff	0	0	false	"political stuff in the ex-Red Roses Order"	"'Slo pols,' you muse to yourself, as the debates re-rage, only moving fractionally forward."
table of random authors	0	0	false	"random author names (ones I particularly liked)"	--
table of random palindrome firstlast names	0	0	false	"First/last names in Name ME Man"	"Impressive! You made it through the phone book."
table of random palindrome lastfirst names	0	0	false	"Last/first names in OH WHO"	"Impressive! You made it through the phone book."
table of rejected kid sidekicks	0	0	false	"the Diktat Kid's rejected kid sidekicks"	--
table of Rob droning	0	0	false	"things Rob babbles about"	"'Rod or Rog or Roy or Roz or ... rot.' Rob takes a moment to shape 'pahs' again."
table of sci pics subjects	0	0	false	"sci pics subjects"	"That's all the education the sci pics offer, but you can read again, if you want."
table of singstuff	0	0	true	"responses to SINGing"	"Won't be joining OctetCo with that voice."
table of snooty toon ads	0	0	false	"snooty toons ads"	"At the end is La Usual, because of course. Everything else is doofy food."
table of swearstuff	0	0	true	"responses to SWEARing"	"Okay, you've had enough attention, I hope. I'm out of shocked responses to your language."
table of trashy art	0	0	false	"other 'art' [if DWELT LEWD is off-stage]a book hidden in the Tract Cart[else]DWELT LEWD[end if] promotes"	"That's all. Your intellectual (I hope) curiosity sated, you look for more constructive tasks[lewd-true], not worried (again, I hope) you've forgotten the plot of DWELT LEWD by now."
table of undoings	0	0	true	"UNDOing notifications"	"[last-in-loop]."
table of university primary targets	0	0	false	"Dr. D/Code Doc's prospective titled colleagues"	"Well, that's the formal doctors repeating. Or starting to."
table of university secondary targets	0	0	false	"Dr. D/Code Doc's prospective untitled colleagues"	"And now the untitled colleagues are repeating. Still, it took a while. The Code Doc has big plans!"
table of waittxt	0	0	true	"responses to WAITing"	"[last-in-loop]."
table of wordy drow laments	0	0	false	"Wordy Drow laments"	"The Wordy Drow has an eternity to repeat itself, but you don't. What could you do to get past it and the liar grail?"
table of yessies	0	0	true	"responses to YES"	"[last-in-loop]."
table of yuge baits	0	0	false	"Yuge Guy bait if you run away"	"The Yuge Guy emits a side-dis you probably weren't meant to hear fully. can't quite hear, and you are enraged enough to want to go back and deal with him later."
table of yuge battle cries	0	0	false	"Yuge Guy battle cries"	"'Dad?! Dad!!! Dad?!' the Yuge Guy yells, in a mixture of rage and supplication. Geez, he's got some issues. Señor drones, you think you yourself, as he winds up for a repeat round of nonsense."

rand-cycle is a truth state that varies.

every turn (this is the notify cycling rule):
	if rand-cycle is true:
		let tn be a table-name;
		let tables-found be 0;
		now rand-cycle is false;
		repeat through table of all randoms:
			if thru-yet entry is 1:
				now thru-yet entry is 2;
				increment tables-found;
				if debug-state is true, say "DEBUG: will be cycling [tabnam entry].";
				if tables-found is 1:
					say "[line break][if there is a cycle-note entry][cycle-note entry][line break][else]Whoah...that sounds familiar. You suspect the dialogue will loop again.[end if]";
				else if tables-found is 2:
					say "This is a further note to say you've looped through random text more than once this turn, which is an impressive bit of timing, even if it doesn't get you any points.";
		if tables-found is 0 and debug-state is true, say "This is a BUG--you should have been notified of random cycling in a table, but you weren't.";
		the rule succeeds;

volume random names of people and places

chapter random names

[NOTE: can-m + can-f = a unisex name. False/False should never happen.]
table of random authors [xxauth]
randtxt	can-m	can-f
"Eliza Bazile"	false	true
"Imogene Gomi"	false	true

table of random palindrome firstlast names [xxfirstname]
randtxt
"Abe Keba"
"Adam Amada"

table of random palindrome lastfirst names [xxlastname]
randtxt
"Adelizzi, Leda"
"Adels, Leda"

volume random responses

part the tables

[arranged alphabetically]

table of altbooks [xxbooks]
randtxt
"Admirer, I'm Da"
"Aegea"

table of attackings [xxatt]
randtxt
"D00d!"
"Dude! Dud."

table of babel babble [xxbabel]
randtxt
"App A"
"Banana B"

table of bad places [xxcity] [xxplaces]
randtxt
"Acidica"
"Dart-Strad"

table of burnies [xxburn]
randtxt
"Burn! Rub!"
"Igniting, I!"

table of Bond Nob bars [xxbar] [xxbond]
randtxt
"Bar Crab"
"Brewer B"

table of businesses [xxbus] [xxbiz] [xxshop]
randtxt
"Art Sastra"
"Ate Beta"

[this may be related to Yuge battle cries, but the Diktat Kid insults you. The Yuge Guy puffs himself up.]
table of diktat taunts [xxdiktat] [xxkid]
randtxt
"Ahahahahahaha!"
"At's-a BASTA!"

table of King Nik ancestors [xxnik]
randtxt
"Iolo I"
"Isaias I"

table of machines [xxmachines]
randtxt
"re-peeper"
"re-life-filer"

table of Moo Room animals [xxanimals]
randtxt
"an align-gila"
"any myna"

table of My Gym songs [xxgym] [xxmy] [xxsong]
randtxt
"Age Mo['] Mega"
"Ai, Tia"

table of noesies [xxno]
randtxt
"Dash sad."
"Derided! Ired!"

table of nothings [xxblank]
randtxt
"Drown, word!"
"Dud!"

table of npc mistakes [xxnpc] [xxtalk]
randtxt
"Allo? Holla[']!"
"Da Sad!"

table of Ms Ism pals [xxism] [xxms]
randtxt
"Able Melba"
"Aglow Olga"

table of political stuff [xxpolitical] [xxpols]
randtxt
"an animals['] lamina"
"College L Loc"

table of rejected kid sidekicks [xxsid] [xxrej] [xxbad]
randtxt
"Abler Elba"
"Accorded Rocca"

table of Rob droning [xxrob]
randtxt
"Am ham-handed? Nah, Ma. Hm, a..."
"Analyticity? Lana!"

table of sci pics subjects [xxsci] [xxpics] [xxcorp] [xxlab]
randtxt
"an enol alone"
"a lab ace cabal"

table of singstuff [xxsing]
randtxt
"Ode? Redo!"
"Rock! Cor!"

table of snooty toon ads [xxtoon] [xxads] [xxfood] [xxeat]
randtxt
"Ay, a papaya"
"dessert stressed"

table of swearstuff [xxswear] [xxcuss]
randtxt
"Bad? A dab!"
"Dammit, I'm mad!"

table of undoings [xxundo]
randtxt
"Ay, CYA."
"Delete-Led!"

table of trashy art [xxart]
randtxt
"AM Enema"
"Amen, Enema"

table of university primary targets [xxu1] [xxuu1] [xxdoc]
randtxt
"B. Reverb"
"Chanah C"

table of university secondary targets [xxu2] [xxuu2]
randtxt
"A. Doda"
"A. Duda"

table of waittxt [xxwait] [xxzs]
randtxt
"Camp, mac!"
"Deed, deed, deed!"

table of wordy drow laments [xxdrow] [xxwordy]
randtxt
"Bardo...drab!"
"Deity...tied!"

table of yessies [xxyes]
randtxt
"Ee! Wowee!"
"Ha, Yah."

table of yuge baits [xxbait]
randtxt
"Avoided I? Ova[']!"
"Boo! Goob!"

table of yuge battle cries [xxyuge] [xxguy]
randtxt
"A-Lago gala!"
"A-lists? I? La!"

Ailihphilia debug Tables ends here.

---- DOCUMENTATION ----
