"Put it Up" by Andrew Schultz

[blurb for comp = A *GASP* SAGA]

the story headline is "Yo, Joy! Wow!"

the release number is 1.

include Trivial Niceties Z-Only by Andrew Schultz.

include Basic Screen Effects by Emily Short.

include Put It Up Debug Tables by Andrew Schultz.

include undo output control by Erik Temple.

volume unsorted

the x-ite tix are a plural-named thing. understand "xite" and "xite tix" as x-ite tix.

Madam Sniffins is a person.

Yuge Guy is a proper-named person. understand "king/nik" and "king nik" as Yuge Guy.

the radar is a thing.

the gold log is a thing.

the sage gas is a thing.

the poo coop is a thing.

the bro orb is a thing.

to win-finally:
	say "You head off to saner arenas for a while, just to reflect on all you did.";
	end the story finally saying "Deified! Deified!"

the stink knits are a thing.

the brag garb is a thing.

the UFO Tofu is an edible thing.

the Mayo Yam is an edible thing.

the mush sum is an edible thing.

the gift fig is an edible thing.

check eating an edible thing: say "Food? Oof! (You don't need to eat anything to win. Food may be more useful for other people.)[paragraph break]" instead;

chapter region and room stuff

a region has a number called max-score. a region has a number called cur-score.

Grebeberg is a region. max-score of Grebeberg is 6.

Dim Mid is a region. max-score of Dim Mid is 2.

Yelpley is a region. max-score of Yelpley is 13.

Odd Do is a region. max-score of Odd Do is 3.

[El Live Ville is a region.]

volume the player

the player carries the Darer Ad.

description of player is "Flesh. Self."

description of Darer Ad is "No LOL on? SEE, REFER-EES! Do! Nod!"

after examining the Darer Ad for the first time:
	say "Well, you need something with a bit more concrete advice. Maybe you'll find it quickly enough.";
	continue the action;

check dropping:
	say "This game is not Pro-Drop. In other words, you don't need to drop anything. You may wish to USE it instead." instead;

to decide which region is mrlp:
	decide on map region of location of player;

after looking (this is the make available for goto rule):
	if location of player is not emo dome, now location of player is available;
	continue the action;

section set o notes

the set o notes is a thing. description is "There's some general vague advice about making a North Tron to defeat the Diktat Kid, but first you'll have to defeat Madam Sniffins and the Yuge Guy, King Nik. The Set O Notes also points out you'll need to find items and use them together, but since you're on a quest, you already sort of knew that."

after examining set o notes for the first time, say "Maybe you'll get something even more detailed than the Set O Notes later."

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
	if debug-state is true, say "DEBUG NOTE: Maximum score is [maximum score].";
	now right hand status line is "[cur-score of mrlp]/[max-score of mrlp] [score]/[maximum score]";
	now left hand status line is "[location of player] ([mrlp])";
	repeat through table of all randoms:
		sort tabnam entry in random order;
	say "You check your mail as you go out to the grocery store. A junk magazine! It's been so long since you got one, you're almost intrigued.[wfak-d]";
	say "It just says GAME MAG. But the cover isn't telling you to actually buy anything, so you look inside. You have a whole backlog of games, but you can just recycle it when you get to the store.[wfak-d]";
	say "Nothing really catches your mind until you see a DARER AD. It's really all caps, and it has a lot of messages.certainly loud.[wfak-d]";
	say "EVIL'S LIVE![wfak-d]";
	say "LIVE DEVIL![wfak-d]";
	say "BOSSES! SOB![wfak-d]";
	say "Then you hear a voice say 'Pass, sap!' You look up, and you're no longer on the way to the store. You're somewhere else. With someone else: a Flee Elf, who looks at you and says 'You'll do, I guess. The first thing to do is, figure how to take this cap.'[wfak-d]"

volume parser errors operations and death

check saving the game: say "Eh, cache...";

part parser errors

chapter nothing to say

nothing-txt is a number that varies.

Rule for printing a parser error when the latest parser error is the i beg your pardon error:
	next-rand table of nothings;

chapter unrecognized verb

