"Put it Up" by Andrew Schultz

[blurb for comp = A *GASP* SAGA]

[there are things you can search for to make the source more navigable.

First, Put It Up tables.i7x contains all the random responses.
Second, Put It Up tables.i7x contains responses to mistakes e.g. palindrome verbs/phrases that don't advance the game but are good tries.
Put XX before each of these to find the beginning of a table, ZZ for the end:
USE for the Table of Useons (USE X ON Y gives a point)
FAIL for Useons that don't work
TALK for talk texts

to search for an item, look for chapter [item].
]

the story headline is "Yo, Joy! Wow!"

the release number is 1.

include Trivial Niceties Z-Only by Andrew Schultz.

include Basic Screen Effects by Emily Short.

[this may be toggled for debug depending on how much space is left--or if I want to force unit tests to make sure that, say, waiting text cycles after only 2 entries. If I add a random wait response, for instance, that would be one more bit of text to account for. For which to account.]
[include Put It Up Tables by Andrew Schultz.]
include Put It Up Debug Tables by Andrew Schultz.

include Put It Up Mistakes by Andrew Schultz.

include undo output control by Erik Temple.

volume definitions

a person can be normal, grunty, ruling, chasey or henchy. a person is usually normal.

a chaser is a kind of person. a chaser has a room called chase-room.

a thing can be drinkable. a thing is usually not drinkable.

a thing can be peripheral. a thing is usually not peripheral.

an ingredient is a kind of thing. an ingredient is usually edible. an ingredient can be solid or liquid.

chapter region and room stuff

a region has a number called max-score. a region has a number called cur-score.

Grebeberg is a region. max-score of Grebeberg is 28.

Dim Mid is a region. max-score of Dim Mid is 10.

Yelpley is a region. max-score of Yelpley is 36.

Odd Do is a region. max-score of Odd Do is 8.

index map with Dirge Grid mapped east of Toll Lot.

the change default appearance for blank rooms rule is listed after the room description body text rule in the carry out looking rules.

carry out looking (this is the change default appearance for blank rooms rule):
	if the description of the location is empty, say "[if number of viable directions is 1]An exit leads[else]Exits lead[end if] [list of viable directions]. NOTE: I need to change this generic text.";
	continue the action;

chapter for (beta) testers

llp-reject is a truth state that varies. [for my own tests: walkthrough with LLPs and without]

endgame-test is a truth state that varies.

in-beta is a truth state that varies.

volume parser simplification

Understand the command "slice" as something new.
Understand the command "prune" as something new.
Understand the command "chop" as something new.

Understand the command "kiss" as something new.
Understand the command "hug" as something new.
Understand the command "embrace" as something new.
Understand the command "buy" as something new.
Understand the command "purchase" as something new.
understand the command "buy" as something new.
understand the command "light" as something new.
understand the command "jump" as something new.
understand the command "hop" as something new.
understand the command "skip" as something new.
understand the command "sip" as something new.
understand the command "swallow" as something new.

Understand the command "shine" as something new.
Understand the command "polish" as something new.
Understand the command "sweep" as something new.
Understand the command "clean" as something new.
Understand the command "dust" as something new.
Understand the command "wipe" as something new.
Understand the command "scrub" as something new.
Understand the command "rub" as something new.

Understand the command "fight" as something new.
Understand the command "torture" as something new.
Understand the command "wreck" as something new.
Understand the command "crack" as something new.
Understand the command "murder" as something new.
Understand the command "kill" as something new.
Understand the command "punch" as something new.
understand the command "thump" as something new.
understand the command "wave" as something new.
understand the command "sorry" as something new.

volume unsorted

to say etg:
	end the story;

section part of a puzzle but still floating

[Otto is a person.]

the brag garb is a proper-named thing. description is "You don't know fashion that well, but this is way spiffier and more comfortable than the old stink knits."

section helpdocs

a helpdoc is a kind of thing.

section ingredients

section tronparts

a tronpart is a kind of thing.

description of a tronpart is usually "The [item described] is one of [number of tronparts] parts needed for the North-Tron."

TNT is a tronpart.

Gorge Grog is a tronpart.

The Ore Zero is a tronpart.

volume the player

description of player is "Flesh. Self."

check dropping:
	say "This game is not Pro-Drop. In other words, you don't need to drop anything. You may wish to USE it instead." instead;

to decide which region is mrlp:
	decide on map region of location of player;

after looking (this is the make available for goto rule):
	if location of player is not Emo Dome, now location of player is available;
	continue the action;

part scoring

to score-inc:
	reg-inc mrlp;

check requesting the score:
	say "Your overall score so far is [score] of [maximum score][if score < 4]. But don't worry, points pile up pretty quickly once you get going[end if].";
	say "Broken down by regions, you have [regres of Dim Mid], [regres of Grebeberg], [regres of Yelpley] and [regres of Odd Do].";
	if My Gym is visited or Evaded Ave is visited:
		if number of grunty people is not number of grunty people in ZeroRez, say "You currently disposed of [number of grunty people in ZeroRez] grunts blocking your way: [list of grunty people in ZeroRez].";
	if Yuge Guy is in ZeroRez, say "You've gotten rid of the Yuge Guy, Evil Clive.";
	if Madam is in ZeroRez, say "You've gotten rid of the La Gal/Madam.";
	if player has set o notes and north tron is off-stage:
		let ni be number of tronparts carried by the player;
		say "You also have [ni] of [number of tronparts] piece[if ni is not 1]s[end if] of the North Tron, according to the set-o-notes.";
	the rule succeeds;

this is the llp rule:
	if llp-reject is true, the rule succeeds;
	reg-inc Odd Do;

