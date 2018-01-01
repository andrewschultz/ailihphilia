"Put it Up" by Andrew Schultz

the story headline is "Yo, Joy"

the release number is 1.

include trivial niceties by Andrew Schultz.

include Basic Screen Effects by Emily Short.

include Put It Up Tables by Andrew Schultz.

the maximum score is 6.

Grebeberg is a region.

Dim Mid is a region.

Not-Kook-Ton is a region.

[El Live Ville is a region.]

a room has a table name called hint-name.

volume unsorted

the party trap is a thing.

the sage gas is a thing.

the resto poster is a thing.

volume the player

the player carries the Darer Ad.

description of Darer Ad is "No LOL on? SEE, REFER-EES! Do! Nod!"

check dropping:
	if noun is not party trap, say "That's not useful to drop." instead;

volume parser errors operations and death

part parser errors

Rule for printing a parser error when the latest parser error is the i beg your pardon error:
	say "[one of]Yo! Coy?[or]Noise lesion.[or]Spill, lips![in random order]"

part after command

after reading a command:
	do nothing;

part dying

to die:
	end the story saying "Offed? Deffo!"

volume verbs

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

chapter saying yes

instead of saying yes, say "Yay!"

chapter saying no

instead of saying no:
	increment no-tab;
	if no-tab > number of rows in table of noesise:
		now no-tab is 1;
		say "(cycling) ";
	choose row no-tab in table of noesies;
	say "[randtxt entry][line break]";

table of noesies
randtxt
"Oo! Noo!"
"No way? Aw, ON!"
"Hm. SMH."

chapter attacking

instead of attacking, say "Harm! Rah!" [Ye KO Pokey]
[instead of attacking, say "Attack, cat? Ta!"]

chapter going

the new generic going reject rule is listed before the can't go that way rule in the check going rules.

check going (this is the new generic going reject rule):
	unless noun is viable, say "You can only go [list of viable directions] here." instead;

definition: a direction (called d) is viable:
	if the room d of location of player is nowhere, no;
	yes;

chapter smelling

instead of smelling: say "Noses, on[one of]! (you don't need to smell anything in this game)[or][stopping]!"

chapter singing

instead of singing: say "Rock! Cor!"

chapter silly swearing

instead of swearing obscenely: say "[one of]Dammit, I'm mad![or]We mew![or]Tact, cat![in random order]"

understand "poop" and "boob" as a mistake ("No swearing! Not even swearing done right for Palindromopolis.")

chapter sleeping

instead of sleeping, say "Panic? I nap!"

chapter waiting

instead of waiting, say "GO, dog!"

chapter xyzzying

xyzzying is an action out of world.

understand the command "xyzzy" as something new.

understand "xyzzy" as xyzzying.

carry out xyzzying:
	say "...[paragraph break]...[paragraph break]X." instead;

volume rooms

part Mid Dim

book Fun 'Nuf

Fun 'Nuf is a room in Mid Dim. "Some tile lit is carved out here."

chapter Pact Cap

The Pact Cap is a thing in Fun 'Nuf. "A pact cap sits here. You need to find the right way to accept it to begin your quest."

chapter packing

understand the command "pack cap" as something new.

understand "pack cap" as packing.

carry out packing:
	if the player has the pact cap, say "You already did.";
	say "Yes, that's how to get the cap. You are ready to go!";
	now player has the cap;
	increment the score;
	the rule succeeds;

chapter tile lit

the tile lit is scenery in Fun 'Nuf. "GREBEBERG has an arrow pointing west by it. NOT-DUD-TON has an arrow pointing "

check taking tile lit: say "It's sort of embedded into the ground. It looks nice there, anyway, and it's useful for information."

part Grebeberg

book Seer Trees

Seer Trees is west of Fun 'Nuf. It is in Grebeberg.

check going in Seer Trees:
	if noun is not east and start rats are in seer trees, say "The seer trees watch you as if to say, you can't explore further until you got rid of the start rats!" instead;

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

to score-inc:
	increment the score;

book Yack Cay

Yack Cay is north of Seer Trees. It is in Grebeberg.

check going west in Yack Cay:
	unless player carries puce cup or puce cup is in lalaland:
		say "You're pushed back by worries of sickness." instead; [??]
	if player carries puce cup:
		say "The fumes
book Flu Gulf

Flu Gulf is west of Yack Cay. It is in Grebeberg.

Code Doc is a person in Flu Gulf.

book Top Spot

Top Spot is west of Seer Trees. It is in Grebeberg.

book Ooze Zoo

Ooze Zoo is south of Seer Trees. It is in Grebeberg.