Rule for printing a parser error when the latest parser error is the didn't understand error:
	say "[if gtv]You do need a special verb here, but not that one. It may not be a standard one, but given the game's theme, I bet you can figure it out. If youwant standard verbs, y[else]I didn't recognize that action. Y[end if]ou can type VERB or VERBS to get a list of them.";

to decide whether gtv:
	if ian is in location of player, yes;
	if dave is in location of player, yes;
	if curt is in location of player, yes;
	no;

part after command

after reading a command:
	do nothing;

part dying

to die:
	end the story saying "Offed? Deffo! / Story Rots! / Stung! Nuts!"

volume verbs

chapter undoing

report undoing an action:
	say "[one of]Nixin[']...[or][']S poor. Oops![or]Time: remit.[in random order]";
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

understand the command "v" as something new.
understand the command "verb" as something new.
understand the command "verbs" as something new.

understand "verbs" as verbing.
understand "verb" as verbing.
understand "v" as verbing.

carry out verbing:
	say "The four basic directions (N, S, E, W) are the main ones, along with USE, in order to get through the game. Also, in some places, specific verbs will be needed. None are terribly long, and---well, there is a pattern to them.";
	say "[line break]Standard verbs like X (EXAMINE) and LOOK also work.";
	say "[line break]GT or GO TO lets you go to a room where you've been before.";
	say "[line break]THINK gives very general hints.";
	say "[line break]Many verbs that are standard for earlier text adventures give random reject text I hope you will enjoy.";
	say "[line break]AID gives you hints for where you are. ABOUT and CREDITS tell about the game.";
	if wr-short-note is true and player is in worn row and workrow is true, say "[line break]REV, ROT and REI use an item on the reviver, rotator and reifier, respectively.";
	the rule succeeds;

wr-short-note is a truth state that varies.

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
	if noun is outside and number of viable directions is 1, try going a random viable direction instead;
	if noun is inside, say "You don't ever need to use IN in the game. Just the four cardinal directions." instead;
	unless noun is viable, say "You can only go [list of viable directions] here." instead;

definition: a direction (called d) is viable:
	if the room d of location of player is nowhere, no;
	yes;

check going (this is the reject noncardinal directions rule):
	if noun is diagonal, say "You don't need diagonal directions in this game." instead;
	if noun is up or noun is down, say "You never need to go up or down in this game." instead;

the reject noncardinal directions rule is listed first in the check going rulebook.

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
		score-inc instead; [+grebeberg]
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
		if wr-short-note is false:
			say "(NOTE: You can abbreviate this command with ROT, REI and REV for the respective machines, later.)[paragraph break]";
			now wr-short-note is true;
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
					if there is a reg-plus entry:
						reg-inc reg-plus entry;
					else:
						sco-inc; [+ignore]
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
use1	use2	getit	preproc (a rule)	postproc (a rule)	sco	d1	d2	babble	regplus
trap art	reifier	party trap	--	--	true	true	false	"The trap art crunches inside the reifier, then -- bam! Out comes what the trap art was imagined to be: a party trap. I bet it could trap more than one person, or thing, or whatever."	yelpley
party trap	start rats	gift fig	--	--	true	true	true	"The rats all try to enter the trap, and SNAP! SNAP! SNAP! The party trap explodes as the last rat enters, but fortunately all the trap-stuff is gone. The seer trees seem to nod a bit. You watch as a gift fig rolls out. You take it."	grebeberg
poo coop	gnu dung	--	--	--	true	true	true	"The gnu dung is sucked towards the poo coop. In fact, it forms a crass arc as it seems like the dung inside the coop must be several times the volume of the coop itself. Whatever, you can now go south."	grebeberg
gold log	rotator	dork rod	--	--	true	true	false	"The gold log begins spinning until it cracks open--leaving a dork rod!"	yelpley
dork rod	tao boat	--	--	--	true	true	false	"The dork rod melds into the Tao Boat. You step aboard. After you leave, you feel much more peaceful."	grebeberg
stink knits	rotator	brag garb	--	wear-garb rule	true	true	false	"The stink knits fit into the rotator without stuffing them too much. After some spinning, you look in again and--they're something much shinier now. Brag garb!"	yelpley
UFO Tofu	Mayo Yam	Mush Sum	in-mont-nom rule	--	true	true	true	"The UFO Tofu and mayo yam blend together in a most unholy fashion, but the magic of Mont Nom kicks in, and they become ... a surprisingly nice smelling and looking mush sum."	grebeberg
Eroded Ore	reviver	Ore Zero	--	--	true	true	true	"The reviver whirs as you drop the eroded ore in, and ... out pops some shiny Ore Zero!"	yelpley
sage gas	tenet	tenet	--	--	true	true	false	"With the sage gas, you're able to see a bit deeper into the tenet."	grebeberg

