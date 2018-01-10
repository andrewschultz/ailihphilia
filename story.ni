"Put it Up" by Andrew Schultz

the story headline is "Yo, Joy! Wow!"

the release number is 1.

include Trivial Niceties Z-Only by Andrew Schultz.

include Basic Screen Effects by Emily Short.

include Put It Up Tables by Andrew Schultz.

include undo output control by Erik Temple.

volume unsorted

the radar is a thing.

the gold log is a thing.

the sage gas is a thing.

the poo coop is a thing.

the bro orb is a thing.

chapter trucking

[this point is unsorted yet]

Curt is a person.

trucking is an action applying to one thing.

understand the command "truck" as something new.

understand "truck [something]" as trucking.

carry out trucking:
	if noun is not Curt, say "Wrong thing to truck." instead;
	move Curt to ZeroRez;
	score-inc;
	the rule succeeds.

chapter region and room stuff

a region has a number called max-score. a region has a number called cur-score.

Grebeberg is a region. max-score of Grebeberg is 3.

Dim Mid is a region. max-score of Dim Mid is 2.

Yelpley is a region. max-score of Yelpley is 7.

Odd Do is a region. max-score of Odd Do is 3.

[El Live Ville is a region.]

section because I'm too lazy to remember how to order the when play begins rules

when play begins:
	now ignore-wait is true;
	now debug-state is true;

volume the player

the player carries the Darer Ad.

description of player is "Flesh. Self."

description of Darer Ad is "No LOL on? SEE, REFER-EES! Do! Nod!"

check dropping:
	say "This game is not Pro-Drop. In other words, you don't need to drop anything. You may wish to USE it instead." instead;

to decide which region is mrlp:
	decide on map region of location of player;

part scoring

to score-inc:
	reg-inc mrlp;

check requesting the score:
	say "Your overall score so far is [score] of [maximum score].";
	say "Broken down by regions, you have [regres of dim mid], [regres of grebeberg], [regres of Yelpley] and [regres of odd do].";
	the rule succeeds;