to reg-inc (re - a region):
	if re is not Odd Do and re is not mrlp, say "DEBUG NOTE: scored [re] point in [mrlp].";
	increment cur-score of re;
	increment the score; [this is the only incidence that shouldn't be replaced]
	if debug-state is true and cur-score of mrlp > max-score of mrlp, say "DEBUG WARNING: REGION SCORE TOO HIGH!";
	if debug-state is true and score > maximum score, say "DEBUG WARNING: OVERALL SCORE TOO HIGH!"

to say regres of (re - a region):
	say "[cur-score of re] of [max-score of re] ";
	if re is Odd Do:
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
	say "It's not the first dream you had about how awful high school was, but it's the worst in a while. A few 'favorite' classmates chanting 'Diary raid!' and passing it around as they mock 'Beefy? Feeb! Bony nob!'[wfak-d]";
	say "You check your mail as you go out to the grocery store. A junk magazine! It's been so long since you got one, you're almost intrigued.[wfak-d]";
	say "It just says GAME MAG. But the cover isn't telling you to actually buy anything, so you look inside. You have a whole backlog of games, but you can just recycle it when you get to the store.[wfak-d]";
	say "Nothing really catches your mind until you see a DARER AD. It's really all caps, and it has a lot of messages.certainly loud.[wfak-d]";
	say "EVIL'S LIVE![wfak-d]";
	say "LIVE DEVIL![wfak-d]";
	say "BOSSES! SOB![wfak-d]";
	say "Then you hear a voice say 'Pass, sap!' You look up, and you're no longer on the way to the store. You're somewhere else. With someone else: a Flee Elf, who looks at you and says 'You'll do, I guess. The first thing to do is, figure how to take this cap.'[wfak-d]"

volume parser errors operations and death

check saving the game: say "Eh, cache...";

check quitting the game: say "Aibohphobia?!";

check restarting the game: say "Warp ... raw.";

part parser errors

chapter nothing to say

nothing-txt is a number that varies.

Rule for printing a parser error when the latest parser error is the i beg your pardon error:
	next-rand table of nothings;

Rule for printing a parser error when the latest parser error is the can't see any such thing error:
	let X be indexed text;
	now X is "[location of player]" in lower case;
	replace the text "[']" in X with "";
	replace the text "-" in X with " ";
	repeat with J running from 1 to number of words in X:
		let Y be word number J in X;
		if the player's command matches the text "[Y]", case insensitively:
			say "It looks like you tried to do something with the location name[if balm-got is false], and you got the sneaky bonus point for doing so[else], though you'll get a bonus point in the right place. Location names are generally just to describe unnecessary scenery[end if].";
			if gone-to is false, say "[line break]However, GO TO/GT (room) may be a nice shortcut to visit a previous location.";
			the rule succeeds;
	continue the action;

chapter unrecognized verb

Rule for printing a parser error when the latest parser error is the didn't understand error:
	say "[if gtv]You do need a special verb here, but not that one. It may not be a standard one, but given the game's theme, I bet you can figure it out. If you want standard verbs, y[else]I didn't recognize that action. Y[end if]ou can type VERB or VERBS to get a list of them.";

to decide whether gtv:
	if Ian is in location of player, yes;
	if Dave is in location of player, yes;
	if Rob is in location of player, yes;
	if Ned is in location of player, yes;
	no;

part after command

after reading a command:
	do nothing;

part dying

to die:
	end the story saying "Offed? Deffo! / Story Rots! / Stung! Nuts! / To Pot!"

volume verbs (standard or semi-standard to Inform)

chapter undoing

report undoing an action:
	say "[one of]Nixin[']...[or][']S poor. Oops![or]Time: remit.[or]'Redo-coder! Redo-coder!'[in random order]";
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

to decide whether the action is pro-and-use: [aip2]
	if useoning, yes;
	if the action is procedural, yes;
	no;

chapter refering / thinking

refer-bonus is a truth state that varies.

refering is an action applying to nothing.

understand the command "refer" as something new.

understand "refer" as refering.

carry out refering:
	if refer-bonus is false:
		say "Yes! That's a slightly more appropriate way to think, here.";
		abide by the llp rule; [REFER]
		now refer-bonus is true;
	try thinking instead;

instead of thinking:
	say "[if refer-bonus is false]There might be a more appropriate way to think[else]You think for a bit[end if]."

chapter inventory

check taking inventory when Dave-evade is true:
	now all things enclosed by the player are marked for listing;
	now all ingredients are unmarked for listing;
	now all tronparts are unmarked for listing;
	now all things worn by the player are unmarked for listing;
	say "[if number of things carried by player > 7]Your scepsis pecs help you carry a lot of things, though you're suspicious and unclear as to how.[else]'Met item' list:[line break][end if]";
	list the contents of the player, with newlines, indented, including contents, giving inventory information, with extra indentation, listing marked items only;
	if number of ingredients carried by player > 0, say "Food found: [a list of ingredients carried by player].";
	if number of things worn by player > 0, say "You are wearing: [a list of things worn by player].";
	if number of tronparts carried by player > 0, say "North-tron parts found: [the list of tronparts carried by player][unless martini tram is off-stage]. The martini tram is in Fun [']Nuf, too[end if].";
	the rule succeeds;

after printing the name of a tronpart while taking inventory: if player has epicer recipe, say " (recipe item)".

after printing the name of yard ray while taking inventory: say " ([unless murk rum is in ZeroRez]un[end if]charged)".

after printing the name of spa maps while taking inventory: say "([if maps-explained is true]deciphered[else]indecipherable[end if])".

after printing the name of the puce cup while taking inventory:
	if puce cup is sappy, say " (full of past sap)";
	if puce cup is soddy, say " (full of dose sod)";
	continue the action;

after printing the name of the radar while taking inventory:
	unless radar-used is 0, say " (damaged)"

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
	say "[line break][one of]I also found some websites useful. CREDITS again to see them.[or]Websites that helped with this game:[paragraph break]  --http://www.angelfire.com/in2/sedavis/palindromes.html STOP LAUGHING ANGELFIRE WAS COOL WHEN IT FIRST CAME OUT ANYWAY GEOCITIES WAS MORE MY BEAT[line break]-- https://www.reddit.com/r/AskReddit/comments/4z899e/whats_your_favorite_palindrome/[paragraph break]";
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
	say "The four basic directions ([b]N, S, E, W[r]) are the main ones, along with [b]USE[r], in order to get through the game. Also, in some places, specific verbs will be needed. None are terribly long, and---well, there is a pattern to them.";
	say "[line break]Standard verbs like [b]X[r] ([b]EXAMINE[r]) and [b]LOOK[r] also work.";
	say "[line break][b]GT[r] or [b]GO TO[r] lets you go to a room where you've been before.";
	say "[line break][b]THINK[r] gives very general hints.";
	say "[line break][b]T[r] or [b]TALK TO[r] talks to someone. You don't need to, to win the game, but there you are.";
	say "[line break][b]USE (item) ON (item)[r] is frequently used. It replaces a lot of verbs like [b]GIVE[r] or [b]THROW[r].";
	say "[line break][b]AID[r] gives you hints for where you are. [b]ABOUT[r] and [b]CREDITS[r] tell about the game.";
	say "[line break]Many verbs that are standard for earlier text adventures give random reject text I hope you will enjoy.";
	if wr-short-note is true and player is in Worn Row and workrow is true, say "[line break][b]REV[r], [b]ROT[r] and [b]REI[r] use an item on the reviver, rotator and reifier, respectively.";
	if in-beta is true:
		say "[line break][b]RR[r] lets you try all three items in the Word Row machines. If one nets a point, it goes last.";
		say "[line break][b]ENDGAME[r] kicks you to the endgame, where you have all the weapons to win the game, though you will be limited to Fun [']Nuf and the Dirge Grid.";
	if debug-state is true:
		say "[line break]WIN lets you win, PER describes peripheral things, and IA flags everything without an initial appearance.";
	the rule succeeds;

wr-short-note is a truth state that varies.

chapter ting

talktoing is an action applying to one thing.

understand the command "t" as something new.
understand the command "talk to" as something new.

understand "t [something]" as talktoing.
understand "talk to [something]" as talktoing.

carry out talktoing:
	if noun is not a person, say "Talking to people or, at least, animals is your best bet." instead;
	if talk-text of noun is empty, say "Nothing. (change this)" instead;
	say "[talk-text of noun][line break]" instead;
	the rule succeeds. [see volume dialogue for all the specifics]

a person has text called talk-text.

chapter drinking

drink-warning is a truth state that varies.

check drinking:
	say "[if noun is drinkable]Pish! Sip?![else][']S not wet. Ew--TONS.[end if]";
	if drink-warning is false, say "(You don't need to drink anything. Liquids have their purpose in this game, but also, there is no Pee Keep anywhere.)[paragraph break]";
	now drink-warning is true instead;

chapter eating

eat-warning is a truth state that varies.

check eating:
	say "[if noun is Demo Med]You're not sick enough to risk it. Maybe someone in much worse shape than you...[else if noun is edible]Food? Oof![else]You contemplate a wan gnaw, but no voice says 'Naw. G'wan!'[end if]";
	if eat-warning is false, say "(You don't need to eat anything to win. Food may be more useful for other people.)[paragraph break]";
	now eat-warning is true instead;

chapter burning

instead of burning, next-rand table of burnies;

chapter saying yes

instead of saying yes, next-rand table of yessies;

chapter saying no

no-tab is a number that varies.

instead of saying no, next-rand table of noesies;

chapter attacking

instead of attacking:
	if noun is player, say "PvP!" instead;
	next-rand table of attackings;

chapter going

the new generic going reject rule is listed before the can't go that way rule in the check going rules.

check going (this is the new generic going reject rule):
	if noun is outside and number of viable directions is 1, try going a random viable direction instead;
	if noun is inside, say "You don't ever need to use IN in the game. Just the four cardinal directions." instead;
	if the room noun of location of player is nowhere, say "You can only go [list of viable directions] here[up-down-check]." instead;

to say up-down-check:
	let xud be 0;
	unless the room up from location of player is nowhere, increment xud;
	unless the room down from location of player is nowhere, increment xud;
	if xud is 0, continue the action;
	say "(";
	unless the room up from the location of player is nowhere, say "up=[othdir of up]";
	if xud is 2, say ", ";
	unless the room down from the location of player is nowhere, say "up=[othdir of down]";
	say ")"

to decide which direction is othdir of (d - a direction):
	repeat with Q running through { north, west, south, east }:
		if the room Q of location of player is the room D of location of player, decide on Q;
	say "(bug)";
	decide on D;

definition: a direction (called d) is viable:
	let lp be location of player;
	if the room d of location of player is nowhere, no;
	if d is north and lp is Gross Org and etage gate is in Gross Org, no;
	if d is up or d is down, no; [you may be able to go that way, but we'll hide that from the reader.]
	yes;

check going (this is the reject noncardinal directions rule):
	if noun is diagonal, say "You don't need diagonal directions in this game." instead;
	if noun is up or noun is down:
		if the room noun of location of player is nowhere, say "You never need to go up or down in this game." instead;

the reject noncardinal directions rule is listed first in the check going rulebook.

chapter smelling

rod-smelled is a truth state that varies;

instead of smelling:
	if stink knits are quicknear, say "The stink knits take over everything and smell of torn rot." instead;
	if troll ort is quicknear, say "The troll ort emits a musk-sum which isn't unpleasant, but it's distinctive." instead;
	if player has dork rod:
		now rod-smelled is true;
		say "You might expect a rod odor, but there isn't one. OR MAYBE IT IS SO INGRAINED IN YOU, YOU NO LONGER SMELL IT." instead;
	if player is in Deli Tiled, say "Ham?! Ah!" instead;
	if player is in Sneer Greens and Yuge Guy is in sneer greens, say "You smell an amoral aroma." instead;
	say "Noses, on[one of]! (you don't need to smell anything in this game)[or][stopping]!"

chapter singing

instead of singing, next-rand table of singstuff;

chapter silly swearing

instead of swearing mildly, try swearing obscenely instead;

swearies is a number that varies.

instead of swearing obscenely, next-rand table of swearstuff;

chapter sleeping

instead of sleeping, try waiting instead;

chapter waiting

instead of waiting, next-rand table of waittxt;

chapter xyzzying

xyzzying is an action out of world.

understand the command "xyzzy" as something new.

understand "xyzzy" as xyzzying.

carry out xyzzying:
	say "...[paragraph break]...[paragraph break]X." instead;

chapter useing

useoning it with is an action applying to two things.

does the player mean useoning the noun with the noun: it is very unlikely.

understand the command "use" as something new.

understand "use [something] on [something]" as useoning it with.
understand "use [something] with [something]" as useoning it with.

to build-the-tron:
	move north tron to Fun 'Nuf;
	now all tronparts are in ZeroRez;
	say "You build the north tron with the instructions from the epicer recipe. It points north and blasts a hole with a huge tron snort before collapsing into uselessness. You tear up the epicer recipe and throw it in the air to make confetti as celebration. You must be close now!";
	now epicer recipe is in ZeroRez;
	now Dirge Grid is mapped north of Fun 'Nuf;
	now Fun 'Nuf is mapped south of Dirge Grid;
	score-inc; [Dim Mid/USE TNT ON ORE ZERO]

chef-yet is a truth state that varies.

to chef (i1 - an ingredient) and (i2 - an ingredient):
	if player is not in Mont Nom:
		say "You're not in the right place to mix food together.";
		continue the action;
	if Ian is in Mont Nom:
		say "Not with Ian around.";
		continue the action;
	if i1 is liquid and i2 is liquid:
		say "Those are both too liquid.";
	else if i1 is solid and i2 is solid:
		say "Those are both too solid to go together.";
	else:
		say "You mix [the i1] with [the i2] in front of the Ark of Okra. You hear a distant rumble. The Ark of Okra shakes visibly.[paragraph break]";
		now i1 is in ZeroRez;
		now i2 is in ZeroRez;
		score-inc; [Grebeberg/USE GIFT FIG ON MAYO YAM&USE SNACK CANS ON UFO TOFU]
		if chef-yet is true:
			say "A martini tram rattles out from behind the Ark of Okra. Guess you need drinks with your, uh, food![paragraph break][if player does not have the epicer recipe]You're shocked to see it, and it rollls further down, over the turf rut to Dumb Mud, then back through the Seer Trees to Fun [']Nuf[else]But you're prepared for it, with your epicer recipe. You move it back to Fun [']Nuf, where it looks like a good base structure for your North Tron[end if]..";
			move martini tram to Fun 'Nuf;
			move player to Fun 'Nuf, without printing a room description;
		else:
			say "You suspect something is behind there! Maybe you can find another combination, you'll see what.";
			now chef-yet is true;

check useoning it with:
	if noun is second noun, say "It's not productive to use something on itself, even with this game being full of palindromes." instead;
	if noun is a workable and second noun is a workable, say "The machines are fixed in place. You can't use one on the other." instead;
	if noun is a workable, try useoning second noun with noun instead;
	if noun is a workable or second noun is a workable:
		if wr-short-note is false:
			say "(NOTE: You can abbreviate this command with ROT, REI and REV for the respective machines, later.)[paragraph break]";
			now wr-short-note is true;
	if second noun is a workable and useleft of second noun is 0, say "No point. The [second noun] is broken." instead;
	if noun is an ingredient and second noun is an ingredient:
		chef noun and second noun instead;
	repeat through table of cantuse:
		if noun is use1 entry or second noun is use1 entry, say "[babble entry][line break]" instead;
	if noun is a person, say "[one of]You're not any good at using other people. In fact, if you tried, they'd wind up using YOU. Plus you don't want to be, really. There's another way. So, no[or]Using people is out[stopping]. Maybe you could use something on a person, though." instead;
	if noun is a tronpart or noun is epicer recipe:
		if second noun is a tronpart or noun is epicer recipe:
			if player does not have epicer recipe, say "Those two things seem to go together, but you don't have detailed instructions." instead;
			if number of off-stage tronparts > 0, say "You have the start of something, but not enough to make a north-tron." instead;
			if player is not in Fun 'Nuf:
				say "You might be better served using these things in Fun [']Nuf. Go there?";
				if the player no-consents, say "OK, but protip: that's where you need to assemble things." instead;
				move player to Fun 'Nuf, without printing a room description;
			build-the-tron instead;
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
						score-inc; [ignore]
				say "[babble entry][line break]";
				if there is a postproc entry:
					[if debug-state is true, say "(considering [postproc entry])[line break]";]
					consider the postproc entry;
				if there is a getit entry and player has getit entry: [try to let "it" be defined]
					set the pronoun it to getit entry;
				else if use1 entry is in ZeroRez and use2 entry is not in ZeroRez:
					set the pronoun it to use2 entry;
				if second noun is a workable:
					wear-down second noun;
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
	if second noun is a workable, abide by the machine message rules for the noun;
	repeat through table of cantuse:
		if noun is use1 entry, say "[babble entry]" instead;
	say "You think of ways to do that productively, but nothing comes up." instead;

The machine message rules are an object-based rulebook.

a machine message rule for a thing (called t):
	repeat through table of useons:
		if t is use1 entry and use2 entry is a workable, say "Nothing happens, but you feel you must be close, here." instead;
	say "Nothing happens at all. Maybe [the t] needs to be used more actively." instead;

table of cantuse
use1	babble
Dave	"Dave's not useful, man."
Ian	"Ian's worse than useless. You need to use your wit on him."
Rob	"Rob's not going to be obliging. You have to get rid of him, somehow."
Ned	"Ned wants a fight, and you need some other way around him."
Pact Cap	"Your pact cap is fine where it is, on your head."
epicer recipe	"It's meant for referral."
Darer Ad	"It was only useful to sucker you into this mess."
Set O Notes	"It's useful for an overview, but not for DOING anything."

[the table of useons approximately follows not only the test commands but also the walkthrough]
[getit = item you get, d1/d2 = use1/use2 disappear(?) pre/post = rule to check, or rule to execute post-happening]
table of useons [xxuse]
use1	use2 (an object)	getit	preproc (a rule)	postproc (a rule)	sco	d1	d2	reg-plus	babble
TO IDIOT	Revolt Lover	--	--	--	true	true	true	Yelpley	"The Revolt Lover begins to read and starts chuckling. Then keeps chuckling. 'Oh my goodness. This is funny. I'd try to explain it to you, but I'm not sure if you deserve to laugh at it yet. Maybe one day.' With uncontrollable laughter spasms, the Revolt Lover runs away." [b4:PACK CAP/EVADE DAVE/BORE ROB/WORD ROW]
pity tip	navy van	snack cans	--	mob-to-alley rule	true	true	false	Yelpley	"The van takes the pity tip and whooshes off. It spits out some snack cans, which roll on the ground. You take them. The navy van then leaves for good. It was apparently obstructing a whole bomb mob!" [af:TEND NET/WORK ROW]
trap art	reifier	party trap	--	--	true	true	false	Yelpley	"The trap art crunches inside the reifier, then -- bam! Out comes what the trap art was imagined to be: a party trap. I bet it could trap more than one person, or thing, or whatever."
debt bed	reviver	stock cots	--	--	true	true	false	Yelpley	"After some crunching and slurping, the debt bed is changed to a bunch of much smaller, but more comfortable looking, stock cots."
party trap	stark rats	gift fig	--	--	true	true	true	Grebeberg	"The rats all try to enter the trap, and SNAP! SNAP! SNAP! The party trap explodes as the last rat enters, but fortunately all the trap-stuff is gone. The Seer Trees seem to nod a bit. You watch as a gift fig rolls out. You take it."
ERA FARE	King Nik	Spur Ups	--	--	true	true	true	Grebeberg	"King Nik reads it, nods sagely, and reads. 'This will help me when I get back to South Ihtuos. Thank you!' He hands you some Spur Ups in gratitude. 'Maybe this will give you the same boost you gave me. Now...I must leave and RAFT FAR back to '"
stock cots	sleep eels	--	--	--	true	true	true	Grebeberg	"The sleep eels seem intrigued by the upgrade in relaxation resources. You put the stock cots down and roll them out of the way. The eels follow. You can now go south!" [af:puff up/pull up]
puce cup	past sap	--	--	sap-to-cup rule	true	false	false	Grebeberg	"You pour some sap into the cup."
puce cup	liar grail	--	sap-in-cup rule	empty-cup rule	true	false	true	Yelpley	"The past sap pours into the liar grail and exposes how bad the grail has been over the years. As it cracks, along with the wall it was attached to to allow passage south, you snicker to yourself. Liar grail? More like Liar FRAIL! Or Liar TRAIL!"
puce cup	dose sod	--	--	sod-to-cup rule	true	false	false	Grebeberg	"You funnel the dose sod into the puce cup. It will keep the sod fresh enough."
puce cup	Marge Pegram	Elan Ale	sod-in-cup rule	empty-cup rule	true	true	true	Yelpley	"You give marge the puce cup. She drinks the dose sod and immediately feels better. 'Well... I have a lot of catching up to do. Can't hang around. Here's some Elan Ale for you, to celebrate how cool you are for helping.'"
stamp mats	slate metals	ye key	--	--	true	false	false	Yelpley	"Impressing the stamp mats on the slate metals, a design pops out! A key! An important looking one emblazoned ... YE KEY."
demo med	gulf lug	cash sac	--	--	true	true	true	Grebeberg	"The Gulf Lug takes the demo med, inspects it, and says, 'Eh, why not...' he looks a lot better within a few seconds. 'Thank you so much!' he says, handing you a cash sac."
cash sac	cross orc	--	--	--	true	true	true	Yelpley	"The cross orc looks at the cash sac suspiciously. It's not sure if the sac is enough. But you convince the orc that money isn't any good if you don't get out there and spend it, and ... with a payee yap, the orc goes to look for ... well, something else."
YOB ATTABOY	Sniffins	Dirt Rid	--	--	true	true	false	Yelpley	"Sniffins accepts your gift. His sniffs slowly change from sadness to something more snooty. He thanks you for helping him be too good for you before handing you a Dirt Rid and kicking you out."
Elan Ale	Sniffins	Gorge Grog	--	--	true	true	false	Yelpley	"Sniffins looks the Elan Ale up and down, sniffs and...well, okay. It will do. 'Now take that Gorge Grog and get it out of here.'" [af:stand nat's]
Dirt Rid	reviver	Cave Vac	--	--	true	true	false	Yelpley	"You watch as the Dirt Rid swirls and becomes shinier and much more powerful. A Cave Vac! It will be capable of cleaning...well, somewhere."
Cave Vac	cassettes sac	radar	--	--	true	true	true	Yelpley	"The Cave Vac has the power to clean up the Dirt Rid, though it chokes and sputters at the end of the effort. And while a lot of the cassettes are beyond repair, there's something at the very bottom.[paragraph break]Wow! Radar![paragraph break]You hear noises from the pod, as a hidden robot appears and whisks the garbage away. That's pretty slick! Looking back, the pod doesn't seem so dopy any more, between the Demo Med's help and how you're sure the radar will help."
radar	crag arc	UFO tofu	orc-gone rule	radar-blink rule	true	false	false	Yelpley	"Beeeep... beeeep..... the radar has found something! A small saucer arises from a hidden part of the crag. Splat! something weird and warm drops from the UFO and lands on the radar, which fizzles a bit from the impact and wetness. It hardens quickly and weirdly into a cubic shape. What could it be? You think a minute. It has to be UFO tofu." [af:deny Ned]
Ye Key	etage gate	gate tag	Ned-gone rule	--	true	true	true	Yelpley	"Ye Key fits perfectly into the Etage Gate.[paragraph break]'Etage-gate? More like Etage-NEGATE!' you brag, not noticing the gate retracting, Ye Key with it. Well, you can't imagine needing it again.[paragraph break]A gate tag falls off. It has a curious emblem, much like you saw at the Emo Dome, so you decide to keep it." [af:Worn Row]
stink knits	rotator	brag garb	--	wear-garb rule	true	true	false	Yelpley	"The stink knits fit into the rotator without stuffing them too much. After some spinning, you look in again and--they're something much shinier now. Brag garb!"
gold log	rotator	dork rod	--	--	true	true	false	Yelpley	"The gold log begins spinning until it cracks open--leaving a dork rod!"
SOME DEMOS	yahoo hay	straw arts	--	hay-gone rule	true	false	false	Grebeberg	"With the help of SOME DEMOS, you manage to rejig the hay into something more aesthetically pleasing: straw arts!"
straw arts	Mike Kim	soot tattoos	--	--	true	true	false	Yelpley	"'Brilliant! Brilliant! Such expressive art! Subversive, yet straightforward! I ... I'd like to sell it on commission. I'd also like to see what else you can do. Here, have these soot tattoos.'"
gate tag	soot tattoos	state tats	--	--	true	true	true	Yelpley	"You stamp the gate tag into the soot tattoos, and they take on an official shape. They look like official State Tats, which you can slap on if you ever need to impersonate an official goon, or something. Way to go!"
poo coop	gnu dung	--	--	--	true	false	true	Grebeberg	"The gnu dung is sucked towards the poo coop. In fact, it forms a crass arc as it seems like the dung inside the coop must be several times the volume of the coop itself. Whatever, you can now go south."
poo coop	turf rut	--	coop-full rule	--	true	true	true	Grebeberg	"The poo coop releases its contents into the turf rut but explodes as the last bit oozes out. You dump it into the hardening mixture. The rut isn't filled, but you have clear passage across, and the ... bridge ... hardens visibly and quickly. You poke it with your foot to make sure. I guess you could call the turf rut something else, now, but I'm trying to keep this game PG."
radar	made dam	eroded ore	--	radar-blink rule	true	false	false	Grebeberg	"You place the radar against the made dam and move back and forth. Suddenly--yes! You hear a few pings. There's something behind. You discover some eroded ore, which you take. It's not much in its current state, but maybe you can regenerate it somehow. The radar plays a weird scale. Being close to the ore has damaged it somehow."
NULL ILLUN	Known Wonk	--	--	--	true	true	true	Grebeberg	"The Known Wonk begins to read. 'This is too simple. It has to be beneath me.' But the more the Wonk reads, the more it's clear...they have overlooked stuff. 'Hey. That makes sense. And if it's simple, well, I need to know when simple stuff works.' The Known Wonk apologizes--it's back to a Tru Yurt for a thought session."
el doodle	edits tide	spa maps	--	--	true	true	false	Grebeberg	"The edits tide washes away enough of El Doodle to reveal maps...and not just any maps, but spa maps!"
elope pole	kayak	you buoy	--	--	true	true	false	Grebeberg	"You unfold the elope pole into two oars. And you take a journey ... well, you're not sure where, but you see Elided Ile in the distance. So you stop off there. First at the Yack Cay for some chat. You are invited to Nevah-Haven, where everyone is happy all the time, but ... it seems too good to be true. Apparently your declining means you passed some sort of test, and the citizens hand you a YOU BUOY to tell you they're glad you're you. They mention it may hold great treasures within, ones that will help you complete your quest. 'Barge! Grab!' they call as one speeds past, in the direction of Calcific Lac. As it gets near and bends away, you jump off, using the buoy to paddle and float back to Calcific Lac."
dork rod	tao boat	enact cane	--	--	true	true	false	Grebeberg	"The dork rod vibrates and causes the Tao Boat to open. You step aboard. Inside are stave vats. You put the dork rod in them, and it shimmers and pops back out as ... an enact-cane. You think back to the rep popper in the alley. Suddenly, you don't feel as though you'd feel silly holding it. You're sure you need it, though for what, you can't say."
tent net	Code Doc	--	--	--	true	true	false	Grebeberg	"Together, you figure out what to do to make the tent net proper cover for the birch crib. 'Tie it ... tie it ...'[paragraph break]Once the work is done, the Code Doc thanks you and offers to share some knowledge in return, whenever."
spa maps	Code Doc	--	maps-still-confusing rule	maps-explain rule	true	false	false	Grebeberg	"The Code Doc looks at the maps. 'Ah! That's how to interpret them. You just do this... and this ...' and suddenly it makes complete sense to you."
spa maps	go-by bog	sage gas	maps-readable rule	--	true	true	false	Grebeberg	"Everything clicks now! You see Go-By Bog, Gobs Bog, and how to pass through each of them. It's not a total breeze, but when you get through, you find sage gas all around. The Spa Maps are surprisingly sturdy, and you're able to reformat them into a receptacle for the sage gas. Lucky you! Or maybe being around that sage gas made you smart enough to figure the science out, there.[paragraph break]As you return to the Apse Spa, the Spa Maps turn into a salt atlas and crumble away."
enact cane	yahoo hay	moor broom	--	hay-gone rule	true	true	false	Grebeberg	"You stick some strands of yahoo hay into the damaged end of the dork rod. It's now a moor broom!"
troll ort	brag garb	--	--	chase-in-zoo rule	true	true	false	Grebeberg	"You rub the troll ort on the Brag Garb. Whew! Somehow the ort mixed with the garb's materials to make a really strong odor. It's an entirely different smell from the Stink Knits, but still quite distinctive." [b4:pace cap] [af:yak okay]
sage gas	guru rug	tenet	--	--	true	true	false	Grebeberg	"The sage gas bubbles out under the guru rug and makes it float away. Under the guru rug is a tenet, which seems a bit corny at first, but it seems like it'll help you focus on who you are and what you need to do."
Moor Broom	Tru Yurt	Exam Axe	--	--	true	true	false	Grebeberg	"You begin to clean the Known Wonk's Tru Yurt, and as you do, all sorts of things turn up. The Known Wonk looks shocked at how your simple advice works. You're pretty shocked, too, given how you've never been GREAT at cleaning stuff, but you realize you do okay. The Known Wonk hands you something unusable for an intellectual, but maybe you will find it handy ... an Exam Axe!" [b4:nail ian/use snack cans on UFO tofu/use gift fig on mayo yam]
Exam Axe	Lie Veil	--	--	--	true	true	true	Grebeberg	"The Exam Axe cuts through the Lie Veil easily. As it does so, it shortens--oh, about 28.57%--before glowing and turning into, well, an ex-axe. You can go north now."
balsa slab	sword rows	not-a-baton	--	--	true	true	false	Yelpley	"The sword rows cut into the balsa slab, carving and honing it into something that almost seems like a weapon. It's pretty generic, and you wonder what it is, but you notice NOT-A-BATON carved into it. It seems kind of cool if you need self-defense, but you bet it could be so much more, since violence hasn't really been important so far."
not-a-baton	reifier	taboo bat	--	--	true	true	false	Yelpley	"The reifier coughs and spits out something even more counter culture than the dork rod: a taboo bat! You will be able to smite a bad-faith pearl-clutcher for sure with one of these."
DNA band	reifier	DNA hand	--	--	true	true	false	Yelpley	"After considerable gooping and whooshing, the reifier pops open to reveal something more lifelike than a DNA band: a DNA hand!"
roto motor	DNA hand	bang nab	--	--	true	true	true	Yelpley	"The roto motor fits right in. The hand glows a bit and wiggles its fingers nimbly and even pinches you before you can react. You notice something inscribed on it, now: BANG NAB. I guess that's what to call it, now. It probably has the dexterity to deal with volatile stuff. The bomb mob, for their part, becomes a poor troop once they see what they've lost."
Eroded Ore	reviver	Ore Zero	--	--	true	true	false	Yelpley	"The reviver whirs as you drop the eroded ore in, and ... out pops some shiny Ore Zero!"
you buoy	rotator	ME gem	--	--	true	true	false	Yelpley	"You hear a clunking as the rotator speeds up. When you open the rotator, the you buoy is in shreds, but a shiny ME gem appears. It's so tempting and beautiful, but you know it's not the main point of your quest. Maybe it can distract someone greedy."
bang nab	TNT	TNT	--	--	true	true	false	Yelpley	"The Bang Nab walks on its index and middle finger to the TNT, then nudges it away as the Bomb Mob isn't watching. It flicks the TNT over your way, then quickly skedaddles off to its old home: DNA Land, of course."
nat's tan	scorn rocs	--	--	--	true	true	true	Grebeberg	"The Nat's Tan burns into the scorn rocs, who were once pridefully spotless. Their fur turns an embarrassing shade of orange. You hear a bellow from the west."
rep popper	Yuge Guy	murk rum	--	--	true	true	true	Grebeberg	"The rep popper deflates the Yuge Guy, leaving behind only murk rum."
Bro Orb	Madam	Yard Ray	--	--	true	true	true	Yelpley	"The Bro Orb shines and drives Madam to rage. 'Live not on evil, madam, live not on evil!' you boom, as the ray does its work. She runs away, sobbing. The Yard Ray is left unguarded. You take it."
murk rum	yard ray	--	--	--	true	true	false	Dim Mid	"The yard ray gleams with energy. It seems like it could do some damage now."
Yard Ray	test set	--	ready-to-test rule	--	true	false	true	Dim Mid	"Fzzt! Zap! The test set goes up in smoke. Okay, you had something to practice on. Now for the final battle." [b4:emit noontime]
ME gem	Knife Fink	--	--	kid-left rule	true	true	true	Dim Mid	"The Knife Fink pauses, dazzled by the gem's brightness. 'Wow! It must be valuable!' [if Verses Rev is in Dirge Grid]The Verses Rev stops to tut-tut the Knife Fink, who ignores that.[end if] The Knife Fink grabs the gem and runs off, successfully bribed." [b4:use tnt on ore zero]
taboo bat	Verses Rev	--	--	kid-left rule	true	true	true	Dim Mid	"You raise the Taboo Bat, and suddenly the Verses Rev knows what he's up against. It's not that it's particularly violent or lethal, but the Verses Rev sees several ways culture has gone to seed (and several it's gotten better, but he's too set in his ways.) More importantly, he sees himself in that. He turns and runs."
Yard Ray	Diktat Kid	X-ITE TIX	--	--	true	true	true	Dim Mid	"Fzzt! Zap! The yard ray zaps the Diktat Kid, who goes running off. 'You haven't won for good! You think everyone's living in harmony, but I will build my ...[paragraph break]... REDIVIDER!'"
X-ITE TIX	TIX EXIT	--	--	you-win rule	true	false	false	Dim Mid	"Yes, it's time to go. You put the X-Ite Tix in the Tix Exit and walk through."
[zzuse]

section pre-use rules

[please add alphabetically]

this is the coop-full rule:
	if gnu dung is in ZeroRez, the rule succeeds;
	say "The poo coop is empty, but if it wasn't, that could work.";
	the rule fails;

this is the in-mont-nom rule:
	if location of player is not Mont Nom:
		say "Eww! Maybe if you were somewhere more magical with food, it would work.";
		the rule succeeds;
	if Ian is not in Mont Nom, the rule succeeds;
	say "Ian is distracting you. Maybe you can get rid of him, first.";
	the rule fails;

this is the maps-still-confusing rule:
	if maps-explained is true:
		say "You already got the Code Doc to decipher the spa maps.";
		the rule fails;
	if tent net is not in ZeroRez:
		say "'I might, but I need some help here first, to make my home here properly homey.'";
		the rule fails;
	the rule succeeds;

this is the maps-readable rule:
	if maps-explained is true, the rule succeeds;
	say "Hmm. Maybe if the maps were a bit clearer to you, that would work. But not now.";
	the rule fails;

this is the Ned-gone rule:
	if Ned is in ZeroRez, the rule succeeds;
	say "Good idea, but not with Ned around.";
	the rule fails;

this is the orc-gone rule:
	if orc is not in Toll Lot, the rule succeeds;
	say "The cross orc prevents you from trying anything possibly constructive. Maybe with the orc gone, you should try it again.";
	the rule fails;

this is the ready-to-test rule:
	if emitted is true, the rule succeeds;
	say "You aren't sure how the Yard Ray works, or what it needs to zap people with. Maybe you should review it to figure things out.";
	the rule fails;

[??	say "That seems right, but you should probably go where there aren't many people. Like back to Fun [']Nuf.";]

this is the sod-in-cup rule:
	if puce cup is soddy, the rule succeeds;
	say "[if puce cup is sappy]Marge Pegram makes a face at the sap in the cup. Maybe something less unpalatable would help her[else]The puce cup is empty. It wouldn't help Marge Pegram[end if].";
	the rule fails;

this is the sap-in-cup rule:
	if puce cup is sappy, the rule succeeds;
	say "[if puce cup is soddy]The sod doesn't seem to belong in the Liar Grail, but maybe something else does[else]The puce cup is empty[end if].";
	the rule fails;

section post-use rules

[please add alphabetically]

this is the chase-in-zoo rule:
	if location of player is Frush Surf, start-chase Kayo Yak;
	the rule succeeds;

this is the empty-cup rule:
	now puce cup is empty;
	if Marge Pegram is in ZeroRez and liar grail is in ZeroRez, say "You probably don't need the puce cup any more.";
	the rule succeeds;

this is the hay-gone rule:
	if SOME DEMOS is in ZeroRez and dork rod is in ZeroRez:
		say "You used up all the hay.";
		now yahoo hay is in ZeroRez;
	else:
		say "There's still some hay (yah!) left over for another creative project.";
	the rule succeeds;

this is the kid-left rule:
	if Verses Rev is in ZeroRez and Knife Fink is in ZeroRez, say "Two-nowt, you muse to yourself. The Diktat Kid, clearly angry, mutters 'I should've gone with Mad Adam. Iller Elli. Able Melba.'";
	the rule succeeds;

this is the maps-explain rule:
	now maps-explained is true;
	the rule succeeds;

this is the mob-to-alley rule:
	now bomb mob is in Yell Alley;
	now tnt is in Yell Alley;
	the rule succeeds;

this is the radar-blink rule:
	if radar-used is 1:
		say "One more hit like that, and the radar might give out for good.";
	else:
		say "Between the UFO tofu dropped on the radar and the eroded ore getting too close to it, the radar shorts out. After a pop, it splits open. A roto motor falls out and looks undamaged, so you take it.";
		now player has roto motor;
		now radar is in ZeroRez;
	the rule succeeds;

this is the sap-to-cup rule:
	now puce cup is sappy;
	repeat through table of useons:
		if use1 entry is puce cup and use2 entry is past sap:
			now sco entry is false;
			the rule succeeds;
	the rule succeeds;

this is the sod-to-cup rule:
	now puce cup is soddy;
	repeat through table of useons:
		if use1 entry is puce cup and use2 entry is dose sod:
			now sco entry is false;
			the rule succeeds;
	the rule succeeds;

this is the wear-garb rule:
	now player wears the brag garb;
	the rule succeeds;

this is the you-win rule:
	say "You head off to saner arenas for a while, just to reflect on all you did. You consider writing a book. What to call it? Hmm, that's it. SOME MEMOS. No, DRAWN INWARD.";
	end the story finally saying "Darn! Rad!";
	say "(this needs to be a lot better. I need to look through my notes more carefully.)";
	the rule succeeds;

chapter failed useons

[xxfail]
table of useons (continued)
use1	use2	getit	preproc (a rule)	postproc (a rule)	sco	d1	d2	reg-plus	babble
radar	sleep eels	--	--	--	false	false	false	--	"A radar isn't supposed to work this way, but somehow, you detect some bitterness at mammals in general. But it's secondary to needing a more comfortable place to sleep."
troll ort	cross orc	--	--	--	false	false	false	--	"The cross orc mutters something unrepeatable about prejudiced people who can't tell the DIFFERENCE and don't WANT to. But the way it looks at you, you suspect it'd forgive you if you gave the right gift."
troll ort	kayo yak	--	--	--	false	false	false	--	"As you hold the troll ort out, the Kayo Yak butts your hand! The troll ort goes flying. You walk over to pick it up."
yard ray	Tru Hurt	--	--	--	false	true	true	--	"The yard ray bounces harmlessly off the Tru Hurt. Maybe it needs to be used nonviolently."
yard ray	Diktat Kid	--	--	--	false	true	true	--	"The yard ray bounces harmlessly off the Diktat Kid. Maybe it needs to be used nonviolently."
[zzfail]

volume rooms

part Dim Mid region

book Fun 'Nuf

Fun 'Nuf is a room in Mid Dim. "[if elite tile is in Fun 'Nuf]Elite tile has replaced the old tile lit. Probably all that's left to do is to read it, or just go back south through the Tix Exit[else]Some tile lit is carved out here, describing what is the various directions[xit-ave][end if][if north tron is in Fun 'Nuf]. Also, the North Tron has carved a passage north[end if]."

to say xit-ave:
	say ". The [if tix exit is in Fun 'Nuf]Tix Exit prevents passage back south[else]Evac Ave is south, if you want to chicken out[end if]"

the north tron is scenery. "It seems to have pushed a passage north here in Fun [']Nuf. Do you have the guts to follow it to your destiny?"

chapter Flee Elf

The Flee Elf is a person in Fun 'Nuf. "A Flee Elf stands here, guarding Evac Ave to the south.". description is "You'd expect to see the Flee Elf wearing a gateman nametag, but maybe that's in some other, even more insanely brilliant, wonderful and creative adventure."

chapter Evac Ave

Evac Ave is scenery in Fun 'Nuf. "Evac Ave leads back to where you were."

instead of entering Evac Ave, try going south.

elf-warn is a number that varies.

the Tix Exit is scenery. "It's nothing particularly fancy. I'm going to go out on a limb here and say it'll accept your X-ITE TIX."

check going south in Fun 'Nuf:
	if player has X-ITE TIX, try useoning X-ITE TIX with Tix Exit instead;
	if Tix Exit is in Fun 'Nuf, say "The Tix Exit blocks your way to where Evac Ave was. I guess you're stuck questing, here." instead;
	if flee elf is in ZeroRez, say "You have no way back now that you accepted the Pact Cap." instead;
	if elf-warn < 3, increment elf-warn;
	say "[if elf-warn is 1]The Flee Elf encourages you to give taking the cap a shot--well, not quite TAKING it, but if you do take it, you'll be ready to go[else if elf-warn is 2]'Oy! Oy! Yo-yo!' The Flee Elf encourages you to find the right way to take--er, get--er, pick up the cap[else]The Flee Elf mentions there are really only 26 simple ways to pick up the cap, if you think about it, and why not just brute force? You're not busy with anything else[end if].";
	if elf-warn < 3, the rule succeeds;
	say "[line break]Do you still wish to go through Evac Ave and turn your back on adventure?";
	if the player yes-consents:
		say "The Flee Elf cries 'Fool! Aloof!' as you walk south past Evac Ave through the Elim-Mile, which removes all your memories of your brief time adventuring.";
		end the story saying "NOWT WON";

check going in Fun 'Nuf:
	if noun is west or noun is east:
		if Flee Elf is in Fun 'Nuf, say "'Keen! Eek!' the Flee Elf stops you. 'You need to figure out the right way to take the Cap, for a place like Grebeberg or Yelpley.'" instead;
		if endgame-test is true, say "Endgame testing is on. So you are restricted to the final combat." instead;

check going north in Fun 'Nuf:
		if Diktat Kid is in ZeroRez, say "No need to go back." instead;
		if north tron is not in Fun 'Nuf, say "Not until you built the North-Tron." instead;
		if player does not have yard ray, say "You don't have a weapon to take down the Diktat Kid." instead;
		if murk rum is not in ZeroRez, say "You have the yard ray, but it isn't, well, charged." instead;
		if player does not have ME gem or player does not have Taboo Bat, say "You feel well equipped ... but well equipped enough?";

chapter Pact Cap

The Pact Cap is a wearable thing in Fun 'Nuf. "A pact cap sits here. You need to find the right way to accept it to begin your quest.". description is "It's no stetson, but it is less messy than a tahini hat, and it [if player has pact cap]feels[else]looks[end if] serviceable enough."

check taking off the pact cap: say "No, you...uh, made a pact." instead;

cap-pace is a truth state that varies. cap-pace is false.

cap-ever-pace is a truth state that varies. cap-ever-pace is false.

check taking pact cap: say "The Flee Elf shakes its head. 'Too direct. You're not doing it right. Don't [b]TAKE[r] it, precisely. A different ... possess-op.'" instead;

section pack cap

packing is an action applying to nothing.

understand the command "pack cap" as something new.

understand "pack cap" as packing.

carry out packing:
	if the player has the pact cap, say "You already did.";
	say "Yes, that's how to get the cap. You are ready to go![paragraph break]'Good job! Here's a set o['] notes to replace that darer ad,' the Flee Elf says. It salutes you before becoming, err, the FLED Elf. Where the elf went, a big TIX EXIT sprouts up. You don't have any tickets or anything, though, so you'll have to worry about that later.[paragraph break]Perhaps it's not the most stylish thing ever, but at least they didn't make you wear a bib.";
	move flee elf to ZeroRez;
	now Tix Exit is in Fun 'Nuf;
	now darer ad is in ZeroRez;
	now player has set o notes;
	now player wears the cap;
	now all cappy rooms are available;
	score-inc; [Dim Mid/pack cap]
	the rule succeeds;

section pace cap

paceing is an action applying to nothing.

understand the command "pace cap" as something new.
understand the command "pacy cap" as something new.

understand "pace cap" and "pacy cap" as paceing.

carry out paceing:
	if kayo yak is in ZeroRez, say "You had enough high-speed fun for one game. If you want to zip around the map, though, GT is always an option." instead;
	if pact cap is in Fun 'Nuf, say "That'll work later, but you need something a little different to actually TAKE the pact cap." instead;
	if cap-pace is true, say "It's already a pace cap." instead;
	if mrlp is Grebeberg, now cap-pace is whether or not cap-pace is true;
	if cap-ever-pace is false:
		score-inc; [Dim Mid/pace cap]
		now cap-ever-pace is true;
		say "[if mrlp is not Grebeberg]You realize it can sort of be a pace cap, too, but there isn't enough open space to run around productively for too long.[else]You suddenly feel [pace-of]![end if]";
	else:
		say "[if mrlp is not Grebeberg]That should work, but it doesn't, here. Maybe try over in Grebeberg?[else]You suddenly feel [pace-of].[end if]";
	the rule succeeds;

to say pace-of:
	say "[if cap-pace is true]full of deep speed[else]slower[end if]"

check going to Fun 'Nuf:
	if cap-pace is true, say "You feel like you can slow down a bit. You adjust the pace cap back to a pact cap.";
	now cap-pace is false;

[helpdocs below]

chapter darer ad

the Darer Ad is a helpdoc. The player carries the Darer Ad.

description of Darer Ad is "No LOL on? SEE, REFER-EES! Do! Nod!"

after examining the Darer Ad for the first time:
	say "Well, you need something with a bit more concrete advice. Maybe you'll find it quickly enough.";
	continue the action;

chapter set o notes

the set o notes is a helpdoc. description is "There's some general vague advice about making a North Tron to defeat the Diktat Kid, but first you'll have to defeat Madam and the Yuge Guy, Evil Clive. The Set O Notes also points out you'll need to find items and use them together, but since you're on a quest, you already sort of knew that."

after examining set o notes for the first time, say "Maybe you'll get something even more detailed than the Set O Notes later."

chapter tile lit

the tile lit is scenery in Fun 'Nuf. "It's a rough compass, with GREBEBERG west by it, YELPLEY east, Evac Ave south and Dirge Grid north. You can't seem to go [if flee elf is in ZeroRez]south and [end if]north, though." [ic]

check taking tile lit: say "It's sort of embedded into the ground. It looks nice there, anyway, and it's useful for information."

chapter elite tile

the elite tile is scenery. "Done? Nod![line break]Nif-T-Fin!"

book Dirge Grid

Dirge Grid is a room in Mid Dim. "The only way back is south[if Diktat Kid is in Dirge Grid], but you can't really run away from the Diktat Kid[else], and you might as well go that way, now you've vanquished the Diktat Kid[end if]. A Tru Hurt is pointed at you, but if you deal with the Kid, that won't matter."

check going to Dirge Grid: if test set is not in ZeroRez, say "[if player does not have yard ray]You don't have an adequate weapon[else]You need to get some practice with the Yard Ray before going north[end if]." instead;

printed name of Dirge Grid is "[if Diktat Kid is in ZeroRez]Top Spot[else]Dirge Grid[end if]"

after looking in Dirge Grid for the first time:
	say "The Diktat Kid booms 'Engage le jeu que je le gagne!'";
	continue the action;

check going south in Dirge Grid: if Diktat Kid is in Dirge Grid, say "'Mom! SOS! LOL! SOS! Mom!' the Diktat Kid mocks you.[paragraph break]You can't chicken out. You must be close!" instead;

chapter Diktat Kid

Diktat Kid is a proper-named person in Dirge Grid.

chapter Knife Fink

the Knife Fink is a person in Dirge Grid. "A Knife Fink wields some leet steel here."

the Knife Fink carries the leet steel.

the leet steel is peripheral. description is "The Knife Fink is waving it around with intent. It looks more like fancy cutlery than an effective weapon, though. But you don't want the Knife Fink to get close enough so you know for sure."

instead of doing something when second noun is a peripheral thing:
	if action is procedural, continue the action;
	blanket-reject second noun instead;

instead of doing something with a peripheral thing:
	if action is procedural, continue the action;
	blanket-reject noun instead;

instead of useoning something with a peripheral thing:
	if action is procedural, continue the action;
	blanket-reject second noun instead;

to blanket-reject (bj - a thing):
	repeat through table of periphery:
		if itm entry is bj:
			say "[reject entry][line break]";
			continue the action;
	say "While [the noun] doesn't need any detailed futzing, I don't have a detailed message for why. I need to fix that. Sorry."

table of periphery
itm	reject
leet steel	"You want to focus on the Knife Fink and not the leet steel."
part strap	"You want to focus on the Verses Rev and not the part strap."
Tru Hurt	"If you dispose of the Diktat Kid, the Tru Hurt won't be able to hurt you."
Waster Fretsaw	"If you dispose of the Diktat Kid, the Waster Fretsaw won't be able to hurt you."

chapter Verses Rev

the Verses Rev is a person in Dirge Grid. "A Verses Rev wields a part strap here."

the Verses Rev carries the part strap.

the part strap is peripheral. description is "It's more for overzealous religious flagellation to be daunting. A more practical weapon just might defeat it."

chapter x-ite tix

the x-ite tix are a plural-named thing. description is "A duo. Loud. They promise passage to an EVEN MORE EXCITING AND EXPANSIVE ADVENTURE THAN THE ONE YOU'VE JUST FINISHED.[paragraph break]The words 'WOW' and 'YAY' are also written about ten times on each ticket."

understand "xite" and "xite tix" as x-ite tix.

chapter tru hurt

the tru hurt is peripheral scenery in Dirge Grid. "The Tru Hurt is here, and it's aimed at you!"

the waster fretsaw is peripheral scenery in Dirge Grid. "The less thought of, the better. Without the Diktat Kid to operate it, it'll be less harmful."

chapter emiting

emitted is a truth state that varies.

emiting is an action applying to one topic.

understand the command "emit" as something new.

understand "emit [text]" as emiting when player has yard ray.

carry out emiting:
	if murk rum is not in ZeroRez, say "The Yard Ray isn't charged enough to emit anything." instead;
	if player is in location of Yuge Guy, say "No...the Yuge Guy needs to be defeated by other means." instead;
	if Diktat Kid is in ZeroRez, say "You already got rid of the Diktat Kid." instead;
	if the topic understood matches "noontime":
		say "BOOM! The yard ray emits so much light, you immediately have to switch it off. Well, that was a good start. Now you want to make sure you can aim it at something that can be destroyed.";
		now emitted is true;
		score-inc; [Dim Mid/emit noontime]
		the rule succeeds;
	say "No, that's not quite what to emit.";
	the rule succeeds;

part Grebeberg region

book Seer Trees

Seer Trees is west of Fun 'Nuf. It is in Grebeberg. "East leads back to Fun [']Nuf[if Yawn Way is visited] and Yelpley[end if], but the other directions lead to further rustic adventure.".