this is the in-mont-nom rule:
	if location of player is mont nom, the rule succeeds;
	say "Eww! Maybe if you were somewhere more magical with food, it would work.";
	the rule fails;

this is the wear-garb rule:
	now player wears the brag garb;
	the rule succeeds;

volume rooms

part Mid Dim

book Fun 'Nuf

Fun 'Nuf is a room in Mid Dim. "[if elite tile is in fun 'nuf]Elite tile has replaced the old tile lit. Probably all that's left to do is to read it, or just go back south through the Tix Exit[else]Some tile lit is carved out here, describing what is the various directions[xit-ave][end if]."

to say xit-ave:
	say ". The [if tix exit is in fun 'nuf]Tix Exit prevents passage back south[else]Evac Ave is south, if you want to chicken out[end if]."
the north tron is scenery. "It seems to have pushed a passage north here in Fun [']Nuf. Do you have the guts to follow it to your destiny?"

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

instead of entering Evac Ave, try going south.

elf-warn is a number that varies.

the Tix Exit is scenery.

check going in Fun 'Nuf:
	if noun is south:
		if player has X-ITE TIX, try useoning X-ITE TIX with Tix Exit instead;
		if Tix Exit is in Fun 'Nuf, say "The Tix Exit blocks your way to where Evac Ave was. I guess you're stuck questing, here." instead;
		if elf-warn < 3, increment elf-warn;
		say "[if elf-warn is 1]The Flee Elf encourages you to give taking the cap a shot--well, not quite TAKING it, but if you do take it, you'll be ready to go[else if elf-warn is 2]The Flee Elf encourages you to find the right way to take--er, get--er, pick up the cap[else]The Flee Elf mentions there are really only 26 simple ways to pick up the cap, if you think about it, and why not just brute force? You're not busy with anything else[end if].";
		if elf-warn < 3, the rule succeeds;
		say "[line break]Do you still wish to go through Evac Ave and turn your back on adventure?";
		if the player yes-consents:
			say "The Flee Elf cries 'Fool! Aloof!' as you walk south past Evac Ave through the Elim-Mile, which removes all your memories of your brief time adventuring.";
			end the story saying "NOWT WON";
	if Flee Elf is in Fun 'Nuf:
		if noun is west or noun is east, say "'Keen! Eek!' the Flee Elf stops you. 'You need to figure out the right way to take the Cap, for a place like Grebeberg or Yelpley.'" instead;
	if noun is north and north tron is not in Fun 'Nuf, say "Not until you built the North-Tron." instead;

chapter Pact Cap

The Pact Cap is a wearable thing in Fun 'Nuf. "A pact cap sits here. You need to find the right way to accept it to begin your quest."

check taking off the pact cap: say "No, you...uh, made a pact." instead;

cap-pace is a truth state that varies. cap-pace is false.

cap-ever-pace is a truth state that varies. cap-ever-pace is false.

check taking pact cap: say "The Flee Elf shakes its head. 'Too direct. You're not doing it right. Don't [b]TAKE[r] it, precisely.'" instead;

section pack cap

packing is an action applying to nothing.

understand the command "pack cap" as something new.

understand "pack cap" as packing.

carry out packing:
	if the player has the pact cap, say "You already did.";
	say "Yes, that's how to get the cap. You are ready to go![paragraph break]'Good job! Here's a set o['] notes to replace that darer ad,' the Flee Elf says. It salutes you before becoming, err, the FLED Elf. Where the elf went, a big TIX EXIT sprouts up. You don't have any tickets or anything, though, so you'll have to worry about that later.";
	move flee elf to ZeroRez;
	now Tix Exit is in ZeroRez;
	now darer ad is in ZeroRez;
	now player has set o notes;
	now player wears the cap;
	now all cappy rooms are available;
	score-inc; [+dim mid]
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