book Mire Rim

Mire Rim is east of Ooze Zoo. It is in Grebeberg.

book Apse Spa

Apse Spa is east of Yack Cay. It is in Grebeberg.

book Moo Room

Moo Room is west of Ooze Zoo. It is in Grebeberg.

part Not-Kook-Ton

book Yawn Way

Yawn Way is east of Fun 'Nuf. It is in Not-Kook-Ton. "Not much to do here, and it's quiet enough it could be Yawling-Nil way, but State Tats is to the south, and My Gym is to the north. An alley is to the east."

book My Gym

My Gym is north of Yawn Way. It is in Not-Kook-Ton. "The only way out is south."

chapter dave

Dave is a person in My Gym. initial appearance is "[one of]A fellow walks over to you and booms 'I'M DAVE!' You freeze, and after a few seconds, he whispers, 'Dud.'[or]Dave is here, keeping an eye on you.[stopping]". description is "Dave is big and strong and fast."

instead of doing something with dave:
	if action is procedural, continue the action;
	say "Looks like you'll need to do something special with, or to, Dave. Nothing destructive. But psych him out, somehow."

chapter resto poster

a resto poster is a thing in My Gym.

check taking resto poster: say "Dave says, 'I can't let you do that, Hal. Ah!' There must be a succinct, clever way to sneak around him!" instead;

chapter evadeing

evadeing is an action applying to one thing.

understand the command "evade" as something new.

understand "evade [something]" as evadeing.

dave-evade is a truth state that varies.

carry out evadeing:
	if noun is dave:
		if dave-evade is true, say "You don't need to evade Dave again.";
		say "You evade Dave! Deked! Deked!";
		now dave is in ZeroRez;
		now dave-evade is true;
		score-inc;
	the rule succeeds.

understand "evade dave" as a mistake ("Dave's not here, man!") when player is not in My Gym.

book State Tats

State Tats is south of Yawn Way. It is in Not-Kook-Ton. "The only way out is north."

book Stope Depots

Stope Depots is east of Emo Dome. It is in Not-Kook-Ton.

[snuff funs]

book Bon Snob

Bon Snob is south of Stope Depots. It is in Not-Kook-Ton.

chapter Marge Pegram

Marge Pegram is a person in Bon Snob.

book Evaded Ave

Evaded Ave is east of Stope Depots. It is in Not-Kook-Ton.

The Puce Cup is a thing in Evaded Ave.

book yell alley

Yell Alley is north of Evaded Ave. It is in Not-Kook-Ton. "A back cab sits here, taking you where you may need to go if you ENTER it."

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

Emo Dome is east of Yawn Way. It is in Not-Kook-Ton.

Xanax is a thing in Emo Dome.

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

Civic Level is north of Emo Dome. It is in Not-Kook-Ton.

book work row

Work Row is south of Emo Dome. It is in Not-Kook-Ton.

The radar is in Civic Level.

volume metarooms

metarooms is a region.

ZeroRez is a room in metarooms.

volume hinting

table of donehere
hint-loc	fail-rule	hint-text
Seer Trees	rats-there rule	"You cleared the start rats, so you should be done here."

chapter seer trees hinting

hint-name of Seer Trees is table of seertrees hints.

table of seertrees hints
hint-rule	hint-text
--	"You need to clear the start rats."
need-party rule	"Some sort of trap would be nice."
need-party rule	"Did you find a party trap yet?"
party-unfilled rule	"You need to fill a party trap with something."
party-unfilled rule	"Something disgusting. What might have something disgusting that works with the party trap?"
party-unfilled rule	"The rash womb/rush womb in Rank Bloom."
party-unfilled rule	"PUT TRAP IN WOMB."
rats-there rule	"With the cake, you can DROP THE CAKE here in Seer Trees."

this is the need-party rule: [?? placeholder is wrong]
	if party trap is in Fun 'Nuf, the rule succeeds;
	the rule fails;

this is the party-unfilled rule:
	if trap-made is false, the rule succeeds;
	the rule fails;

this is the rats-there rule:
	if rats are in seer trees, the rule succeeds;
	the rule fails;

chapter My Gym hinting

hint-name of My Gym is table of mygym hints.

table of mygym hints
hint-rule	hint-text
--	"Dave is tough to get around. You need to find a way to do so."
--	"You don't need a special item, just the right verb."
--	"This is a palindrome area. Dave backwards is EVAD..."
--	"EVADE DAVE lets you evade Dave."

chapter State Tats hinting

hint-name of State Tats is table of statetats.

table of statetats
hint-rule	hint-text
--	"You obviously want to get a tattoo."