check going in Seer Trees:
	if noun is not east and stark rats are in Seer Trees, say "The stark rats block you from going anywhere. At least they are not banging stop pots." instead;

the stark rats are a plural-named thing in Seer Trees. "Stark rats impede you every way except back east.". description is "They are scurrying about. There are too many to get through without getting bitten."

check taking stark rats: say "There are too many, and they'd probably bite you, anyway." instead;

check dropping party trap in Seer Trees: try useoning party trap with stark rats instead;

book Cold Loc

Cold Loc is north of Seer Trees. It is in Grebeberg. "Past sap drips from a rift fir that blocks a steep drop west."

A rift fir is scenery in Cold Loc. "It's a rife fir. You're not getting past it, but you don't need to."

the past sap is scenery in Cold Loc.

check going west in Cold Loc: say "The rift fir blocks the way to much more dangerous places." instead;

check taking past sap: say "[if liar grail is in ZeroRez]You probably don't need any more past sap, now that you used it to dispose of the Liar Grail.[else]It's too sticky to carry around by itself. Maybe have a container carrying it?[end if]"

instead of doing something with past sap:
	if action is procedural, continue the action;
	say "[if liar grail is in ZeroRez]With the liar grail gone, you don't want to have to deal with the past sap again[else]The past sap might be useful, but you need a way to take it, first[end if]."