the tile lit is scenery in Fun 'Nuf. "It's a rough compass, with GREBEBERG west by it, YELPLEY east, EVAC AVE south and DIRGE GRID north. You can't seem to go [if flee elf is in ZeroRez]south and [end if]north, though."

check taking tile lit: say "It's sort of embedded into the ground. It looks nice there, anyway, and it's useful for information."

chapter elite tile

the elite tile is scenery. "Done? Nod![line break]Nif-T-Fin!"

chapter back cab

The back cab is a thing. description is "It's here and waiting to take you, uh, back.". "A back cab waits here to the south, where the Evac-Ave once was, to take you home."

instead of entering back cab, win-finally instead;

book Dirge Grid

Dirge Grid is a room in Mid Dim. "The only way back is south[if diktat kid is in dirge grid], but you can't really run away from the Diktat Kid[else], and you might as well go that way, now you've vanquished the Diktat Kid[end if]."

Diktat Kid is a proper-named person in Dirge Grid.

part Grebeberg

book Seer Trees

Seer Trees is west of Fun 'Nuf. It is in Grebeberg.

check going in Seer Trees:
	if noun is not east and start rats are in seer trees, say "The start rats block you from going anywhere. At least they are not banging stop pots." instead;

the start rats are a plural-named thing in Seer Trees.

check taking start rats: say "There are too many, and they'd probably bite you, anyway." instead;

check dropping party trap in Seer Trees: try useoning party trap with start rats instead;

book Cold Loc

Cold Loc is north of Seer Trees. It is in Grebeberg.

check going north in Cold Loc: [to flu gulf]
	unless player carries puce cup or puce cup is in ZeroRez:
		say "You're pushed back by worries of sickness." instead;
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

chapter Demo Med

a Demo Med is a thing in Dumb Mud. "A demo med sits here, on a pill lip.". description is "You're not sure what it could be. Xanax? Whatever, you feel calmer just looking at it."

check eating Demo Med:
	if player is not in Yawn Way, say "There's nothing anxious-making around, yet." instead;
	say "Eewee! Well, you feel a bit more relaxed now.";
	now Demo Med is in Zerorez;

the pill lip is scenery in Dumb Mud.

instead of doing something with pill lip, say "The pill lip is just there to prevent the demo med from getting dirty on the ground."

book Le Babel

Le Babel is north of Dumb Mud. It is in Grebeberg.

book Mont Nom

Mont Nom is south of Dumb Mud. It is in Grebeberg.

book Ooze Zoo

Ooze Zoo is south of Seer Trees. It is in Grebeberg. "[if etage gate is in ooze zoo]An etage gate blocks the way south--and probably will until you prove yourself worthy to get by. But you can still go back north[else]You can go north to the Seer Trees, or south to [s-dray][end if]."

to say s-dray:
	say "[if dray yard is visited]Dray Yard[else]a yard[end if]"

chapter etage gate

the Etage Gate is scenery in Ooze Zoo.

book Dray Yard

Dray Yard is south of Ooze Zoo. It is in Grebeberg.

Line Nil is in Dray Yard.

book Moo Room

Moo Room is east of Dray Yard. It is in Grebeberg.

book Mire Rim

Mire Rim is west of Dumb Mud. It is in Grebeberg.

The Eroded Ore is in Mire Rim.

The Ore Zero is a thing.

book Yack Cay

Yack Cay is south of Mire Rim. It is in Grebeberg.

book Lair Trial

Lair Trial is south of Yack Cay. It is in Grebeberg.

book Motto Bottom

Motto Bottom is east of Lair Trial. It is in Grebeberg.

chapter tenet

The tenet is a thing in Motto Bottom.

check taking tenet: say "'Egad! Adage!' you think to yourself. The tenet seems too cliche, and you don't have the wisdom to give it any intrinsic value back. Well, not yet." instead;

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

Worn Row is west of My Gym. It is in Yelpley. "[if workrow is true]Three machines are here[else if wordrow is true]A library is here, just full of books[else]It's pretty empty here, but maybe you could make it a bit more active and cheery[end if]."

printed name of Worn Row is "[if wordrow is true]Word[else if workrow is true]Work[else]Worn[end if] Row"

