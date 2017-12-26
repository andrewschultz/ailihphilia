"Put it Up" by Andrew Schultz

the story headline is "Yo, Joy"

the release number is 1.

include trivial niceties by Andrew Schultz.

include Basic Screen Effects by Emily Short.

include Put It Up Tables by Andrew Schultz.

the maximum score is 6.

Fun 'Nuf is a room.

the tile lit is scenery in Fun 'Nuf. "It reads [b]PALINDROMOPOLIS THIS WAY![r]"

El Live Ville is a region.

volume unsorted

the party trap is a thing.

the sage gas is a thing.

the resto poster is a thing.

volume parser errors

Rule for printing a parser error when the latest parser error is the i beg your pardon error:
	say "Noise lesion."

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

chapter attacking

instead of attacking, say "Harm! Rah!"
[instead of attacking, say "Attack, cat? Ta!"]

chapter smelling

instead of smelling: say "Noses, on[one of]! (you don't need to smell anything in this game)[or][stopping]!"

chapter singing

instead of singing: say "Rock! Cor!"

chapter silly swearing

instead of swearing obscenely: say "[one of]Dammit, I'm mad![or]We mew![in random order]"

understand "poop" and "boob" as a mistake ("No swearing! Not even swearing done right for Palindromopolis.")

chapter waiting

instead of waiting, say "GO, dog!"

chapter xyzzying

xyzzying is an action out of world.

understand the command "xyzzy" as something new.

understand "xyzzy" as xyzzying.

carry out xyzzying:
	say "No, that's not quite a spoonerism and not quite a palindrome." instead;

volume rooms

book Fun 'Nuf

Fun 'Nuf is a room. "A sign of light blocks your view, but not your progress, to the west. Some tile lit is carved to the east."

check taking tile lit: say "It's sort of embedded into the ground. It looks nice there, anyway, and it's useful for information."

book Seer Trees

Seer Trees is east of Fun 'Nuf.

check going east in Seer Trees:
	if start rats are in seer trees, say "The seer trees watch you as if to say, you can't explore further until you got rid of the start rats!" instead;

the start rats are a plural-named thing in Seer Trees.

check taking start rats: say "There are too many, and they'd probably bite you, anyway."

check dropping party trap in Seer Trees:
	if trap-made is false, say "You have nothing to bait the trap with. With which to bait the trap." instead;
	say "The rats all try to enter the cake, and SNAP! SNAP! SNAP! The party trap explodes as the last rat enters, but fortunately all the trap-stuff is gone. The seer trees seem to nod a bit.";
	now start rats are in lalaland;
	now party trap is in lalaland;
	score-inc;
	the rule succeeds;

book Yawn Way

Yawn Way is east of Seer Trees. "Not much to do here, but State Tats is to the north, and My Gym is to the east. An alley is to the east."

book Dumb Mud

book State Tats

State Tats is south of Yawn Way. "The only way out is north."

book my gym

My Gym is north of Yawn Way. "The only way out is south."

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
		say "You evade Dave!";
		now dave is in lalaland;
		now dave-evade is true;
		score-inc;
	the rule succeeds.

understand "evade dave" as a mistake ("Dave's not here, man!") when player is not in My Gym.

book Bon Snob

Bon Snob is a room.

chapter Marge Pegram

Marge Pegram is a person in Bon Snob.

book yell alley

Yell Alley is a east of Yawn Way. "A back cab sits here, taking you where you may need to go if you ENTER it."

The back cab is scenery in Yell Alley.

chapter pulluping

pulled-up is a truth state that varies.

pulluping is an action applying to nothing.

understand the command "pullup" as something new.

understand "pullup" as pulluping.

carry out pulluping:
	if pulled-up is true, say "You already did." instead;
	unless player is in yell alley or player is in yawn way, say "This isn't the place.";
	if yell alley is unvisited, say "You can't do this yet." instead;
	say "You run back, but this time, you pull up, and you find a new location.";
	now civic level is mapped east of yawn way;
	now yawn way is mapped west of civic level;
	now civic level is mapped west of yell alley;
	now yell alley is mapped east of civic level;
	score-inc;
	the rule succeeds;

book Stope Depots

Stope Depots is a room.

[snuff funs]

book civic level

Civic Level is a room.

book work row

Work Row is south of Civic Level.

The radar is in Civic Level.

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