chapter King Nik

King Nik is a person in Cold Loc.

chapter Spur Ups

the Spur Ups are a plural-named thing. description is "Boy! These are so much better than that round tuitt a teacher gave you as a joke. If you could mass produce and market them when you got back, what a motivational fad you could start--and profit from."

book Flu Gulf

Flu Gulf is north of Cold Loc. It is in Grebeberg. "North and east, it's, oh, too H2O. The passage is clear back south, but [if scorn rocs are in Flu Gulf]scorn rocs['] gaze blocks you going west[else]west past the scorn rocs seems a bit treacherous[end if]."

the Gulf Lug is a proper-named person in Flu Gulf. "The Gulf Lug stands here, holding his stomach.". description is "He looks slightly ill. Maybe you could help him.".

the cash sac is a thing. description is "It's full of currency--currency which you don't know whether you can spend anywhere."

chapter scorn rocs

The scorn rocs are plural-named scenery in Flu Gulf. "While they're motionless, their stare drives you back. They're fiercely proud and blazingly colored."

check going west in Flu Gulf when scorn rocs are in Flu Gulf:	say "The scorn rocs remain motionless, but their gaze freezes you as you try to go west." instead;

book Sneer Greens

Sneer Greens is west of Flu Gulf. It is in Grebeberg. "[if Yuge Guy is in sneer greens]Despite the impressive view, the place has gone to pot.[else]Nicer with the Yuge Guy gone. Still, it's...[end if][paragraph break]You can only go back east."

Sneer Greens is above Flu Gulf.

printed name of Sneer Greens is "[if Yuge Guy is in sneer greens]Sneer Greens[else]Et Tu Butte[end if]"

understand "et tu butte" and "et/tu/butte" and "et tu" and "et/tu butte" as Sneer Greens when Yuge Guy is in Sneer Greens.

after looking in Sneer Greens for the first time:
	say "The Yuge Guy calls 'BOO! NOOB!' just to reinforce his contempt.";
	continue the action;

every turn when player is in Sneer Greens:
	if a random chance of 1 in 2 succeeds, say "The Yuge Guy mumbles '[one of]Main, I am![or]Soros! Soros![or]Huge! Guh![or]Rofl! For...[or]Gibe! Big![or]Misdeeds? I'm ...[in random order]'";

check going east in Sneer Greens:
	if Yuge Guy is in Sneer Greens, say "'LOW AWOL!' the Yuge Guy booms, as you run away."

chapter Yuge Guy

Yuge Guy is a proper-named person in Sneer Greens. description is "Bilgy. Glib."

understand "evil/clive" and "evil clive" as Yuge Guy.

chapter murk rum

the murk rum is a drinkable thing. description is "You're not sure what's in it, but boy, it looks potent."

book Dumb Mud

Dumb Mud is west of Seer Trees. It is in Grebeberg. "A turf rut to the south is [if poo coop is in ZeroRez]filled in enough[else]too deep[end if] to cross. The way west is [if gnu dung is in ZeroRez]blocked by gnu dung[else]free[end if]. [if lie veil is in Dumb Mud]A lie veil blocks your way[else]With the lie veil removed, you can go[end if] north."

The lie veil is scenery in Dumb Mud. "It looks untrustworthy."

the gnu dung is in Dumb Mud. "Gnu dung blocks exit west from the Dumb Mud.". description is "You're not an expert in this sort of biology, but given what you've seen so far, it's probably from a gnu."

check going west in Dumb Mud:
	if gnu dung is in Dumb Mud, say "Not through the gnu dung you aren't." instead;

check going south in Dumb Mud:
	if poo coop is not in ZeroRez, say "The turf rut is too deep. You need a way to fill it in." instead;
	if Mont Nom is unvisited, say "With the turf rut filled in, the way across remains stable, and it even smells okay! Bonus! You climb up to...";

check going north in Dumb Mud:
	if lie veil is in Dumb Mud, say "As you touch the lie veil, you shake your head. No. You don't really want or need to explore north. Surely there's some better place to be? Perhaps you're not 100% prepared for the lie veil's thought provoking paradoxes, and it's doing you a favor pushing you back? You try to walk further north, but somehow you wind up walking back south." instead;

instead of doing something with gnu dung:
	if action is pro-and-use, continue the action;
	say "Eewee! (You probably want to deal with the gnu dung indirectly.)"

chapter turf rut

The turf rut is scenery in Dumb Mud. "[if poo coop is in ZeroRez]Since you filled it in, you can walk across it to the south[else]It's deep enough to prevent you going south[end if]."

understand "turd rut" as turf rut when poo coop is in ZeroRez.

book Le Babel

Le Babel is north of Dumb Mud. It is in Grebeberg. "This is a weird place. Nothing makes sense here. A voodoo v blocks passage--and sight--everywhere except back south."

chapter voodoo v

the voodoo v is scenery. "Maybe you could walk across it without getting hurt, but you doubt it. It's there, and it's immovable."

instead of doing something with voodoo v:
	if action is procedural, continue the action;
	say "You don't want or need to mess with the voodoo v.";

chapter opossum

the opossum is a thing in Le Babel. "An opossum crouches here, looking scared. Maybe you can help it be less frozen by fear.". description is "Cute little thing, lovely fur, but it could use a friendly gesture."

instead of doing something with opossum:
	if current action is taking, say "The opossum bounds away. Perhaps you can be less grabby." instead;
	if action is procedural, continue the action;
	if current action is mussing, continue the action;
	say "You probably want to find a way to comfort the poor scared opossum."

section mussing

opmussing is an action applying to nothing.

mussing is an action applying to one thing.

understand the command "muss" as something new.

understand "ruff fur" as opmussing when opossum is quicknear.

instead of opmussing, try mussing opossum instead.

understand "muss [something]" as mussing.

carry out mussing:
	if noun is not opossum, say "You don't need to muss [the noun]." instead;
	say "You reach over and give the opossum a loving scratch. It perks up! Suddenly, it looks around and runs off, in search of home, wherever that is.";
	abide by the llp rule; [muss opossum]
	move opossum to ZeroRez;
	the rule succeeds.

chapter balsa slab

The Balsa Slab is a thing in Le Babel. "A balsa slab is just lying here. You're not sure how it get here, but here it is.". description is "It appears grooved, as if someone has labeled places to cut it to make it into something useful."

report taking the Balsa Slab: say "It's light. It weighs ... not a gigaton."

chapter Bro Orb

the Bro Orb is a thing in Le Babel. "[one of]An orb hovers in the air. You know it must be a Bro Orb[or]The Bro Orb still hovers in the air[stopping]. You would love to take it, but you're not sure if you're worthy.". description is "Looking into the Bro Orb, you start to understand social, subjective knowledge you assumed only jerks know. Maybe they know it better, but you realize you are cheating yourself if you don't learn it.". [??bros orb]

check taking Bro Orb:
	if player has Bro Orb, say "You already have it." instead;
	if player does not have tenet, say "A voice in your head says 'WANT? NAW!'[paragraph break]You aren't sure you can handle the potentially corrupting power of the Bro Orb. [if player has sage gas]The sage gas helps you to understand how things could go wrong, but still, you're a bit worried[end if]. Maybe if you had some more balance to your thinking." instead;
	say "You wonder if you should take the Bro Orb. If you deserve to. But you reread the tenet and whisper to yourself, 'Nag, ol['] slogan,' and feel balanced enough to take the Bro Orb and accept the responsibility for doing so.";