understand "work row" and "work" as Worn Row when workrow is true.
understand "word row" and "word" as Worn Row when wordrow is true.

Ian is a person in Worn Row.

chapter workables

a workable is a kind of thing. a workable has a number called useleft. useleft of a workable is usually 3.

the reifier is a workable.
the reviver is a workable.
the rotator is a workable.

instead of inserting into:
	if second noun is a workable, try useoning noun with second noun instead;
	continue the action;

instead of putting on:
	if second noun is a workable, try useoning noun with second noun instead;
	continue the action;

instead of switching on a workable, say "You need to USE something with [the noun]."

section reiing

reiing is an action applying to one thing.

understand the command "rei" as something new.

understand "rei [something]" as reiing when player is in worn row and reifier is not off-stage.

carry out reiing:
	if reifier is not in worn row, say "You need to bring back Work Row." instead;
	try useoning noun with reifier instead;

section reving

reving is an action applying to one thing.

understand the command "rev" as something new.

understand "rev [something]" as reving when player is in worn row and reviver is not off-stage.

carry out reving:
	if reviver is not in worn row, say "You need to bring back Work Row." instead;
	try useoning noun with reviver instead;

section roting

roting is an action applying to one thing.

understand the command "rot" as something new.

understand "rot [something]" as roting when player is in worn row and rotator is not off-stage.

carry out roting:
	if reifier is not in worn row, say "You need to bring back word row." instead;
	try useoning noun with rotator instead;

chapter books

a book is a kind of thing.

TO IDIOT is a proper-named book.
GIGOLO GIG is a proper-named book.
FOREVER OF is a proper-named book.
NULL ILLUN is a proper-named book.
ERA FARE is a proper-named book.

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

understand "work row" and "workrow" as workrowing when player is in worn row.

workrow is a truth state that varies.

ever-workrow is a truth state that varies.

carry out workrowing:
	if ian is in worn row, say "That'll work when Ian is gone." instead;
	if workrow is true, say "You're already in Work Row." instead;
	now workrow is true;
	now wordrow is false;
	say "Three machines [one of][or]re[stopping]appear[if wordrow is true], replacing the books[end if].";
	if ever-workrow is false, score-inc;
	now ever-workrow is true;
	now all workables are in worn row;
	now all books in worn row are in TempMet;
	the rule succeeds;

understand "worn row" and "wornrow" as a mistake ("No need to revert things.") when shouldnt-revert.

to decide whether shouldnt-revert:
	unless player is in Worn Row, no;
	if workrow is false and wordrow is false, no;
	yes;

chapter wordrowing

wordrowing is an action applying to nothing.

understand the command "wordrow" as something new.

understand "word row" and "wordrow" as wordrowing when player is in worn row.

wordrow is a truth state that varies.

ever-wordrow is a truth state that varies.

carry out wordrowing:
	if ian is in worn row, say "That'll work when Ian is gone." instead;
	if wordrow is true, say "You're already in Word Row." instead;
	now wordrow is true;
	now workrow is false;
	now all workables are in TempMet;
	if ever-wordrow is false, score-inc;
	now ever-wordrow is true;
	say "A bunch of books appear.";
	now all books in TempMet are in Worn Row;
	the rule succeeds;

understand "worn row" and "wornrow" as a mistake ("No need to revert things.") when player is in Swept Pews and workrow is false and wordrow is false.

book State Tats

State Tats is north of Yawn Way. It is in Yelpley. "The only way out is north."

the trap art is a thing in State Tats. "Some trap art sits here. It's free. You might as well take it.". description is "The trap art depicts a bunch of nasty, dirty animals being trapped--it's not a real trap, but maybe it could become one."

book Toll Lot

Toll Lot is east of Emo Dome. It is in Yelpley. "While it's easy enough to go back east, you may have to do something special to go north or south."

[snuff funs]

a tame mat is in Toll Lot. "A tame mat reading BON SNOB is in your way to the south."

check going south in Toll Lot when tame mat is in Toll Lot:
	say "An upper-crust voice emits from the tame mat, which curls up: 'DA CAD!'[paragraph break]Maybe if it were more glued to the ground." instead;

check taking tame mat:
	say "That would be stealing." instead;

book ned's den

