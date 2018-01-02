"Put it Up" by Andrew Schultz

the story headline is "Yo, Joy"

the release number is 1.

include trivial niceties by Andrew Schultz.

include Basic Screen Effects by Emily Short.

include Put It Up Tables by Andrew Schultz.

the maximum score is 7.

volume unsorted

the sage gas is a thing.

chapter region and room stuff

a region has a number called max-score. a region has a number called cur-score.

Grebeberg is a region. max-score of Grebeberg is 1.

Dim Mid is a region. max-score of Dim Mid is 2.

Not-Kook-Ton is a region. max-score of Not-Kook-Ton is 4.

[El Live Ville is a region.]

a room has a table name called hint-name.

volume the player

the player carries the Darer Ad.

description of Darer Ad is "No LOL on? SEE, REFER-EES! Do! Nod!"

check dropping:
	say "This game is not Pro-Drop. In other words, you don't need to drop anything. You may wish to USE it instead." instead;

to decide which region is mrlp:
	decide on map region of location of player;

part scoring

to score-inc:
	increment cur-score of mrlp;
	increment the score; [this is the only incidence that shouldn't be replaced]
	if debug-state is true and cur-score of mrlp > max-score of mrlp, say "DEBUG WARNING: REGION SCORE TOO HIGH!";
	if debug-state is true and score > maximum score, say "DEBUG WARNING: OVERALL SCORE TOO HIGH!"

check requesting the score:
	say "Your overall score so far is [score] of [maximum score].";
	say "Broken down by regions, you have [regres of dim mid], [regres of grebeberg] and [regres of not-kook-ton].";
	the rule succeeds;

to say regres of (re - a region):
	say "[cur-score of re] of [max-score of re] for [re][if mrlp is re] (current region)[end if]"

part when play begins

when play begins:
	if debug-state is true:
		let reg-sum be 0;
		repeat with Q running through regions:
			increase reg-sum by max-score of Q;
		say "[if reg-sum is not the maximum score]Region sum ([reg-sum]) does not equal maximum score ([maximum score])[else]Region sum maximum scores match overall maximum score[end if].";
	now right hand status line is "[cur-score of mrlp]/[max-score of mrlp] [score]/[maximum score]";
	now left hand status line is "[location of player] ([mrlp])"

volume parser errors operations and death

part parser errors

Rule for printing a parser error when the latest parser error is the i beg your pardon error:
	say "[one of]Dud![or]Yo! Coy?[or]Noise lesion.[or]Spill, lips![in random order]"

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

no-tab is a number that varies.

instead of saying no:
	increment no-tab;
	if no-tab > number of rows in table of noesies:
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

instead of swearing obscenely: say "[one of]Dammit, I'm mad![or]We mew![or]Tact, cat![or]Not on![in random order]"

understand "poop" and "boob" as a mistake ("Such a word is particularly (in)appropriate for Grebeberg and Not-Kook-Ton.")

chapter sleeping

the eels are people in Dumb Mud.

instead of sleeping:
	if eels are in location of player:
		say "You manage to calm the eels down. They go away.";
		move eels to ZeroRez;
		score-inc instead;
	say "Sleeping is equivalent to waiting in this game...well, except for one place...";
	try waiting instead;

chapter waiting

instead of waiting, say "[one of]GO, dog![or]Don't nod![or]Panic? I nap![in random order]"

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

cap-pace is a truth state that varies. cap-pace is false.

cap-ever-pace is a truth state that varies. cap-ever-pace is false.

section pack cap

packing is an action applying to nothing.

understand the command "pack cap" as something new.

understand "pack cap" as packing.

carry out packing:
	if the player has the pact cap, say "You already did.";
	say "Yes, that's how to get the cap. You are ready to go!";
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
		score-inc;
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

book Yack Cay

Yack Cay is north of Seer Trees. It is in Grebeberg.

check going west in Yack Cay:
	unless player carries puce cup or puce cup is in ZeroRez:
		say "You're pushed back by worries of sickness." instead; [??]
	if player carries puce cup:
		say "The fumes push you back east." instead;

book Flu Gulf

Flu Gulf is west of Yack Cay. It is in Grebeberg.

Code Doc is a person in Flu Gulf.

book Le Babel

Le Babel is west of Seer Trees. It is in Grebeberg.

Xanax is a thing in Le Babel. "Xanax sits here, on a pill lip."

check eating Xanax:
	if player is not in Yawn Way, say "There's nothing anxious-making around, yet." instead;
	say "Gulp!

the pill lip is scenery in Le Babel.

instead of doing something with pill lip, say "The pill lip is just there to prevent the Xanax from getting dirty on the ground."

book Top Spot

Le Babel is west of Top Spot. It is in Grebeberg.

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

My Gym is south of Yawn Way. It is in Not-Kook-Ton. "You can go back out south to Yawn Way. There's also passage west."

chapter dave

Dave is a person in My Gym. initial appearance is "[one of]A fellow walks over to you and booms 'I'M DAVE!' You freeze, and after a few seconds, he whispers, 'Dud.'[or]Dave is here, keeping an eye on you, guarding the passage west.[stopping]". description is "Dave is big and strong and fast."

instead of doing something with dave:
	if action is procedural, continue the action;
	say "Looks like you'll need to do something special with, or to, Dave. Nothing destructive. But psych him out, somehow."

check going west in My Gym when Dave is in My Gym: say "Dave says, 'I can't let you do that, Hal. Ah!' There must be a succinct, clever way to sneak around him!" instead;

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
		now all davey rooms are available;
	else:
		say "There's only one person you need to evade in this game.";
	the rule succeeds.

understand "evade dave" as a mistake ("Dave's not here, man!") when player is not in My Gym.

book Worn Row

Worn Row is west of My Gym. It is in Not-Kook-Ton.

printed name of Worn Row is "[if workrow is true]Work[else]Worn[end if] Row"

understand "work row" and "work" as Worn Row when workrow is true.

Ian is a person in Worn Row.

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

chapter resto poster

a resto poster is a thing in Worn Row.

chapter Tract Cart

The tract cart is a thing in Worn Row.

book State Tats

State Tats is north of Yawn Way. It is in Not-Kook-Ton. "The only way out is north."

the trap art is a thing in State Tats.

the party trap is a thing.

Marge Pegram is a person in State Tats.

book Stope Depots

Stope Depots is east of Emo Dome. It is in Not-Kook-Ton. "This is another intersection in Not-Kook-Toon where you can go all four directions."

[snuff funs]

a tame mat is in Stope Depots. "A tame mat reading BON SNOB is in your way to the south."

check going south in Stope Depots when tame mat is in Stope Depots:
	say "An upper-crust voice emits from the tame mat, which curls up: 'DA CAD!'[paragraph break]Maybe if it were more glued to the ground." instead;

check taking tame mat:
	say "That would be stealing." instead;

chapter tamping

tamping is an action applying to nothing.

understand the command "tamp mat" as something new.

understand "tamp mat" as tamping when player is in stope depots and tame mat is in stope depots.

carry out tamping:
	say "Boom! That's the idea. With the mat tamped, you walk across, and there's no more nonsense.";
	wfak;
	score-inc;
	the rule succeeds;

understand "tame mat" as a mistake ("That's not quite what to do. This is a game about palindromes, not homonyms.") when player is in Stope Depots and tame mat is in Stope Depots.

book Bon Snob

Bon Snob is south of Stope Depots. It is in Not-Kook-Ton.

chapter Marge Pegram

Marge Pegram is a person in Bon Snob.

book Evaded Ave

Evaded Ave is east of Stope Depots. It is in Not-Kook-Ton.

The Puce Cup is a thing in Evaded Ave.

book Le Falafel

Le Falafel is south of Evaded Ave.

book Yell Alley

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

The radar is in Civic Level.

book Swept Pews

Swept Pews is south of Emo Dome. It is in Not-Kook-Ton.

the resto poster is a thing in Swept Pews.

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

volume endgame stuff

volume beta testing - not for release

chapter wining

wining is an action applying to nothing.

understand the command "win" as something new.

understand "win" as wining.

carry out wining:
	end the story finally;
	the rule succeeds;