report taking Bro Orb:
	now tenet is in ZeroRez;
	say "Taking the Bro Orb requires two hands. You watch the tenet flutter off beyond the Voodoo V. Oh, well. You carry the tenant's message in your mind and heart and stuff anyway, now.";

book Mont Nom

Mont Nom is south of Dumb Mud. It is in Grebeberg. "An ark of okra blocks passage every way except back north here."

Mont Nom is above Dumb Mud.

The ark of okra is scenery in Mont Nom. "You always found okra, or the idea, icky, but the ark is beautiful enough, you sort of wonder how it'd taste."

instead of eating ark of okra: say "You don't know how long it's been out here. It's probably, like, the vegetable version of wax fruit."

the martini tram is a tronpart. "That martini tram that appeared from Mont Nom is here.". description is "The martini tram looks like it'll provide a handy base for the future North-Tron.".

chapter Ian

Ian is a person in Mont Nom.

chapter nailing

nailing is an action applying to one thing.

understand the command "nail" as something new.

understand "nail [something]" as nailing when player is in Mont Nom and Ian is in Mont Nom.

carry out nailing:
	if Ian is in ZeroRez, say "There's nobody named Elian to nail later in the game, so this isn't an action you need to take any more." instead;
	if noun is not Ian, say "You'll know what or whom to nail, and that's not it." instead;
	say "You wait and hide. After a while, you catch Ian picking his nose absent-mindedly. You call him on it! In the presence of food, no less! Ian hurries away in shame across the Turf Rut. He takes one look at the, um, bridge and realizes that if he hadn't DONE anything gross, he wouldn't have to CROSS anything gross.";
	move Ian to ZeroRez;
	score-inc; [Grebeberg/nail ian]
	the rule succeeds;

book Ooze Zoo

Ooze Zoo is south of Seer Trees. It is in Grebeberg. "[if sleep eels are in Ooze Zoo]Sleep eels block passage south, but you can still go back north[else]With the sleep eels gone, you can go north, or south to [s-dray][end if]."

the sleep eels are plural-named people in Ooze Zoo. "The sleep eels squirm. Maybe there's a humane way to move them out."

to say s-dray:
	say "[if Frush Surf is visited]the Frush Surf[else]a coastal place[end if]"

book Frush Surf

Frush Surf is south of Ooze Zoo. "Slate metals are here by the shore. They're too heavy to move unless you managed to cut a piece off of them.". It is in Grebeberg.

[Line Nil is scenery in Frush Surf.]

stamp mats are a thing in Frush Surf.

The Kayo Yak is a chaser in Frush Surf.

chapter yakokaying

yakokaying is an action applying to nothing.

understand the command "yakokay" as something new.
understand the command "yak okay" as something new.

understand "yak okay" as yakokaying.

carry out yakokaying:
	if ergot ogre is in ZeroRez, say "[if yak is in location of player]The yak has served you well. It deserves a rest.[else]You relive past glories. Why not?[end if]" instead;
	if yak is in location of player and ergot ogre is in location of player:
		say "The kayo yak surges at the ergot ogre and knocks it over with a few ... smart rams! The ergot won't spread to the yak's horns, so that's good. The ogre dusts itself off and walks away, embarrassed. The yak, for its part, looks relaxed--almost like a tao goat--and heads off, not to the Frush Surf, but somewhere calmer.[paragraph break]You think you hear an elk cackle in the distance.";
		score-inc; [Grebeberg/YAK OKAY]
		now yak is in ZeroRez;
		now ergot ogre is in ZeroRez;
		now being-chased is false;
		the rule succeeds;
	if yak is in location of player, say "The yak sees nothing to attack." instead;
	say "There's no yak to say okay to." instead;
	the rule succeeds;

book Moo Room

Moo Room is east of Frush Surf. It is in Grebeberg. "You can't see any cows, but you occasionally hear them. From what you can see, the farm belongs to a Mr. A, who is not around. The only way back is west."

the poo coop is in Moo Room. "A poo coop sits here. Thankfully, it looks empty.". description is "While it's 1/4 too small to be a pooch coop, it's 1) empty and 2) somehow bigger on the inside than the outside. Maybe it can clean up a dirty area. Well, a less dirty area than the Moo Room where you found it."

chapter yahoo hay

the yahoo hay is scenery in Moo Room. "Just being around the yahoo hay makes you feel, man, this can be used to build even cooler stuff."

chapter straw arts

the straw arts are a plural-named thing. description is "Whatever they are, you made them, and you hope it expresses something or other."

chapter moor broom

the moor broom is a thing. description is "It's made of that enact came amd the yahoo hay, and just looking at it, you feel almost excited about cleaning."

book Mire Rim

Mire Rim is west of Dumb Mud. It is in Grebeberg. "A made dam blocks your way west. You can go north, south and east here."

the made dam is scenery in Mire Rim. description is "It looks hastily put together, and you're not sure if it's actually protecting any great torrent of water."

The Eroded Ore is a thing. description is "You're no expert metallurgist, but it's dim and porous and probably not as potent as it could be."

book Birch Crib

Birch Crib is south of Mire Rim. It is in Grebeberg. "This is a homey little north-south passage, [if tent net is in ZeroRez]especially now that you helped the Code Doc add some furnishings[else]but it doesn't quite feel quite as comfortable as it should, yet[end if]."

Code Doc is a person in Birch Crib. "[one of]Someone is pacing back and forth here, muttering 'More ROM! MORE Rom! MORE ROM!' They look up as you walk in. 'Oh. Sorry. Hi. I'm the Code Doc. I can help you with, like, technical stuff, if you need.'[or]The Code Doc paces back and forth here.[stopping]"

chapter Spa Maps

Spa Maps are a plural-named proper-named thing. description is "[if sage gas is not off-stage]The maps seem old hat now you've gotten the sage gas[else if maps-explained is false]You can't quite make sense out of them. There's Gobs-Bog and Go-By Bog, and one is a lot safer than the other, but you're not sure which[else]The spa maps clearly demark Go-By Bog and Gobs Bog and even Goblin-Nil Bog, which probably contains a troll or two. And no hospitality[end if]."

check examining spa maps:
	if player is not in Apse Spa, say "It doesn't look like the maps are useful here." instead;
	try useoning spa maps with go-by bog instead;

maps-explained is a truth state that varies.

book Lair Trial

Lair Trial is south of Birch Crib. It is in Grebeberg. "This lair bends north and east, [if ergot ogre is in ZeroRez], and with the trial over, you're free to go either way[end if]."

the ergot ogre is a person in Lair Trial. "An ergot ogre blocks the way east.". description is "It looks vicious, and you don't want it touching you, due to disease and possible dismemberment. You need to get the ogre out of the way, somehow.".

check going east in Lair Trial: if ergot ogre is in Lair Trial, say "Not with the ergot ogre guarding the way." instead;

book Motto Bottom

Motto Bottom is east of Lair Trial. It is in Grebeberg. "Go-fog blocks passage every way except back west."

chapter go fog

the go fog is scenery in Motto Bottom. understand "gofog" and "go-fog" as go fog. "The go fog is very opaque. It would be too easy to get lost in."

instead of doing something with go fog:
	if action is procedural, continue the action;
	say "The go fog is very dense. It pushes you back west even as you look at it. As if to say, go away, and also, get going with what you want and need to do."

chapter guru rug

The guru rug is a thing in Motto Bottom. "A guru rug lies here. You're not sure how impressed you should be by it.". description is "Hmm, it's not fully tacked to the ground. Maybe you could slip the right thing in or under. Its simplicity leads you to believe it holds even greater secrets within."

check taking guru rug: say "'Egad! Adage!' you think to yourself. You're not up to any great philosophy. Maybe something less heavy than the guru rug." instead;

chapter tenet

The tenet is a thing. description is "It seems a bit too cliche, but you have the wisdom to get the encouragement you need from it."

check useoning tenet with Bro Orb: try taking Bro Orb instead;

book Swamp Maws

Swamp Maws is north of Mire Rim. It is in Grebeberg. "An edits tide blocks your way west. You can go north or south here. [if Known Wonk is in ZeroRez]The Known Wonk's Tru-Yurt is here. It looks really messy[end if]."

check going north in Swamp Maws when Known Wonk is in Swamp Maws: say "The Known Wonk pushes you back. 'You don't know how weird it is to the north. But I know a thing or two about adventuring theory.'" instead;

chapter Known Wonk

The Known Wonk is a person in Swamp Maws. "The Known Wonk stands by a Tru Yurt, [one of]figuring you'll have to do, even though you're not as interesting as a book[or]waiting for intellectual conversation[stopping]."

chapter  Exam Axe

The Exam Axe is a thing. description is "Just looking at the exam axe, you feel as though you've been right about stuff. Maybe not right or morally superior, but you're able to see through obvious nonsense. You know it will help you with some max-exam, somewhere."

chapter Tru Yurt

The Tru Yurt is scenery in Swamp Maws. "It looks really messy. THe Known Wonk said it needed a good cleaning."

chapter Edits Tide

The Edits Tide is scenery in Swamp Maws. "A voice from the edits tide seems to say [if spa maps are off-stage]that you could use its proofreading skills[else]it has labored enough for you[end if]."

book Calcific Lac

Calcific Lac is north of Swamp Maws. It is in Grebeberg. "A Tao Boat rests at the edge of Calcific Lac. [eli-ile].[paragraph break][if dork rod is in ZeroRez]The Tao Boat that helped you get at peace with things is here[else]A Tao Boat rests on the shore, here[end if]."

to say eli-ile:
	if elope pole is in ZeroRez:
		say "That kayak you took to Elided Ile is here, too";
	else:
		say "There's a kayak, too. ";
		if NULL ILLUN is in ZeroRez:
			say "[one of]And wait! If you look into the distance, you see something! Elided Ile! Just as the Known Wonk said it had to be somewhere! The Wonk's calculations and predictions were all right[or]You see Elided Ile in the distance. Maybe some day, you will get there[stopping]";
		else:
			say "You scan in the distance for anywhere the kayak might take you, but you can't find anywhere, yet";

chapter kayak

The kayak is scenery in Calcific Lac. "It's, well, just a kayak. It doesn't have anything to steer it with, though. Maybe you have something, or you could find something."

instead of doing something with kayak when elope pole is in ZeroRez: [??use X on kayak]
	if action is procedural, continue the action;
	say "The kayak has served its purpose."

chapter tao boat

The Tao Boat is scenery in Calcific Lac. "It rocks gently on the waves. You [if dork rod is in ZeroRez]wonder what it's like inside, if you're worthy[else]look back on your time inside with fondness. It put you at peace with the job you have ahead[end if]."

chapter dork rod

The dork rod is a thing. description is "It's kind of neat and quirky, but it's not shiny enough to be the famed Dorada Rod."

chapter enact cane

The Enact Cane is a thing. description is "Just holding it makes you feel snazzier and more authoritative and with it. It's slightly mussed at one end, as if maybe you could attach something there."

chapter taboo bat

The taboo bat is a thing. description is "You feel rebellious just holding this thing. One look, and visions of chances taken and authority bucked in your youth, sensible or not, swirl at you for a bit."

chapter you buoy

the you buoy is a thing. description is "It's reallly plain, now you look at it. Also, as you look it over, it rattles a bit."

check opening you buoy: say "You can't find an opening. Sadly, this is sllightly trickier than Zork I. Slightly." instead;

chapter ME gem

the ME gem is a thing. description is "You feel a strong urge to keep this and not share it, because of all the crazy things you did to get it, but you know that's not quite right.[paragraph break]Also, it looks nothing at all like the emerald in Zork I, so stop thinking that."

book Apse Spa

Apse Spa is east of Cold Loc. It is in Grebeberg. "The Apse Spa is covered with dose sod, which you can't take--you're not sick--but it looks beautiful. Also, Go-By Bog expands every way except back west[if sage gas is off-stage]. You could traverse it, if you knew what you were doing[else]You already went through it, though[end if]."

the dose sod is scenery in Apse Spa. "It looks ucky, but given you're in an Apse Spa, it may have health benefits for those that need them."

Go-By Bog is scenery in Apse Spa.

chapter sage gas

some sage gas is a thing. description is "It's pretty translucent--you're just glad you've been able to bottle it up in the maps, somehow.".

part Yelpley region

book Yawn Way

Yawn Way is east of Fun 'Nuf. It is in Yelpley. "Not much to do here, and it's quiet enough it could be Yawling-Nil way, but Art Xtra is to the north, and My Gym is to the south. An alley is to the east."

book My Gym

My Gym is south of Yawn Way. It is in Yelpley. "You can go back out south to Yawn Way. There's also passage west."

chapter Dave

Dave is a person in My Gym. initial appearance is "[one of]A fellow walks over to you and booms 'I'M Dave!' You freeze, and after a few seconds, he whispers, 'Dud.'[or]Dave is here, keeping an eye on you, guarding the passage west.[stopping]". description is "Dave is big and strong and fast."

instead of doing something with Dave:
	if action is procedural, continue the action;
	if current action is evadeing, continue the action;
	say "Looks like you'll need to do something special with, or to, Dave. Nothing destructive. But psych him out, somehow."

check going west in My Gym when Dave is in My Gym: say "Dave says, 'I can't let you do that, Hal. Ah!' There must be a succinct, clever way to sneak around him!" instead;

chapter sword rows

the sword rows are a plural-named thing in My Gym. "Some tiny sword rows lie here[if Dave is in My Gym] behind Dave[end if].". description is "[if Dave is in My Gym]They're tiny. You can't get a good look with Dave guarding them[else]They could probably cut or chip away at something, if you needed them to[end if]."

chapter not-a-baton

The not-a-baton is a thing. description is "It is wood and round and long. It's too long to be a baton, but it's the right shape to be something powerful. It just sort of feels lifeless right now."

chapter evadeing

evadeing is an action applying to one thing.

understand the command "evade" as something new.

understand "evade [something]" as evadeing.

does the player mean evadeing Dave: it is very likely.

Dave-evade is a truth state that varies.

carry out evadeing:
	if noun is Dave:
		if Dave-evade is true, say "You don't need to evade Dave again.";
		say "You evade Dave! Deked! Deked![paragraph break]Behind Dave, you find a pair of scepsis pecs. You're suspicious they actually work, but as you test them out, a surge goes through you. After a few seconds, you've half forgotten you have them.";
		now Dave is in ZeroRez;
		now Dave-evade is true;
		score-inc; [Yelpley/evade dave]
		now all davey rooms are available;
	else:
		say "There's only one person you need to evade in this game.";
	the rule succeeds.

book Worn Row

Worn Row is west of My Gym. It is in Yelpley. "[if workrow is true]Three machines are here[else if wordrow is true]A tract cart is here, [tract-status][else]It's pretty empty here, but maybe you could make it a bit more active and cheery[end if][if redness ender is in Worn Row]. There's also a redness ender here, but it looks dangerous to get too close to[end if]."

printed name of Worn Row is "[if wordrow is true]Word[else if workrow is true]Work[else]Worn[end if] Row"

understand "work row" and "work" as Worn Row when workrow is true.
understand "word row" and "word" as Worn Row when wordrow is true.

chapter redness ender

the redness ender is a thing in Worn Row. "It also seems to double as a redness SENDER, as when you get close to look at it, an ominous red dot appears on you. You back off."

instead of doing something with redness ender:
	if action is procedural, continue the action;
	say "You don't want to do anything crazy with it."

chapter tract cart

the tract cart is scenery in Worn Row.

tract-trace is a truth state that varies.

to say tract-status:
	if tract-trace is false:
		say "but it's closed";
	else:
		say "[if number of books in Worn Row is 1]almost empty[else]holding a few books[end if]"

for printing a locale paragraph about a book (called bk):
	if bk is not mentioned:
		say "The tract cart contains [list of books in Worn Row].";
		now all books are mentioned;

chapter Rob

Rob is a person in Worn Row.

chapter test set

The test set is a thing. "A test set lies here, looking convoluted and -- well, open to abuse.". description is "You're not sure what it's good for, but now that you worked through all the machines, maybe you just need it to, well, try stuff before your final confrontation.".

check taking the test set: say "It's too unwieldy. But it has to be useful for something." instead;

chapter boreing

boreing is an action applying to one thing.

understand the command "bore" as something new.

understand "bore [something]" as boreing.

does the player mean boreing Rob: it is very likely.