to reg-inc (re - a region):
	increment cur-score of re;
	increment the score; [this is the only incidence that shouldn't be replaced]
	if debug-state is true and cur-score of mrlp > max-score of mrlp, say "DEBUG WARNING: REGION SCORE TOO HIGH!";
	if debug-state is true and score > maximum score, say "DEBUG WARNING: OVERALL SCORE TOO HIGH!"

to say regres of (re - a region):
	say "[cur-score of re] of [max-score of re] ";
	if re is odd do:
		say "extra points";
	else:
		say "for [re][if mrlp is re] (current region)[end if]"

part when play begins

when play begins:
	repeat with Q running through regions:
		increase maximum score by max-score of Q;
	if debug-state is true, say "Maximum score is [maximum score].";
	now right hand status line is "[cur-score of mrlp]/[max-score of mrlp] [score]/[maximum score]";
	now left hand status line is "[location of player] ([mrlp])";
	repeat through table of all randoms:
		sort tabnam entry in random order;

volume parser errors operations and death

part parser errors

chapter nothing to say

nothing-txt is a number that varies.

Rule for printing a parser error when the latest parser error is the i beg your pardon error:
	next-rand table of nothings;

chapter unrecognized verb

Rule for printing a parser error when the latest parser error is the didn't understand error: [?? if you are in a guess the verb zone, this should be different]
	say "I didn't recognize that action. You can type VERB or VERBS to get a list of them.";

part after command

after reading a command:
	do nothing;

part dying

to die:
	end the story saying "Offed? Deffo!"

volume verbs

chapter undoing

report undoing an action:
	say "[one of]Nixin[']...[or][']S poor. Oops![in random order]";
	rule succeeds.

chapter procedurality

to decide whether the action is procedural: [aip]
	if examining, yes;
	if attacking, yes;
	if saying yes, yes;
	if saying no, yes;
	if dropping, yes;
	if looking, yes;
	if listening, yes;
	no;

chapter refering / thinking

refer-bonus is a truth state that varies.

refering is an action applying to nothing.

understand the command "refer" as something new.

understand "refer" as refering.

carry out refering:
	if refer-bonus is false:
		say "Yes! That's a slightly more appropriate way to think, here.";
		reg-inc odd do;
		now refer-bonus is true;
	try thinking instead;

instead of thinking:
	say "[if refer-bonus is false]There might be a more appropriate way to think[else]You think for a bit[end if]."

chapter abouting

abouting is an action applying to nothing.

understand the command "about" as something new.

understand "about" as abouting.

carry out abouting:
	say "Put it Up was originally written for IFComp 2018. Like many of my games, I got the idea from Nord and Bert Couldn't Make Head or Tail of It, at least partially. Another game that gave me ideas was Nick Montfort's [b]I Palindrome I[r], part of the Apollo 18+20 collection Kevin Jackson-Mead organized. I felt there could be more that could be done with palindromes, but I didn't know what. Also, the Palindome in Kingdom of Loathing prompted my curiosity years ago. I tried to avoid palindromes it already considered, though the Dumb Mud from Heavy Rains was too good to pass up.";
	say "[line break]The result of all my work is some guess-the-verb, but hopefully with the game's general idea, you'll see what's going on.";
	say "[line break]Originally, Put it Up was part of a spoonerism game--a sort of side area--but eventually I found enough rooms and ideas it could be its own game. Whether or not it's a good game, I guess you have to decide. It doesn't have any deep philosophy, but I hope you enjoy it, and if you write games yourself, I hope it inspires you to go through with anything unusual you weren't sure if you should try. (Spoiler: you should!)";
	the rule succeeds;

chapter creditsing

creditsing is an action applying to nothing.

understand the command "credits" as something new.

understand "credits" as creditsing.

carry out creditsing:
	say "(Your name here, tester!)";
	the rule succeeds;

chapter verbing

verbing is an action applying to nothing.

understand the command "verb" as something new.
understand the command "verbs" as something new.

understand "verbs" as verbing.

carry out verbing:
	say "The four basic directions (N, S, E, W) are the main ones, along with USE, in order to get through the game. Also, in some places, specific verbs will be needed. None are terribly long, and---well, there is a pattern to them.";
	say "[line break]Standard verbs like X (EXAMINE) and LOOK also work.";
	say "[line break]GT or GO TO lets you go to a room where you've been before.";
	say "[line break]THINK gives very general hints.";
	say "[line break]Many verbs that are standard for earlier text adventures give random reject text I hope you will enjoy.";
	say "[line break]AID gives you hints for where you are. ABOUT and CREDITS tell about the game.";
	the rule succeeds;

chapter burning

instead of burning, next-rand table of burnies;

chapter saying yes

instead of saying yes, next-rand table of yessies;

chapter saying no

no-tab is a number that varies.

instead of saying no, next-rand table of noesies;

chapter attacking

instead of attacking, next-rand table of attackings;

chapter going

the new generic going reject rule is listed before the can't go that way rule in the check going rules.

check going (this is the new generic going reject rule):
	unless noun is viable, say "You can only go [list of viable directions] here." instead;

definition: a direction (called d) is viable:
	if the room d of location of player is nowhere, no;
	yes;

chapter smelling

rod-smelled is a truth state that varies;

instead of smelling:
	if player has dork rod:
		now rod-smelled is true;
		say "You might expect a rod odor, but there isn't one. OR MAYBE IT IS SO INGRAINED IN YOU, YOU NO LONGER SMELL IT." instead;
	if player is in Top Spot, say "You smell an amoral aroma." instead;
	say "Noses, on[one of]! (you don't need to smell anything in this game)[or][stopping]!"

chapter singing

instead of singing: say "Rock! Cor!"

chapter silly swearing

instead of swearing mildly, try swearing obscenely instead;

swearies is a number that varies.

instead of swearing obscenely, next-rand table of swearstuff;

chapter pooping

pooping is an action applying to nothing.

understand the commands "boob" and "poop" as something new.

understand "boob" and "poop" as pooping.

poop-boob-yet is a truth state that varies.

carry out pooping:
	say "Oath tao!";
	if poop-boob-yet is false:
		now poop-boob-yet is true;
		say "[line break][bracket]Your score has just gone up by 727 points.[close bracket]";
		wfak;
		say "Well, for the moment.[line break]";
		wfak;
		repeat with Q running from 1 to 6:
			say "[line break][bracket][if Q is 1]Wait, no, y[else]Y[end if]our score has just gone down [if Q > 1]again [end if]by 121 points.[close bracket]";
			wfak;
		reg-inc Odd Do;
		now the last notified score is the score;
	else:
		say "[line break]X2?[paragraph break]...X!";
	the rule succeeds;

chapter sleeping

instead of sleeping:
	if eels are in location of player:
		say "You manage to calm the eels down. They go away.";
		move eels to ZeroRez;
		score-inc instead;
	say "Sleeping is equivalent to waiting in this game...well, except for one place...";
	try waiting instead;

chapter waiting

instead of waiting, next-rand table of waittxt;

chapter xyzzying

xyzzying is an action out of world.

understand the command "xyzzy" as something new.

understand "xyzzy" as xyzzying.

carry out xyzzying:
	say "...[paragraph break]...[paragraph break]X." instead;

chapter useing

understand the command "use" as something new.

understand "use [something] on [something]" as useoning it with.
understand "use [something] with [something]" as useoning it with.

useoning it with is an action applying to two things.

check useoning it with:
	repeat through table of cantuse:
		if noun is use1 entry or second noun is use1 entry, say "[babble entry][line break]" instead;
	if noun is a person, say "[one of]You're not any good at using other people. In fact, if you tried, they'd wind up using YOU. Plus you don't want to be, really. There's another way. So, no[or]Using people is out[stopping]. Maybe you could use something on a person, though." instead;
	if noun is a workable or second noun is a workable:
		if ian is in worn row, say "You can't operate the machines with Ian around." instead;
		if workrow is false, say "You need to repair the machines somehow. Maybe you can do so all at once." instead;
	repeat through table of useons:
		if there is a use1 entry and noun is use1 entry:
			if there is a use2 entry and second noun is use2 entry:
				if there is a preproc entry:
					consider the preproc entry;
					if the rule failed, the rule succeeds;
				if there is a getit entry:
					now player has getit entry;
				if d2 entry is true:
					now use2 entry is in ZeroRez;
				if d1 entry is true:
					now use1 entry is in ZeroRez;
				if sco entry is true:
					score-inc;
				say "[babble entry][line break]";
				if there is a postproc entry:
					consider the postproc entry;
				if there is a getit entry and player has getit entry: [try to let "it" be defined]
					set the pronoun it to getit entry;
				else if use1 entry is in ZeroRez and use2 entry is not in ZeroRez:
					set the pronoun it to use2 entry;
				the rule succeeds;
			else if there is no use2 entry:
				say "[babble entry][line break]";
				if there is a postproc entry:
					consider the postproc entry;
				the rule succeeds;
		if there is a use2 entry and second noun is use2 entry and there is no use1 entry:
			say "[babble entry][line break]";
			if there is a postproc entry:
				consider the postproc entry;
			the rule succeeds;
		if there is a use1 entry and second noun is use1 entry:
			if there is a use2 entry and noun is use2 entry:
				try useoning second noun with noun;
				the rule succeeds;
[	repeat through table of usemaybes:
		if noun is use1 entry, say "[babble entry][line break]" instead;
	repeat through table of usemaybes:
		if second noun is use1 entry, say "[babble entry][line break]" instead;]
	say "You think of ways to do that productively, but nothing comes up." instead;

table of cantuse
use1	babble
Dave	"Dave's not useful, man."

[getit = item you get, d1/d2 = use1/use2 disappear(?) pre/post = rule to check, or rule to execute post-happening]
table of useons [xxuse]
use1	use2	getit	preproc (a rule)	postproc (a rule)	sco	d1	d2	babble
trap art	reifier	party trap	--	--	true	true	false	"The trap art crunches inside the reifier, then -- bam! Out comes what the trap art was imagined to be: a party trap. I bet it could trap more than one person, or thing, or whatever."
poo coop	gnu dung	--	--	--	true	true	true	"The gnu dung is sucked towards the poo coop. In fact, it forms a disturbing arc (I'll let you guess what type) as it seems like the dung inside the coop must be several times the volume of the coop itself. Whatever, you can now go south."
gold log	rotator	dork rod	--	--	true	true	false	"The gold log begins spinning until it cracks open--leaving a dork rod!"
dork rod	tao boat	--	--	--	true	true	false	"The dork rod melds into the Tao Boat. You step aboard. After you leave, you feel much more peaceful."

volume rooms

part Mid Dim

book Fun 'Nuf

Fun 'Nuf is a room in Mid Dim. "Some tile lit is carved out here, describing what is west and east."

chapter Flee Elf

The Flee Elf is a person in Fun 'Nuf. "A Flee Elf stands here by Evac Ave to the south."

understand "flea elf" and "flea" as a mistake("[fe0]The elf scratches for a bit, then looks embarrassed.") when player is in Fun 'Nuf and Flee Elf is in Fun 'Nuf.

understand "flex elf" and "flex" as a mistake("[fe1]The elf looks more flexible than you. It's the cap you want to concentrate on.") when player is in Fun 'Nuf and Flee Elf is in Fun 'Nuf.

understand "fleece elf" and "fleece" as a mistake("[fe2]There is much more fortune and glory in adventure! It's the cap you want to concentrate on.") when player is in Fun 'Nuf and Flee Elf is in Fun 'Nuf.

flea-elf is a truth state that varies.
flex-elf is a truth state that varies.
fleece-elf is a truth state that varies.

to say fe0:
	now flea-elf is true;

to say fe1:
	now flex-elf is true;

to say fe2:
	now fleece-elf is true;

chapter Evac Ave

Evac Ave is scenery in Fun 'Nuf. "Evac Ave leads back to where you were."

instead of entering Evac Ave:
	try going south;

elf-warn is a number that varies.

check going south in Fun 'Nuf:
	if Flee Elf is in ZeroRez, continue the action;
	if elf-warn < 3, increment elf-warn;
	say "[if elf-warn is 1]The Flee Elf encourages you to give taking the cap a shot--well, not quite TAKING it, but if you do take it, you'll be ready to go[else if elf-warn is 2]The Flee Elf encourages you to find the right way to take--er, get--er, pick up the cap[else]The Flee Elf mentions there are really only 26 simple ways to pick up the cap, if you think about it, and why not just brute force? You're not busy with anything else[end if].";
	if elf-warn < 3, the rule succeeds;
	say "[line break]Do you still wish to go through Evac Ave and turn your back on adventure?";
	if the player yes-consents:
		say "You walk south past Evac Ave through the Elim-Mile, which removes all your memories of your brief time adventuring.";
		end the story saying "NOWT WON";

chapter Pact Cap

The Pact Cap is a thing in Fun 'Nuf. "A pact cap sits here. You need to find the right way to accept it to begin your quest."

cap-pace is a truth state that varies. cap-pace is false.

cap-ever-pace is a truth state that varies. cap-ever-pace is false.

section pack cap

packing is an action applying to nothing.

understand the command "pack cap" as something new.

understand "pack cap" as packing.

carry out packing:
	if the player has the pact cap, say "You already did.";
	say "Yes, that's how to get the cap. You are ready to go! The Flee Elf salutes you and becomes, err, the FLED Elf.";
	move flee elf to ZeroRez;
	now player has the cap;
	now all cappy rooms are available;
	score-inc;
	the rule succeeds;

section pace cap

paceing is an action applying to nothing.

understand the command "pace cap" as something new.
understand the command "pacy cap" as something new.

understand "pace cap" and "pacy cap" as paceing.

carry out paceing:
	if pact cap is in Fun 'Nuf, say "That'll work later, but you need something a little different to actually TAKE the pact cap." instead;
	if cap-pace is true, say "It's already a pace cap." instead;
	if cap-ever-pace is false:
		reg-inc Dim Mid;
		now cap-ever-pace is true;
	say "You suddenly feel [if cap-pace is false]swifter[else]slower[end if].";
	now cap-pace is whether or not cap-pace is true;
	the rule succeeds;

chapter tile lit

the tile lit is scenery in Fun 'Nuf. "GREBEBERG has an arrow pointing west by it. NOT-DUD-TON has an arrow pointing "

check taking tile lit: say "It's sort of embedded into the ground. It looks nice there, anyway, and it's useful for information."

part Grebeberg

book Seer Trees

Seer Trees is west of Fun 'Nuf. It is in Grebeberg.

check going in Seer Trees:
	if noun is not east and start rats are in seer trees, say "The start rats block you from going anywhere. At least they are not banging stop pots." instead;

the start rats are a plural-named thing in Seer Trees.

check taking start rats: say "There are too many, and they'd probably bite you, anyway."

trap-made is a truth state that varies.

check dropping party trap in Seer Trees:
	if trap-made is false, say "You have nothing to bait the trap with. With which to bait the trap." instead;
	say "The rats all try to enter the cake, and SNAP! SNAP! SNAP! The party trap explodes as the last rat enters, but fortunately all the trap-stuff is gone. The seer trees seem to nod a bit.";
	now start rats are in ZeroRez;
	now party trap is in ZeroRez;
	score-inc;
	the rule succeeds;

book Cold Loc

Cold Loc is north of Seer Trees. It is in Grebeberg.

check going west in Cold Loc:
	unless player carries puce cup or puce cup is in ZeroRez:
		say "You're pushed back by worries of sickness." instead; [??]
	if player carries puce cup:
		say "The fumes push you back east." instead;

book Flu Gulf

Flu Gulf is north of Cold Loc. It is in Grebeberg.

Code Doc is a person in Flu Gulf.

book Top Spot

Top Spot is west of Flu Gulf. It is in Grebeberg.

book Dumb Mud

Dumb Mud is west of Seer Trees. It is in Grebeberg.

the gnu dung is in Dumb Mud. "Gnu dung blocks exit south from the dumb mud.". description is "You're not an expert in this sort of biology, but given what you've seen so far, it's probably from a gnu."

check going south in Dumb Mud:
	if gnu dung is in dumb mud, say "Not through the dumb mud you aren't." instead;

instead of doing something with gnu dung:
	if action is procedural, continue the action;
	say "Eewee! (You probably want to deal with the gnu dung indirectly.)"

the eels are people in Dumb Mud. "Some eels are blocking passage west."

chapter Xanax

Xanax is a thing in Dumb Mud. "Xanax sits here, on a pill lip."

check eating Xanax:
	if player is not in Yawn Way, say "There's nothing anxious-making around, yet." instead;
	say "Eewee! Well, you feel a bit more relaxed now.";
	now Xanax is in Zerorez;

the pill lip is scenery in Dumb Mud.

instead of doing something with pill lip, say "The pill lip is just there to prevent the Xanax from getting dirty on the ground."

book Le Babel

Le Babel is north of Dumb Mud. It is in Grebeberg.

book Mont Nom

Mont Nom is south of Dumb Mud. It is in Grebeberg.

book Ooze Zoo

Ooze Zoo is south of Seer Trees. It is in Grebeberg.

book Dray Yard

Dray Yard is south of Ooze Zoo. It is in Grebeberg.

book Moo Room

Moo Room is east of Dray Yard. It is in Grebeberg.

book Mire Rim

Mire Rim is west of Dumb Mud. It is in Grebeberg.

book Yack Cay

Yack Cay is south of Mire Rim. It is in Grebeberg.

book Lair Trial

Lair Trial is south of Yack Cay. It is in Grebeberg.

book Motto Bottom

Motto Bottom is east of Lair Trial. It is in Grebeberg.

book Birch Crib

Birch Crib is north of Mire Rim. It is in Grebeberg.

book Calcific Lac

Calcific Lac is north of Birch Crib. It is in Grebeberg. "A Tao Boat rests at the edge of Calcific Lac."

The Tao Boat is scenery in Calcific Lac.

The dork rod is a thing in Calcific Lac. description is "It's kind of neat and quirky, but it's not shiny enough to be the famed Dorada Rod."

book Apse Spa

Apse Spa is east of Cold Loc. It is in Grebeberg.

part Yelpley

book Yawn Way

Yawn Way is east of Fun 'Nuf. It is in Yelpley. "Not much to do here, and it's quiet enough it could be Yawling-Nil way, but State Tats is to the south, and My Gym is to the north. An alley is to the east."

book My Gym

My Gym is south of Yawn Way. It is in Yelpley. "You can go back out south to Yawn Way. There's also passage west."

chapter dave

Dave is a person in My Gym. initial appearance is "[one of]A fellow walks over to you and booms 'I'M DAVE!' You freeze, and after a few seconds, he whispers, 'Dud.'[or]Dave is here, keeping an eye on you, guarding the passage west.[stopping]". description is "Dave is big and strong and fast."

instead of doing something with dave:
	if action is procedural, continue the action;
	if current action is evadeing, continue the action;
	say "Looks like you'll need to do something special with, or to, Dave. Nothing destructive. But psych him out, somehow."

check going west in My Gym when Dave is in My Gym: say "Dave says, 'I can't let you do that, Hal. Ah!' There must be a succinct, clever way to sneak around him!" instead;

chapter evadeing

evadeing is an action applying to one thing.

understand the command "evade" as something new.

understand "evade [something]" as evadeing.

does the player mean evadeing dave: it is very likely.

dave-evade is a truth state that varies.

carry out evadeing:
	if noun is dave:
		if dave-evade is true, say "You don't need to evade Dave again.";
		say "You evade Dave! Deked! Deked!";
		now dave is in ZeroRez;
		now dave-evade is true;
		score-inc;
		now all davey rooms are available;
	else:
		say "There's only one person you need to evade in this game.";
	the rule succeeds.

understand "evade dave" as a mistake ("Dave's not here, man!") when player is not in My Gym.

book Worn Row

Worn Row is west of My Gym. It is in Yelpley. "A reifier, a reviver and a rotator are all here. They look [if workrow is false]in[end if]operable at the moment."

printed name of Worn Row is "[if workrow is true]Work[else]Worn[end if] Row"

understand "work row" and "work" as Worn Row when workrow is true.

Ian is a person in Worn Row.

a workable is a kind of thing. a workable has a number called useleft. useleft of a workable is usually 3.

the reifier is a workable in worn row.
the reviver is a workable in worn row.
the rotator is a workable in worn row.

instead of inserting it into a workable, try useoning noun on second noun instead;
instead of putting it on a workable, try useoning noun on second noun instead;

instead of switching on a workable, say "You need to USE something with [the noun]."

chapter party trap

the party trap is a thing. "It could trap more than one thing if you USE it right. That would be cool."

chapter nailing

nailing is an action applying to nothing.

understand the command "nail ian" as something new.

understand "nail ian" as nailing when player is in Worn Row and Ian is in Worn Row.

carry out nailing:
	say "Boom! There goes Ian.";
	move Ian to Zerorez;
	score-inc;
	the rule succeeds;

chapter workrowing

workrowing is an action applying to nothing.

understand the command "workrow" as something new.

understand "work row" and "workrow" as workrowing when workrow is false.

workrow is a truth state that varies.

carry out workrowing:
	now workrow is true;
	say "All the machines seem a bit shinier now. Yay!";
	score-inc;
	the rule succeeds;

understand "worn row" and "wornrow" as a mistake ("No need to revert things.") when player is in Swept Pews and workrow is true.

book State Tats

State Tats is north of Yawn Way. It is in Yelpley. "The only way out is north."

Marge Pegram is a person in State Tats. "'Hi! I'm Marge Pegram."

the trap art is a thing in State Tats. "Some trap art sits here. It's free. You might as well take it.". description is "The trap art depicts a bunch of nasty, dirty animals being trapped--it's not a real trap, but maybe it could become one."

book Dirge Grid

Dirge Grid is east of Emo Dome. It is in Yelpley. "This is another intersection in Not-Kook-Toon where you can go all four directions."

[snuff funs]

a tame mat is in Dirge Grid. "A tame mat reading BON SNOB is in your way to the south."

check going south in Dirge Grid when tame mat is in Dirge Grid:
	say "An upper-crust voice emits from the tame mat, which curls up: 'DA CAD!'[paragraph break]Maybe if it were more glued to the ground." instead;

check taking tame mat:
	say "That would be stealing." instead;

book ned's den

Ned's Den is north of Dirge Grid. It is in Yelpley.

Ned is a person in Ned's Den.

chapter denting

denting is an action applying to one thing.

understand the command "dent" as something new.

understand "dent [something]" as denting.

does the player mean denting ned: it is likely.

carry out denting:
	if noun is ned:
		say "Bam! Bye bye Ned.";
		now Ned is in ZeroRez;
		score-inc;
	the rule succeeds;

chapter tamping

tamping is an action applying to nothing.

understand the command "tamp mat" as something new.

understand "tamp mat" as tamping when player is in Dirge Grid and tame mat is in Dirge Grid.

carry out tamping:
	say "Boom! That's the idea. With the mat tamped, you walk across, and there's no more nonsense.";
	wfak;
	score-inc;
	the rule succeeds;

understand "tame mat" as a mistake ("That's not quite what to do. This is a game about palindromes, not homonyms.") when player is in Dirge Grid and tame mat is in Dirge Grid.

book Bon Snob

Bon Snob is south of Dirge Grid. It is in Yelpley.

Nat's Tan is a thing in Bon Snob. "A container of something called Nat's Tan is here."

chapter standing

standing is an action applying to one thing.

understand the command "stand" as something new.

understand "stand [something]" as standing.

carry out standing:
	if noun is nat's tan:
		say "It's tough, but you manage to stand the icky Nat's Tan as you pour it on yourself.";
		score-inc;
		now nat's tan is in lalaland.
	the rule succeeds.

book Evaded Ave

Evaded Ave is north of State Tats. It is in Yelpley.

The Puce Cup is a thing in Evaded Ave.

book Trapeze Part

Trapeze Part is west of Evaded Ave. It is in Yelpley.

book Yell Alley

Yell Alley is east of Evaded Ave. It is in Yelpley. "A back cab sits here, taking you where you may need to go if you ENTER it."

The back cab is scenery in Yell Alley.

chapter pulluping

pulled-up is a truth state that varies.

pulluping is an action applying to nothing.

understand the command "pull up" as something new.
understand the command "pullup" as something new.

understand "pull up" as pulluping.
understand "pullup" as pulluping.

carry out pulluping:
	if pulled-up is true, say "You already did." instead;
	unless player is in emo dome, say "This isn't the place[if emo dome is visited], but maybe you could do this in the Emo Dome[end if]." instead;
	say "You manage to stop yourself. The whining isn't too bad. Yeah, you can hack it here.";
	now pulled-up is true;
	score-inc;
	the rule succeeds;

book Emo Dome

Emo Dome is east of Yawn Way. It is in Yelpley.

instead of doing something in Emo Dome when pulled-up is false:
	if current action is going:
		if noun is not west and noun is not east:
			say "You're scared those places would be even worse.";
			try going emo-dir instead;
		say "You run [if noun is emo-dir]away[else if noun is opposite of emo-dir] with extra speed.";
		continue the action;
	say "You keep running [emo-dir], instead. It's too whiny in here."

emo-dir is a direction that varies. emo-dir is west.

check going to emo dome:
	if pulled-up is true:
		now emo-dir is noun;

book civic level

Civic Level is north of Emo Dome. It is in Yelpley.

The radar is in Civic Level.

book Swept Pews

Swept Pews is south of Emo Dome. It is in Yelpley.

chapter resto poster

the resto poster is a thing in Swept Pews.

chapter Tract Cart

The tract cart is a thing in Swept Pews.

book Drawl Ward

Drawl Ward is south of Swept Pews. It is in Yelpley.

book Le Falafel

Le Falafel is east of Drawl Ward. It is in Yelpley.

book Dope Pod

Dope Pod is west of Drawl Ward. It is in Yelpley.

Line Nil is in Dray Yard.

Ball Lab is north of Ned's Den. It is in Yelpley.

volume gotoing

a room can be notyet, available, cappy, davey, ratsy, pully, tamey, or gatey.

Fun 'Nuf is available.

Seer Trees, Yawn Way, State Tats and My Gym are cappy.

Worn Row is davey.

chapter gotoing

gotoing is an action applying to one visible thing.

understand the command "gt" as something new.
understand the command "goto" as something new.

understand "goto [room]" as gotoing.
understand "gt [room]" as gotoing.

to decide whether goto-available:
	yes. [obviously we don't want this to be trivial once the game's complete, but we want the code in place.]

carry out gotoing: [?? can't goto Emo Dome before running back/forth]
	unless goto-available, say "You're at a point in the game where goto isn't available." instead;
	if noun is not available, say "[noun] isn't available yet, so you can't go there." instead;
	if noun is available and noun is not visited, say "You can reach [noun], but you haven't visited there, yet. So I'm going to be a stickler and say you have to get there first." instead;
	move player to noun;
	the rule succeeds;

section gotocheck - not for release

[this is to make sure that rooms are unfolded]

when play begins:
	say "[if number of notyet rooms is 0]All rooms have a switch saying you can go there[else]Rooms that are still notyet: [list of notyet rooms][end if]."

volume metarooms

[there is a little bit of cute code here. Odd Do's score = weird stuff, but it's also where ZeroRez, the collect-all room for used objects, goes.]

Odd Do is a region.

ZeroRez is a room in Odd Do.

volume aiding

chapter aiding

aiding is an action applying to nothing.

understand the command "dial aid" as something new.
understand the command "aid" as something new.

understand "aid" as aiding.
understand "dial aid" as aiding.

dial-yet is a truth state that varies.

check aiding:
	if dial-yet is false and word number 1 in the player's command is "dial":
		say "Your 'correct' way of asking for aid nets a last lousy point. Yay![paragraph break]";
		reg-inc odd do;
		now dial-yet is true;
	if dial-yet is false:
		say ""Aid... aid...[paragraph break]";
	if done-here, say "You're done here." instead;
	say "Thinking...";

to decide whether done-here:
	if player is in yawn way, yes;
	if player is in fun 'nuf and flee elf is in zerorez, yes;
	if player is in my gym and dave is in zerorez, yes;
	if player is in seer trees and start rats are in zerorez, yes;
	if player is in calcific lac and dork rod is in zerorez, yes;
	no;

volume endgame stuff

part final questions

Table of Final Question Options (continued)
final question wording	only if victorious	topic	final response rule	final response activity
"NO responses"	true	"NO"	no-list rule	loafing
"WAIT responses"	true	"WAIT"	wait-list rule	loafing
"EMPTY command responses"	true	"EMPTY"	empty-list rule	loafing
"see what you MISSED"	true	"MISSED"	what-missed rule	loafing
--	true	"AMT"	amuse-toggle rule	loafing

loafing is an activity.

chapter random listing rules

this is the amuse-toggle rule:
	now ignore-done is whether or not ignore-done is false;
	say "Ignoring done amusements is now [on-off of ignore-done].";

this is the no-list rule:
	plowit table of noesies;

this is the wait-list rule:
	plowit table of waittxt;

this is the empty-list rule:
	plowit table of nothings;

to plowit (t - a table name):
	let count be 0;
	repeat through t:
		increment count;
		say "[count]. [randtxt entry][line break]";

part amusing and what you missed

ignore-done is a truth state that varies.

rule for amusing a victorious player:
	let count be 0;
	repeat through table of amusing stuff:
		if ignore-done is true:
			if there is no dorule entry, next;
			follow the dorule entry;
			if the rule succeeded, next;
			increment count;
		say "[funstuff entry][if ignore-done is false][line break][end if]";
	if ignore-done is true:
		say "[if count is 0]You found everything potentially funny! Way to go![else][line break]That's [count] total missed.[end if]";
	else:
		say "[line break]Toggle what you already did with AMT.";

table of amusing stuff
funstuff	dorule
"FLEA ELF?"	elf-fleaed rule
"FLEX ELF?"	elf-flexed rule
"FLEECE ELF?"	elf-fleeced rule
"SMELLing the dork rod?"	--

this is the elf-fleaed rule:
	if flea-elf is true, the rule succeeds;
	the rule fails;

this is the elf-flexed rule:
	if flex-elf is true, the rule succeeds;
	the rule fails;

this is the elf-fleeced rule:
	if fleece-elf is true, the rule succeeds;
	the rule fails;

this is the rod-smell rule:
	if rod-smelled is true, the rule succeeds;
	the rule fails;

this is the what-missed rule:
	let missed be 0;
	repeat through table of potential misses:
		follow the dorule entry;
		if the rule failed:
			say "[funstuff entry][line break]";
			increment missed;
	if missed is 0, say "You found all the points!"

table of potential misses
funstuff	dorule
"BOOB or POOP"	pb-yet rule
"REFER instead of THINK"	refer-yet rule
"DIAL AID instead of aid"	dial-yet rule

this is the dial-yet rule:
	if dial-yet is true, the rule succeeds;
	the rule fails;

this is the pb-yet rule:
	if poop-boob-yet is true, the rule succeeds;
	the rule fails;

this is the refer-yet rule:
	if refer-bonus is true, the rule succeeds;
	the rule fails;

volume beta testing - not for release

chapter wining

wining is an action applying to nothing.

understand the command "win" as something new.

understand "win" as wining.

carry out wining:
	end the story finally;
	the rule succeeds;