Ned's Den is north of Toll Lot. It is in Yelpley.

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

understand "tamp mat" as tamping when player is in Toll Lot and tame mat is in Toll Lot.

carry out tamping:
	say "Boom! That's the idea. With the mat tamped, you walk across, and there's no more nonsense.";
	wfak;
	score-inc;
	the rule succeeds;

understand "tame mat" as a mistake ("That's not quite what to do. This is a game about palindromes, not homonyms.") when player is in Toll Lot and tame mat is in Toll Lot.

book Bon Snob

Bon Snob is south of Toll Lot. It is in Yelpley.

Nat's Tan is a thing in Bon Snob. "A container of something called Nat's Tan is here."

Le Falafel is a proper-named thing in Bon Snob.

chapter standing

standing is an action applying to one thing.

understand the command "stand" as something new.

understand "stand [something]" as standing.

carry out standing:
	if noun is nat's tan:
		say "It's tough, but you manage to stand the icky Nat's Tan as you pour it on yourself.";
		score-inc;
		now nat's tan is in ZeroRez;
	the rule succeeds.

book Evaded Ave

Evaded Ave is north of State Tats. It is in Yelpley.

The Puce Cup is a thing in Evaded Ave.

book Trapeze Part

Trapeze Part is west of Evaded Ave. It is in Yelpley.

book Yell Alley

Yell Alley is east of Evaded Ave. It is in Yelpley.

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
	now emo dome is available;
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

check going north in emo dome:
	say "The Civic Level is, like, double-intensity. Just the name leaves you pondering you probably aren't ready for it yet until you're, like, totally ready. As you get close, you are intimidated by 'Go jog!' and think, hang? Nah." instead;
	if Civic Level is unvisited, say "You step into what may be your final challenge in Yelpley..."

book civic level

Civic Level is north of Emo Dome. It is in Yelpley.

book Swept Pews

Swept Pews is south of Emo Dome. It is in Yelpley.

chapter resto poster

the resto poster is a thing in Swept Pews.

chapter Tract Cart

The tract cart is a thing in Swept Pews.

book Drawl Ward

Drawl Ward is south of Swept Pews. It is in Yelpley.

Marge Pegram is a person in Drawl Ward. "'Hi! I'm Marge Pegram."

book Scrap Arcs

Scrap Arcs is east of Drawl Ward. It is in Yelpley.

The gate tag is in Scrap Arcs.

book Dope Pod

Dope Pod is west of Drawl Ward. It is in Yelpley.

The radar is in Dope Pod.

book ball lab

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
	if player is in dirge grid and diktat kid is in dirge grid, no;
	yes. [obviously we don't want this to be trivial once the game's complete, but we want the code in place.]

carry out gotoing:
	unless goto-available, say "You're at a point in the game where goto isn't available." instead;
	if noun is not available, say "[noun] isn't available yet, so you can't go there." instead;
	if noun is available and noun is not visited, say "You can reach [noun], but you haven't visited there, yet. So I'm going to be a stickler and say you have to get there first." instead;
	move player to noun;
	the rule succeeds;

section gotocheck - not for release

[this is to make sure that rooms are unfolded]

when play begins:
	say "[if number of notyet rooms is 0]All rooms have a switch saying you can go there[else]Rooms that are still notyet: [list of notyet rooms][end if]."

volume unsorted

chapter trucking

[this point is unsorted yet]

Curt is a person.

trucking is an action applying to one thing.

understand the command "truck" as something new.

understand "truck [something]" as trucking.

carry out trucking:
	if noun is not Curt, say "Wrong thing to truck." instead;
	move Curt to ZeroRez;
	score-inc; [+yelpley]
	the rule succeeds.

volume metarooms

[there is a little bit of cute code here. Odd Do's score = weird stuff, but it's also where ZeroRez, the collect-all room for used objects, goes. TempMet is for items that temporarily disappear.]

part Odd Do

ZeroRez is a room in Odd Do.

TempMet is a room in Odd Do.

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
		say "Aid... aid...[paragraph break]";
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

volume internal testing - not for release

the debug tweaks rule is listed first in the when play begins rulebook.

when play begins (this is the debug tweaks rule):
	now ignore-wait is true;
	now debug-state is true;