carry out boreing:
	if noun is not a person, say "You should try to bore people, not things." instead;
	if noun is not Rob, say "Wrong thing or person to bore." instead;
	say "You bore Rob successfully. He wanders off.";
	move Rob to ZeroRez;
	score-inc; [Yelpley/bore rob]
	the rule succeeds.

chapter workables

a workable is a kind of thing. a workable has a number called useleft.

description of a workable is "[if useleft of item described is 0]It's broken now, but you got good use out of it[else if useleft of item described is 3]The only way you can tell it from the other two is because [printed name of item described in upper case] is printed on the front[else]Since you had success using [the item described], you feel more comfortable using it again[end if]."

the reifier is a workable. useleft is 3.
the reviver is a workable. useleft is 3.
the rotator is a workable. useleft is 3.

to wear-down (w - a workable):
	decrement useleft of w;
	if useleft of w is 0, say "You watch as [the w] sputters and dies. Well, you got a lot of good use out of it, and hopefully you won't need any more.";
	if useleft of w is 1, say "[the w] wheezes emphatically. Hopefully, you won't need to use it too much more.";
	if machuses is 0:
		say "[line break]With [list of workables] all destroyed, Work Row shakes a bit more. The machines fall out from a wall, revealing something behind ... a test set. It's big and huge and you can't move it, but who knows what it'll be useful for later?";
		move test set to Worn Row;
		now all workables are in ZeroRez;

to decide which number is machuses:
	let retval be 0;
	repeat with Q running through workables:
		increase retval by useleft of Q;
	decide on retval;

instead of inserting into:
	if second noun is a workable, try useoning noun with second noun instead;
	continue the action;

instead of putting on:
	if second noun is a workable, try useoning noun with second noun instead;
	continue the action;

instead of switching on a workable, say "You need to USE something with [the noun]."

instead of taking a workable, say "Too heavy. But you can USE something on it.";

section reiing

reiing is an action applying to one thing.

understand the command "rei" as something new.

understand "rei [something]" as reiing when player is in Worn Row and reifier is not off-stage.

carry out reiing:
	if reifier is not in Worn Row, say "You need to bring back Work Row." instead;
	try useoning noun with reifier instead;

section reving

reving is an action applying to one thing.

understand the command "rev" as something new.

understand "rev [something]" as reving when player is in Worn Row and reviver is not off-stage.

carry out reving:
	if reviver is not in Worn Row, say "You need to bring back Work Row." instead;
	try useoning noun with reviver instead;

section roting

roting is an action applying to one thing.

understand the command "rot" as something new.

understand "rot [something]" as roting when player is in Worn Row and rotator is not off-stage.

carry out roting:
	if reifier is not in Worn Row, say "You need to bring back word row." instead;
	try useoning noun with rotator instead;

chapter books

the tract cart is scenery. "It carries [number of books in Worn Row] books: [list of books in Worn Row]."

check examining tract cart:
	if number of books in Worn Row is 0:
		say "It's empty now. Maybe some day, someone will write a book like ";
		next-rand table of altbooks;
		say ". Maybe it could be you! But you don't have the time to read right now, really." instead;

a book is a kind of thing. description of a book is usually "It [if player carries the item described]is[else]looks[end if] really heavy and incomprehensible to you."

a book can be in-row or hidden. a book is usually in-row.

chapter pity tip

the pity tip is a thing. description of pity tip is "It's not THAT hard to figure what to do to the cart. There are only 26 choices, really.[paragraph break]NOTE: this document is good for free snack cans, not redeemable if purchaser is able to eat them."

chapter books in bookcase

TO IDIOT is a proper-named book. [Revolt Lover]
NULL ILLUN is a proper-named book. [Known Wonk]
ERA FARE is a proper-named book. [King Nik]
YOB ATTABOY is a proper-named book. [Sniffins]

chapter SOME DEMOS

there is a book called SOME DEMOS. It is proper-named and hidden.

gap-yet is a truth state that varies.

after examining a book:
	if gap-yet is false, say "You look for a page gap, and you're surprised there isn't one.";
	now gap-yet is true;
	continue the action;

chapter DWELT LEWD

DWELT LEWD is a proper-named hidden book.

dwelt-first is a list of text that varies. dwelt-first is { "Nell, Edna", "Leon", "Nedra", "Anita", "Rolf", "Nora", "Alice", "Carol", "Leo", "Jane", "Reed", "Dena" }.
dwelt-last is a list of text that varies. dwelt-last is { "Ned", "Dee", "Rena", "Joel", "Lora", "Cecil", "Aaron", "Flora", "Tina", "Arden", "Noel", "and Ellen" }

lewd-chap is a number that varies. lewd-chap is 0.
lewd-read is a truth state that varies.

check examining DWELT LEWD: if lewd-chap is 1 and lewd-read is true, say "Another round? Sicko.[paragraph break]";

description of DWELT LEWD is "[lewd-details][line break]".

to say lewd-details:
	let lelt be number of entries in dwelt-first;
	if lelt is not number of entries in dwelt-last, say "(BUG mismatched text array sizes) "; [should never happen, but just in case]
	increment lewd-chap;
	say "You read chapter [lewd-chap]: Dennis";
	repeat with X running from 1 to lewd-chap - 1:
		say ", [entry X of dwelt-first]";
	let temp be lewd-chap;
	let min be lelt + 2 - lewd-chap;
	if debug-state is true and lewd-chap > 1, say ","; [for reference, to see where the midpoint is]
	repeat with X running from min to lelt:
		say "[if X is not lelt],[end if] [entry X of dwelt-last]";
	say " Sinned";
	if lewd-chap is number of entries in dwelt-first + 1 and lewd-read is false:
		say ".[paragraph break]Whew! You've finished DWELT LEWD. After reading the blurb for the sequel, [']S SENSUOUSNESS, and a related Leer Reel, MUCH, you realize you've forgotten the plot [one of]already[or]yet again[stopping], if there was one. Sicko. (Hey, don't look at me, I just wrote the abstract code for the 'book.')";
		now lewd-chap is 0;
		now lewd-read is true;

section book verbs

books-carried-yet is a truth state that varies.

check taking a book:
	if player has noun, continue the action;
	if number of books in ZeroRez is 2 and SOME DEMOS is off-stage:
		say "As you pick up [noun], something else falls out. It's a smaller pamphlet, called SOME DEMOS. You pick it up.";
		now player has SOME DEMOS;
		now SOME DEMOS is in-row;
		continue the action;
	if number of books in ZeroRez is 3 and DWELT LEWD is off-stage:
		say "Oh dear. Hidden at the very back is a book called DWELT LEWD. I won't judge you if you wish to read it, but you have been warned.";
		now DWELT LEWD is in Worn Row;
		now DWELT LEWD is in-row;
		continue the action;
	if books-carried-yet is false:
		say "Oof! That's a heavy book. Looks like you'll only be able to take one at a time from the tract cart.";
		now books-carried-yet is true;
	else:
		if number of books carried by player is 1:
			let myb be random book carried by player;
			say "Oof! You need to put [myb] back in the tract cart to take [noun]. So you do.";
			now myb is in Worn Row;
		else:
			say "It's a bit unwieldy, but you manage to pick up [noun].";
	now player has noun instead;

chapter party trap

the party trap is a thing. description is "It looks roughly like the notes from the trap art, but you don't need to worry about the details. Poking around would be dangerous. It looks You just hope it works right when you USE it. That would be cool. I mean, if you used it on things that deserved it.".

chapter workrowing

workrowing is an action applying to nothing.

understand the command "workrow" as something new.

understand "work row" and "workrow" as workrowing when player is in Worn Row.

workrow is a truth state that varies.

ever-workrow is a truth state that varies.

this is the wornrow-change rule:
	if Rob is in Worn Row, say "That'll work when Rob is gone." instead;
	if Psi Wisp is in Worn Row, say "Right idea, wrong room to change to." instead;
	continue the action;

carry out workrowing:
	abide by the wornrow-change rule;
	if workrow is true, say "You're already in Work Row." instead;
	now workrow is true;
	now wordrow is false;
	say "Three machines [one of][or]re[stopping]appear[if wordrow is true], replacing the books[end if].";
	if ever-workrow is false, score-inc; [Yelpley/work row]
	now ever-workrow is true;
	now all workables are in Worn Row;
	now all books in Worn Row are in TempMet;
	if redness ender is in Worn Row, now redness ender is in TempMet;
	now tract cart is in TempMet;
	the rule succeeds;

to decide whether shouldnt-revert:
	unless player is in Worn Row, no;
	if workrow is false and wordrow is false, no;
	yes;

chapter wordrowing

wordrowing is an action applying to nothing.

understand the command "wordrow" as something new.

understand "word row" and "wordrow" as wordrowing when player is in Worn Row.

wordrow is a truth state that varies.

ever-wordrow is a truth state that varies.

carry out wordrowing:
	abide by the wornrow-change rule;
	if wordrow is true, say "You're already in Word Row." instead;
	now wordrow is true;
	now workrow is false;
	now all workables are in TempMet;
	now all books not in ZeroRez are in Worn Row; [?? what if you are carrying it]
	if redness ender is in Worn Row, now redness ender is in TempMet;
	move tract cart to Worn Row;
	if ever-wordrow is false, score-inc; [Yelpley/word row]
	now ever-wordrow is true;
	say "A tract cart [one of]appears, with a pity tip fluttering down. You take the tip[or]re-appears[stopping].";
	now all books in TempMet are in Worn Row;
	if pity tip is off-stage, now player has pity tip;
	the rule succeeds;

chapter wornrowing

wornrowing is an action applying to nothing.

understand the command "wornrow" as something new.
understand the command "Worn Row" as something new.

understand "wornrow" as wornrowing when player is in Worn Row.
understand "Worn Row" as wornrowing when player is in Worn Row.

carry out wornrowing:
	if psi wisp is in ZeroRez, say "You already used the redness ender for something." instead;
	if psi wisp is not in Worn Row, say "You don't want to face the redness ender alone." instead;
	say "Worn Row rematerializes, along with the redness ender. Zap! Zot! It locks on the Psi Wisp, which explodes in a shower of rage. But somehow, the Psi Wisp connects enough to zap the redness ender back. Whew.";
	move psi wisp to ZeroRez;
	now being-chased is false;
	now redness ender is in ZeroRez;
	now workrow is false;
	now wordrow is false;
	score-inc; [Yelpley/WORN ROW]
	the rule succeeds;

book Art Xtra

Art Xtra is north of Yawn Way. It is in Yelpley. "You can go south or north here."

[??mike kim likes the look of your pact cap]

the trap art is a thing in Art Xtra. "Some trap art sits here. It's free. You might as well take it.". description is "The trap art depicts a bunch of nasty, dirty animals being trapped--it's not a real trap, but maybe it could become one."

El Doodle is a thing. description is "A jumble of raw creativity, it looks like it could be a map--or something--but it sure could use some paring down."

after going to Art Xtra when El Doodle is off-stage:
	if stark rats are in ZeroRez:
		say "You tell Mike Kim about how you got rid of the stark rats. He's impressed. He mentions he has something else for you he can't decipher, but maybe you can. 'Someone left it for me. They called it El Doodle. Maybe you can make sense of it.'";
		now player has El Doodle;
	continue the action;

chapter Mike Kim

Mike Kim is a person in Art Xtra.

chapter state tats

the state tats are a plural-named thing. description is "They say OMG MO[']."

instead of doing something with state tats:
	if action is procedural, continue the action;
	say "You don't need to do anything to or with the state tats, now that you're wearing them.";

chapter soot tattoos

the soot tattoos are a plural-named thing. description is "They're blank now, but maybe if they were the right shape, they could help your image, somehow."

book Toll Lot

Toll Lot is east of Emo Dome. It is in Yelpley. "[if cross orc is in Toll Lot]While it's easy enough to go back west to the Emo Dome, that cross orc doesn't seem to want to let you go north or south[else]You can go north or south with the cross orc gone or, well, back west, too[end if]. A crag arc rises to the east[if UFO tofu is not in ZeroRez]--maybe it is hiding something[end if]."

[??snuff funs]

check going in Toll Lot:
	if cross orc is in Toll Lot:
		if noun is north or noun is south, say "The cross orc stops you from going [noun]. 'GIVE VIG!' it booms." instead;

chapter cross orc

The cross orc is a person in Toll Lot. "A cross orc paces quickly back and forth between the north and south exits, just to reinforce that you'd better not try to go that way with it around.". description is "It paces quickly, rubbing its fingers together, mumbling to itself about the fabled moola loom and loot stool, or a possible bank nab or bar grab to afford a nice place on Fee Reef."

chapter crag arc

the crag arc is scenery in Toll Lot. "It soars high and is too dangerous to climb[if UFO tofu is off-stage]. It's so intricate, maybe it is hiding something you can find[end if]."

chapter UFO tofu

some UFO tofu is a liquid ingredient. description is "It's a disturbingly squishy, yet impenetrable, block. I guess the preservatives mean it won't go bad too soon. I mean, more bad than tofu itself is."

book Gross Org

Gross Org is north of Toll Lot. It is in Yelpley. description is "[if etage gate is in Gross Org]An etage gate blocks your way north. You can go back south[else]With the etage gate gone, you can go north or south[end if]."

chapter stink knits

the stink knits are a plural-named thing in Gross Org. description is "The inside of the stink knits reveals they were sewn together by SMELLEMS.". "Stink knits, unwearable enough even without DAFT FAD printed on the front, lie here.".

check wearing the stink knits: say "That's physically possible, but no. No way." instead;

check taking when player is in Gross Org and Ned is in Gross Org: say "Not with Ned around, you won't." instead;

the etage gate is scenery in Gross Org. "It is locked and too strong to move."

instead of opening etage gate:
	if player has Ye Key, try useoning Ye Key with etage gate instead;
	try going north;

[instead of unlocking etage gate:
	try going north;]

check going north in Gross Org: if etage gate is in Gross Org, say "The etage gate blocks you." instead;

understand "evened" and "den evened" as Gross Org when Ned is in ZeroRez.

Ned is a person in Gross Org. "'Ned's Den!' someone booms. You're guessing their name must be Ned."

The Puce Cup is a thing in Emo Dome. "Someone has left a puce cup here.". description is "It's, well, puce, and it seems sturdy enough. It's currently [if puce cup is empty]empty[else if puce cup is sappy]full of Past Sap from the rift fir in Cold Loc[else]full of Dose Sod from the Apse Spa[end if]."

the puce cup can be empty, sappy or soddy. the puce cup is empty.

chapter Gate Tag

the Gate Tag is a thing. description is "It has an emblem a lot like what you saw north of the Emo Dome."

chapter denying

denying is an action applying to one thing.

understand the command "deny" as something new.

understand "deny [something]" as denying.

does the player mean denying Ned: it is likely.

carry out denying:
	if noun is Ned:
		say "Ned wants to get in an argument or fight, so you get in an argument over whether it's really necessary, and then you say, that wasn't so great, see? He slinks off, defeated.";
		now Ned is in ZeroRez;
		score-inc; [Yelpley/deny Ned]
	the rule succeeds;

book Deli Tiled

Deli Tiled is south of Toll Lot. It is in Yelpley. printed name is "[if yob attaboy is in ZeroRez]Bon Snob[else]Deli, Tiled[end if]". description is "There's not much decor in this [if yob attaboy is in ZeroRez]deli[else]fancy eatery, except for some snooty toons[end if]. You can exit to the north."

the gift fig is a solid ingredient. description is "Well, it's a fig."

the Dirt Rid is a thing. description is "The Dirt Rid looks old and decrepit. Sniffins probably wore it out converting the Bon Snob, but it's yours now."

the cave vac is a thing. description is "It looks a lot more powerful than the Dirt Rid."

Sniffins is a person in Deli Tiled. "[one of]You hear a sniff, and the proprietor introduces themselves as Sniffins, apologizing for how lame the ambience and decor are, but there's just no INSPIRATION to do better[or]Sniffins sniffs here[stopping]."

The Gorge Grog is in Deli Tiled. "Some Gorge Grog is here. It looks out of place in the Bon Snob, but Sniffins probably won't give it to you for free.". description is "Unsurprisingly, it is a product of Grog-Org."

check taking Gorge Grog: say "Sniffins chides you. 'It's worthless to us, but if there's anything tackier than bad alcohol, it's people who want to steal it!'[paragraph break]Maybe you could trade something for it." instead;

Nat's Tan is a thing in Deli Tiled. "A container of something called Nat's Tan is here."

check taking nat's: say "Ugh! It feels too gross to take. Maybe you need to build yourself up to figure how to take it." instead;

a tame mat is in Deli Tiled. "A tame mat reading Deli Tiled here."

check taking tame mat:
	say "That would be stealing." instead;

chapter snooty toons

The snooty toons are scenery. "They certainly add ambience to the place. You're not sure whether you should feel obliged to laugh at them or not good enough to laugh at them. But they're not really hurting you, you guess."

instead of doing something with snooty toons:
	if action is procedural, continue the action;
	say "The snooty toons can't help or harm you. They're just there."

chapter standing

standing is an action applying to one thing.

understand the command "stand" as something new.

understand "stand [something]" as standing.

carry out standing:
	if noun is nat's tan:
		say "It's tough, but you manage to stand the icky Nat's Tan enough to pick it up--it's for the good of youor adventure. Maybe you can dump it on someone or something who finds it even ickier than you do.";
		score-inc; [Yelpley/stand nat's]
		now player has nat's tan;
	the rule succeeds.

book Evaded Ave

Evaded Ave is north of Art Xtra. It is in Yelpley. "It's a bit sleazy in here. You can go back south. Or you can go east and west."

the Revolt Lover is a person in Evaded Ave. "[one of]Someone waving their fists and shouting at who-knows-what pauses as you walk by. 'I'm the Revolt Lover.' They peg you as not insurgent enough to deserve to visit west or east, without a proper gift[or]The Revolt Lover continues to pace back and forth here, making sure you don't sneak off any way but back south[stopping]."

check going in Evaded Ave:
	if Revolt Lover is in Evaded Ave:
		if noun is west or noun is east, say "The Revolt Lover blocks you. Maybe if you gave them a gift, they'd be more generous." instead;

chapter debt bed

the debt bed is a thing in Evaded Ave. "A small debt bed lies [if Revolt Lover is in Evaded Ave]behind the Revolt Lover[else]around for the taking[end if].". description is "It's small, so an actual person couldn't sleep on it."

check taking debt bed:
	if Revolt Lover is in Evaded Ave, say "The Revolt Lover won't let you." instead;

the stock cots are a plural-named thing.

book Trapeze Part

Trapeze Part is west of Evaded Ave. It is in Yelpley. "[if epicer recipe is off-stage]There's a ten level net on the floor, here. It could protect you from a long fall. You're convinced there must be something at the far end, but it's probably not safe to use the trapeze to get over until, well, you've done safety checks[else]The ten level net still sits here, and it'd be handy if there was anything else on the other side of it, but there isn't[end if]."

the ten level net is scenery in Trapeze Part. "[if epicer recipe is off-stage]It doesn't quite look sturdy enough. Maybe you could do something to fix it[else]It was sturdy enough to help you get the epicer recipe, and that's enough[end if]."

the tent net is a thing. description is "It doesn't have any pegs or anything to attach it to, to make a structure. But maybe it could complete a home somewhere."

chapter epicer recipe

the epicer recipe is a helpdoc. description is "You've seen recipes before, but this is a big interesting one! It describes how to make a north-tron, which will get you north of Fun [']Nuf.[paragraph break][tronpartlist][run paragraph on]"

to say tronpartlist:
	repeat with tp running through tronparts:
		say "--[tp][if player has tp or tp is in Fun 'Nuf] (got it!)[end if][line break]"

chapter tending

tending is an action applying to one thing.

understand the command "tend" as something new.

understand "tend [something]" as tending.

carry out tending:
	if noun is not level net, say "That doesn't need tending." instead;
	if player has epicer recipe, say "You already did what you needed with the net." instead;
	say "You adjust the ten level net. You're not sure how to make it work, but with some common sense, you make it. The set o['] notes gives surprising help. You climb and swing from the trapeze to the other side--falling into the ten level net about a hundred or so times--but the hundred and first bam! You notice an epic-er recipe on the other side.[paragraph break]It's a clear step up from the set o['] notes, which you won't be needing any more. Yay! There's also something labeled an elope pole, which you suspect may help you get away if and when you need to. Part of the net falls off, too. It'd make a nice tent: a tent net.";
	now player has elope pole;
	now player has tent net;
	now set o notes is in ZeroRez;
	now player has epicer recipe;
	score-inc; [Yelpley/TEND NET]
	the rule succeeds.

chapter elope pole

The elope pole is a thing. description is "It looks foldable, maybe even separable. You wonder where it could help you get."

book Yell Alley

Yell Alley is east of Evaded Ave. It is in Yelpley. "The only way back is west. The way east is blocked by a [if navy van is in Yell Alley]navy van... you're not sure[else]bomb mob... so that's[end if] where the yelling is from."

chapter navy van

the navy van is scenery in Yell Alley. "There seems to be no way to enter it. It has a small gig where you could maybe put something in."

understand "gig" as navy van.

chapter snack cans

the snack cans are a plural-named solid ingredient. description is "You're not sure what's in them, but whatever it is--well, you're not hungry enough. Yet.".

chapter Mayo Yam

the Mayo Yam is a liquid ingredient in Yell Alley. "A gross looking -- something -- is here. It's a mayo yam! It's a bit on the slimy side, and it's probably worse inside.". description is "Fortunately, the mayo yam's skin is sturdy enough to avoid being burst and making a mess. But you can still smell the mayo inside it, and there are a few globs on its surface."

chapter rep popper

the rep popper is a thing in Yell Alley. "A rep popper lies here. You're wary of getting too close to it. You're not sure how good your rep is, but that thing looks [if dork rod is in ZeroRez]less fearsome than it used to[else]like it could embarrass you quickly[end if]."

check taking rep popper:
	if player has taboo bat:
		now player has rep popper;
		say "With the taboo bat in your possession, you just don't care about stuff like rep, so you have no problem taking the rep popper." instead;
	if player has dork rod, say "With the dork rod, you aren't THAT worried about your rep, but you're still worried enough not to take the popper. Maybe you can do a bit better..." instead;
	if dork rod is not in ZeroRez, say "No way! You're not sure how much rep you have, but taking that rep popper would drop it a notch or more, and the prospect seems too horrible." instead;

[??Yuge Guy rep popper used what's wrong with you? I make boring people feel less boring vs you describing how you figured things out and only 26 possibilities really and also some trial and error]

chapter bomb mob

the bomb mob are plural-named people. description is "They're ignoring you, and that's probably for the best.".

understand "poor troop" and "poor/troop" as bomb mob when DNA hand is in ZeroRez.

chapter puffuping

puffuping is an action applying to nothing.

understand the command "puffup" as something new.
understand the command "puff up" as something new.

understand "puffup" as puffuping.
understand "puff up" as puffuping.

carry out puffuping:
	if spur ups are in ZeroRez, say "You already did." instead;
	if player does not have spur ups, say "You don't possess anything that would help you feel more up." instead;
	say "As you hold the Spur-Ups, you think about how great you are and can and will be. Surprisingly, it works! It works so well, you figure you don't even need the spur-ups for a boost in the future. You feel more confident, more able to deal with sadness now.";
	now Spur Ups are in ZeroRez;
	score-inc; [Yelpley/puff up]
	the rule succeeds;

chapter pulluping

pulled-up is a truth state that varies.

pulluping is an action applying to nothing.

understand the command "pull up" as something new.
understand the command "pullup" as something new.

understand "pull up" as pulluping.
understand "pullup" as pulluping.

carry out pulluping:
	if pulled-up is true, say "You already did." instead;
	if player has Spur Ups, say "Maybe you can be or do that sort of up, later.";
	if player is in Emo Dome:
		say "You manage to stop yourself. The whining isn't too bad. Yeah, you can hack it here.";
		now pulled-up is true;
		score-inc; [Yelpley/pull up]
		now Emo Dome is available instead;
	say "This isn't the place[if Emo Dome is visited], but maybe you could do this in the Emo Dome[end if]." instead;

book Emo Dome

Emo Dome is east of Yawn Way. It is in Yelpley. "You can go any direction here, and you sort of want to, because it's stuffy in here. [if madam is in ZeroRez]But not back north. You're done there[else]However, the way north looks particularly treacherous[end if]."

instead of doing something in Emo Dome when pulled-up is false:
	if current action is pulluping, continue the action;
	if current action is going:
		if noun is not west and noun is not east:
			say "You're scared those places would be even worse.";
			try going emo-dir instead;
		say "You run [if noun is emo-dir]away[else if noun is opposite of emo-dir] with extra speed.";
		continue the action;
	say "You keep running [emo-dir], instead. It's too whiny in here.";
	try going emo-dir instead;

emo-dir is a direction that varies. emo-dir is west.

check going to Emo Dome:
	if pulled-up is true:
		now emo-dir is noun;

check going north in Emo Dome:
	if state tats are off-stage, say "The Red Roses Order is, like, double-intensity. Just the name leaves you pondering you probably aren't ready for it yet until you're, like, totally ready. As you get close, you are intimidated by a voice: 'DIFF-ID?'[paragraph break]You don't have anything identifying yourself. 'Oh, who? Go jog!' the voice continues. You think, hang? Nah." instead;
	if Bro Orb is off-stage, say "You don't feel prepared enough to enter the Red Roses Order, yet." instead;
	say "You make sure your state tats are visible for scanning. They are accepted and promptly rub off.[paragraph break]You step into what may be your final challenge in Yelpley..."

book Red Roses Order

Red Roses Order is north of Emo Dome. It is in Yelpley. "[if madam is in red roses order]The only way back is south, but you can't chicken out[else]Your work is done here. Time to go back south[end if]."

Red Roses Order is above Emo Dome.

chapter madam

Madam is a person in Red Roses Order. Madam carries the gal flag. description is "MADAM stands here in defiance, holding the Gal Flag high."

description of Gal Flag is "It's fluttering even without a breeze."

understand "la gal" and "la/gal" as Madam.

check going south in Red Roses Order when Madam is in Red Roses Order: say "No way! You are locked in mortal combat! Plus, there's really only one thing to do, here." instead;

chapter yard ray

the yard ray is a thing. description is "It looks pretty lethal. It's no dinky resale laser![paragraph break]There are also has instructions: EMIT ********.[paragraph break]It's currently [if murk rum is in ZeroRez]loaded with energy from the Murk Rum[else]empty of fuel[end if]."

book Swept Pews

Swept Pews is south of Emo Dome. It is in Yelpley. "You can go back north to the Emo Dome in this tidy little area[if liar grail is in ZeroRez]. A passage has been opened south with the Liar Grail's demise[end if]."

The Liar Grail is a thing in Swept Pews. description is "It's carved with 'NIP IN? NOT ON!' If you hadn't examined it, you wouldn't think there might be a passage to the south, but now that you have, you consider the possibility. Either way, it annoys you enough to want to get rid of the liar grail. Lies are sometimes self-defeating like that". "A liar grail is embedded in the south wall, aw."

check taking liar grail: say "A small voice cries 'Da cad! Da cad!' You probably don't want the liar grail corrupting you." instead;

check going south in Swept Pews:
	if Liar Grail in Swept Pews, say "Maybe there's a path where you could get rid of the grail, but not yet." instead;

chapter troll ort

the troll ort is an edible thing in Swept Pews. "A troll ort lies on the floor here, but it looks dry enough, the five-second rule can't matter too much.". description is "It doesn't look particularly edible to you. It also has a strong smell."

book Drawl Ward

Drawl Ward is south of Swept Pews. It is in Yelpley. "This passage is a T, walled off to the south."

Marge Pegram is a person in Drawl Ward. "[one of]'Hi! I'm Marge Pegram. I ain't feeling so good, but I wondered if maybe I could get some medicine.'[or]Marge Pegram continues to moan colloquially about how sick she is.[stopping]"

check going in Drawl Ward:
	if Marge Pegram is in Drawl Ward:
		if noun is west or noun is east, say "You hear Marge Pegram groaning and think it wouldn't be heroic to pass her by. Maybe you should find a way to help her feel less sick." instead;

the Elan Ale is a drinkable thing. description is "It's labeled as CLASS Alc, unsurprisingly."

book Scrap Arcs

Scrap Arcs is east of Drawl Ward. It is in Yelpley. "You can't go any farther here--only back west."

chapter slate metals

slate metals are scenery in Scrap Arcs. "You could probably carve something out of them, with the right implement(s). Maybe not steel fleets, but something useful."

chapter Ye Key

Ye Key is a thing. description is "Engraved YE KEY, it clearly looks important. There are only so many locked places here, so you'll probably find what it can open."

book Dopy Pod

Dopy Pod is west of Drawl Ward. It is in Yelpley. printed name of Dopy Pod is "[if cassettes sac is in ZeroRez]Dope[else]Dopy[end if] Pod". "[if cassettes sac is in ZeroRez]There's not much left here, but it was neat to get the radar. [else]There doesn't seem like there's much useful in here, but who knows? [end if]The only exit is back east."

chapter cassettes sac

the cassettes sac is a thing in Dopy Pod. "A rather large cassettes sac sits here. It's too dirty to pick up.". description is "Phew! It's too dirty to look at too closely."

understand "casette/casete/cassette/cassetes sac" and "casette/casete/cassette/cassetes" as cassettes sac. [1 is technically not an anagram but it's a plausible misspelling, so we should allow it.]

instead of doing something with cassettes sac:
	if action is pro-and-use, continue the action;
	say "The cassettes sac is too messy to do anything with. You need to find a way to clean it up."

chapter radar

to decide which number is radar-used:
	let temp be 0;
	if eroded ore is not off-stage, increment temp;
	if UFO tofu is not off-stage, increment temp;
	decide on temp;

the radar is a thing in Dopy Pod. description is "You're not sure of the deeper science, but you will probably figure how to USE it when the time comes[if radar-used is 1] again, though it does seem slightly damaged[end if]."

The roto motor is a thing. description is "It seems to have been saved from whatever caused the radar to go on the fritz."

chapter Demo Med

a Demo Med is an edible thing in Dopy Pod. "A demo med sits here, on a pill lip.". description is "You're not sure what it could be. Xanax? Whatever, you feel calmer just looking at it."

the pill lip is scenery in Dopy Pod. "A Demo Med rests on the Pill Lip."

instead of doing something with pill lip, say "The pill lip is just there to prevent the demo med from getting dirty on the ground."

report taking demo med:
	say "The pill lip retracts as you take the demo med.";
	move pill lip to ZeroRez.

book Pro Corp

Pro Corp is north of Gross Org. It is in Yelpley. description is "A butene tub rests here. You probably don't want to mess with it, [if bald-lab is true]since you've yoinked enough[else]but there's other useful stuff here[end if]. The only way out is back south."

Pro Corp is above Gross Org.

report taking when player is in pro corp:
	if number of things in pro corp is 0:
		say "Pro Corp is now a bald lab.";
		now bald-lab is true;
		now printed name of Pro Corp is "Bald Lab";
	else:
		continue the action;

bald-lab is a truth state that varies.

understand "bald/lab" and "bald lab" as Pro Corp when bald-lab is true.

the butene tub is scenery in Pro Corp. "It smells pretty nice, though there's no visible way to operate it."

instead of doing something with butene tub:
	say "You don't need to tinker with the butene tub. It's empty, and that's probably a good thing. Just, a secret lab hideout needs something mysterious and weird."

chapter gold log

the gold log is a thing in Pro Corp. description is "It's pretty cylindrical but feels hollow, not a ton, lighter than it should. Maybe if it were shaped a bit different it would be a golf log you could use to putt up, but as-is, it's not too useful."

chapter DNA band and hand and what's after

The DNA band is a thing in Pro Corp. "A DNA band sits here, nice and tidy and helical.". description is "The DNA band seems like it could come to life, but you'd need some cool science to do so.".

The DNA hand is a thing. "It's motionless, but it looks lifelike enough. There must be a way to bring it to life!"

The bang nab is a thing. "Wow! It's really evolved from a DNA band! It's sturdy. If it had eyes, it'd be looking for something to steel and run--umm, that's not quite right--off with. You're not sure why it hasn't run off with anything in your inventory. Is all this stuff you piled up worthless? Perhaps the bang nab is just grateful."

volume dialogue

section talk texts

[xxtalk]
[organized alphabetically, why not ... this doesn't need to be here, strictly, but I'd rather define talk text AFTER defining people]

talk-text of the player is "'Me! Hi! Hem.'"

talk-text of Bomb Mob is "You don't need a gang nag. Maybe you can sneak around them to get the TNT, though.".
talk-text of Code Doc is "There is some awkward small talk. The Code Doc is more about understanding and explaining things.".
talk-text of Cross Orc is "'Pay?! Yap!'".
talk-text of Dave is "Dave's here, man. And Dave's not chatty, man. He just seems to want to block you from doing anything.".
talk-text of Diktat Kid is "Now's not the time for talk. Okay, the Diktat Kid might be bragging, but you won't get a word in.".
talk-text of Ergot Ogre is "'Guh! Ug!'[paragraph break]Diplomacy won't get you by, here.".
talk-text of Flee Elf is "[one of]'That cap. It's for you. Find the right way to take it, and I'll leave you on your way. Ask me again for hints.'[or]'Well, there are only twenty-six ways to take the Pact Cap--um, okay, twenty-five, if you think about it. And don't overthink. Once you do, I'm on my way.'[stopping]".
talk-text of Gulf Lug is "'Ill, I...'".
talk-text of Ian is "Ian sniffs. 'Why should I talk to someone not classy enough to BELONG here on Mont Nom?' He turns his head for a moment, as if doing something he's ashamed of.".
talk-text of Kayo Yak is "It looks up a bit but then ignores you. Maybe there's an order it can respond to.".
talk-text of King Nik is "'I am not a very good king! I tried to understand social forces and big picture issues and stuff on my trip abroad, but I do not understand them yet. Maybe you could help me?'".
talk-text of Knife Fink is "The Knife Fink stops and looks over your possessions for a moment.".
talk-text of Known Wonk is "There is some awkward small talk. The Known Wonk's mind is elsewhere, but maybe you can help with practical matters.".
talk-text of Madam is "She is raising the Gal Flag and incanting ... something. You're not sure what. But talking won't interrupt it.".
talk-text of Mike Kim is "Did you find any Stray Arts? I can always use them.".
talk-text of Marge Pegram is "'I ain't much for talking now I'm sick...'".
talk-text of Ned is "Ned's not in the mood for regular talk. He seems to want an argument or fight, but you don't.".
talk-text of Psi Wisp is "It has nothing to say. It just pulses.".
talk-text of Revolt Lover is "The Revolt Lover launches into how everyone is really stupid and at fault, and you can't really do anything except snark about it.".
talk-text of Rob is "Rob yawns. He doesn't find you very interesting. Maybe there's a way to take advantage of that.".
talk-text of sleep eels is "Maybe they are sending some sort of electric message you could detect with the right instrument, but they're not talking. You're more struck, though, by how uncomfortable they look while sleeping--wriggling about.".
talk-text of Sniffins is "[if YOB ATTABOY is not in ZeroRez]'Tony? Not! Poor lower class me is a failure! Nobody wants Le Falafel! If only I had some success manual!'[else]'Oh. It's you again. If you were REALLY smart, you'd have taken the advice in that book you gave me.'[end if]".
talk-text of Verses Rev is "The Verses Rev booms 'Erupt! Pure!' then piously intones how weirdos not in line with the Diktat Kid's values need to be eradicated.".
talk-text of Yuge Guy is "'Believe Me. Adore Me. Believe!' O gee, ego, you think to yourself."

volume gotoing

[?? rules for GT'ing a room]

a room can be notyet, available, cappy, davey, ratsy, pully, tamey, or gatey.

Fun 'Nuf is available.

Seer Trees, Yawn Way, Art Xtra and My Gym are cappy.

Worn Row is davey.

chapter gotoing

gotoing is an action applying to one visible thing.

understand the command "gt" as something new.
understand the command "goto" as something new.
understand the command "go to" as something new.

understand "go to [any room]" as gotoing.
understand "goto [any room]" as gotoing.
understand "gt [any room]" as gotoing.

to decide whether goto-available:
	if Diktat Kid is quicknear, no;
	if Madam is quicknear, no;
	yes. [obviously we don't want this to be trivial once the game's complete, but we want the code in place.]

gone-to is a truth state that varies.

carry out gotoing:
	if being-chased is true, say "Sorry, but since you're being chased by the [chase-person], you need to be specific about directions, here." instead;
	if cap-pace is true and map region of location of noun is not Grebeberg:
		now cap-pace is false;
		say "Your pace cap slows down as you [if noun is Fun 'Nuf]enter[else]cross[end if] Fun [']Nuf..." instead;
	if noun is location of player, say "Already there!";
	unless goto-available, say "You're at a point in the game where goto isn't available." instead;
	if noun is not available, say "[noun] isn't available yet, so you can't go there." instead;
	if noun is available and noun is not visited, say "You can reach [noun], but you haven't visited there, yet. So I'm going to be a stickler and say you have to get there first." instead;
	if noun is Dirge Grid, say "You already beat the Diktat Kid. You don't need to go back." instead;
	now gone-to is true;
	move player to noun;
	the rule succeeds;

section gotocheck - not for release

[this is to make sure that rooms are unfolded]

when play begins:
	let n be number of notyet rooms;
	say "Minor check for GOTO behavior: [if n is 0]All rooms have a switch saying you can go there[else]There are [n] that need to be ordered. They are: [list of notyet rooms not in Odd Do][end if]."

volume chases

being-chased is a truth state that varies.
init-turn is a truth state that varies.

chase-person is a person that varies.

last-chase-direction is a direction that varies.

to start-chase (guy - a person):
	now chase-person is guy;
	now last-chase-direction is southwest;
	now being-chased is true;
	now init-turn is false;

every turn when being-chased is true:
	if init-turn is false:
		say "You'd better get a move on. The [chase-person] looks pretty agitated.";
		now init-turn is true;
		continue the action;
	if chase-person is in location of player:
		say "You've been caught! Aigh!";
		if mrlp is Grebeberg, move player to Seer Trees;
		if mrlp is Yelpley, move player to Yawn Way;
		move chase-person to chase-room of chase-person;
	else:
		say "The [chase-person] follows you.";
		move chase-person to location of player;

after going when being-chased is true:
	now last-chase-direction is noun;
	continue the action;

check going when being-chased is true:
	if last-chase-direction is opposite of noun, say "The [chase-person] is blocking you from the [noun]. You try a gazelle-zag but don't have the moves." instead;

check going to Fun 'Nuf when being-chased is true: say "You feel yourself running up against an invisible barrier. Apparently, running away that way from the [chase-person] won't help." instead;

the Psi Wisp is a chaser. chase-room of Psi Wisp is Pro Corp. description is "The Psi Wisp is very red, and it pulses fervently. If it had feelings, you'd be pretty sure it didn't like you."

after looking when being-chased is false:
	if player is in pro corp and psi wisp is not in ZeroRez:
		start-chase Psi Wisp;
		say "The Psi Wisp begins to chase after you!";
	if troll ort is in ZeroRez and player is in frush surf and kayo yak is in frush surf:
		start-chase Kayo Yak;
		say "The Kayo Yak bounds after you!";
	continue the action;

volume unsorted

chapter crap arc

volume metarooms

[there is a little bit of cute code here. Odd Do's score = weird stuff, but it's also where ZeroRez, the collect-all room for used objects, goes. TempMet is for items that temporarily disappear.]

part Odd Do region

[don't give the player any accidental access to the rooms]

ZeroRez is a privately-named room in Odd Do. "Bug."

TempMet is a privately-named room in Odd Do. "Bug."

section debug helps - not for release

understand "zr/zero/ZeroRez/ll/lll/ZeroRez" as ZeroRez. [ZeroRez is my default for other games. So why not.]

understand "tm/TempMet" as TempMet.

volume bonus points and odd verbs

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
		abide by the llp rule; [DIAL AID]
		now dial-yet is true;
	if dial-yet is false:
		say "Aid... aid...[paragraph break]";
	if done-here, say "You're done here." instead;
	say "Thinking...";

to decide whether done-here:
	if player is in Yawn Way, yes;
	if player is in Fun 'Nuf and flee elf is in ZeroRez, yes;
	if player is in My Gym and Dave is in ZeroRez, yes;
	if player is in Seer Trees and stark rats are in ZeroRez, yes;
	if player is in Calcific Lac and dork rod is in ZeroRez, yes;
	no;

chapter balmlabing

balm-got is a truth state that varies.

balmlabing is an action applying to nothing.

understand the command "balmlab" as something new.
understand the command "balm lab" as something new.

understand "balm lab" as balmlabing when player is in Pro Corp and number of things in pro corp is 0.
understand "balmlab" as balmlabing when player is in Pro Corp and number of things in pro corp is 0.

carry out balmlabing:
	if balm-got is true, say "No double dipping." instead;
	now balm-got is true;
	abide by the llp rule; [BALM LAB]
	say "Some EOL Aloe squirts out of the butene tub. You rub it on yourself. You immediately quit running around in circles in your mind, and when a disturbing through pops back up, you sort of say EOL, and it disappears, and it doesn't feel cheesy. But then an enol cyclone blows you over, and when you wake up again, it's a bald lab." instead;

chapter peeping

peeped-yet is a truth state that varies.

peeping is an action applying to nothing.

understand the command "peep" as something new.

understand "peep" as peeping.

carry out peeping:
	try looking;
	if peeped-yet is false:
		now peeped-yet is true;
		say "You feel more in tune with the world, now that you've looked a little differently.";
		abide by the llp rule; [PEEP]
	the rule succeeds;

chapter pooping

pooping is an action applying to nothing.

understand the commands "boob" and "poop" and "pap" as something new.

understand "boob" and "poop" and "pap" as pooping.

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
		abide by the llp rule; [POOP]
		now the last notified score is the score;
	else:
		say "[line break]X2?[paragraph break]...X!";
	the rule succeeds;

chapter slammammalsing

slam-mam is a truth state that varies.

slammammalsing is an action applying to nothing.

understand the command "slam mammals" as something new.

understand "slam mammals" as slammammalsing.

carry out slammammalsing:
	if slam-mam is true, say "You already did. Don't overdo it.";
	if sleep eels are in ZeroRez, say "Too late for that." instead;
	unless player is in Ooze Zoo and sleep eels are in Ooze Zoo, say "You have no sympathetic audience." instead;
	say "The sleep eels wake from their slumber briefly to squirm. They telephathically project their pleasure before going back to sleep. You've ... done something, I guess?";
	abide by the llp rule; [SLAM MAMMALS]
	the rule succeeds;

chapter statsing

stats-yet is a truth state that varies.

statsing is an action out of world.

understand the command "stats" as something new.

understand "stats" as statsing.

carry out statsing:
	try requesting the score;
	if stats-yet is false:
		say "Extra style point for requesting the score 'correctly.'";
		abide by the llp rule; [STATS]
		now stats-yet is true;
	the rule succeeds;

volume endgame stuff

part final questions

Table of Final Question Options (continued)
final question wording	only if victorious	topic	final response rule	final response activity
"see responses to various commands (RAND 0 for list, RAND 1-[number of rows in table of all randoms] for specific table)"	true	"RAND [number]"	--	rling
"see what you MISSED"	true	"MISSED"	what-missed rule	loafing
--	true	"AMT"	amuse-toggle rule	loafing

rling is an activity.

rule for rling: try randlisting number understood instead;

randlisting is an action applying to one number.

carry out randlisting:
	let count be 0;
	if number understood is 0:
		repeat through table of all randoms:
			increment count;
			say "[count]. [tabnam entry][line break]";
		the rule succeeds;
	if number understood < 0 or number understood > number of rows in table of all randoms, say "Need 1-[number of rows in table of all randoms]." instead;
	choose row number understood in table of all randoms;
	let mytab be tabnam entry;
	now count is 0;
	say "All random text for [desc entry]:[line break]";
	repeat through mytab:
		increment count;
		say "[randtxt entry][line break]";

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

chapter amusing table

table of amusing stuff
funstuff	dorule
"FLEA ELF?"	elf-fleaed rule
"FLEX ELF?"	elf-flexed rule
"FLEECE ELF?"	elf-fleeced rule
"SMELLing the dork rod?"	rod-smell rule

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
		consider the dorule entry;
		if the rule failed:
			say "[funstuff entry]";
			increment missed;
	if missed is 0, say "You found all the points!"

chapter misses table

table of potential misses
funstuff	dorule
"BOOB or POOP or PAP to swear 'right"	pb-yet rule
"REFER instead of THINK"	refer-yet rule
"DIAL AID instead of AID"	dial-yet rule
"SLAM MAMMALS around the eels"	slam-yet rule
"PEEP instead of looking"	peep-yet rule
"BALM LAB in the Bald Lab"	balm-yet rule
"STATS to get the score"	stats-yet rule
"MUSS OPOSSUM to make a friend"	muss-yet rule

this is the balm-yet rule:
	if balm-got is true, the rule succeeds;
	the rule fails;

this is the dial-yet rule:
	if dial-yet is true, the rule succeeds;
	the rule fails;

this is the muss-yet rule:
	if opossum is in ZeroRez, the rule succeeds;
	the rule fails;

this is the pb-yet rule:
	if poop-boob-yet is true, the rule succeeds;
	the rule fails;

this is the peep-yet rule:
	if peeped-yet is true, the rule succeeds;
	the rule fails;

this is the refer-yet rule:
	if refer-bonus is true, the rule succeeds;
	the rule fails;

this is the slam-yet rule:
	if slam-mam is true, the rule succeeds;
	the rule fails;

this is the stats-yet rule:
	if stats-yet is true, the rule succeeds;
	the rule fails;

volume beta testing - not for release

when play begins:
	now in-beta is true;

chapter llping

llping is an action out of world.

understand the command "llp" as something new.

understand "llp" as llping.

carry out llping:
	now llp-reject is whether or not llp-reject is true;
	say "LLP reject is now [on-off of llp-reject].";
	the rule succeeds;

chapter endgame

endgameing is an action applying to nothing.

understand the command "endgame" as something new.

understand "endgame" as endgameing.

carry out endgameing: [?? what about martini tram]
	say "Giving you all the cool stuff to defeat the Diktat Kid.";
	now player carries all tronparts;
	now player carries murk rum;
	now player carries yard ray;
	now player carries epicer recipe;
	now set o notes is in ZeroRez;
	now Darer Ad is in ZeroRez;
	now elf is in ZeroRez;
	now player has pact cap;
	now player has taboo bat;
	now player has ME gem;
	now Tix Exit is in Fun 'Nuf;
	if player is not in Fun 'Nuf, move player to Fun 'Nuf;
	now endgame-test is true;
	the rule succeeds;

chapter rring

rring is an action applying to one thing.

understand the command "rr" as something new.

understand "rr [something]" as rring.

carry out rring:
	repeat through table of useons: [It would be simpler to use an if statement but things could get shuffled in the table of useons. This assures that we try all possible machines before an item vanishes permanently.]
		if use2 entry is reviver and use1 entry is noun:
			try useoning use1 entry with reifier;
			try useoning use1 entry with rotator;
			try useoning use1 entry with reviver;
			break;
		if use2 entry is reifier and use1 entry is noun:
			try useoning use1 entry with rotator;
			try useoning use1 entry with reviver;
			try useoning use1 entry with reifier;
			break;
	try useoning noun with reviver;
	try useoning noun with reifier;
	try useoning noun with rotator;
	the rule succeeds.

chapter wining

wining is an action applying to nothing.

understand the command "win" as something new.

understand "win" as wining.

carry out wining:
	end the story finally;
	the rule succeeds;

chapter iaing

a thing can be need-ia. a thing is usually need-ia.

a book is usually not need-ia. a helpdoc is usually not need-ia. scenery is usually not need-ia.

the player is not need-ia. the leet steel is not need-ia. the part strap is not need-ia.

the tent net is need-ia. the elope pole is need-ia. the pity tip is need-ia.

ia-yet is a truth state that varies.

iaing is an action out of world.

understand the command "ia" as something new.

understand "ia" as iaing.

carry out iaing:
	let count be 0;
	let got be 0;
	if ia-yet is false:
		now ia-yet is true;
		repeat through table of useons:
			if there is a getit entry:
				now getit entry is not need-ia;
	repeat with Q running through things:
		if Q is need-ia and initial appearance of Q is empty:
			increment count;
			say "[count]: [Q] needs initial appearance.";
		else:
			increment got;
	say "[got] has initial appearance, [count] doesn't.";
	the rule succeeds;

chapter pering

pering is an action out of world.

understand the command "per" as something new.

understand "per" as pering.

carry out pering:
	say "Peripheral things: [list of peripheral things].";
	the rule succeeds;

volume internal testing - not for release

the debug tweaks rule is listed first in the when play begins rulebook.

when play begins (this is the debug tweaks rule):
	now ignore-wait is true;
	now debug-state is true;

when play begins (this is the make sure everyone is chatty rule):
	let count be 0;
	repeat with Q running through people:
		if talk-text of Q is empty:
			increment count;
			say "[count]. [Q] needs basic talk-text.";
	if count is 0:
		say "YAY all people accounted for!";
	else:
		say "[count] of [number of people] unaccounted for.";

include Put It Up Tests by Andrew Schultz.
