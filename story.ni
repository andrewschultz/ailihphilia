"Put it Up" by Andrew Schultz

[blurb for comp = A *GASP* SAGA]

[there are things you can search for to make the source more navigable.

First, Put It Up tables.i7x contains all the random responses.
Second, Put It Up tables.i7x contains responses to mistakes e.g. palindrome verbs/phrases that don't advance the game but are good tries.
Put an x or two before each of these to find the beginning of a table, ZZ for the end:
USE for the Table of Useons (USE X ON Y gives a point)
FAIL for Useons that don't work
TALK for talk texts
WIN for winning the game
PER for table of periphery
PRE for pre-rules in the table of useons
POST for post-rules in the table of useons
LLP for last lousy points

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

use American dialect.

volume definitions

definition: a thing is moot:
	if it is in devreserved, yes; [ic]
	no;

to moot (Q - a thing):
	move Q to DevReserved; [ic]

a chaser is a kind of person. a chaser has a room called chase-room.

a guhthug is a kind of person. [Ian, Rob, Ned, Dave]

a thing can be drinkable. a thing is usually not drinkable.

a thing can be peripheral. a thing is usually not peripheral.

an ingredient is a kind of thing. an ingredient is usually edible. an ingredient can be solid or liquid.

section compiler constants

use MAX_VERBS of 260.

section compiler constants - not for release

use MAX_VERBS of 300. [290 for 125 mistakes, so, gap of 165 as of 3/10/18]

chapter region and room stuff

a region has a number called max-score. a region has a number called cur-score.

Grebeberg is a region. max-score of Grebeberg is 30.

Dim Mid is a region. max-score of Dim Mid is 10.

Yelpley is a region. max-score of Yelpley is 37.

Odd Do is a region. max-score of Odd Do is 11.

index map with Dirge Grid mapped east of Toll Lot.

the change default appearance for blank rooms rule is listed after the room description body text rule in the carry out looking rules.

carry out looking (this is the change default appearance for blank rooms rule):
	if the description of the location is empty, say "[if number of viable directions is 1]An exit leads[else]Exits lead[end if] [list of viable directions]. NOTE: I need to change this generic text.";
	continue the action;

chapter for (beta) testers

[these are variables that are not used in the final release, but often, they have to be defined in the release, because major verbs use them.]

LLP-reject is a truth state that varies. [for my own tests: walkthrough with LLPs and without]

endgame-test is a truth state that varies.

in-beta is a truth state that varies.

aid-detail is a truth state that varies.

debug-verbose is a truth state that varies.

to display-dropbox-link:
	say "If you can take a look at https://www.dropbox.com/s/hex2w7dzhs8lg5k/piu-concerns.txt?dl=0 to see if anything rings a bell, that would be a big help. I didn't want to expose this before a first play through."

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

chapter oldschooling

understand the command "slice/prune/chop/kiss/hug/embrace/buy/purchase/buy/light/jump/hop/skip/sip/swallow/shine/polish/sweep/clean/dust/wipe/scrub/rub/fight/torture/wreck/crack/murder/kill/punch/thump/wave/sorry" as oldschooling.

oldschooling is an action out of world.

carry out oldschooling:
	say "That's an old school very and won't be necessary in this game. See V/VERB/VERBS for what is used/useful." instead;

volume unsorted

to say etg:
	end the story;

section part of a puzzle but still floating

[Otto is a person.]

the brag garb is a proper-named thing. description is "You don't know fashion that well, but this is way spiffier and more comfortable than the old stinky knits."

section helpdocs

a helpdoc is a kind of thing. a helpdoc has a number called importancy. the indefinite article of a helpdoc is usually "the".

before printing the name of a helpdoc while taking inventory:
	if Dave is off-stage, say "the ";

to say other-docs:
	let L be the list of still-useful helpdocs carried by player;
	sort L in reverse importancy order;
	say "[the L]";

Definition: A helpdoc is relevant if its importancy is 1 or more.

to decide which number is max-useful:
	let X be 0;
	repeat with Q running through helpdocs carried by player:
		if importancy of Q > X, now X is importancy of Q;
	decide on X;

Definition: A helpdoc (called h) is still-useful:
	if importancy of h >= max-useful, no;
	yes;

section ingredients

section tronparts

a tronpart is a kind of thing.

description of a tronpart is usually "The [item described] is one of [number of tronparts] parts needed for the North-Tron."

The resale laser is a tronpart.

The Ore Zero is a tronpart.

volume the player

description of player is "Flesh. Self.". initial appearance of player is "U R U".

check dropping:
	say "This game is not Pro-Drop. In other words, you don't need to drop anything. You may wish to USE it instead." instead;

to decide which region is mrlp:
	decide on map region of location of player;

part scoring

to score-inc:
	reg-inc mrlp;

check requesting the score:
	say "Your overall score so far is [score] of [maximum score][if score < 4]. But don't worry, points pile up pretty quickly once you get going[end if]. [to-get-max].";
	say "Broken down by regions, you have [regres of Dim Mid], [regres of Grebeberg], [regres of Yelpley] and [regres of Odd Do].";
	if My Gym is visited or Evaded Ave is visited:
		if number of guhthugs is not number of moot guhthugs, say "You currently disposed of [number of moot guhthugs] grunts blocking your way: [list of moot guhthugs].";
	if Yuge Guy is moot, say "You've gotten rid of the Yuge Guy, Evil Clive.";
	if Madam is moot, say "You've gotten rid of the La Gal/Madam.";
	if player has x-ite tix:
		let Q be roving-LLP;
		if Q is 0:
			say "You may want to go back to Fun [']Nuf now and [if the score is maximum score - 1]use the tickets[else]try the other LLP command[plur-s of Q][end if].";
		else:
			say "You have [Q] roving last lousy point[unless Q is 1]s[end if] left."; [?? test roving LLPs]
	if player has Set O Notes and north tron is off-stage:
		let ni be number of tronparts carried by the player;
		say "You also have [ni] of [number of tronparts] piece[if ni is not 1]s[end if] of the North-Tron, according to the epicer recipe.";
	if mist-found > 0, say "[line break]You've also found [mist-found] of [number of entries in checkoffs] palindromes that were there but not critical to the story. [if mist-found * 2 > number of entries in checkoffs]Very impressive![else]Don't knock yourself out trying to find them all.[end if]";
	the rule succeeds;

to say to-get-max:
	if cur-score of Odd Do is max-score of Odd Do:
		say "You got all LLPs";
	else:
		say "You need at least [maximum score - max-score of Odd Do + cur-score of Odd Do] to win"

to say plur-s of (myn - a number):
	unless myn is 1, say "s"

this is the LLP rule:
	if LLP-reject is true, the rule succeeds;
	let prev-rov be roving-LLP;
	reg-inc Odd Do;
	if player has x-ite tix and prev-rov is 1 and roving-LLP is 0, say "You have all the roving LLPs. You can go back to Fun [']Nuf now.";

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
	if debug-state is true:
		say "DEBUG NOTE: Maximum score is [maximum score].";
		say "[if max-score of Odd Do is number of rows in table of last lousy points]LLPs = LLP table rows[else]Uh oh, [max-score of Odd Do] Odd Do points and [number of rows in table of last lousy points] LLP table rows. We need to fix this[end if].";
	now right hand status line is "[cur-score of mrlp]/[max-score of mrlp] [score]/[maximum score]";
	now left hand status line is "[location of player] ([mrlp])";
	sort table of last lousy points in random order;
	repeat through table of all randoms:
		sort tabnam entry in random order;
	say "It's not the first dream you had about how awful high school was, but it's the worst in a while. A few 'favorite' classmates chanting 'Diary raid!' and passing it around as they mock 'Beefy? Feeb! Bony Nob!'[wfak-d]";
	say "You check your mail as you go out to the grocery store. A junk magazine! It's been so long since you got one, you're almost intrigued.[wfak-d]";
	say "It just says GAME MAG. But the cover isn't telling you to actually buy anything, so you look inside. You have a whole backlog of games, but you can just recycle it when you get to the store. No, not the erot-store![wfak-d]";
	say "Nothing really catches your mind until you see a DARER AD. It's a bit vague, but it catches your eye.[wfak-d]";
	say "EVIL'S LIVE![wfak-d]";
	say "LIVE DEVIL![wfak-d]";
	say "BOSSES! SOB![wfak-d]";
	say "You fold the Darer Ad and start off to the store.[paragraph break]'[unicode 161]Aloha. Hola!' someone, or something, cries. You run in the general direction of the voice.  You look up, and you're no longer on the way to the store. You're somewhere else. Your smartphone starts blinking: LOAD AOL! You look up. Who is responsible for this? An elf, who sees you futzing with your smartphone. 'No El Google on?' You nod. Awkward silence.[wfak-d]";
	say "'Mind Nim?' You shrug. 'Put it up.' You win several games in a row, because after being confused by it, you looked up the winning strategy on the internet. 'Hanoi? On, ah!' the Flee Elf says. You quickly shuffle five-high towers. Then 'Is reversi...?'";
	say "After your fifth win in a row, the Flee Elf yells 'Put it up!' You freeze--well, until you're knocked to the ground.[wfak-d]";
	say "The Flee Elf gives a mournful headshake. 'Lame? Mal. Not physical enough for Raw Level War. You'll do for Yelpley, I guess.' The Flee Elf leads you away. 'The first thing to do is, figure how to take this cap.'[wfak-d]";
	do nothing; [debug information below here. I've had problems putting it in and not deleting it, so I want to make things clear.]

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
	if bees-seen is false and player is in Moo Room:
		if the player's command matches the regular expression "bee(s)?", case insensitively:
			say "You can't [one of]spot[or]look at[or]view[in random order] anything like that here.";
			the rule succeeds;
	abide by the dir-error rules for location of player; [check this room and any adjacent room descriptions]
	repeat with Q running through maindir:
		abide by the dir-error rules for room Q of location of player;
	continue the action;

the dir-error rules are a room based rulebook.

a dir-error rule for a room (called myr):
	if myr is nowhere, continue the action;
	let X be indexed text;
	now X is "[myr]" in lower case;
	replace the text "[']" in X with "";
	replace the text "-" in X with " ";
	repeat with J running from 1 to number of words in X:
		let Y be word number J in X;
		if the player's command matches the text "[Y]", case insensitively:
			say "It looks like you tried to do something with [if myr is location of player]this[else]an adjacent[end if] location. You don't ever need to do this to win the game, [if balm-got is true]and you got the sneaky bonus point for doing so[else]though you'll get a bonus point in the right place. Location names are generally just to describe unnecessary scenery[end if].";
			if gone-to is false, say "[line break]However, GO TO/GT (room) may be a nice shortcut to visit a previous location.";
			the rule succeeds;
	continue the action;

chapter unrecognized verb

Rule for printing a parser error when the latest parser error is the didn't understand error or the latest parser error is the not a verb I recognise error:
	say "[if gtv]You do need a special verb here, but not that one. It may not be a standard one, but given the game's theme, I bet you can figure it out. If you want standard verbs, y[else]I didn't recognize that action. Y[end if]ou can type VERB or VERBS to get a list of them.";

to decide whether gtv:
	if Ian is in location of player, yes;
	if Dave is in location of player, yes;
	if Rob is in location of player, yes;
	if Ned is in location of player, yes;
	no;

part after command

after reading a command:
	if in-beta is true and the player's command matches the regular expression "^<;\*>":
		say "(Noted.)[paragraph break]";
		reject the player's command;
	if the player's command matches the regular expression "<^a-z 0-9>":
		if no-punc-flag is false:
			say "(NOTE: you don't need to use anything but letters to get through the game. The parser simply strips out non-alphabetic characters.)[paragraph break]";
			now no-punc-flag is true;
			let XX be the player's command;
			replace the regular expression "<^a-z 0-9>" in XX with "";
			change the text of the player's command to XX;

no-punc-flag is a truth state that varies.

part dying

to die:
	end the story saying "Offed? Deffo! / Story Rots! / Stung! Nuts! / To Pot!"

volume verbs (standard or semi-standard to Inform)

check taking scenery: say "Grab? Arg! (Scenery doesn't need to be taken.)[paragraph break]" instead;
check taking a workable: say "Grab? Arg! (Scenery doesn't need to be taken.)[paragraph break]" instead;

chapter search replacement

search-warn is a truth state that varies.

instead of searching:
	if search-warn is false:
		say "You never need to search something. Examining works just as well.";
		now search-warn is true;
	try examining noun instead;

chapter give replacement

give-warn is a truth state that varies.

instead of giving to a person:
	if give-warn is false:
		now give-warn is true;
		say "(NOTE: USE X ON Y is the preferred syntax, though GIVE/TO should work too.)[paragraph break]";
	try useoning noun with second noun;

chapter undoing

report undoing an action:
	next-rand table of undoings;
	the rule succeeds;

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

chapter climbing

the block climbing rule is not listed in any rulebook.

instead of climbing, say "You haven't drunk enough Klimb-Milk. Err, Climb-Milc. Whichever. You don't need to climb to win the game."

chapter listening

instead of listening:
	if player is in My Gym:
		say "[if Dave is in My Gym]Behind Dave's grunts,[else]Y[end if]ou hear ";
		next-rand table of My Gym songs;
		say "[one of], or at least, that's what repeats in the chorus[or][stopping]." instead;
	if player is in Mont Nom, say "The Ark of Okra is almost saying 'C'mon! Nom!' or even 'Tum-Smut!'" instead;
	say "Noise lesion."

chapter seebeesing

seebeesing is an action applying to nothing.

understand the command "see bees" as something new.

understand "see bees" as seebeesing.

bees-seen is a truth state that varies.

carry out seebeesing:
	if bees-seen is true, say "You already saw the bees [if player is in Moo Room]here[else]in Moo Room[end if]." instead;
	if player is not in Moo Room, say "There are no bees to see here." instead;
	say "You look carefully and hear a soft buzzing. Yes, that's where the bees are. You can see them, and you're not afraid.";
	abide by the LLP rule; [SEE BEES]
	now bees-seen is true;
	the rule succeeds;

chapter refering / thinking

refer-bonus is a truth state that varies.

refering is an action applying to nothing.

understand the command "refer" as something new.

understand "refer" as refering.

carry out refering:
	if refer-bonus is false:
		say "Yes! That's a slightly more appropriate way to think, here.";
		abide by the LLP rule; [REFER]
		now refer-bonus is true;
	try thinking instead;

instead of thinking:
	say "[if refer-bonus is false]There might be a more appropriate (five-letter) way to think, given the environs[else]You think for a bit[end if].";
	if pace-prev is true, say "You can use the PACE CAP somewhere.";
	if cap-ever-pace is true, say "You haven't figured where to PACE CAP, yet.";
	let LLP-yet be false;
	repeat through table of last lousy points:
		if mclu entry is true:
			consider the dorule entry;
			if the rule succeeded:
				if LLP-yet is false:
					now LLP-yet is true;
					say "LAST LOUSY POINTS NOTES:[line break]";
				say "[cluey entry][line break]";

chapter inventory

after printing the name of a book (called bk) while taking inventory: say " (by [auth-name of bk])"

check taking inventory when Dave-evade is true:
	now all things enclosed by the player are marked for listing;
	now all ingredients are unmarked for listing;
	now all tronparts are unmarked for listing;
	now all helpdocs are unmarked for listing;
	now all things worn by the player are unmarked for listing;
	now state tats are unmarked for listing;
	now all books are unmarked for listing;
	say "[if number of things carried by player > 7]Your scepsis pecs help you carry a lot of things, though you're suspicious and unclear as to how.[else]'Met item' list:[line break][end if]";
	list the contents of the player, with newlines, indented, including contents, giving inventory information, with extra indentation, listing marked items only;
	if number of carried books > 0, say "Currently lugging (oof) [list of carried books].";
	if number of ingredients carried by player > 0, say "Food found: [a list of ingredients carried by player].";
	if number of things worn by player > 0, say "You are wearing: [a list of things worn by player][if player has state tats], in addition to state tats[end if].";
	if number of helpdocs carried by the player is 1:
		say "So far, you only have [the list of helpdocs carried by the player] as reference. More later, maybe?";
	else:
		say "AIDE MEDIA: While [b][relevantest helpdoc carried by the player][r] seems useful as a guide, [other-docs] may shore up a few minor points.";
	if number of tronparts carried by player > 0, say "North-tron parts found: [the list of tronparts carried by player][unless martini tram is off-stage]. The martini tram is in Fun [']Nuf, too[end if].";
	the rule succeeds;

after printing the name of pact cap while taking inventory: if cap-pace is true, say " (bent slightly to be a PACE cap too)".

after printing the name of yard ray while taking inventory: say " ([unless murdered rum is moot]un[end if]charged)".

after printing the name of spa maps while taking inventory: say " ([if maps-explained is true]deciphered[else]indecipherable[end if])".

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
	say "Put it Up was originally written for IFComp 2018. Like many of my games, I got the idea from [i]Nord and Bert Couldn't Make Head or Tail of It[r], at least partially. Another game that gave me ideas was Nick Montfort's [i]I Palindrome I[r], part of the Apollo 18+20 collection Kevin Jackson-Mead organized back in 2012. I felt there could be more that could be done with palindromes, but I didn't know what, and I didn't know how much.[paragraph break]Also, the Palindome in Kingdom of Loathing prompted my curiosity back in 2010. I would still be playing it today, if it hadn't inspired me to try to write my own games, which left less time for KoL (spoiler: I still ascended over 100 times.) I tried to avoid palindromes it already considered, though the Dumb Mud from the special Heavy Rains was too good to pass up. It's an item there but a location here, so I can't claim to copycat too much.";
	say "[line break]In my continuing quest to nail down my Python knowledge, I realized that even if I didn't get MANY palindromes, a few scripts could print things out. I had word and name lists from my anagram games Shuffling Around and A Roiling Original, so I had the raw materials.";
	say "[line break]The result of all my work is some guess-the-verb, but hopefully with the game's general idea, you'll see what's going on.";
	say "[line break]Originally, Put it Up was part of a spoonerism game--a sort of side area--but eventually I found enough rooms and ideas it could be its own game. Whether or not it's a good game, I guess you have to decide. It doesn't have any deep philosophy, but I hope you enjoy it. If you write games yourself, I hope it inspires you to go through with anything unusual you weren't sure if you should try, even if it rubs you the wrong way. (Spoiler: you should write that game! Just start early and take all the notes you can, but don't think the first draft needs to be perfect!)[paragraph break]";
	the rule succeeds;

chapter creditsing

creditsing is an action applying to nothing.

understand the command "credits" as something new.

understand "credits" as creditsing.

showed-sites is a truth state that varies.

carry out creditsing:
	say "I'd like to thank my testers for finding so much that left me free to think up more weirdness. They are, in first name alphabetical order: Anssi Raissanen, Brian Rushton, and Jack Welch. While I made an effort to run tests to minimize silly errors, they found a lot and gave positive suggestions.[paragraph break]IFComp organizers past and present. Without them, I wouldn't have started and kept going. Whether that's good for gaming is up for debate, but it's been good for me.[paragraph break]Various Python communities, especially StackOverflow, helped me to write utilities that helped not only to extract palindromes but also to tune up Inform code (obligatory thanks to all past and current Inform developers) and run simple tests.";
	if showed-sites is false:
		now showed-sites is true;
		say "I also found some websites useful. CREDITS again to see them.";
	else:
		say "Websites that helped with this game:[paragraph break]";
		say "  --http://www.angelfire.com/in2/sedavis/palindromes.html STOP LAUGHING ANGELFIRE WAS COOL WHEN IT FIRST CAME OUT ANYWAY GEOCITIES WAS MORE MY BEAT[line break]";
		say "  --https://www.reddit.com/r/AskReddit/comments/4z899e/whats_your_favorite_palindrome/";
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
	if wr-short-note is true and player is in Worn Row and Worn Row is worky, say "[line break][b]REV[r], [b]ROT[r] and [b]REI[r] use an item on the reviver, rotator and reifier, respectively.";
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
	if talk-text of noun is empty:
		if gender-oppo of noun is not Diktat Kid and talk-text of gender-oppo of noun is not empty, say "[talk-text of gender-oppo of noun][line break]" instead;
		say "Nothing. (change this)" instead;
	say "[talk-text of noun][line break]" instead;
	the rule succeeds. [see volume dialogue for all the specifics]

a person has text called talk-text.

chapter drinking

drink-warning is a truth state that varies.

the block drinking rule is not listed in any rulebook.

check drinking:
	if noun is Elan Ale, say "No drinking on the job. Besides, with what you've done so far, you might be able to trade it for something more useful." instead;
	if noun is Gorge Grog, say "One look at the grog, and you realize you're not up to such super-powered alcohol." instead;
	if noun is murdered rum, say "The rum part is drinkable, but the murdered rum isn't." instead;
	say "[if noun is drinkable]Pish! Sip?![else][']S not wet. Ew--TONS.[end if]";
	if drink-warning is false, say "(You don't need to drink anything in this game. Liquids have other purposes. Besides, I didn't implement Pee Keep.)[paragraph break]";
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

maindir is a list of directions variable. maindir is { north, west, south, east }

to decide which direction is othdir of (d - a direction):
	repeat with Q running through maindir:
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
		if the room noun of location of player is nowhere, say "You never need to go up or down in this game, though sometimes they act as a backup to the main cardinal directions--for instance, to or from [if Mont Nom is visited] Mont Nom[else]a hill[end if]." instead;

the reject noncardinal directions rule is listed first in the check going rulebook.

chapter smelling

instead of smelling stinky knits, say "The stinky knits take over everything and smell of torn rot and stunk-nuts." instead;

instead of smelling dork rod, say "You might expect a rod odor, but there isn't one. OR MAYBE IT IS SO INGRAINED IN YOU, YOU NO LONGER SMELL IT." instead;

instead of smelling butene tub, say "The butene tub smells kind of nice. Much nicer than a butt tub." instead;

instead of smelling mush sum, say "Unsurprisingly, the mush sum emits an unavoidable musk sum." instead;

instead of smelling troll ort, say "The troll ort emits a musk-sum which isn't unpleasant, but it's distinctive." instead;

instead of smelling location of player:
	if stinky knits are quicknear, try smelling stinky knits instead;
	if player is in Flu Gulf, try smelling mush sum instead;
	if player is in Emo Dome or player is in Red Roses Order, say "Roses ... or ..." instead;
	if player is in Swamp Maws or player is in Mire Rim, say "A morass aroma." instead;
	if y-poopy, say "Whew! Worse than an emu fume!" instead;
	if player has dork rod, try smelling dork rod instead;
	if troll ort is quicknear, try smelling troll ort instead;
	if player is in Moo Room, say "Hay! Ah!" instead;
	if player is in Deft Fed, say "Ham?! Ah!" instead;
	if player is in Red Roses Order or player is in Emo Dome, say "You smell roses. Weird." instead;
	if player is in Pro Corp and butene tub is in Pro Corp, try smelling butene tub instead;
	if player is in Sneer Greens and Yuge Guy is in Sneer Greens, say "You smell an amoral aroma." instead;
	continue the action;

instead of smelling, say "Noses, on[one of]! (you don't need to smell anything in this game, thoiugh some specific items give silly text.)[or][stopping]!"

to decide whether y-poopy:
	if gnu dung is quicknear, yes;
	if player has poo coop and gnu dung is moot, yes;
	no;

chapter singing

instead of singing, next-rand table of singstuff;

chapter silly swearing

instead of swearing mildly, try swearing obscenely instead;

swearies is a number that varies.

instead of swearing obscenely, next-rand table of swearstuff;

chapter sleeping

instead of sleeping:
	say "Zzz.[paragraph break]Wait, no. That's cheating... let's pretend you're waiting, instead.[paragraph break]";
	try waiting instead;

chapter waiting

instead of waiting, next-rand table of waittxt;

chapter plughing

plughing is an action out of world.

understand the command "plugh" as something new.

understand "plugh" as plughing.

carry out plughing:
	say "GULP." instead;

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
	move north tron to Fun Nuf;
	now all tronparts are in devreserved; [ic]
	say "You build the North-Tron with the instructions from the epicer recipe. It points north and blasts a hole with a huge tron snort, but some of the energy bounces back and vaporizes it! I guess you could call it a martyry tram, now.[paragraph break]Anyway, you tear up the epicer recipe and throw it in the air to make confetti as celebration. You must be close now!";
	moot epicer recipe;
	now Dirge Grid is mapped north of Fun Nuf;
	now Fun Nuf is mapped south of Dirge Grid;
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
		moot i1;
		moot i2;
		score-inc; [Grebeberg/USE GIFT FIG ON MAYO YAM&USE SNACK CANS ON UFO TOFU]
		if chef-yet is true:
			say "A martini tram rattles out from behind the Ark of Okra. Guess you need drinks with your, uh, food![paragraph break][if player does not have the epicer recipe]You're shocked to see it, and it rollls further down, over the turf rut to Dumb Mud, then back through the Seer Trees to Fun [']Nuf[else]But you're prepared for it, with your epicer recipe. You move it back to Fun [']Nuf, where it looks like a good base structure for your North-Tron[end if].";
			move martini tram to Fun Nuf;
			move player to Fun Nuf, without printing a room description;
			say "[b]Fun [']Nuf[r][paragraph break]";
		else:
			say "You suspect something is behind there! Maybe you can find another combination, you'll see what.";
			now chef-yet is true;

check useoning it with:
	if noun is second noun, say "It's not productive to use something on itself, even with this game being full of palindromes." instead;
	if noun is the player or second noun is the player, say "You never need to use anything explicitly on yourself." instead;
	if noun is a workable and second noun is a workable, say "The machines are fixed in place. You can't use one on the other." instead;
	if noun is a workable, try useoning second noun with noun instead;
	if noun is a workable or second noun is a workable:
		if wr-short-note is false:
			say "(NOTE: You can abbreviate this command with ROT, REI and REV for the respective machines, later.)[paragraph break]";
			now wr-short-note is true;
	if second noun is a workable and useleft of second noun is 0, say "No point. The [second noun] is broken." instead;
	if noun is an ingredient and second noun is an ingredient:
		chef noun and second noun;
		the rule succeeds;
	repeat through table of cantuse:
		if noun is use1 entry or second noun is use1 entry, say "[babble entry][line break]" instead;
	if noun is a person, say "[one of]You're not any good at using other people. In fact, if you tried, they'd wind up using YOU. Plus you don't want to be, really. There's another way. So, no[or]Using people is out[stopping]. Maybe you could use something on a person, though." instead;
	if noun is a tronpart or noun is epicer recipe:
		if second noun is a tronpart or noun is epicer recipe:
			if player does not have epicer recipe, say "Those two things seem to go together, but you don't have detailed instructions." instead;
			if number of off-stage tronparts > 0, say "You have the start of something, but not enough to make a north-tron." instead;
			if player is not in Fun Nuf:
				if madam is quicknear or Yuge Guy is quicknear, say "Deal with [if player is in Red Roses Order]Madam[else]the Yuge Guy[end if] first." instead;
				say "You might be better served using these things in Fun [']Nuf. Go there?";
				if the player no-consents, say "OK, but protip: that's where you need to assemble things." instead;
				move player to Fun Nuf, without printing a room description;
			build-the-tron instead;
	repeat through table of useons:
		if there is a use1 entry and noun is use1 entry: [I would like to get rid of this ... the table of cantuse should take care of this, but I need to check things]
			if there is a use2 entry and second noun is use2 entry:
				if there is a preproc entry:
					consider the preproc entry;
					unless the rule succeeded, the rule succeeds;
				if there is a getit entry:
					now player has getit entry;
				if d2 entry is true:
					moot use2 entry;
				if d1 entry is true:
					moot use1 entry;
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
				else if use1 entry is moot and use2 entry is not moot:
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
	repeat through table of specific use rejects:
		if noun is use1 entry and second noun is use2 entry:
			say "[babble entry][line break]" instead;
	repeat through table of shiftables:
		if noun is use1 entry and second noun is use2 entry, try useoning use3 entry with use2 entry instead;
		if noun is use2 entry and second noun is use1 entry, try useoning use3 entry with use2 entry instead;
	repeat through table of usemaybes:
		if second noun is use1 entry, say "[babble entry][line break]" instead;]
	if second noun is a workable, abide by the machine message rules for the noun;
	repeat through table of cantuse:
		if noun is use1 entry or second noun is use1 entry, say "[babble entry]" instead;
	say "You think of ways to do that productively, but nothing comes up." instead;

The machine message rules are an object-based rulebook.

a machine message rule for a thing (called t):
	repeat through table of useons:
		if t is use1 entry and use2 entry is a workable, say "Nothing happens, but you feel you must be close, here." instead;
	say "Nothing happens at all. Maybe [the t] needs to be used more actively." instead;

table of cantuse
use1	babble
redness ender	"The redness ender is good for destroying stuff. Probably evil stuff. You don't need to vaporize anything you're carrying." [?? Rob]
Spur Ups	"The Spur Ups make you want to do something for yourself, by yourself. You're not sure what."
Psi Wisp	"The Psi Wisp is impervious. You need to outrun and outsmart it."
Kayo Yak	"The Kayo Yak grunts. Looks like you can't, or don't want to, use anything on it."
Dave	"Dave's not useful, man."
Ian	"Ian's worse than useless. You need to use your wit on him."
Rob	"Rob's not going to be obliging. You have to get rid of him, somehow."
Ned	"Ned wants a fight, and you need some other way around him."
Pact Cap	"Your pact cap is fine where it is, on your head."
epicer recipe	"It's meant for referral."
Darer Ad	"It was only useful to sucker you into this mess."
Set O Notes	"It's useful for an overview, but not for DOING anything."
north tron	"The North-Tron's already done its job."

[the table of useons approximately follows not only the test commands but also the walkthrough]
[getit = item you get, d1/d2 = use1/use2 disappear(?) pre/post = rule to check, or rule to execute post-happening]
table of useons [xxuse]
use1	use2 (an object)	getit	preproc (a rule)	postproc (a rule)	sco	d1	d2	reg-plus	babble
TI	Door Frood	--	--	--	true	true	true	Yelpley	"The Door Frood begins to read and starts chuckling. Then keeps chuckling. 'Oh my goodness. This is funny. I'd try to explain it to you, but I'm not sure if you deserve to laugh at it yet. Maybe one day.' With uncontrollable laughter spasms, the Door Frood runs away." [b4:PACK CAP/EVADE DAVE/BORE ROB/WORD ROW]
pity tip	eye	snack cans	--	mob-to-alley rule	true	true	false	Yelpley	"The eye scans the pity tip, and the navy van beeps and boops and spits out some snack cans, which roll on the ground. You take them. The navy van then becomes a navi-van and whooshes off to leave for good. And there's something behind it! Apparently, a whole bomb mob! That's who was making all the noise!" [af:TEND NET/WORK ROW]
trap art	reifier	party trap	--	--	true	true	false	Yelpley	"The trap art crunches inside the reifier, then -- bam! Out comes what the trap art was imagined to be: a party trap. I bet it could trap more than one person, or thing, or whatever."
bunk nub	reviver	stock cots	--	--	true	true	false	Yelpley	"After some crunching and slurping, the bunk nub is changed to a bunch of much smaller, but more comfortable looking, stock cots."
party trap	stark rats	gift fig	--	--	true	true	true	Grebeberg	"The rats all try to enter the trap, and SNAP! SNAP! SNAP! The party trap explodes as the last rat enters, but fortunately all the trap-stuff is gone. The Seer Trees seem to nod a bit. You watch as a gift fig rolls out. You take it."
EPOCH COPE	King Nik	Spur Ups	--	cold-loc-hint-bump rule	true	true	true	Grebeberg	"King Nik reads it, nods sagely, and reads. 'Wow! It makes a lot more sense now. I feel like I can understand the more in-depth stuff my parents told me I needed to one day. ERA FARE, Era Care, Era Ware ... and maybe even Era Dare! Thank you!' He hands you some Spur Ups in gratitude. 'Maybe this will give you the same boost you gave me. Now...I must leave and RAFT FAR back to South Ihtuos.'"
stock cots	sleep eels	--	--	--	true	true	true	Grebeberg	"The sleep eels seem intrigued by the upgrade in relaxation resources. You put the stock cots down and roll them out of the way. The eels follow. You can now go south!" [af:puff up/pull up]
wash saw	past sap	--	sap-not-cut-yet rule	sap-loose rule	true	false	false	Grebeberg	"You hack away at the past sap with the wash saw, first squirting some loosening/thawing liquid. It's tricky, but the saw holds out, and with some perseverance, you're able to twist the sap off the rife fir."
puce cup	past sap	--	check-sap-cup rule	sap-to-cup rule	false	false	false	--	"You pour some sap into the cup."
puce cup	liar grail	--	sap-in-cup rule	empty-cup rule	true	false	true	Yelpley	"The past sap pours into the liar grail and exposes how bad the grail has been over the years. As it cracks, along with the wall it was attached to allow passage south, you snicker to yourself. Liar grail? More like Liar FRAIL! Or Liar TRAIL!"
puce cup	dose sod	--	check-sod-cup rule	sod-to-cup rule	true	false	false	Grebeberg	"You funnel the dose sod into the puce cup. It will keep the sod fresh enough."
puce cup	Bond Nob	Elan Ale	sod-in-cup rule	empty-cup rule	true	true	true	Yelpley	"You give the Bond Nob the puce cup. Gulp! Gulp! 'The Bond Nob smashes the Puce Cup and looks embarrassed. 'Oops! Maybe you could still have used that...or not. Please accept some Elan Ale with my apologies. Oh, and enjoy my digs to the west. So many places to visit: Tope Depot, Nigh Gin, Sara's, Soto's, Pat's Tap...'"
stamp mats	slate metals	Ye Key	--	--	true	true	false	Yelpley	"Impressing the stamp mats on the slate metals, a design pops out! A key! An important looking one emblazoned ... YE KEY. You find it hard to pull the stamp mats out, and when you take YE KEY, the mats quickly morph into the slate metals. Eh, well. Less inventory to worry about."
demo med	gulf lug	cash sac	--	bump-gulf rule	true	true	true	Grebeberg	"The Gulf Lug takes the demo med, inspects it, and says, 'Eh, why not...' he looks a lot better within a few seconds. 'Thank you so much!' he says, handing you a cash sac."
cash sac	cross orc	--	--	--	true	true	true	Yelpley	"The cross orc looks at the cash sac suspiciously. It's not sure if the sac is enough. But you convince the orc that money isn't any good if you don't get out there and spend it, and ... with a payee yap, the orc goes off, mumbling how to show off its wealth to those snooty scroll orcs."
YOB ATTABOY	Sniffins	Dirt Rid	--	toons-to-den rule	true	true	false	Yelpley	"Sniffins accepts your gift, with sniffs slowly changing from sadness to something more snooty. Your thanks for helping Sniffins be too good for you is a Dirt Rid. Sniffins shoos you back out. There is remodeling to be done!"
Elan Ale	Sniffins	Gorge Grog	--	--	true	true	false	Yelpley	"Sniffins looks the Elan Ale up and down, sniffs and...well, okay. It will do. 'Now take that Gorge Grog and get it out of here.' Hey, you're not one to say 'stuff free stuff.'" [af:stand nat's]
Dirt Rid	reviver	Cave Vac	--	--	true	true	false	Yelpley	"You watch as the Dirt Rid swirls and becomes shinier and much more powerful. A Cave Vac! It will be capable of cleaning...well, somewhere."
Cave Vac	cassettes sac	radar	--	bump-pod rule	true	true	true	Yelpley	"The Cave Vac has the power to clean up the cassettes sac, though it chokes and sputters at the end of the effort. And while a lot of the cassettes are beyond repair, there's something at the very bottom.[paragraph break]Wow! Radar![paragraph break]You hear noises from the pod, as a hidden robot appears and whisks the garbage away. That's pretty slick! Looking back, the pod doesn't seem so dopy any more, between the Demo Med's help and how you're sure the radar will help."
radar	crag arc	UFO tofu	orc-gone rule	radar-blink rule	true	false	false	Yelpley	"Beeeep... beeeep..... the radar has found something! A small saucer arises from a hidden part of the crag. Splat! something weird and warm drops from the UFO and lands on the radar, which fizzles a bit from the impact and wetness. It hardens quickly and weirdly into a cubic shape. What could it be? You think a minute. It has to be UFO tofu." [af:deny Ned]
Ye Key	etage gate	gate tag	Ned-gone rule	--	true	true	true	Yelpley	"Ye Key fits perfectly into the Etage Gate.[paragraph break]'A hall! Aha! Etage-gate? More like Etage-NEGATE!' you brag, not noticing the gate retracting, Ye Key with it. Well, you can't imagine needing it again.[paragraph break]A gate tag falls off. You pick it up." [af:Worn Row]
stinky knits	rotator	brag garb	--	wear-garb rule	true	true	false	Yelpley	"The stinky knits fit into the rotator without stuffing them too much. After some spinning, you look in again and--they're something much shinier now. Brag garb!"
Gorge Grog	Butene Tub	resale laser	--	make-sag rule	true	true	true	Yelpley	"The Gorge Grog starts fizzing as it pours down the tub, and nothing seems to happen, until you hear a FOOMP below and the tub starts shaking. There must've been an open spark below the tub. You find it best to hide, and that's the right thing to do, because the butene tub explodes into pieces. Under it is a resale laser! You figure the really good stuff is hidden way back for security reasons, and this is probably just an emergency gadget, but it's got to be good for something."
gold log	rotator	dork rod	--	--	true	true	false	Yelpley	"The gold log begins spinning until it cracks open--leaving a dork rod! You wonder briefly if you deserve to take it, or E there's something wrong with you if you deserve to, but once you hold it, memories of past silliness come back, and they're easier to deal with, now. You have some perspective. You even feel sorry for people who pointed out you were a dork. They'd be barred from an adventure like this. So you keep the dork rod."
SOME DEMOS	yahoo hay	straw arts	--	hay-gone rule	true	false	false	Grebeberg	"With the help of SOME DEMOS, you manage to rejig the hay into something more aesthetically pleasing: straw arts!"
straw arts	Revolt Lover	soot tattoos	--	rebump-art-xtra rule	true	true	false	Yelpley	"'Brilliant! Brilliant! Such expressive art! Subversive, yet straightforward! I ... I'd like to sell it on commission. I'd also like to see what else you can do. Here, have these soot tattoos.'"
gate tag	soot tattoos	state tats	--	tats-peripheral rule	true	true	true	Yelpley	"You stamp the gate tag into the soot tattoos, and they take on an official shape. They look like official State Tats, which you can slap on if you ever need to impersonate an official goon, or something. Way to go!"
poo coop	gnu dung	--	--	--	true	false	true	Grebeberg	"The gnu dung is sucked towards the poo coop. In fact, it forms a crass arc as it seems like the dung inside the coop must be several times the volume of the coop itself. Whatever, you can now go south."
poo coop	turf rut	--	coop-full rule	shift-dumb-mud rule	true	true	true	Grebeberg	"The poo coop releases its contents into the turf rut but explodes as the last bit oozes out. You dump it into the hardening mixture.[paragraph break]A bold lob! The rut isn't filled, but you have clear passage across, and the ... bridge ... hardens visibly and quickly. You poke it with your foot to make sure. I guess you could call the turf rut something else, now, but I'm trying to keep this game PG."
radar	made dam	eroded ore	--	radar-blink rule	true	false	false	Grebeberg	"You place the radar against the made dam and move back and forth. Suddenly--yes! You hear a few pings. There's something behind. You discover some eroded ore, which you take. It's not much in its current state, but maybe you can regenerate it somehow. The radar plays a weird scale. Being close to the ore has damaged it somehow."
NULL ILLUN	Known Wonk	--	--	bump-maws rule	true	true	true	Grebeberg	"The Known Wonk begins to read. 'This is too simple. It has to be beneath me. I mean, it's almost as bad as [i]EBB?! BE[r].' But the more the Wonk reads, the more it's clear...they have overlooked stuff. 'Hey. That makes sense. And if it's simple, well, I need to know when simple stuff works.' The Known Wonk apologizes--it's back to the Tru Yurt for a thought session."
el doodle	edits tide	spa maps	--	rahs-too rule	true	true	false	Grebeberg	"The edits tide washes away enough of El Doodle to reveal maps...and not just any maps, but spa maps! And there is a bonus! It appears El Doodle was so jumbled, there were two things. Sharp rahs appear on another sheet of paper, as some sort of confused motivation, and you take them."
elope pole	kayak	you buoy	--	--	true	true	false	Grebeberg	"You unfold the elope pole into two oars. And you take a journey ... well, you're not sure where, but you see Elided Ile in the distance. So you stop off there. First at the Yack Cay for some chat. You are invited to Nevah-Haven, where everyone is happy all the time, but ... it seems too good to be true. Apparently your declining means you passed some sort of test, and the citizens hand you a YOU BUOY to tell you they're glad you're you. They mention it may hold great treasures within, ones that will help you complete your quest. 'Barge! Grab!' they call as one speeds past, in the direction of Calcific Lac. As it gets near and bends away, you jump off, using the buoy to paddle and float back to Calcific Lac."
dork rod	tao boat	enact cane	--	--	true	true	false	Grebeberg	"The dork rod vibrates and causes the Tao Boat to open. You step aboard. Inside are stave vats. You put the dork rod in them, and it shimmers and pops back out as ... an enact-cane. You could stay here forever...but then a voice calls 'Re-rise, desirer!'[paragraph break]You think back to the rep popper in the alley. Suddenly, you don't feel as though you'd feel silly holding it. You're sure you need it, though for what, you can't say."
tent net	Code Doc	--	--	--	true	true	false	Grebeberg	"Together, you figure out what to do to make the tent net proper cover for the All-Ivy Villa. 'Tie it ... tie it ...'[paragraph break]Once the work is done, the Code Doc thanks you and offers to share some knowledge in return, whenever."
spa maps	Code Doc	--	maps-still-confusing rule	maps-explain rule	true	false	false	Grebeberg	"The Code Doc looks at the maps. 'Hmm. I learned a few tricks from Edu-Dude. But I'll need my math tam for this one. One second, let's see--Aha! Oho...' and despite a minor pupil slip-up, it soon makes complete sense to you."
spa maps	go-by bog	sage gas	maps-readable rule	--	true	true	false	Grebeberg	"Everything clicks now! You see Go-By Bog, Gobs Bog, and how to pass through each of them. It's not a total breeze, but when you get through, you find sage gas all around. The Spa Maps are surprisingly sturdy, and you're able to reformat them into a receptacle for the sage gas. Lucky you! Or maybe being around that sage gas made you smart enough to figure the science out, there.[paragraph break]As you return to the Apse Spa, the Spa Maps turn into a salt atlas and crumble away."
enact cane	yahoo hay	moor broom	--	hay-gone rule	true	true	false	Grebeberg	"You stick some strands of yahoo hay into the damaged end of the dork rod. It's now a moor broom!"
troll ort	brag garb	--	--	chase-in-zoo rule	true	true	false	Grebeberg	"You rub the troll ort on the Brag Garb. Whew! Somehow the ort mixed with the garb's materials to make a really strong odor. It's an entirely different smell from the stinky knits, but still quite distinctive." [b4:pace cap] [af:yak okay]
sage gas	tame mat	guru rug	--	--	true	true	true	Grebeberg	"The sage gas bubbles out under the tame mat, and the message changes. To something wiser. But perhaps a bit stuffy."
sharp rahs	guru rug	tenet	--	--	true	true	true	Grebeberg	"The sharp rahs meld into the guru rug, which feels less weighted down by philosophy and floats away. Under it there's a tenet, which seems a bit corny at first, but it seems like it'll help you focus on who you are and what you need to do."
Moor Broom	Tru Yurt	Exam Axe	--	bump-crib rule	true	true	false	Grebeberg	"You begin to clean the Known Wonk's Tru Yurt, and as you do, all sorts of things turn up. The moor broom even shifts into a pomp mop when you need it to, for a bit. The Known Wonk looks shocked at how your simple advice works. You're pretty shocked, too, given how you've never been GREAT at cleaning stuff, but you realize you do okay. The Known Wonk hands you something unusable for an intellectual, but maybe you will find it handy ... an Exam Axe!" [b4:nail ian/use snack cans on UFO tofu/use gift fig on mayo yam]
wash saw	porch crop	balsa slab	--	--	true	true	false	Grebeberg	"You start hacking away with the wash saw, and the whole operation is fun...almost a mirth trim. The Code Doc frowns briefly: 'Bonsai! ... A snob?' before you counter with 'Hep, eh?' The Code Doc nods. You've done well. There's a balsa slab lying around. The Code doc offers it to you. Now, you do own wood!"
Exam Axe	Lie Veil	--	--	--	true	true	true	Grebeberg	"The Exam Axe cuts through the Lie Veil easily. As it does so, it shortens--oh, about 28.57%--before glowing and turning into, well, an ex-axe. You can go north now."
DNA band	reifier	DNA hand	--	--	true	true	false	Yelpley	"After considerable gooping and whooshing, the reifier pops open to reveal something more lifelike than a DNA band: a DNA hand!"
roto motor	DNA hand	bang nab	--	--	true	true	true	Yelpley	"The roto motor fits right in. The hand glows a bit and wiggles its fingers nimbly and even pinches you before you can react. You notice something inscribed on it, now: BANG NAB. I guess that's what to call it, now. It probably has the dexterity to deal with volatile stuff. The bomb mob, for their part, becomes a poor troop once they see what they've lost."
Eroded Ore	reviver	Ore Zero	--	--	true	true	false	Yelpley	"The reviver whirs as you drop the eroded ore in, and ... out pops some shiny Ore Zero!"
you buoy	rotator	ME gem	--	--	true	true	false	Yelpley	"You hear a clunking as the rotator speeds up. When you open the rotator, the you buoy is in shreds, but a shiny ME gem appears. 'You BOFFO buoy!' you can't help shouting.[paragraph break]The gem's so tempting and beautiful, but you know it's not the main point of your quest. Maybe it can distract someone greedy."
bang nab	TNT	TNT	--	--	true	true	false	Yelpley	"The Bang Nab walks on its index and middle finger to the TNT, then nudges it away as the Bomb Mob isn't watching. It flicks the TNT over your way, then quickly skedaddles off to its old home: DNA Land, of course."
nat's tan	scorn rocs	--	--	--	true	true	true	Grebeberg	"The Nat's Tan burns into the scorn rocs, who were once pridefully spotless. Their fur turns an embarrassing shade of orange. You hear a bellow from the west."
rep popper	ME Totem	murdered rum	--	totem-out rule	true	true	true	Grebeberg	"'BOO! NOOB!' the Yuge Guy booms, but his face has turned derp-red. You hold the rep popper at the Yuge Guy until he ducks behind the ME Totem, but by now, the popper is charged, and it splits the totem in half. The Yuge Guy deflates like a balloon and whooshes out over the smirk rims. 'SOS! SOS!' he cries, making a male lam.[paragraph break]The ME Totem, sliced several ways, collapses and sinks into the ground. There's some murdered rum inside. Powerful stuff! You pick it up carefully."
Bro Orb	Mist Sim	Yard Ray	--	sword-rows-reveal rule	true	true	true	Yelpley	"The Bro Orb shines and blinks. The mist sim dissipates under the brutal light. 'Live not on evil, madam, live not on evil!' you boom, as the Orb does its work. Maadam looks much less intimidating now. 'Does it mean...? It does!' She runs away, sobbing. 'You can't catch me! Not with Line Nil in place!' The Yard Ray is left unguarded. You take it. You also wipe off your state tats--you won't need them any more."
balsa slab	sword rows	not-a-baton	--	--	true	true	false	Yelpley	"The sword rows hum and rotate as the balsa slab approaches. They whir and grind as they cut through it, carving and honing it into something that almost seems like a weapon. It's pretty generic, and you wonder what it is, but you notice NOT-A-BATON carved into it. It seems kind of cool if you need self-defense, but you bet it could be so much more, since violence hasn't really been important so far, even to dispose of Madam."
not-a-baton	reifier	taboo bat	--	--	true	true	false	Yelpley	"The reifier coughs and spits out something even more counter culture than the dork rod: a taboo bat! You will be able to smite a bad-faith pearl-clutcher for sure with one of these."
murdered rum	yard ray	--	--	--	true	true	false	Dim Mid	"The yard ray gleams with energy. It seems like it could do some damage now."
Yard Ray	test set	--	ready-to-test rule	--	true	false	true	Dim Mid	"Fzzt! Zap! The test set goes up in smoke. Okay, you had something to practice on. Now for the final battle." [b4:emit noontime]
ME gem	Knife Fink	--	--	kid-left rule	true	true	true	Dim Mid	"The Knife Fink pauses, dazzled by the gem's brightness. 'Wow! It must be valuable!' [if Verses Rev is in Dirge Grid]The Verses Rev stops to tut-tut the Knife Fink, who ignores that.[end if] The Knife Fink grabs the gem and runs off, successfully bribed." [b4:use TNT on ore zero]
taboo bat	Verses Rev	--	--	kid-left rule	true	true	true	Dim Mid	"You raise the Taboo Bat, yelling 'El Bat-Able,' (and ignoring the actual archaic meaning) and suddenly the Verses Rev knows what he's up against. It's not that it's particularly violent or lethal, but ... the Verses Rev has developed such a warped orthodoxy, the bat is much scarier than it should be. Nothing to do but turn and run!"
Yard Ray	redivider	X-ITE TIX	--	kid-bye rule	true	true	true	Dim Mid	"'Havoc, OVAH!' you should as you aim and fire the yard ray.[paragraph break]Fzzt! Zap! The yard ray brightens the Dirge Grid and zaps the Diktat Kid, who goes running off. 'You haven't won for good! You think everyone's living in harmony, but I will build my ...[paragraph break]... RETRO PORTER! It will make things as before you came!'[paragraph break]'What if it moves things to before YOU came?' you taunt.[paragraph break]'SHUT UP!'[paragraph break]You wonder if you should've said that. The Kid is going to check for that now, but with the Kid gone, you see saner arenas all around. Revel, clever! Revel, ever!"
X-ITE TIX	TIX EXIT	--	--	you-win rule	true	false	false	Dim Mid	"Yes, it's time to go. You put the X-Ite Tix in the Tix Exit and walk through."
[zzuse]

section pre-use rules [xxpre]

[please add alphabetically]

this is the check-sap-cup rule:
	if sap-takeable is false:
		say "The sap is stuck to the tree.";
		the rule fails;
	if liar grail is moot:
		say "You doubt you will need the past sap again, since it got you by the Liar Grail[if puce cup is soddy]. In fact, the sod seems like a good thing to have[else]. But maybe something else[end if].";
		the rule fails;
	if puce cup is sappy:
		say "The puce cup already contains past sap.";
		the rule fails;
	if puce cup is soddy:
		say "The puce cup already contains dose sod. Pour it out to get the past sap?";
		if the player yes-consents, the rule succeeds;
		the rule fails;
	the rule succeeds;

this is the check-sod-cup rule:
	if puce cup is soddy:
		say "The puce cup already contains dose sod.";
		the rule fails;
	if puce cup is sappy:
		say "The puce cup already contains past sap. Pour it out to get the dose sod?";
		if the player yes-consents, the rule succeeds;
		the rule fails;
	the rule succeeds;

this is the coop-full rule:
	if gnu dung is moot, the rule succeeds;
	say "The poo coop is empty, but if it wasn't, that could work.";
	the rule fails;

this is the maps-readable rule:
	if maps-explained is true, the rule succeeds;
	say "Hmm. Maybe if the maps were a bit clearer to you, that would work. But not now.";
	the rule fails;

this is the maps-still-confusing rule:
	if maps-explained is true:
		say "You already got the Code Doc to decipher the spa maps.";
		the rule fails;
	if tent net is not moot:
		say "'I might, but I need some help here first, to make my home here properly homey.'";
		the rule fails;
	the rule succeeds;

this is the Ned-gone rule:
	if Ned is moot, the rule succeeds;
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

this is the sap-not-cut-yet rule:
	if sap-takeable is true:
		say "You already hacked enough sap off.";
		the rule fails;
	the rule succeeds;

this is the sap-in-cup rule:
	if puce cup is sappy, the rule succeeds;
	say "[if puce cup is soddy]The sod doesn't seem to belong in the Liar Grail, but maybe something else does[else]The puce cup is empty[end if].";
	the rule fails;

this is the sod-in-cup rule:
	if puce cup is soddy, the rule succeeds;
	say "[if puce cup is sappy]The Bond Nob makes a face at the sap in the cup. Maybe something less unpalatable would help her[else]The puce cup is empty. It wouldn't help the Bond Nob[end if].";
	the rule fails;

section post-use rules [xxpost]

[please add alphabetically]

this is the bump-crib rule:
	shuffle-before Den Ivy Vined and Red Roses Order;
	move porch crop to Den Ivy Vined;
	the rule succeeds;

this is the bump-gulf rule:
	shuffle-before Flu Gulf and Sneer Greens;
	the rule succeeds;

this is the bump-maws rule:
	shuffle-before Dumb Mud and Le Babel;
	shuffle-before Swamp Maws and Dumb Mud;
	the rule succeeds;

this is the bump-pod rule:
	shuffle-before Dopy Pod and Toll Lot;
	the rule succeeds;

this is the chase-in-zoo rule:
	if location of player is Frush Surf, start-chase Kayo Yak;
	the rule succeeds;

this is the cold-loc-hint-bump rule:
	shuffle-before Cold Loc and Emo Dome;
	the rule succeeds;

this is the empty-cup rule:
	now puce cup is moot;
	shuffle-before Apse Spa and Motto Bottom;
	the rule succeeds;

this is the hay-gone rule:
	if SOME DEMOS is moot and dork rod is moot:
		say "You used up all the hay.";
		moot yahoo hay;
	else:
		say "There's still some hay (yah!) left over for another creative project.";
	the rule succeeds;

this is the kid-bye rule:
	move saner arenas to Dirge Grid;
	moot Diktat Kid;
	the rule succeeds;

this is the kid-left rule:
	if Verses Rev is moot and Knife Fink is moot, say "Two-nowt, you muse to yourself. The Diktat Kid, clearly angry, mutters 'Meh, THEM! I should've gone with Mad Adam. Iller Elli. Able Melba. Wolf Low.'";
	the rule succeeds;

this is the make-sag rule:
	move gash sag to Pro Corp;
	say "Soon after you take the resale laser, a small gash sag fills in the explosion you made. Technology!";
	consider the bald-lab rule;
	the rule succeeds;

this is the maps-explain rule:
	now maps-explained is true;
	the rule succeeds;

this is the mob-to-alley rule:
	moot navy van;
	now girt rig is in Yell Alley;
	now bomb mob is in Yell Alley;
	now TNT is in Yell Alley;
	shuffle-before Yell Alley and Sneer Greens;
	the rule succeeds;

this is the radar-blink rule:
	if radar-used is 1:
		say "One more hit like that, and the radar might give out for good.";
	else:
		say "Between the UFO tofu dropped on the radar and the eroded ore getting too close to it, the radar shorts out. After a pop, it splits open. A roto motor falls out and looks undamaged, so you take it.";
		now player has roto motor;
		moot radar;
	the rule succeeds;

this is the rahs-too rule:
	now player has the sharp rahs;
	the rule succeeds;

this is the rebump-art-xtra rule:
	shuffle-before Art Xtra and Red Roses Order;
	the rule succeeds;

this is the sap-loose rule:
	now sap-takeable is true;
	if player has puce cup:
		say "Hmm, the puce cup would be perfect to carry the past sap in[if cup is not empty], though you'd need to empty the cup, first[end if].";
		the rule succeeds;
	say "You don't want to take the sap now--you don't have a container that would hold it in the sticky warmth. But you've cut enough off the tree.";
	the rule succeeds;

this is the sap-to-cup rule:
	now puce cup is sappy;
	now puce-ever is true;
	repeat through table of useons:
		if use1 entry is puce cup and use2 entry is past sap:
			now sco entry is false;
			the rule succeeds;
	the rule succeeds;

this is the shift-dumb-mud rule:
	shuffle-before Dumb Mud and Le Babel;
	the rule succeeds;

this is the sod-to-cup rule:
	now puce cup is soddy;
	now puce-ever is true;
	repeat through table of useons:
		if use1 entry is puce cup and use2 entry is dose sod:
			now sco entry is false;
			the rule succeeds;
	the rule succeeds;

this is the sword-rows-reveal rule:
	move sword rows to Red Roses Order;
	moot madam;
	move Line Nil to Red Roses Order;
	the rule succeeds;

this is the tats-peripheral rule:
	now state tats are peripheral;
	the rule succeeds;

this is the toons-to-den rule:
	move player to Toll Lot;
	moot decal placed;
	move snooty toons to Deft Fed;
	the rule succeeds;

this is the totem-out rule:
	moot ME Totem;
	the rule succeeds;

this is the wear-garb rule:
	now player wears the brag garb;
	the rule succeeds;

this is the you-win rule: [xxwin]
	say "The Flee Elf greets you on the other side. 'Deified! Deified!' You ask hesitantly about the new adventures promised.[wfak-d]";
	say "The X-ITE TIX lead to A REAL WORLD THAT WILL BE MORE EXCITING AFTER YOUR EXPERIENCE HERE!'[wfak-d]Well, given all the palindromes you dealt with, you probably should've expected a circular loop to 'back where you began' non-twist. Books like that always kind of annoyed you, but you did have fun here. Probably more than if you'd stood around and leveled up a whole bunch in some more 'exciting' world. So that's something. The Flee Elf shakes your hand and pulls out a device. 'This RIDE-DIR will help you return to your own world.'[wfak-d]";
	say "As you wait, you hear arguments over if Yelpley needs a name change and if so to what: Tropiciport? El Live Ville? Grub Burg? Or even Prodded-Dorp (sounds motivational!) You realize you're probably not going to stop that sort of silly argument, but on the other hand, why be bothered by it?[wfak-d]";
	say "Toot! Toot! A ride pulls up. You were sort of expecting a racecar, but it turns out it's just a Back Cab--a Toyota, too. 'Race fast, safe car,' you mutter unconsciously, but it doesn't. Still, you enjoy the extra time reflecting. You're disappointed you didn't get a DVD as a gift, but to remember this, you'd like ... to jot. What to call them? It's a tough call between SOME MEMOS, SAGAS or SOLOS. Hmm, maybe DRAWN INWARD.";
	end the story finally saying "Darn! Rad!";
	sort the table of last lousy points in finord order;
	if in-beta is true, display-dropbox-link;
	the rule succeeds;

chapter failed useons

[?? poo coop on, well, everything]

[xxfail]
table of specific use rejects
use1	use2	babble
Dirt Rid	cassettes sac	"The Dirt Rid wheezes but is unable to clean up the cassettes sac. You need something more powerful."
radar	sleep eels	"A radar isn't supposed to work this way, but somehow, you detect some bitterness at mammals in general. But it's secondary to needing a more comfortable place to sleep."
troll ort	cross orc	"The cross orc mutters something unrepeatable about prejudiced people who can't tell the DIFFERENCE and don't WANT to. But the way it looks at you, you suspect it'd forgive you if you gave the right gift."
troll ort	kayo yak	"As you hold the troll ort out, the Kayo Yak butts your hand! The troll ort goes flying. You walk over to pick it up."
Gorge Grog	yard ray	"The Gorge Grog is pretty strong stuff, but you may need something even stronger."
Rep Popper	Yuge Guy	"It seems like the Rep Popper should work, but it doesn't, quite. Maybe there is something that is giving the Yuge Guy all his rep?"
Bro Orb	Madam	"The Bro Orb might dissolve her, but you're not out to kill anyone. Still, close."
poo coop	Yuge Guy	"That could be fun, but he might be normalised to the stuff in the coop."
poo coop	Liar Grail	"Maybe if the contents came from a bull and not a gnu, it would be appropriate."
yard ray	Diktat Kid	"The Diktat Kid laughs as you point the yard ray. 'Destroy me, but my work will remain!'"
yard ray	Tru Hurt	"The Tru Hurt is dangerous, but maybe you should use the yard ray on something even more harmful."
yard ray	Waster Fretsaw	"The Waster Fretsaw is dangerous, but maybe you should use the yard ray on something even more harmful."
gate tag	DIFF ID	"You wave the gate tag in front of the DIFF ID, which beeps for a second, then ... nothing. Maybe the gate tag (or its pattern) needs to be read a different way."
soot tattoos	DIFF ID	"The Diff-ID doesn't respond. Maybe you need a way to put them on you, somehow."
state tats	DIFF ID	"You can just walk north to get through."
[zzfail]

[below is something to cut and paste to the table of failed useons]
[item1	item2	"[fill-in-here]"]

chapter shiftables

table of shiftables
use1	use2	use3
wash saw	rift fir	past sap

volume rooms

part Dim Mid region

book Fun Nuf

Fun Nuf is a room in Dim Mid. "[if elite tile is in Fun Nuf]Elite tile has replaced the old tile lit. Probably all that's left to do is to read it, or just go back south through the Tix Exit[else]Some tile lit is carved out here, describing what is the various directions[xit-ave][end if][if north tron is in Fun Nuf]. Also, the North-Tron has carved a passage north[end if]."

to say xit-ave:
	say ". The [if tix exit is in Fun Nuf]Tix Exit prevents passage back south[else]Evac Ave is south, if you want to chicken out[end if]"

chapter north tron

the north tron is scenery. "[if Dirge Grid is visited]The North-Tron is useless now.[else]It seems to have cracked open a passage north here in Fun [']Nuf. Do you have the guts to follow it to your destiny?[end if]"

printed name of north tron is "North-Tron".

chapter Flee Elf

The Flee Elf is a person in Fun Nuf. "A Flee Elf stands here, guarding Evac Ave to the south.". description is "Quite a pert rep. You'd expect to see the Flee Elf wearing a gateman nametag, but maybe that's in some other, even more insanely brilliant, wonderful and creative adventure."

understand "pert/rep" and "pert rep" as Flee Elf.
does the player mean doing something with rep popper: it is likely.

chapter Evac Ave

Evac Ave is scenery in Fun Nuf. "Evac Ave leads back to where you were."

instead of entering Evac Ave, try going south.

elf-warn is a number that varies.

the Tix Exit is scenery. "It's nothing particularly fancy. I'm going to go out on a limb here and say it'll accept [if player has X-ITE TIX]your X-ITE TIX[else]X-ITE TIX, if you can find them[end if]."

check going south in Fun Nuf:
	if player has X-ITE TIX, try useoning X-ITE TIX with Tix Exit instead;
	if Tix Exit is in Fun Nuf, say "The Tix Exit blocks your way to where Evac Ave was. You try to look for a way to bust through, but a voice booms 'EL BARRABLE!'[paragraph break]I guess you're stuck questing, here." instead;
	if flee elf is moot, say "You have no way back now that you accepted the Pact Cap." instead;
	if elf-warn < 3, increment elf-warn;
	say "[if elf-warn is 1]The Flee Elf encourages you to give taking the cap a shot--well, not quite TAKING it, but if you do take it, you'll be ready to go[else if elf-warn is 2]'Oy! Oy! Yo-yo!' The Flee Elf encourages you to find the right way to take--er, get--er, pick up the cap[else]The Flee Elf mentions there are really only 26 simple ways to pick up the cap, if you think about it, and why not just brute force? You're not busy with anything else[end if].";
	if elf-warn < 3, the rule succeeds;
	say "[line break]Do you still wish to go through Evac Ave and turn your back on adventure?";
	if the player yes-consents:
		say "The Flee Elf cries 'Fool! Aloof!' as you walk south past Evac Ave through the Elim-Mile, which removes all your memories of your brief time adventuring.";
		end the story saying "NOWT WON";

xite-warn is a truth state that varies.

check going in Fun Nuf:
	if noun is west or noun is east:
		if Flee Elf is in Fun Nuf, say "'Keen! Eek!' the Flee Elf stops you. 'You need to figure out the right way to take the Cap, for a place like Grebeberg or Yelpley.'" instead;
		if endgame-test is true, say "Endgame testing is on. So you are restricted to the final combat." instead;
	if player has x-ite tix and xite-warn is false:
		now xite-warn is true;
		if roving-LLP is 0:
			say "[if the score is maximum score - 1]There's nothing else to do. No last lousy points. You can/should really just leave[else]You have a few last lousy points left, but none require you to move[end if]. Do you still want to explore?";
			if the player yes-consents:
				say "Okay, have fun.";
			else:
				say "Okay, back to winning." instead;
		else:
			say "You have a few last lousy points to look around for, so why not poke around?";

to decide which number is roving-LLP: [Not location dependent: DIAL AID, STATS, REFER, POOP, PEEP]
	let temp be 0;
	if senile felines are in Moo Room, increment temp;
	if slam-mam is false, increment temp;
	if balm-got is false, increment temp;
	if opossum is not moot, increment temp;
	if DWELT LEWD is off-stage, increment temp;
	if bees-seen is false, increment temp;
	decide on temp;

check going north in Fun Nuf:
	if Diktat Kid is moot, say "No need to go back." instead;
	if epicer recipe is off-stage, say "You need to get there. But you have no clue what to build, or how." instead;
	if er-ex is false, say "You're clueless how. But you decide to look at the epicer recipe...[paragraph break]" instead;
	if north tron is not in Fun Nuf, say "Not until you built the North-Tron." instead;
	if player does not have yard ray, say "You don't have a weapon to take down the Diktat Kid." instead;
	if murdered rum is not moot, say "You have the yard ray, but it isn't, well, charged." instead;
	if player does not have ME gem or player does not have Taboo Bat, say "As you go north, you hear three voices. Perhaps the yard ray would work okay at first, but ... you get the feeling you may need some other stuff to take out EVERYBODY.";

chapter Pact Cap

The Pact Cap is a wearable thing in Fun Nuf. "A pact cap sits here. You need to find the right way to accept it to begin your quest.". description is "It's no stetson, but it is less messy than a tahini hat, and it [if player has pact cap]feels[else]looks[end if] serviceable enough."

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
	say "Yes, that's how to get the cap. You are ready to go![paragraph break]'Good job! Here's a set o['] notes to help with that Darer Ad,' the Flee Elf says. It salutes you before becoming, err, the FLED Elf. Where the elf went, a big TIX EXIT sprouts up. You don't have any tickets or anything, though, so you'll have to worry about that later.[paragraph break]Perhaps it's not the most stylish thing ever, but at least they didn't make you wear a bib.";
	moot flee elf;
	now Tix Exit is in Fun Nuf;
	now player has Set O Notes;
	now player wears the cap;
	score-inc; [Dim Mid/pack cap]
	the rule succeeds;

chapter pace cap

paceing is an action out of world.

understand the command "pace cap" as something new.
understand the command "pacy cap" as something new.

understand "pace cap" and "pacy cap" as paceing.

pace-prev is a truth state that varies.

carry out paceing:
	if kayo yak is moot, say "You had enough high-speed fun for one game. If you want to zip around the map, though, GT is always an option." instead;
	if pact cap is in Fun Nuf:
		now pace-prev is true;
		say "That'll work later, but you need something a little different to actually TAKE the pact cap." instead;
	if cap-pace is true, say "It's already a pace cap." instead;
	if mrlp is Grebeberg, now cap-pace is whether or not cap-pace is false;
	if cap-ever-pace is false:
		reg-inc Dim Mid; [pace cap]
		now cap-ever-pace is true;
		now pace-prev is false;
		say "[if mrlp is not Grebeberg]As you flip the cap, a voice booms 'WALK: LAW.' Perhaps you need to change it in a slower area.[else]You suddenly feel [pace-of]![end if]";
	else:
		say "[if mrlp is not Grebeberg]As you flip the cap, a voice booms 'WALK: LAW.' Perhaps you need to change it in a slower area. Like Grebeberg to the west?[else]You suddenly feel [pace-of].[end if]";
	follow the notify score changes rule;
	the rule succeeds;

to say pace-of:
	say "[if cap-pace is true]full of deep speed[else]slower[end if]"

check going to Fun Nuf:
	if cap-pace is true, say "From the east, a voice booms 'WALK: LAW.' You adjust your pace cap back to a pact cap.";
	now cap-pace is false;

[helpdocs below]

chapter Darer Ad

the Darer Ad is a proper-named helpdoc. The player carries the Darer Ad. importancy of the Darer Ad is 1.

description of Darer Ad is "No LOL on? SEE, REFER-EES! Do! Nod!"

after examining the Darer Ad for the first time:
	say "Well, you need something with a bit more concrete advice. Maybe you'll find it quickly enough.";
	continue the action;

chapter Set O Notes

the Set O Notes is a proper-named helpdoc. description is "There's some general vague advice about making a North-Tron to defeat the Diktat Kid, but first you'll have to defeat [b]Madam[r], as well as the [b]Yuge Guy, Evil Clive[r].[paragraph break]You notice that there is a guh-thug at various places that doesn't quite fit in, and you can probably guess what to do there. [thug-report].[paragraph break]Also scribbled, in the center, is FUN [']NUF with TRI-GIRT below that. [paragraph break]The Set O Notes also points out you'll need to find items and use them together, but since you're on a quest, you already sort of knew that.". importancy of the Set O Notes is 2.

x-notes-yet is a truth state that varies.

to say thug-report:
	let GG be number of moot guhthugs;
	let GG2 be number of seenees guhthugs;
	if GG is 4:
		say "You've gotten all of them, so yay";
		continue the action;
	else if GG is 0:
		if GG2 is 0:
			say "[if GG2 is 0]You haven't seen any yet, but who knows";
		else:
			say "[list of seenees guhthugs] may fit this description. Maybe you can get past [if GG2 is 1]him[else]them[end if]";
	else:
		say "[if number of seenees guhthugs is 0]Maybe you will figure how to tackle [list of seenees guhthugs][else]You got rid of [list of moot guhthugs], but maybe someone else is around[end if]";

definition: a guhthug (called th) is seenees:
	if location of th is visited, yes;
	no;

after examining Set O Notes:
	if x-notes-yet is false:
		say "Well, that was much more useful than the Darer Ad, but maybe you'll get something even more detailed than the Set-O-Notes later.";
		now x-notes-yet is true;
	if player is in Worn Row, say "[trigirt].";

to say trigirt:
	if x-notes-yet was false, say "[line break]";
	if ever-workrow is true and ever-wordrow is true:
		say "Well, that makes sense. You've changed Worn Row to Word Row and Work Row";
	else if ever-workrow is false and ever-wordrow is false:
		say "Hmm. You wonder what Tri-Girt could mean, here. Maybe Worn Row is not quite as static as it seems";
	else:
		say "You've made [location of player] Row, but the 'tri' makes you think there might be something else"

chapter tile lit

the tile lit is scenery in Fun Nuf. "It's a rough compass, with GREBEBERG west by it, YELPLEY east, Evac Ave south and Dirge Grid north. You can't seem to go [if flee elf is moot]south and [end if]north, though." [ic]

check taking tile lit: say "It's sort of embedded into the ground. It looks nice there, anyway, and it's useful for information."

chapter elite tile

the elite tile is scenery. "Done? Nod![line break]Nif-T-Fin!"

after going to Fun Nuf when Diktat Kid is moot:
	say "You notice the elite tile has changed slightly.";
	continue the action;

book Dirge Grid

Dirge Grid is a room in Dim Mid. "The only way back is south[if Diktat Kid is in Dirge Grid], but you can't really run away from the Diktat Kid. A Tru Hurt is pointed at you, but if you deal with the Kid, that won't matter[else], and you might as well go that way, now you've vanquished the Diktat Kid. Saner Arenas surround you[end if]."

check going to Dirge Grid: if test set is not moot, say "[if player does not have yard ray]You don't have an adequate weapon[else]You need to get some practice with the Yard Ray before going north[end if]." instead;

printed name of Dirge Grid is "[if Diktat Kid is moot]Top Spot[else]Dirge Grid[end if]"

for writing a paragraph about a person when player is in Dirge Grid:
	now all people in Dirge Grid are mentioned;
	if Dirge Grid is visited:
		say "You are greeted by someone who must be the Diktat Kid, who reminds you of a bully from high school. 'You did some weird things to get this far--but I've done some PRACTICAL things to make sure that's it! Knife Fink! Verses Rev!'[paragraph break]'ENGAGE LE JEU QUE JE LE GAGNE!'[wfak-d]";
		say "They both appear. And they are armed! The Knife Fink, with leet steel, and the Verses Rev, with a part strap.";
		if player does not have ME gem and player does not have taboo bat:
			say "Looking at your items, there's no way you have enough to take care of the Diktat Kid and the two henchmen. You back off.";
			move player to Fun Nuf, without printing a room description;
			continue the action;
		if player does not have ME gem and player does not have taboo bat:
			say "You feel like you aren't quite prepared enough to tackle the Diktat Kid's henchmen. You back off.";
			move player to Fun Nuf, without printing a room description;
			continue the action;
	else:
		if player does not have ME gem and player does not have taboo bat:
			say "You're still overwhelmed by all three opponents.";
			move player to Fun Nuf, without printing a room description;
			continue the action;
		if player does not have ME gem and player does not have taboo bat:
			say "You still don't feel confident of victory. You need just a little more.";
			move player to Fun Nuf, without printing a room description;
			continue the action;
		else if Knife Fink is moot and Verses Rev is moot:
			say "The Diktat Kid continues to rage at you. Two henchmen gone, but it's not over!";
		else if Knife Fink is moot:
			say "The Diktat Kid continues to yell at the Verses Rev to do something.";
		else if Verses Rev is moot:
			say "The Diktat Kid continues to yell at the Knife Fink to do something.";
		else:
			say "The Diktat Kid yells and wonders why the Verses Rev and Knife Fink haven't disposed of you, yet.";

check going south in Dirge Grid: if Diktat Kid is in Dirge Grid, say "'Mom! SOS! LOL! SOS! Mom!' the Diktat Kid mocks you.[paragraph break]You can't chicken out. You must be close!" instead;

advance-kid is a truth state that varies.

kid-moves is a number that varies.

every turn when player is in Dirge Grid:
	if advance-kid is true, increment kid-moves;
	if kid-moves is 5:
		say "Deport! Roped!"; [?? punch up]

chapter saner arenas

saner arenas are peripheral scenery. "They're a sign that Grebeberg and Yelpley will return to where they were."

chapter Diktat Kid

Diktat Kid is a proper-named person in Dirge Grid. description is "The Diktat Kid [if henchmen-left is 0]is yelling at you, now[else if henchmen-left is 1]alternates between yelling at the departed [hl of true] and the remaining [hl of false][else]is barking out orders needlessly to the Knife Fink and Verses Rev[end if]."
[??due: Feud]

to say hl of (ts - a truth state):
	say "[if ts is whether or not Verses Rev is moot]Knife Fink[else]Verses Rev[end if]"

to decide which number is henchmen-left:
	let count be 0;
	if Knife Fink is in Dirge Grid, increment count;
	if Verses Rev is in Dirge Grid, increment count;
	decide on count;

every turn when Diktat Kid is quicknear:
	say "The Diktat Kid whines '";
	next-rand table of diktat taunts;
	say "'";

chapter Knife Fink

the Knife Fink is a person in Dirge Grid. "A Knife Fink wields some leet steel here.". description is "A rough customer, to be sure. But the Fink's dazed look suggests greed more than hate, obligation more than violence."

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

table of periphery [xxper]
itm	reject
girt rig	"The girt rig is too sturdy to move. But then, there's even sleazier stuff beyond it."
redness ender	"You don't want to do anything crazy with the Redness Ender. You don't want to go near it. It's dangerous looking. You can picture it ambushing someone who doesn't expect it."
decal placed	"The decal placed decal is just there to advertise the food. It's not critical to the story."
snooty toons	"The snooty toons are just there for ambience. They're not critical to the story."
pill lip	"The pill lip is just there to prevent the demo med from getting dirty on the ground."
mush sum	"The mush sum is too murky and unstable to deal with. And to break the fourth wall, it's just there to provide a north border."
go fog	"The go fog is very dense. It pushes you back even as you look at it. As if to say, go away, and also, get going with what you want and need to do."
be web	"The be web is--well, it's itself, and maybe there's a message here but you'll figure it out once you're finished adventuring. It's not important enough now."
voodoo v	"You don't want or need to mess with the voodoo v."
leet steel	"You want to focus on the Knife Fink and not the leet steel."
senile felines	"You don't have to do anything standard with the senile felines. In fact, you should think of them as cats."
late petal	"You don't need to do anything with the late petal. Perhaps you could help the felines, uh, cats reach it?"
part strap	"You want to focus on the Verses Rev and not the part strap."
pool gloop	"Fortunately, you don't need to do anything special to or with the pool gloop."
spa taps	"The spa taps can't do much. You're not a customer, anyway."
smirk rims	"The smirk rims are only important if you let them be. In other words, they're not."
state tats	"You don't need to do anything to or with the state tats, now that you're wearing them."
storm rots	"Yuck. You don't want or need to touch the storm rots, or do anything with them. There's probably worse behind them."
Line Nil	"There's no way to dispel Line Nil, but Madam isn't the main enemy here, any more."
DIFF ID	"The DIFF ID can't be broken. You [if Red Roses Order is visited]already found[else]just need to find[end if] a way to identify yourself."
Par Wrap	"It's not the Verses Rev's clothes you need to worry about."
Tru Hurt	"[rediv-instead of tru hurt]."
Waster Fretsaw	"[rediv-instead of waster fretsaw]."
saner arenas	"It's good the saner arenas are there, but you don't need to mess with them."

to say rediv-instead of (th - a thing):
	say "While the [th] is worrisome, it's clearly not as dangerous as the Redivider"

chapter Verses Rev

the Verses Rev is a person in Dirge Grid. "A Verses Rev wields a part strap here.". description of Verses Rev is "Looking pretty average in a par wrap, but the hate and brimstone the Rev intones at you is a different matter."

the Verses Rev wears the Par Wrap.

the Par Wrap is peripheral. description is "It's your average religious-person clothing.".

the Verses Rev carries the part strap.

the part strap is peripheral. description is "It's more for overzealous religious flagellation to be daunting. A more practical weapon just might defeat it."

chapter x-ite tix

the x-ite tix are a plural-named thing. description is "A duo. Loud. They promise passage to an EVEN MORE EXCITING AND EXPANSIVE ADVENTURE THAN THE ONE YOU'VE JUST FINISHED.[paragraph break]The words 'WOW' and 'YAY' are also written about ten times on each ticket."

understand "xite" and "xite tix" as x-ite tix.

chapter redivider

the redivider is scenery in Dirge Grid. "[if Diktat Kid is moot]It's broken down now. You don't understand how it works, but perhaps it could be repurposed as something more useful. Like a rotavator. The folks in Grebeberg could use a few extra agricultural tools[else]Just looking at the redivider makes you very mad at friends who said something mean two years ago, as if people who lived life better would've stayed madder and found even better friends. It's hard to pull yourself away, but you do[end if]."

chapter tru hurt

the tru hurt is peripheral scenery in Dirge Grid. "The Tru Hurt is here, and it's aimed at you!"

chapter waster fretsaw

the waster fretsaw is peripheral scenery in Dirge Grid. "The less thought of, the better. Without the Diktat Kid to operate it, it'll be less harmful."

chapter emiting

emitted is a truth state that varies.

emiting is an action applying to one topic.

understand the command "emit" as something new.

understand "emit [text]" as emiting when player has yard ray.

carry out emiting:
	if murdered rum is not moot, say "The Yard Ray isn't charged enough to emit anything." instead;
	if player is in location of Yuge Guy, say "No...the Yuge Guy needs to be defeated by other means." instead;
	if Diktat Kid is moot, say "You already got rid of the Diktat Kid." instead;
	if the topic understood matches "noontime":
		say "BOOM! The yard ray emits so much light, you immediately have to switch it off. Well, that was a good start. Now you want to make sure you can aim it at something that can be destroyed.";
		now emitted is true;
		score-inc; [Dim Mid/emit noontime]
		the rule succeeds;
	if the topic understood matches "time":
		say "Yes, but what sort of time? Something positive and cheery, you'd guess." instead;
	if the topic understood includes "time":
		say "Not that sort of time. But it must be SOME time. A good time." instead;
	say "No, that's not quite what to emit.";
	the rule succeeds;

part Grebeberg region

book Seer Trees

Seer Trees is west of Fun Nuf. It is in Grebeberg. "East leads back to Fun [']Nuf[if Yawn Way is visited] and Yelpley[end if], but the other directions lead to further rustic adventure.".

check going in Seer Trees:
	if noun is not east and stark rats are in Seer Trees, say "The stark rats block you from going anywhere. At least they are not banging stop pots." instead;

chapter stark rats

the stark rats are a plural-named thing in Seer Trees. "Stark rats impede you every way except back east.". description is "They are scurrying about. There are too many to get through without getting bitten."

check taking stark rats: say "There are too many, and they'd probably bite you, anyway." instead;

check dropping party trap in Seer Trees: try useoning party trap with stark rats instead;

chapter gift fig

the gift fig is a solid ingredient. description is "Well, it's a fig."

book Cold Loc

Cold Loc is north of Seer Trees. It is in Grebeberg. "It's kind of dewed, here. A rift fir that blocks a steep drop west. [if sap-takeable is true]The past sap you cut from it is lumped on the ground[else]Some past sap clings to the rift fir[end if]."

check going west in Cold Loc: say "The rift fir blocks the way to much more dangerous places." instead;

chapter rift fir

A rift fir is scenery in Cold Loc. "It's a rife fir. You're not getting past it, but you don't need to."

chapter past sap

the past sap is scenery in Cold Loc. "[if sword rows are moot]It is in a lump on the ground[else]It's stuck to the rift fir, but with the right tool, maybe you could pry it off[end if]."

check taking past sap: say "[if liar grail is moot]You probably don't need any more past sap, now that you used it to dispose of the Liar Grail.[else]It's too sticky to carry around by itself. Maybe have a container carrying it?[end if]"

instead of taking the past sap: say "It'd get sticky on your fingers. You need some way to carry it."

instead of doing something with past sap:
	if action is procedural, continue the action;
	say "[if liar grail is moot]With the liar grail gone, you don't want to have to deal with the past sap again[else]The past sap might be useful, but you [how-take-sap[end if]."

to say how-take-sap:
	say "might [if puce-ever is true]want to USE the cup to hold it[else]need something to carry it in. It's sticky[end if]"

sap-takeable is a truth state that varies.

chapter King Nik

King Nik is a person in Cold Loc. "[one of]A man sits here, shaking his head. On seeing you, he gets up. 'I'm King Nik, and I came to Grebeberg for advice. Got any?'[or]King Nik paces around hopelessly, looking lost.[stopping]". description is "He doesn't look very regal. Maybe he needs something that can help him gain, or learn, gravitas.".

chapter Spur Ups

the Spur Ups are a plural-named thing. description is "Boy! These are so much better than that round tuitt a teacher gave you as a joke. If you could mass produce and market them when you got back, what a motivational fad you could start--and profit from."

book Flu Gulf

Flu Gulf is north of Cold Loc. It is in Grebeberg. "North and east, it's, oh, too H2O. The passage is clear back south, but [if scorn rocs are in Flu Gulf]scorn rocs['] gaze blocks you going west[else]west past the scorn rocs seems a bit treacherous[end if]. No way you're getting through the mush sum to the north."

chapter mush sum

the mush sum is peripheral scenery in Flu Gulf. "It looks deceptive and swampy."

chapter gulf lug

the Gulf Lug is a proper-named person in Flu Gulf. "The Gulf Lug stands here, holding his stomach.". description is "He looks slightly ill. Maybe you could help him.".

chapter cash sac

the cash sac is a thing. description is "It's full of currency--currency which you don't know whether you can spend anywhere."

chapter scorn rocs

The scorn rocs are plural-named scenery in Flu Gulf. "While they're motionless, their stare drives you back. They're fiercely proud and blazingly colored."

check going west in Flu Gulf when scorn rocs are in Flu Gulf:	say "The scorn rocs remain motionless, but their gaze freezes you as you try to go west." instead;

book Sneer Greens

Sneer Greens is west of Flu Gulf. It is in Grebeberg. "[if Yuge Guy is in Sneer Greens]Despite the impressive view, the place has gone to pot.[else]Nicer with the Yuge Guy gone. Still, it's...[end if][paragraph break]You can only go back east. Smirk rims block every way back except east[if me totem is in Sneer Greens], and a ME Totem towers above you."

check going nowhere in Sneer Greens: say "The smirk rims push you back, but you really don't need to do anything [if Yuge Guy is moot]more here[else]with them, just the Yuge Guy[end if]." instead;

Sneer Greens is above Flu Gulf.

printed name of Sneer Greens is "[if Yuge Guy is in Sneer Greens]Sneer Greens[else]Et Tu Butte[end if]"

understand "et tu butte" and "et/tu/butte" and "et tu" and "et/tu butte" as Sneer Greens when Yuge Guy is in Sneer Greens.

after looking in Sneer Greens for the first time:
	say "'Believe Me. Adore Me. Believe!' O gee, ego, you think to yourself.";
	continue the action;

every turn when Yuge Guy is quicknear:
	if a random chance of 1 in 2 succeeds:
		say "The Yuge Guy mumbles '";
		next-rand table of yuge taunts;
		say "'";

check going east in Sneer Greens:
	if Yuge Guy is in Sneer Greens, say "'LOW AWOL! BOO, NOOB!' the Yuge Guy booms, as you run away."

chapter Yuge Guy

Yuge Guy is a proper-named person in Sneer Greens. description is "Bilgy. Glib. He cries 'GAWK, WAG!' as you look at him.". "[one of]'BELIEVE ME! LOVE ME! BELIEVE!' yells someone Wow--he's a lot bigger than you.[paragraph break]'I am EVIL CLIVE! the Yuge Guy!' he drones on. After your initial shock, you see that while he is bigger than you, it's more horizontally than vertically, and he looks like the ME Totem, too.[or]The Yuge Guy continues carrying on about how the world stinks, except for him.[stopping]"

understand "evil/clive" and "evil clive" as Yuge Guy.

chapter ME Totem

the ME Totem is scenery in Sneer Greens. description is "It's a more favorable version of the Yuge Guy: taller, thinner, better looking. It's overdone, but you can see how people would be fooled by it. It is hard to look away. But you know you need to."

chapter smirk rims

the smirk rims are peripheral scenery in Sneer Greens. description is "They look at you as if to say, 'What makes you think you can beat the [if Yuge Guy is in Sneer Greens]Yuge Guy[else]Diktat Kid[end if]?'"

chapter murdered rum

some murdered rum is a drinkable thing. description is "It looks viscous, like oil. Perhaps it was only murk rum long ago, before it sat in the belly of the ME Totem for so long. It's ... well, you wouldn't want to get in contact with it. A lot more powerful than regular alcohol."

book Dumb Mud

Dumb Mud is west of Seer Trees. It is in Grebeberg. "Mud! Um...[paragraph break]A turf rut to the south is [if poo coop is moot]filled in enough[else]too deep[end if] to cross. The way west is [if gnu dung is moot]free[else]blocked by gnu dung[end if]. [if lie veil is in Dumb Mud]A lie veil blocks your way[else]With the lie veil removed, you can go[end if] north."

check going west in Dumb Mud:
	if gnu dung is in Dumb Mud, say "Not through the gnu dung you aren't." instead;

check going south in Dumb Mud:
	if poo coop is not moot, say "The turf rut is too deep. You need a way to fill it in." instead;
	if Mont Nom is unvisited, say "With the turf rut filled in, the way across remains stable, and it even smells okay! Bonus! You climb up to...";

check going north in Dumb Mud:
	if lie veil is in Dumb Mud, say "As you touch the lie veil, you shake your head. No. You don't really want or need to explore north. Surely there's some better place to be? Perhaps you're not 100% prepared for the lie veil's thought provoking paradoxes, and it's doing you a favor pushing you back? You try to walk further north, but somehow you wind up walking back south." instead;

chapter gnu dung

the gnu dung is in Dumb Mud. "Gnu dung blocks exit west from the Dumb Mud.". description is "You're not an expert in this sort of biology, but given what you've seen so far, it's probably from a gnu."

instead of doing something with gnu dung:
	if action is pro-and-use, continue the action;
	say "Eewee! (You probably want to deal with the gnu dung indirectly.)"

chapter turf rut

The turf rut is scenery in Dumb Mud. "[if poo coop is moot]Since you filled it in, you can walk across it to the south[else]It's deep enough to prevent you going south[end if]."

check taking turf rut: say "You'd need a nab-rut turban to do that. There's no nab-rut turban in this game[if poo coop is moot]. Besides, you already [rut-made-go] across[end if]." instead;

to say rut-made-go:
	say "[if Mont Nom is visited]made it[else]can go[end if]"

understand "turd rut" as turf rut when poo coop is moot.

chapter lie veil

The lie veil is scenery in Dumb Mud. "It looks untrustworthy."

book Le Babel

Le Babel is north of Dumb Mud. It is in Grebeberg. "This is a weird place. Nothing makes sense here. A voodoo v blocks passage--and sight--everywhere except back south."

chapter voodoo v

the voodoo v is peripheral scenery. "Maybe you could walk across it without getting hurt, but you doubt it. It's there, and it's immovable."

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
	abide by the LLP rule; [MUSS OPOSSUM]
	moot opossum;
	the rule succeeds.

chapter Bro Orb

the Bro Orb is a thing in Le Babel. "[one of]An orb hovers in the air. You know it must be a Bro Orb[or]The Bro Orb still hovers in the air[stopping]. You would love to take it, but you're not sure if you're worthy.". description is "Looking into the Bro Orb, you think, 'Do orbs brood?' You start to understand social, subjective knowledge you assumed only jerks know. Maybe they know it better, but you realize you are cheating yourself if you don't learn it.". [??bros orb]

check taking Bro Orb:
	if player has Bro Orb, say "You already have it." instead;
	if player does not have tenet, say "A voice in your head says 'WANT? NAW!'[paragraph break]You aren't sure you can handle the potentially corrupting power of the Bro Orb. [if player has sage gas]The sage gas helps you to understand how things could go wrong, but still, you're a bit worried[end if]. Maybe if you had some more balance to your thinking." instead;
	say "You wonder if you should take the Bro Orb. If you deserve to. But you reread the tenet and whisper to yourself, 'Nag, ol['] slogan,' and feel balanced enough to take the Bro Orb and accept the responsibility for doing so.";

report taking Bro Orb:
	moot tenet;
	say "Taking the Bro Orb requires two hands. You watch the tenet flutter off beyond the Voodoo V. Oh, well. You carry the tenant's message in your mind and heart and stuff anyway, now.";

check useoning tenet with Bro Orb:
	say "You don't need to wave the tenet around or anything to take the orb, but you focus on the tenet to make sure.[paragraph break]";
	try taking Bro Orb instead;

book Mont Nom

Mont Nom is south of Dumb Mud. It is in Grebeberg. "An ark of okra blocks passage every way except back north here."

Mont Nom is above Dumb Mud.

chapter ark of okra

The ark of okra is scenery in Mont Nom. "You always found okra, or the idea, icky, but the ark is beautiful enough, you sort of wonder how it'd taste. Here you can see DO OFT FOOD inscribed on it. Maybe if you LISTEN you'll hear an equally weird and vaguely useful message."

instead of eating ark of okra: say "You don't know how long it's been out here. It's probably, like, the vegetable version of wax fruit."

chapter martini tram

the martini tram is a tronpart. "That martini tram that appeared from Mont Nom is here.". description is "[if player has epicer recipe]The martini tram looks like it'll provide a handy base for the future North-Tron the epicer recipe described[else]You're not sure what it is for, but it seems sturdy[end if].". [?? "examined" as a property]

chapter Ian

Ian is a proper-named guhthug in Mont Nom. "[one of]'I'm Ian. I guess I can't make you leave, but you seem ill-equipped to deal with the sophisticated blend of tastes served up by Mont Nom.'[or]Ian continues to look down his nose at you.[stopping]". description is "Ian smirks back at you. You turn away. He seems just a bit too suave.".

chapter nailing

nailing is an action applying to one thing.

understand the command "nail" as something new.

understand "nail [something]" as nailing when player is in Mont Nom and Ian is in Mont Nom.

carry out nailing:
	if Ian is moot, say "There's nobody named Elian to nail later in the game, so this isn't an action you need to take any more." instead;
	if noun is not Ian, say "You'll know what or whom to nail, and that's not it." instead;
	say "You wait and hide. After a while, you catch Ian picking his nose absent-mindedly. You call him on it! In the presence of food, no less! Ian hurries away in shame across the Turf Rut. He takes one look at the, um, bridge and realizes that if he hadn't DONE anything gross, he wouldn't have to CROSS anything gross.";
	moot Ian;
	score-inc; [Grebeberg/nail ian]
	the rule succeeds;

book Ooze Zoo

Ooze Zoo is south of Seer Trees. It is in Grebeberg. "[if sleep eels are in Ooze Zoo]Sleep eels block passage south, but you can still go back north[else]With the sleep eels gone, you can go north, or south to [s-dray][end if]."

chapter sleep eels

the sleep eels are plural-named people in Ooze Zoo. "The sleep eels look comfortable where they are. Maybe you can give them better sleeping quarters.". description is "The sleep eels squirm. Maybe there's a humane way to move them out."

to say s-dray:
	say "[if Frush Surf is visited]the Frush Surf[else]a coastal place[end if]"

book Frush Surf

Frush Surf is south of Ooze Zoo. "The land curves here. You can go north or east. The surf is to the south.". It is in Grebeberg.

check going south in Frush Surf: say "You barely step in, and the water's a bit hot. You're worried you might run into some scorch crocs." instead;

[Line Nil is scenery in Frush Surf.]

chapter Stamp Mats

stamp mats are a thing in Frush Surf. "Stamp mats lie here.". description is "The stamp mats appear to be engraved in order to cut a pattern out."

after taking stamp mats:
	shuffle-before Frush Surf and Trial Lair;
	continue the action;

chapter Kayo Yak

The Kayo Yak is a chaser in Frush Surf. chase-room of Kayo Yak is Frush Surf. "A kayo yak paws the ground here. It doesn't seem violent, but it seems up for rough play.". description is "[if being-chased is true]The Kayo Yak is really rumbling around, here[else]The Kayo Yak looks alert, ready for more than just standing around[end if]."

chapter yakokaying

yakokaying is an action applying to nothing.

understand the command "yakokay" as something new.
understand the command "yak okay" as something new.

understand "yak okay" as yakokaying.

carry out yakokaying:
	if ergot ogre is moot, say "[if yak is in location of player]The yak has served you well. It deserves a rest.[else]You relive past glories. Why not?[end if]" instead;
	if yak is in location of player and ergot ogre is in location of player:
		say "The kayo yak surges at the ergot ogre and knocks it over with a few ... smart rams! The ergot won't spread to the yak's horns, so that's good. The ogre dusts itself off and walks away, damp, mad. The yak, for its part, looks relaxed--almost like a tao goat--and heads off, not to the Frush Surf, but somewhere calmer.[paragraph break]You think you hear an elk cackle in the distance.[paragraph break]Whew! That's enough exercise. You readjust your pace cap back to a pact cap.";
		now cap-pace is false;
		score-inc; [Grebeberg/YAK OKAY]
		moot yak;
		moot ergot ogre;
		now being-chased is false;
		the rule succeeds;
	if yak is in location of player, say "The yak sees nothing to attack." instead;
	say "There's no yak to say okay to." instead;
	the rule succeeds;

book Moo Room

Moo Room is east of Frush Surf. It is in Grebeberg. "You can't see any cows, but you occasionally hear them. From what you can see, the farm belongs to a Mr. A, who is not around. [if yahoo hay is in Moo Room]Yahoo hay is piled all around. [end if]The only way back is west."

chapter poo coop

the poo coop is in Moo Room. "A poo coop sits here. Thankfully, it looks empty.". description is "While it's 1/4 too small to be a pooch coop, it's 1) empty and 2) somehow bigger on the inside than the outside. [if gnu dung is moot]It's full of gnu dung, which would be nice to get rid of[else]Maybe it can clean up a dirty area. Well, a less dirty area than the Moo Room where you found it[end if]."

chapter senile felines

the senile felines are plural-named peripheral things in Moo Room. "Senile felines swat at a late petal just a bit too high to reach. It might be fun to help them, but they probably can't help you. CATS!". description is "They are just lazing around, swatting at the late petal but never reaching it. You guess it must be fun for them.[paragraph break]Maybe it'd be fun to think of them as CATS."

understand "cats" as senile felines.

check taking the senile felines: say "Sure, that'd help them swat the petal and 'win' whatever game they're playing, but maybe they want to feel like they did it themselves. As CATS." instead;

the late petal is peripheral scenery in Moo Room. "It's just out of reach of the cats."

instead of taking late petal, say "That'd be cheating, to actually give the cats the petal."

chapter yahoo hay

the yahoo hay is scenery in Moo Room. "Just being around the yahoo hay makes you feel, man, this can be used to build even cooler stuff."

chapter straw arts

the straw arts are a plural-named thing. description is "Whatever they are, you made them, and you hope it expresses something or other."

chapter moor broom

the moor broom is a thing. description is "It's made of that enact came amd the yahoo hay, and just looking at it, you feel almost excited about cleaning."

book Mire Rim

Mire Rim is west of Dumb Mud. It is in Grebeberg. "A made dam blocks your way west. You can go north, south and east here."

crib-clue is a truth state that varies.

after looking in Mire Rim when player has exam axe:
	say "You notice that the den to the south looks a bit different. Something's been growing there. Maybe you should check it out.";
	now crib-clue is true;
	continue the action;

chapter made dam

the made dam is scenery in Mire Rim. description is "It looks hastily put together, and you're not sure if it's actually protecting any great torrent of water."

instead of attacking made dam, say "You don't want to make it a ... maddened dam."

chapter eroded ore

some Eroded Ore is a thing. description is "You're no expert metallurgist, but it's dim and porous and probably not as potent as it could be."

book Den Ivy Vined

Den Ivy Vined is south of Mire Rim. It is in Grebeberg. "This is a homey little north-south passage, [if tent net is moot]especially now that you helped the Code Doc add some furnishings[else]but it doesn't quite feel quite as comfortable as it should, yet[end if][if-porch]."

printed name of Den Ivy Vined is "[if tent net is moot]Den, Ivy-Vined[else]All-Ivy Villa[end if]".

understand "all ivy villa" and "all ivy" and "all/ivy" and "all/ivy villa" as den ivy vined when tent net is not moot.

chapter code doc

Code Doc is a person in Den Ivy Vined. "[one of]Someone is pacing back and forth here, muttering 'More ROM! MORE Rom! MORE ROM!' They look up as you walk in. 'Oh. Sorry. Hi. I'm the Code Doc. I can help you with, like, technical stuff, if you need.'[or]The Code Doc paces back and forth here.[stopping]". description is "The Code Doc scribbles notes here, before putting them back in an unused pocket. Busy, but not too busy to help someone else."

chapter Spa Maps

Spa Maps are a plural-named proper-named thing. description is "[if sage gas is not off-stage]The maps seem old hat now you've gotten the sage gas[else if maps-explained is false]You can't quite make sense out of them. There's Gobs-Bog and Go-By Bog, and one is a lot safer than the other, but you're not sure which[else]The spa maps clearly demark Go-By Bog and Gobs Bog and even Goblin-Nil Bog, which probably contains a troll or two. And no hospitality[end if]."

understand "spa map" and "map" as spa maps.

check examining spa maps:
	if player is not in Apse Spa, say "It doesn't look like the maps are useful here." instead;
	try useoning spa maps with go-by bog instead;

maps-explained is a truth state that varies.

chapter porch crop

the porch crop is scenery. "[if wash saw is moot]It's been cleared up since you used the wash saw on it[else]It really sprawls. Maybe there is a way to trim it to help the Code Doc[end if]."

to say if-porch:
	if porch crop is in Den Ivy Vined:
		say ". [if wash saw is moot]The porch crop is still trimmed back[else]Some porch crop has sprouted up, and it looks okay, but there's just too much of it[end if]";

chapter balsa slab

The Balsa Slab is a thing. description is "It appears grooved, as if someone has labeled places to cut it to make it into something useful."

book Lair Trial

Lair Trial is south of Den Ivy Vined. It is in Grebeberg. "Thick go-fog causes passage in this lair to bend [if Motto Bottom is unvisited]back [end if]north and east[if ergot ogre is moot], and with the trial over, you're free to go either way[end if]."

check going nowhere in Lair Trial: say "[if ogre is in Lair Trial]You can't sneak around the ergot ogre. You need to get rid of it[else]There's nothing in the fog[end if]." instead;

chapter ergot ogre

the ergot ogre is a person in Lair Trial. "An ergot ogre blocks the way east.". description is "It looks vicious, and you don't want it touching you, due to disease and possible dismemberment. You need to get the ogre out of the way, somehow.".

check going east in Lair Trial: if ergot ogre is in Lair Trial, say "Not with the ergot ogre guarding the way." instead;

chapter go fog

the go fog is peripheral scenery in Trial Lair. understand "gofog" and "go-fog" as go fog. "The go fog is very opaque. It would be too easy to get lost in."

book Motto Bottom

Motto Bottom is east of Lair Trial. It is in Grebeberg. "A be-web blocks passage every way except back west."

chapter be web

the be web is peripheral scenery in Motto Bottom. understand "beweb" as be web. "The be-web spans everywhere except back west. Perhaps if you were a lot cleverer, or sillier, you could find meaning in it, but as-is, it only blocks your way back west."

chapter tame mat

The tame mat is a thing in Motto Bottom. "A tame mat lies here. It's supposed to be profound and universal, but you're half embarrassed to look at what it says.". description is "'MAIN, I AM!' it reads. That's sort of lame. There must be some way to improve it, make it cleverer or weightier."

chapter guru rug

The guru rug is a thing. "A guru rug lies here. You're not sure how impressed you should be by it.". description is "Hmm, it's not fully tacked to the ground. Maybe you could slip the right thing in or under. Its simplicity leads you to believe it holds even greater secrets within."

check taking guru rug: say "'Egad! Adage!' you think to yourself. You're not up to any great philosophy. Maybe something less heavy than the guru rug." instead;

chapter tenet

The tenet is a thing. description is "It seems a bit too cliche, but you have the wisdom to get the encouragement you need from it."

check useoning tenet with Bro Orb: try taking Bro Orb instead;

book Swamp Maws

Swamp Maws is north of Mire Rim. It is in Grebeberg. "An edits tide blocks your way west, and storm rots block your way east. You can go [if Known Wonk is moot]north and [end if]south here[if Known Wonk is moot]. The Known Wonk's Tru-Yurt is here. It looks really messy[end if]."

check going north in Swamp Maws when Known Wonk is in Swamp Maws: say "The Known Wonk pushes you back. 'You don't know how weird it is to the north. But I know a thing or two about adventuring theory.'" instead;

check going west in Swamp Maws: say "The edits tide [if el doodle is moot]was more useful to help reconfigure El Doodle[else]is probably better for something edit-able[end if]." instead;

check going east in Swamp Maws: say "You don't want or need to have anything to do with the storm rots." instead;

chapter storm rots

the storm rots are plural-named peripheral scenery in Swamp Maws. "Euugh. You don't want to go anywhere near them."

chapter Known Wonk

The Known Wonk is a person in Swamp Maws. "The Known Wonk stands by a Tru Yurt, blocking the way north and [one of]figuring you'll have to do, even though you're not as interesting as a book[or]waiting for intellectual conversation[stopping].". description is "Not particularly disheveled, but then, not terribly charismatic. The Known Wonk seems lost in more esoteric matters than helping you figure how to save Grebeberg and Yelpley."

chapter  Exam Axe

The Exam Axe is a thing. description is "Just looking at the exam axe, you feel as though you've been right about stuff. Maybe not right or morally superior, but you're able to see through obvious nonsense. You know it will help you with some max-exam, somewhere."

chapter Tru Yurt

The Tru Yurt is scenery in Swamp Maws. "It looks really messy. The Known Wonk said it needed a good cleaning."

chapter Edits Tide

The Edits Tide is scenery in Swamp Maws. "A voice from the edits tide seems to say [if spa maps are off-stage]that you could use its proofreading skills[else]it has labored enough for you[end if]."

chapter sharp rahs

the sharp rahs are a plural-named thing. "The sharp rahs get you enthused, but they're not enough by themselves. Perhaps they are a bit overdone, with stuff like ZEST SEZ. They need balance some way.". description is "Reading the rahs leaves you feeling more motivated for a bit, but not long, because you used all; your mental energy getting motivated. Perhaps they need to be balanced with something more cerebral." [??rahs on mat]

book Calcific Lac

Calcific Lac is north of Swamp Maws. It is in Grebeberg. "[if dork rod is moot]The Tao Boat that helped you get at peace with things is here[else]A Tao Boat rests on the shore, here, with no clear entry[end if]. [eli-ile].[paragraph break]"

to say eli-ile:
	if elope pole is moot:
		say "That kayak you took to Elided Ile is here, too";
	else:
		say "There's a kayak, too. ";
		if NULL ILLUN is moot:
			say "[one of]And wait! If you look into the distance, you see something! Elided Ile! Just as the Known Wonk said it had to be somewhere! The Wonk's calculations and predictions were all right[or]You see Elided Ile in the distance. Maybe some day, you will get there[stopping]";
		else:
			say "You scan in the distance for anywhere the kayak might take you, but you can't find anywhere, yet";

chapter kayak

The kayak is scenery in Calcific Lac. "It's, well, just a kayak. It doesn't have anything to steer it with, though. Maybe you have something, or you could find something."

instead of doing something with kayak when elope pole is moot: [??use X on kayak]
	if action is procedural, continue the action;
	say "The kayak has served its purpose."

chapter tao boat

The Tao Boat is scenery in Calcific Lac. "It rocks gently on the waves, with no clear entry, just fine without anyone riding on it. You [if dork rod is moot]wonder what it's like inside, if you're worthy[else]look back on your time inside with fondness. It has put you at peace with the job you have ahead[end if]. Just looking at it gives more inner peace than you'd get from any of the medicine or alcohol you've come across in the game."

check entering tao boat: say "You see no clear entry. Perhaps you need to make some gesture, or show the boat an emblem of your worth or self-acceptance." instead;

chapter dork rod

The dork rod is a thing. description is "It's kind of neat and quirky, but it's not shiny enough to be the famed Dorada Rod. Which would be worth more at a pawn shop, but the dork rod reminds you of embarrassing things you did in the past, and yet...you're not quite so embarrassed about them! You know how to deal a bit better, now."

chapter enact cane

The Enact Cane is a thing. description is "Just holding it makes you feel snazzier and more authoritative and with it. It's slightly mussed at one end, as if maybe you could attach something there."

chapter taboo bat

The taboo bat is a thing. description is "You feel rebellious just holding this thing. One look, and visions of chances taken and authority bucked in your youth, sensible or not, swirl at you for a bit."

chapter you buoy

the you buoy is a thing. description is "It's reallly plain, now you look at it. Also, as you look it over, it rattles a bit."

check opening you buoy: say "You can't find an opening. Sadly, this is slightly trickier than Zork I. Slightly." instead;

chapter ME gem

the ME gem is a thing. description is "You feel a strong urge to keep this and not share it, because of all the crazy things you did to get it, but you know that's not quite right. You wonder of its origin--perhaps it was chipped off from Le We Jewel, or it was originally engraved in the Ring O['] Zognir.[paragraph break]Also, it looks nothing at all like the emerald in Zork I, which was also in a buoy, so stop thinking that."

book Apse Spa

Apse Spa is east of Cold Loc. It is in Grebeberg. "The Apse Spa is covered with dose sod, which you don't need for yourself--you're not sick--but it looks beautiful. Pool gloop and Go-By Bog block pretty much every way except back west. You [if sage gas is off-stage]could traverse it, if you knew what you were doing[else]already went through it, though[end if]. There are also spa taps here you shouldn't mess with, since you're not a paying customer."

chapter dose sod

the dose sod is scenery in Apse Spa. "It looks ucky, but given you're in an Apse Spa, it may have health benefits for those that need them."

check taking dose sod: say "It's pretty slimy. And if it has curative properties, that'd be canceled out by your germs carrying it." instead;

chapter go-by bog

Go-By Bog is scenery in Apse Spa. description is "It's too hazy. You'd get lost navigating it without a lot of help."

chapter pool gloop

The pool gloop is peripheral scenery in Apse Spa. "The pool gloop is probably to help people convalesce, but you're not sick."

chapter spa taps

some spa taps are plural-named peripheral scenery in Apse Spa. "They probably keep the spa feeling relaxing, somehow. You resist the urge to twiddle them. Or maybe get rid of one to create a path tap that might lead somewhere."

check taking spa taps: say "They're useless, altogether or if you take just one. You don't need a path tap in this game."

chapter sage gas

some sage gas is a thing. description is "It's pretty translucent--you're just glad you've been able to bottle it up in the maps, somehow.".

part Yelpley region

book Yawn Way

Yawn Way is east of Fun Nuf. It is in Yelpley. "Not much to do here, and it's quiet enough it could be Yawling-Nil way, but you can go in all four directions, here: back west to Fun [']Nuf, north to [if Art Xtra is visited]Art Xtra[else]an art store[end if], south to [if My Gym is visited]My Gym[else]a gym[end if], or east to [if Emo Dome is visited]Emo Dome[else]a dome[end if]."

chapter puffuping

puffuping is an action applying to nothing.

understand the command "puffup" as something new.
understand the command "puff up" as something new.

understand "puffup" as puffuping.
understand "puff up" as puffuping.

puffed-up is a truth state that varies.

carry out puffuping:
	if puffed-up is true, say "You already did." instead;
	if player does not have spur ups, say "You don't possess anything that would help you feel more up." instead;
	say "As you hold the Spur-Ups, you think about how great you are and can and will be. Surprisingly, it works! It works so well, you figure you don't even need the spur-ups for a boost in the future.[paragraph break]Hardened! Rah![paragraph break]You feel more confident, more able to deal with sadness now.";
	now puffed-up is true;
	moot Spur Ups;
	score-inc; [Yelpley/puff up]
	the rule succeeds;

book My Gym

My Gym is south of Yawn Way. It is in Yelpley. "You can go back out north to Yawn Way. There's also passage west[if Worn Row is visited]to [Worn Row][end if]. Or you can LISTEN to soak up 'energetic' beats."

chapter Dave

Dave is a proper-named guhthug in My Gym. initial appearance is "[one of]A fellow walks over to you and booms 'I'M DAVE!' You freeze, and after a few seconds, he whispers, 'Dud.'[or]Dave is here, keeping an eye on you, guarding the passage west.[stopping]". description is "Dave is big and strong and fast."

instead of doing something with Dave:
	if action is procedural, continue the action;
	if current action is evadeing, continue the action;
	say "Looks like you'll need to do something special with, or to, Dave. Nothing destructive. But psych him out, somehow."

check going west in My Gym when Dave is in My Gym: say "Dave says, 'I can't let you do that, Hal. Ah!' There must be a succinct, clever way to sneak around him!" instead;

chapter wash saw

The wash saw is in My Gym. "A small wash saw [if Dave is moot]lies here[else]is behind Dave[end if].". description of wash saw is "How handy! It can squirt out cleaning fluid or whatever. Useful if something's stuck.".

check taking wash saw when Dave is quicknear: say "Not with Dave around." instead;

chapter evadeing

evadeing is an action applying to one thing.

understand the command "evade" as something new.

understand "evade [something]" as evadeing.

does the player mean evadeing Dave: it is very likely.

Dave-evade is a truth state that varies.

carry out evadeing:
	if noun is Dave:
		if Dave-evade is true, say "You don't need to evade Dave again.";
		say "You evade Dave! Deked! Deked![paragraph break]Dave, frustrated from spinning around trying to catch you, runs off.[paragraph break]Suspicious there are no actual weight machines, you find a passage to a hidden spate of Sperses-Reps machines. You're suspicious they actually work, but as you test them out, a surge goes through you. Your attitude nets you scepsis-pecs, which will help you carry any amount or weight of things you pick up in your journey. After a few seconds, you've half forgotten you have them.";
		moot Dave;
		now Dave-evade is true;
		score-inc; [Yelpley/evade dave]
	else:
		say "There's only one person you need to evade in this game.";
	the rule succeeds.

book Worn Row

Worn Row is west of My Gym. It is in Yelpley. "[if Worn Row is worky]Three machines are here[else if Worn Row is wordy]A tract cart is here, [tract-status][else]It's pretty empty here, but maybe you could make it a bit more active and cheery[end if][if redness ender is in Worn Row]. There's also a redness ender here, but it looks dangerous to get too close to[end if]. The only way out is back east."

printed name of Worn Row is "[if Worn Row is wordy]Word[else if Worn Row is worky]Work[else]Worn[end if] Row"

Worn Row can be worny, wordy or worky. Worn Row is worny.

understand "work row" and "work" as Worn Row when ever-workrow is true.
understand "word row" and "word" as Worn Row when ever-wordrow is true.

chapter redness ender

the redness ender is a peripheral thing in Worn Row. "A redness ender sits here, looking lethal. Maybe it's part of why Worn Row is so worn--nobody wants to stick around enough to clean things up, or build anything. But maybe there is a simple way to get rid of it.". description is "It also seems to double as a redness SENDER, as when you get close to look at it, an ominous red dot appears on you. You back off.".

chapter tract cart

the tract cart is scenery in Worn Row.

tract-trace is a truth state that varies.

to say tract-status:
	say "[if number of books in Worn Row is 1]almost empty[else if number of books in Worn Row is 0]holding no books[else]holding a few books[end if]"

definition: a book (called bo) is sober:
	if bo is DWELT LEWD, no;
	yes;

for printing a locale paragraph about a book (called bk):
	if bk is not mentioned:
		say "The tract cart contains [list of sober books in Worn Row][if DWELT LEWD is in Worn Row], with DWELT LEWD off to the side[end if].";
		now all books are mentioned;

chapter Rob

Rob is a proper-named guhthug in Worn Row. "[one of]'Oh, hi! I'm Rob, it's pretty uninteresting here, so you'd sort of fit in, but I'm trying to make it better. So, bug off, okay?'[or]Rob is still here giving you the side-eye.[stopping]". description is "Rob sniffs and rolls his eyes as if he is too good for Worn Row."

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
	say "You bore Rob successfully. He wanders off, perhaps to Ybor.";
	moot Rob;
	score-inc; [Yelpley/bore rob]
	the rule succeeds.

chapter workables

a workable is a kind of thing. a workable has a number called useleft. useleft of a workable is usually 3.

understand "machine" as a workable.

description of a workable is "[if useleft of item described is 0]It's broken now, but you got good use out of it[else if useleft of item described is 3]The only way you can tell it from the other two is because [printed name of item described in upper case] is printed on the front[else]Since you had success using [the item described], you feel more comfortable using it again[end if]."

the reifier is a workable. useleft is 3.
the reviver is a workable. useleft is 3.
the rotator is a workable. useleft is 3.

rule for supplying a missing second noun when useoning:
	if noun is a workable:
		say "You need to USE something on the [noun]. Or you can just [if noun is reifier]REI[else if noun is reviver]REV[else]ROT[end if] a thing, for shorthand.";
		reject the player's command;
	continue the action;

to wear-down (w - a workable):
	decrement useleft of w;
	if useleft of w is 0, say "You watch as [the w] sputters and dies. Well, you got a lot of good use out of it, and hopefully you won't need any more.";
	if useleft of w is 1, say "[the w] wheezes emphatically. Hopefully, you won't need to use it too much more.";
	if machuses is 0:
		hint-bump-worn;
		say "[line break]With [list of workables] all destroyed, Work Row shakes a bit more. The machines fall out from a wall, revealing something behind ... a test set. It's big and huge and you can't move it, but who knows what it'll be useful for later?";
		move test set to Worn Row;
		now all workables are in devreserved; [ic]
		[?? how to moot all workables]

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

understand "rei [something]" as reiing when player is in Worn Row and reifier is not off-stage and ever-workrow is true.

carry out reiing:
	if reifier is not in Worn Row, say "You need to bring back Work Row." instead;
	try useoning noun with reifier instead;

section reving

reving is an action applying to one thing.

understand the command "rev" as something new.

understand "rev [something]" as reving when player is in Worn Row and reviver is not off-stage and ever-workrow is true.

carry out reving:
	if reviver is not in Worn Row, say "You need to bring back Work Row." instead;
	try useoning noun with reviver instead;

section roting

roting is an action applying to one thing.

understand the command "rot" as something new.

understand "rot [something]" as roting when player is in Worn Row and rotator is not off-stage and ever-workrow is true.

carry out roting:
	if reifier is not in Worn Row, say "You need to bring back word row." instead;
	try useoning noun with rotator instead;

chapter books

the tract cart is scenery. "It carries [number of books in Worn Row] books: [list of books in Worn Row][hint-trace]."

to say hint-trace:
	say "[if tract-trace is true]. But it also seems a bit too big for just carrying a few books. Maybe it holds a deeper secret[end if]"

check examining tract cart:
	if number of not necessary books in Worn Row is 0:
		say "It's empty now[hint-trace]. Maybe some day, someone will write a book like ";
		next-rand table of altbooks;
		say ". Maybe it could be you! But you don't have the time to read right now, really." instead;

a book is a kind of thing.

check examining a book:
	if description of noun is empty, say "It [if player carries the item described]is[else]looks[end if] really heavy and incomprehensible to you."

to decide which book is rand-book:
	let Q be a random carried book;
	decide on Q;

understand "book/books" as a book. [?? doesn't work long term]

does the player mean doing something with a carried book: it is very likely.

after examining a book:
	if noun is not DWELT LEWD, say "The author is [auth-name of noun].";
	continue the action;

to say auth-name of (mybk - a book):
	define-author mybk;
	choose row auth-row of mybk in table of random authors;
	say "[person-name entry]";

a book can be in-row or hidden. a book is usually in-row.

a book can be necessary. a book is usually necessary.

a book has a number called auth-row. auth-row of a book is usually 0.

auth-ind is a number that varies.

check examining a book (this is the assign a book to a random table rule):
	define-author noun;

to define-author (bk - a book):
	if auth-row of bk is 0:
		increment auth-ind;
		now auth-row of bk is auth-ind;

chapter pity tip

the pity tip is a thing. description of pity tip is "'You can do something neat with the cart! There are so many possibilities, of course.'[paragraph break]NOTE: this document is good for free snack cans at Seedy Dee's."

chapter books in bookcase

TI is a proper-named book. printed name of TI is "TO IDIOT (TI)". understand "to idiot" and "idiot" as ti. description is "It's full of hot takes and 'clever' put-downs based on assuming the recipient isn't as smart as they think they are. You remember laughing at this sort of thing when you were really bored or grouchy, and you sort of regret it now. Still, it keeps some people busy.". [Door Frood]
NULL ILLUN is a proper-named book. printed name of NULL ILLUN is "NULL ILLUN (NI)". understand "ni" as NULL ILLUN. description is "Surprisingly wise advice about how to achieve happiness and shake annoyances you can't dispel with just logic.". [Known Wonk]
EPOCH COPE is a proper-named book. printed name of EPOCH COPE is "EPOCH: COPE (EC)". understand "ec" as EPOCH COPE. description is "All sorts of present-day political and social musings.". [King Nik]
YOB ATTABOY is a proper-named book. printed name of YOB ATTABOY is "YOB ATTABOY (YA)". understand "ya" as YOB ATTABOY. description is "All about picking yourself up by your bootstraps and not feeling sorry for yourself or being too jealous of what others know or can do.". [Sniffins]

chapter SOME DEMOS

there is a book called SOME DEMOS. printed name is "SOME DEMOS (SD)". understand "sd" as SOME DEMOS. It is proper-named and hidden. description is "It's a sort of life hacker book with a particular emphasis on having fun with making weird art out of common or even unsophisticated materials and not worrying too much how good it is.".

gap-yet is a truth state that varies.

after examining a book:
	if gap-yet is false, say "You look for a page gap, and you're surprised there isn't one.";
	now gap-yet is true;
	continue the action;

chapter DWELT LEWD

DWELT LEWD is a proper-named not necessary hidden book. printed name of DWELT LEWD is "DWELT LEWD (DL)".

dwelt-first is a list of text that varies. dwelt-first is { "Nell, Edna", "Leon", "Nedra", "Anita", "Rolf", "Nora", "Alice", "Carol", "Leo", "Jane", "Reed", "Dena" }.
dwelt-last is a list of text that varies. dwelt-last is { "Ned", "Dee", "Rena", "Joel", "Lora", "Cecil", "Aaron", "Flora", "Tina", "Arden", "Noel", "and Ellen" }

lewd-chap is a number that varies. lewd-chap is 0.
lewd-read is a truth state that varies.

check examining DWELT LEWD: if lewd-chap is 1 and lewd-read is true, say "Another round? Sicko.[paragraph break]";

description of DWELT LEWD is "[lewd-details]".

to say lewd-details:
	let lelt be number of entries in dwelt-first;
	if lelt is not number of entries in dwelt-last, say "(BUG mismatched text array sizes) "; [should never happen, but just in case]
	increment lewd-chap;
	say "[one of]It's by Liberty Trebil and Bernie Weinreb. [or][stopping]You read chapter [lewd-chap]: Dennis";
	repeat with X running from 1 to lewd-chap - 1:
		say ", [entry X of dwelt-first]";
	let temp be lewd-chap;
	let min be lelt + 2 - lewd-chap;
	if debug-state is true and lewd-chap > 1, say ","; [for reference, to see where the midpoint is]
	repeat with X running from min to lelt:
		say "[if X is not lelt],[end if] [entry X of dwelt-last]";
	say " Sinned.";
	if lewd-chap is number of entries in dwelt-first + 1 and lewd-read is false:
		say "[line break]Whew! You've finished DWELT LEWD. After reading the blurb for the sequel, [']S SENSUOUSNESS, and a related Leer Reel (on DVD), MUCH, you realize you've forgotten the plot [one of]already[or]yet again[stopping], if there was one. Sicko. (Hey, don't look at me, I just wrote the abstract code for the 'book.')";
		now lewd-chap is 0;
		now lewd-read is true;

check taking DWELT LEWD: say "No, you'd be embarrassed to be seen with it. It can't be useful anywhere. You hope not, anyway." instead;

chapter book verbs

books-carried-yet is a truth state that varies.

a thing has a number called take-order. the take-order of a thing is usually 1.

take-order of DWELT LEWD is 2.

The book-sort rule is listed before the generate action rule in the turn sequence rules.

This is the book-sort rule:
	let L be the multiple object list;
	if the number of entries in L is greater than 1:
		sort L in take-order order;
		alter the multiple object list to L.

check taking a book:
	if number of entries in multiple object list > 1:
		let firstbook be the noun;
		alter the multiple object list to { };
		add noun to multiple object list;
	if player has noun, continue the action;
	if number of moot books is 2 and SOME DEMOS is off-stage:
		say "As you pick up [noun], something else falls out. It's a smaller pamphlet, called SOME DEMOS. You pick it up.";
		now player has SOME DEMOS;
		now SOME DEMOS is in-row;
		continue the action;
	if books-carried-yet is false:
		say "Oof! a bit heavy, but after working out in My Gym, it's not TOO unwieldy.";
		now books-carried-yet is true;
	else:
		if number of books carried by player is 1:
			let myb be random book carried by player;
			say "A flashback to that time you checked out too many library books and got a small fine when you couldn't finish them all impels you to put [myb] back in the tract cart to take [noun].[paragraph break]Plus nothing says 'adventure' less than schlepping around multiple books.";
			now myb is in Worn Row;
		else:
			say "It's a bit unwieldy, but you manage to pick up [noun].";
	now player has noun instead;

chapter clear Worn Row

to clear-worn-row:
	if Worn Row is worny:
		if redness ender is in Worn Row, move redness ender to TempMet;
	else if Worn Row is wordy:
		move tract cart to TempMet;
		repeat with Q running through books:
			if Q is in Worn Row, now Q is in TempMet;
	else if Worn Row is worky:
		if test set is in Worn Row, move test set to TempMet;
		repeat with Q running through workables:
			if Q is in Worn Row, now q is in TempMet;
	else:
		say "This should never happen, but it did. I'd be interested to see how."

chapter workrowing

workrowing is an action applying to nothing.

understand the command "workrow" as something new.

understand "work row" and "workrow" as workrowing when player is in Worn Row.

ever-workrow is a truth state that varies.

this is the wornrow-change rule:
	if Rob is in Worn Row, say "That'll work when Rob is gone." instead;
	if Psi Wisp is in Worn Row, say "Right idea, wrong room to change to." instead;
	continue the action;

carry out workrowing:
	abide by the wornrow-change rule;
	if Worn Row is worky, say "You're already in Work Row." instead;
	clear-worn-row;
	now Worn Row is worky;
	if ever-workrow is false:
		say "VLABADABOOM! [Worn Row] shakes, and you're thrown to the ground. When you get up, things look different.";
		score-inc; [Yelpley/work row]
	else:
		say "[Worn Row] returns once again to Work Row. It's a little less disorienting this time around.";
	say "[line break][one of]Those three machines re[or]Three machines, once again, [stopping]appear[if Worn Row is wordy], replacing the tract cart[end if]."; [?? what if you have destroyed the machines]
	now ever-workrow is true;
	now all workables are in Worn Row;
	now all books in Worn Row are in TempMet;
	if redness ender is in Worn Row, now redness ender is in TempMet;
	now tract cart is in TempMet;
	the rule succeeds;

chapter wordrowing

wordrowing is an action applying to nothing.

understand the command "wordrow" as something new.

understand "word row" and "wordrow" as wordrowing when player is in Worn Row.

ever-wordrow is a truth state that varies.

definition: a book (called bo) is tractable:
	if bo is hidden, no;
	if bo is moot, no;
	if player carries bo, no;
	yes;

carry out wordrowing:
	abide by the wornrow-change rule;
	if Worn Row is wordy, say "You're already in Word Row." instead;
	clear-worn-row;
	now Worn Row is wordy;
	now all workables are in TempMet;
	if redness ender is in Worn Row, now redness ender is in TempMet;
	move tract cart to Worn Row;
	if ever-wordrow is false:
		hint-bump-worn;
		score-inc; [Yelpley/word row]
		say "A tract cart appears, full of odd books. A pity tip also flutters down. You take the tip.";
	else:
		say "The tract cart re-appears.";
	now ever-wordrow is true;
	now all tractable books are in Worn Row;
	if pity tip is off-stage, now player has pity tip;
	the rule succeeds;

chapter wornrowing

wornrowing is an action applying to nothing.

understand the command "wornrow" as something new.
understand the command "Worn Row" as something new.

understand "wornrow" as wornrowing when player is in Worn Row.
understand "Worn Row" as wornrowing when player is in Worn Row.

carry out wornrowing:
	if psi wisp is moot, say "You already used the redness ender for something." instead;
	if psi wisp is not in Worn Row, say "You don't want to face the redness ender alone." instead;
	clear-worn-row;
	say "Worn Row rematerializes, along with the redness ender. Zap! Zot! It locks on the Psi Wisp, which explodes in a shower of rage. But somehow, the Psi Wisp connects enough to zap the redness ender back. Whew.";
	now being-chased is false;
	clear-worn-row;
	now Worn Row is worny;
	moot psi wisp;
	moot redness ender;
	score-inc; [Yelpley/WORN ROW]
	the rule succeeds;

chapter mytraceing

mytraceing is an action applying to one thing.

understand the command "trace" as something new.

understand "trace [something]" as mytraceing.

carry out mytraceing:
	if noun is not tract cart, say "That's not something to trace." instead;
	if DWELT LEWD is not off-stage, say "Nothing new turns up." instead;
	say "Yes, something about the tract cart seems off. There's a bit more space than the books would need...while fiddling with the cart, a new book pops out. It's called DWELT LEWD. You can imagine why it was hidden. Nothing's forcing you to read it, and it's probably not critical, but there it is.";
	abide by the LLP rule; [TRACE CART]
	now DWELT LEWD is in Worn Row;
	now DWELT LEWD is in-row;
	the rule succeeds;

chapter allow me to trace

Include (-

[ testcommandnoun obj o2;
	switch (scope_stage) {
		1: rtrue; ! allow multiple objects
		2: objectloop (obj)
			if ((obj ofclass Object) && (obj provides KD_Count))
				PlaceInScope(obj, true);
		3: print "There seems to be no such object anywhere in the model world.^";
	}
];

{-testing-command:abstract}
	* scope=testcommandnoun 'to' scope=testcommandnoun -> XAbstract;
{-testing-command:actions}
	*                                           -> ActionsOn
	* 'on'                                      -> ActionsOn
	* 'off'                                     -> ActionsOff;
{-testing-command:gonear}
	* scope=testcommandnoun                     -> Gonear;
{-testing-command:purloin}
	* scope=testcommandnoun                     -> XPurloin;
{-testing-command:random}
	*                                           -> Predictable;
{-testing-command:relations}
	*                                           -> ShowRelations;
{-testing-command:rules}
	*                                           -> RulesOn
	* 'all'                                     -> RulesAll
	* 'on'                                      -> RulesOn
	* 'off'                                     -> RulesOff;
{-testing-command:scenes}
	*                                           -> ScenesOn
	* 'on'                                      -> ScenesOn
	* 'off'                                     -> ScenesOff;
{-testing-command:scope}
	*                                           -> Scope
	* scope=testcommandnoun                     -> Scope;
{-testing-command:showheap}
	*                                           -> ShowHeap;
{-testing-command:showme}
	*                                           -> ShowMe
	* scope=testcommandnoun                     -> ShowMe;
{-testing-command:showverb}
	* special                                   -> Showverb;
{-testing-command:test}
	*                                           -> TestScript
	* special                                   -> TestScript;
{-testing-command:traec}
	*                                           -> TraceOn
	* number                                    -> TraceLevel
	* 'on'                                      -> TraceOn
	* 'off'                                     -> TraceOff;
{-testing-command:tree}
	*                                           -> XTree
	* scope=testcommandnoun                     -> XTree;

-) instead of "Grammar" in "Tests.i6t".

book Art Xtra

Art Xtra is north of Yawn Way. It is in Yelpley. "You can go south or north here."

printed name of Art Xtra is "[if el doodle is moot]Traded Art[else]Art Xtra[end if]".

understand "traded" and "traded art" as Art Xtra when el doodle is moot.

art-free-warn is a truth state that varies.

after looking in Art Xtra:
	if el doodle is moot and art-free-warn is false:
		now art-free-warn is true;
		say "The Revolt Lover lets you know that there's some other art, more powerful stuff, but ... they need to know that you have an artsy side, too, and you won't just be the new tyrant replacing the old tyrant, here.";
		continue the action;

[??traded art]
[??Revolt Lover likes the look of your pact cap]

chapter trap art

some trap art is a thing in Art Xtra. "Some trap art sits here. It's free. You might as well take it.". description is "The trap art depicts a bunch of nasty, dirty animals being trapped--it's not a real trap, but maybe it could become one."

after taking trap art:
	shuffle-before Art Xtra and Swamp Maws;
	continue the action;

chapter el doodle

after taking El Doodle:
	shuffle-before Art Xtra and Red Roses Order;
	continue the action;

El Doodle is a thing. description is "A jumble of raw creativity, it looks like it could be a map--or something--but it sure could use some paring down."

after going to Art Xtra when El Doodle is off-stage:
	if stark rats are moot:
		say "You tell the Revolt Lover about how you got rid of the stark rats. the Revolt Lover, impressed, mentions there's something else for you. 'Someone left it here a while back. It's indecipherable. I can't use it, but maybe you can figure it out.'";
		now player has El Doodle;
	continue the action;

chapter party trap

the party trap is a thing. description is "It looks roughly like the notes from the trap art, and when you read it you note it's more powerful than a MICE-DECIM. You just hope it works right when you USE it. That would be cool. I mean, if you used it on things that deserved it.".

chapter traping

traping is an action applying to one thing.

understand "trap [something]" as traping when player has party trap.

carry out traping:
	try useoning party trap with noun instead;

chapter Revolt Lover

Revolt Lover is a person in Art Xtra. "[one of]'Hi! I'm the Revolt Lover. Business is slow here, but I still have a few freebies. If you're able to use them, I'd be willing to trade for more.'[or]The Revolt Lover smiles at you.[stopping]". description is "Artsy looking, but not pretentiously hipster-ish.".

chapter state tats

the state tats are a plural-named thing. description is "They say OMG MO[']."

chapter soot tattoos

the soot tattoos are a plural-named thing. description is "They're blank now, but maybe if they were the right shape, they could help your image, somehow."

book Toll Lot

Toll Lot is east of Emo Dome. It is in Yelpley. "[if cross orc is in Toll Lot]While it's easy enough to go back west to the Emo Dome, that cross orc doesn't seem to want to let you go north or south[else]You can go north or south with the cross orc gone or, well, back west, too[end if]. A crag arc rises to the east[if UFO tofu is not off-stage]--maybe it is hiding something[end if]."

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

chapter stinky knits

the stinky knits are a plural-named thing in Gross Org. description is "The inside of the stinky knits reveals they were sewn together by SMELLEMS.". "Stinky knits, unwearable enough even without DAFT FAD printed on the front, lie here.".

check wearing the stinky knits: say "That's physically possible, but no. No way." instead;

check taking when player is in Gross Org and Ned is in Gross Org: say "Not with Ned around, you won't." instead;

the etage gate is scenery in Gross Org. "It is locked and too strong to move. It's engraved with...hmm, roses, or..."

instead of opening etage gate:
	if player has Ye Key, try useoning Ye Key with etage gate instead;
	try going north;

[instead of unlocking etage gate:
	try going north;]

check going north in Gross Org: if etage gate is in Gross Org, say "The etage gate blocks you." instead;

understand "evened" and "den evened" as Gross Org when Ned is moot.

Ned is a proper-named guhthug in Gross Org. "'Ned's Den!' someone booms. You're guessing their name must be Ned.". description is "Ned is sort of wildly flailing about, looking for a verbal or physical altercation, but that's not really your thing.".

chapter Gate Tag

the Gate Tag is a thing. description is "It--well, it seems patterned. Roses, or..."

chapter denying

denying is an action applying to one thing.

understand the command "deny" as something new.

understand "deny [something]" as denying.

does the player mean denying Ned: it is likely.

carry out denying:
	if noun is Ned:
		say "Ned wants to get in an argument or fight, so you get in an argument over whether it's really necessary, and then you say, that wasn't so great, see? He slinks off, defeated.";
		moot Ned;
		score-inc; [Yelpley/deny Ned]
	the rule succeeds;

book Deft Fed

Deft Fed is south of Toll Lot. It is in Yelpley. printed name is "[if yob attaboy is moot]Bon Snob[else]Deli, Tiled[end if]". description is "There's not much decor in this [if yob attaboy is moot]deli, tiled, except for a decal placed[else]fancy eatery, except for some snooty toons[end if]. You can exit to the north."

chapter Sniffins

Sniffins is a person in Deft Fed. "[one of]You hear a sniff, and the proprietor introduces themselves as Sniffins, apologizing for how lame the ambience and decor are, but there's just no INSPIRATION to do better[or]Sniffins sniffs here[stopping].". description is "Sniffins looks [if yob attaboy is moot]unfriendly despite your help--what a posh sop[else]despondent and pleading, for any sort of help[end if]."

the Dirt Rid is a thing. description is "The Dirt Rid looks old and decrepit. Sniffins probably wore it out converting the Bon Snob, but it's yours now."

the cave vac is a thing. description is "It looks a lot more powerful than the Dirt Rid."

chapter Gorge Grog

Gorge Grog is in Deft Fed. "Some Gorge Grog is here. It looks out of place in the Bon Snob, but Sniffins probably won't give it to you for free.". description is "Unsurprisingly, it is a product of Grog-Org. It's considerably more than four prouf. Err, foor proof."

Gorge Grog is proper-named.

check taking Gorge Grog when player does not have Gorge Grog: say "Sniffins chides you. 'It's worthless to us, but if there's anything tackier than bad alcohol, it's people who want to steal it!'[paragraph break]Maybe you could trade something for it." instead;

chapter Nat's Tan

Nat's Tan is a thing in Deft Fed. "A container of something called Nat's Tan is here.". description is "Ugh! Given that it advertises turning you orange, you're not sure you'd want that. Maybe there are some people or things much neater than you that would hate it even more.".

check taking nat's: say "Ugh! It feels too gross to take. Maybe you need to build yourself up to figure how to take it." instead;

chapter placed decal

the decal placed is peripheral scenery in Deft Fed. description is "It's an advertisement for LE FALAFEL."

chapter snooty toons

The snooty toons are peripheral scenery. "They certainly add ambience to the place. You're not sure whether you should feel obliged to laugh at them or not good enough to laugh at them. But they're not really hurting you, you guess."

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

the Door Frood is a person in Evaded Ave. "[one of]Someone waving their fists and shouting at who-knows-what pauses as you walk by. 'I'm the Door Frood.' They peg you as not insurgent enough to deserve to visit west or east, without a proper gift[or]The Door Frood continues to pace back and forth here, making sure you don't sneak off any way but back south[stopping].". description is "Probably not angry enough to actually do anything besides block others from doing what they want."

check going in Evaded Ave:
	if Door Frood is in Evaded Ave:
		if noun is west or noun is east, say "The Door Frood blocks you. Maybe if you gave them a gift, they'd be more generous." instead;

chapter bunk nub

the bunk nub is a thing in Evaded Ave. "A small bunk nub lies [if Door Frood is in Evaded Ave]behind the Door Frood[else]around for the taking[end if].". description is "It's small, so an actual person couldn't sleep on it."

check taking bunk nub:
	if Door Frood is in Evaded Ave, say "The Door Frood won't let you." instead;

the stock cots are a plural-named thing. description is "The stock cots are cut cleverly from the remains of the bunk nub. They'll make a great place to sleep for any number of small animals."

book Trapeze Part

Trapeze Part is west of Evaded Ave. It is in Yelpley. "[if epicer recipe is off-stage]There's a ten level net on the floor, here. It could protect you from a long fall. You're convinced there must be something at the far end, but it's probably not safe to use the trapeze to get over until, well, you've done safety checks[else]The ten level net still sits here, and it'd be handy if there was anything else on the other side of it, but there isn't[end if]."

chapter ten level net

the ten level net is scenery in Trapeze Part. "[if epicer recipe is off-stage]It doesn't quite look sturdy enough. Maybe you could do something to fix it[else]It was sturdy enough to help you get the epicer recipe, and that's enough[end if]."

chapter tent net

the tent net is a thing. description is "It doesn't have any pegs or anything to attach it to, to make a structure. But maybe it could complete a home somewhere."

chapter epicer recipe

er-ex is a truth state that varies. [?? delete with EXAMINED property later]

after examining epicer recipe:
	now er-ex is true;
	continue the action;

the epicer recipe is a helpdoc. description is "You've seen recipes before, but this is a big interesting one! It describes how to make a north-tron, which will get you north of Fun [']Nuf.[paragraph break][tronpartlist][run paragraph on]". importancy of the epicer recipe is 3.

to say tronpartlist:
	repeat with tp running through tronparts:
		say "--[tp][if player has tp or tp is in Fun Nuf] (got it!)[end if][line break]"

chapter tending

tending is an action applying to one thing.

understand the command "tend" as something new.

understand "tend [something]" as tending.

carry out tending:
	if noun is not level net, say "That doesn't need tending." instead;
	if player has epicer recipe, say "You already did what you needed with the net." instead;
	say "You adjust the ten level net. You're not sure how to make it work, but with some common sense, you make it. The set o['] notes gives surprising help. You climb and swing from the trapeze to the other side--falling into the ten level net about a hundred or so times--but the hundred and first bam! You notice an epic-er recipe under some superfluous steno-nets.[paragraph break]It's a clear step up from the set o['] notes. Yay! There's also something labeled an elope pole, which you suspect may help you get away if and when you need to. Part of the net falls off, too. It'd make a nice tent: a tent net. You gather up a nice haul: pole, net, recipe.";
	now player has elope pole;
	now player has tent net;
	now player has epicer recipe;
	score-inc; [Yelpley/TEND NET]
	the rule succeeds.

chapter elope pole

The elope pole is a thing. description is "It looks foldable, maybe even separable. You wonder where it could help you get."

book Yell Alley

Yell Alley is east of Evaded Ave. It is in Yelpley. "[if girt rig is in Yell Alley]A girt rig blocks every way except back[else]The only way back is[end if] west. The way east is blocked by a [alley-e-block] where the yelling is from."

to say alley-e-block:
	say "[if navy van is in Yell Alley]navy van... you're not sure[else]bomb mob... so that's[end if]"

chapter navy van

the navy van is scenery in Yell Alley. "There seems to be no way to enter it. It is labeled SEEDY DEE'S and has a small eye you could USE something on to scan it."

understand "seedy/dee/dees" and "seedy dee/dees" as navy van.

section eye

the eye is part of the navy van. description is "It looks electronic and (unsurprisingly) symmetrically spherical. Perhaps you could USE something on it."

chapter snack cans

the snack cans are a plural-named solid ingredient. description is "They're labeled DEE FEED. You're not sure what's in them, but whatever it is--well, you're not hungry enough. Yet.".

understand "dee feed" and "dee/feed" as snack cans.

chapter girt rig

the girt rig is peripheral scenery. description is "It is too sturdy to climb or break down."

chapter Mayo Yam

the Mayo Yam is a liquid ingredient in Yell Alley. "A gross looking -- something -- is here. It's a mayo yam! It's a bit on the slimy side, and it's probably worse inside.". description is "Fortunately, the mayo yam's skin is sturdy enough to avoid being burst and making a mess. But you can still smell the mayo inside it, and there are a few globs on its surface. It doesn't look, well, muy yum."

chapter rep popper

the rep popper is a thing in Yell Alley. "A rep popper lies here. You're wary of getting too close to it. You're not sure how good your rep is, but that thing looks [if dork rod is moot]less fearsome than it used to[else]like it could embarrass you quickly[end if].". description is "The rep popper is a combination of a funny flower, joy buzzer, and several old stupid gags. You're not sure how it's supposed to work, and it's not something you carry around to show off how cool it is."

check taking rep popper:
	if player has taboo bat:
		now player has rep popper;
		say "With the taboo bat in your possession, you just don't care about stuff like rep, so you have no problem taking the rep popper." instead;
	if player has dork rod, say "With the dork rod, you aren't THAT worried about your rep, but you're still worried enough not to take the popper. Maybe you can do a bit better..." instead;
	if dork rod is not moot, say "No way! You're not sure how much rep you have, but taking that rep popper would drop it a notch or more, and the prospect seems too horrible." instead;

[??Yuge Guy rep popper used what's wrong with you? I make boring people feel less boring vs you describing how you figured things out and only 26 possibilities really and also some trial and error]

chapter bomb mob

the bomb mob are plural-named people. description is "They're ignoring you, and that's probably for the best.". "You're lucky the bomb mob is not looking your way, or you'd be in trouble."

understand "poor troop" and "poor/troop" as bomb mob when DNA hand is moot.

chapter TNT

TNT is a tronpart. "Well, it's not going to blow up in your hands.".

check taking TNT: say "The bomb mob would say a bit more than 'Yank? Nay!' You'd be seen too easily." instead;

book Emo Dome

Emo Dome is east of Yawn Way. It is in Yelpley. "You can go any direction here, and you sort of want to, because it's stuffy in here, even if it smells nice. [can-go-rro]."

to say can-go-rro:
	if Red Roses Order is unvisited:
		say "Something labeling itself DIFF ID guards the way north";
	else:
		say "[if not-a-baton is off-stage]You feel you may still have unfinished business behind the DIFF ID to the north[else]The DIFF ID guards the Red Roses Order, which no longer holds adventure[end if]"

instead of doing something in Emo Dome when pulled-up is false:
	if current action is pulluping, continue the action;
	if current action is going:
		if noun is not west and noun is not east:
			say "You're scared those places would be even worse.";
			try going emo-dir instead;
		say "You run [if noun is emo-dir]away[else if noun is opposite of emo-dir] with extra speed[end if].[paragraph break]";
		continue the action;
	say "You keep running [emo-dir], instead. It's too whiny in here.";
	try going emo-dir instead;

emo-dir is a direction that varies. emo-dir is west.

check going to Emo Dome:
	if Spur Ups are off-stage, say "It's too whiny to the east! You just aren't positive enough to deal with it, yet. You back out." instead;
	if Spur Ups are not moot, say "The Spur Ups make you feel a bit more confident, but you need to do something to make yourself feel a bit more up before entering the Emo Dome." instead;
	if pulled-up is false:
		now emo-dir is noun;

check going north in Emo Dome:
	if state tats are off-stage, say "The Red Roses Order is, like, double-intensity. Just the name leaves you pondering you probably aren't ready for it yet until you're, like, totally ready. As you get close, you are intimidated by a bright no-go-gon and a voice from the DIFF-ID: 'Oh! Who?'[paragraph break]You don't have anything identifying yourself. 'Go jog!' the voice continues. You think, hang? Nah." instead;
	if Bro Orb is in Le Babel, say "The DIFF ID is silent, but you don't feel prepared enough to enter the Red Roses Order, yet." instead;
	if not-a-baton is moot, say "You probably did all you needed to." instead;
	say "You make sure your state tats are visible for scanning. They are accepted.[paragraph break][if madam is in Red Roses Order]You step into what may be your final challenge in Yelpley...[else]Maybe there is something you can do with the sword rows.[end if]";

chapter DIFF ID

[?? if you have the tattoos and tried going north, we should check those cases]

the DIFF ID is peripheral scenery in Emo Dome. "You can't really look directly into it too much, but it seems like one of those scanners that could pop up a force field, or make a really annoying noise, if you tried to cross it."

chapter pulluping

pulled-up is a truth state that varies.

pulluping is an action applying to nothing.

understand the command "pull up" as something new.
understand the command "pullup" as something new.

understand "pull up" as pulluping.
understand "pullup" as pulluping.

carry out pulluping:
	if pulled-up is true, say "You already did." instead;
	if Spur Ups are off-stage, say "Maybe you can be or do that sort of up, later." instead;
	if player is in Emo Dome:
		say "You manage to stop yourself. The whining isn't too bad. Yeah, you can hack it here.";
		now pulled-up is true;
		score-inc; [Yelpley/pull up]
		the rule succeeds;
	say "This isn't the place[if Emo Dome is visited], but maybe you could do this in the Emo Dome[end if]." instead;

chapter puce cup

The Puce Cup is a thing in Emo Dome. "Someone has left a puce cup here.". description is "It's, well, puce, and it seems sturdy enough. It's currently [if puce cup is empty]empty[else if puce cup is sappy]full of [sap-sirup] from the rift fir in Cold Loc[else]full of Dose Sod from the Apse Spa[end if]."

to say sap-sirup:
	say "[if location of player is not Cold Loc]Past Sap[else]Purist Sirup[end if]"

report taking puce cup: say "Emo swag! Awesome!"

the puce cup can be empty, sappy or soddy. the puce cup is empty.

puce-ever is a truth state that varies.

understand "purist sirup" and "purist/sirup" as puce cup when puce cup is sappy and player is not in Cold Loc.

understand "dose sod" as puce cup when puce cup is soddy and player is not in Apse Spa.

after going from Cold Loc when puce cup is sappy:
	say "The past sap in the puce cup thaws into purist sirup.";
	continue the action;

after going to Cold Loc when puce cup is sappy:
	say "The purist sirup in the puce cup hardens [one of][or]back [stopping]into past sap.";
	continue the action;

book Red Roses Order

Red Roses Order is north of Emo Dome. It is in Yelpley. "[if madam is in Red Roses Order]The only visible way back is south, with a mist sim blocking the other directions and seeming very threatening and oppressive indeed, but you can't chicken out[else]Sword rows have been revealed once the mist sim dispersed. Line Nil flickers and guards the way north where Madam left. You can go back south[end if]."

Red Roses Order is above Emo Dome.

chapter mist sim

the mist sim is scenery in Red Roses Order. "You can't see through it, and you have a feeling it may be fake, but what if it isn't? If only there was a way to dispel it..."

chapter sword rows

The sword rows are plural-named scenery. ."[if not-a-baton is moot]It doesn't look like you broke them, but you probably don't need them any more[else]It looks automatic. Put something it can cut in, and get something out[end if]."

chapter not-a-baton

The not-a-baton is a thing. description is "It is wood and round and long. It's too long to be a baton, but it's the right shape to be something powerful. It just sort of feels lifeless right now."

chapter madam

Madam is a person in Red Roses Order. Madam carries the gal flag. "MADAM stands here in defiance, holding the Gal Flag high and waving it.". description is "She is waving that Gal Flag. You should probably be grateful she doesn't have a girl rig, too. You need a way to neutralize the Gal Flag!"

description of Gal Flag is "It's fluttering even without a breeze."

understand "la gal" and "la/gal" as Madam.

check going south in Red Roses Order when Madam is in Red Roses Order: say "No way! You are locked in mortal combat! Plus, there's really only one thing to do, here." instead;

chapter yard ray

the yard ray is a thing. description is "It looks pretty lethal. It's no dinky resale laser![paragraph break]There are also has instructions: EMIT ********.[paragraph break]It's currently [if murdered rum is moot]loaded with energy from the murdered rum[else]empty of fuel[end if]."

chapter Line Nil

Line Nil is peripheral scenery in Red Roses Order. "It's, well, a red line you would do well not to cross."

check going north in Red Roses Order when Line Nil is in Red Roses Order: say "Whether or not Line Nil could damage you, you don't need to follow Madam. You need to take down the Diktat Kid!" instead;

book Swept Pews

Swept Pews is south of Emo Dome. It is in Yelpley. "You can go back north to the Emo Dome in this tidy little area[if liar grail is moot]. A passage has been opened south with the Liar Grail's demise[end if]."

check going south in Swept Pews:
	if Liar Grail in Swept Pews, say "Maybe there's a path where you could get rid of the grail, but not yet." instead;

chapter liar grail

The Liar Grail is a thing in Swept Pews. description is "It's carved with 'NIP IN? NOT ON!' If you hadn't examined it, you wouldn't think there might be a passage to the south, but now that you have, you consider the possibility. Either way, it annoys you enough to want to get rid of the liar grail. Lies are sometimes self-defeating like that.". "A liar grail is embedded in the south wall, aw."

check taking liar grail: say "A small voice cries 'Da cad! Da cad!' You probably don't want the liar grail corrupting you." instead;

every turn when player is in Swept Pews and wordy drow is in Swept Pews: next-rand table of wordy drow laments;

chapter wordy drow

The wordy drow is a person in Swept Pews. description is "Seemingly attached to the Liar Grail. Maybe you can release it.". "[one of]A[or]The[stopping] wordy drow mumbles to itself here, sometimes blurting out something intelligble and haunting."

chapter troll ort

the troll ort is an edible thing in Swept Pews. "A troll ort lies on the floor here, but it looks dry enough, the five-second rule can't matter too much.". description is "It doesn't look particularly edible to you. It also has a strong smell."

book Drawl Ward

Drawl Ward is south of Swept Pews. It is in Yelpley. "This passage is a T (well, a [unicode 9524]), walled off to the south."

check going west in Drawl Ward:
	if Bond Nob is in Drawl Ward:
		if noun is west or noun is east, say "You hear the Bond Nob groaning and think it wouldn't be nice to pass by. They'll let you by once you help them with whatever sickness they have." instead;

chapter Bond Nob

the Bond Nob is a person in Drawl Ward. "[one of]'Hi! I'm the Bond Nob. I ain't feeling so good, but I wondered if maybe I could get some medicine.'[or]the Bond Nob continues to moan colloquially about the sickness, the pain.[stopping]". description is "the Bond Nob looks pretty ill. Nothing life-threatening, but too sick to go fetch even the dinkiest over-the-counter medication."

chapter Elan Ale

the Elan Ale is a drinkable thing. description is "It's labeled as CLASS Alc, unsurprisingly. It's about the size of a pint nip."

book Scrap Arcs

Scrap Arcs is east of Drawl Ward. It is in Yelpley. "You can't go any farther here--only back west. Some slate metals are lying around here[if stamp mats are moot]--you've probably already used what you need[else], and if you needed to use a bit, nobody would notice[end if]."

chapter slate metals

slate metals are scenery in Scrap Arcs. "You could probably carve something out of them, with the right implement(s). Maybe not steel fleets, but something useful."

chapter Ye Key

Ye Key is a thing. description is "Engraved YE KEY, it clearly looks important. It's carved with...well, roses, or ... you're not sure. Maybe it does not lead to Ye Fey or Ye Ley, but there are only so many locked places here, so you'll probably find what it can open."

book Dopy Pod

Dopy Pod is west of Drawl Ward. It is in Yelpley. printed name of Dopy Pod is "[if cassettes sac is moot]Dope[else]Dopy[end if] Pod". "[if cassettes sac is moot]There's not much left here, but it was neat to get the radar. [else]There doesn't seem like there's much useful in here, but who knows? [end if]The only exit is back east."

check going nowhere in Dopy Pod: say "Maybe there's a do-prefer pod somewhere, but it's off-limits to you." instead;

chapter cassettes sac

the cassettes sac is a thing in Dopy Pod. "A rather large cassettes sac sits here. It's too dirty to pick up.". description is "Phew! It's too dirty to look at too closely."

understand "casette/casete/cassette/cassetes sac" and "casette/casete/cassette/cassetes" as cassettes sac. [1 is technically not an anagram but it's a plausible misspelling, so we should allow it.]

instead of doing something with cassettes sac:
	if action is pro-and-use, continue the action;
	say "The cassettes sac is too messy to do anything with. You need to find a way to clean it up."

after taking demo med:
	consider the bump-pod rule;
	continue the action;

chapter radar

to decide which number is radar-used:
	let temp be 0;
	if eroded ore is not off-stage, increment temp;
	if UFO tofu is not off-stage, increment temp;
	decide on temp;

the radar is a thing. description is "You're not sure of the deeper science, but you will probably figure how to USE it when the time comes[if radar-used is 1] again, though it does seem slightly damaged[end if]."

The roto motor is a thing. description is "It seems to have been saved from whatever caused the radar to go on the fritz."

chapter Demo Med

a Demo Med is an edible thing in Dopy Pod. "The demo med that must not have worked for the Bond Nob sits here, on a pill lip.". description is "You're not sure what it could be. Xanax? You don't want to risk it, though, because you're not sick."

instead of eating demo med, say "That would only be a temporary reprieve from your troubles."

the pill lip is peripheral scenery in Dopy Pod. "A Demo Med rests on the Pill Lip."

report taking demo med:
	say "The pill lip retracts as you take the demo med.";
	moot pill lip;

book Pro Corp

Pro Corp is north of Gross Org. It is in Yelpley. description is "[if butene tub is in Pro Corp]A butene tub rests here. At least, that's what it says it is[else]Pro Corp is devoid of equipment now you blew up the butene tub[end if]. The only way out is back south."

Pro Corp is above Gross Org.

instead of dropping when number of entries in multiple object list > 1 (this is the don't allow dropping all rule):
	alter the multiple object list to { };
	add noun to multiple object list;
	continue the action;

instead of taking a thing when player is in Pro Corp and Psi Wisp is in Pro Corp:
	let Q be the noun;
	if the number of entries in multiple object list is greater than 1:
		alter the multiple object list to { };
		add Q to multiple object list;
	say "OUCH! The psi wisp stings your hand before you can grab [the noun]." instead;

report taking when player is in Pro Corp:
	consider the bald-lab rule;
	continue the action;

this is the bald-lab rule:
	if number of things in Pro Corp is 1:
		say "Pro Corp is now a bald lab.";
		now bald-lab is true;
		now printed name of Pro Corp is "Bald Lab";
	else:
		continue the action;

bald-lab is a truth state that varies.

understand "bald/lab" and "bald lab" as Pro Corp when bald-lab is true.

chapter butene tub

the butene tub is scenery in Pro Corp. "It smells pretty nice. But it's been marked condemned, dangerously close to falling apart if you put too much weight on it. Who knows what sort of reactions could occur with the flammable butene if the tub collapsed to the dangerously sparky area below with special instruments and such? You can't just pour any old thing down![paragraph break]What sort of adventurer could ignore a warning like that? Especially in a game that's meant to be polite on the Zarfian cruelty scale!"

[??It looks unstable? Part of the warning?]

chapter gash sag

the gash sag is peripheral scenery. "It has covered up your destruction of the butene tub."

chapter resale laser

the resale laser is a thing. description is "It looks lethal enough."

chapter gold log

the gold log is a thing in Pro Corp. description is "It's pretty cylindrical but feels hollow, not a ton, lighter than it should. Maybe if it were shaped a bit different it would be a golf log you could use to putt up, but as-is, it's not too useful."

chapter DNA band and hand and what's after

The DNA band is a thing in Pro Corp. "A DNA band sits here, nice and tidy and helical.". description is "The DNA band seems like it could come to life, but you'd need some cool science to do so.".

The DNA hand is a thing. description is "It's motionless, but it looks lifelike enough. There must be a way to bring it to life!"

The bang nab is a thing. description is "Wow! It's really evolved from a DNA band! It's sturdy. If it had eyes, it'd be looking for something to steel and run--umm, that's not quite right--off with. You're not sure why it hasn't run off with anything in your inventory. Is all this stuff you piled up worthless? Perhaps the bang nab is just grateful."

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
talk-text of Revolt Lover is "'Did you find any Stray Arts? I can always use them.'".
talk-text of Bond Nob is "'I ain't much for talking now I'm sick...'".
talk-text of Ned is "Ned's not in the mood for regular talk. He seems to want an argument or fight, but you don't.".
talk-text of Psi Wisp is "It has nothing to say. It just pulses.".
talk-text of Door Frood is "The Door Frood launches into how everyone is really stupid and at fault, and you can't really do anything except snark about it.".
talk-text of Rob is "Rob yawns. He doesn't find you very interesting. Maybe there's a way to take advantage of that.".
talk-text of sleep eels is "Maybe they are sending some sort of electric message you could detect with the right instrument, but they're not talking. You're more struck, though, by how uncomfortable they look while sleeping--wriggling about.".
talk-text of Sniffins is "[if YOB ATTABOY is not moot]'Tony? Not! Poor lower class me is a failure! If only I had some success manual!'[else]'Oh. It's you again. If you were REALLY smart, you'd have taken the advice in that book you gave me.'[end if]".
talk-text of Verses Rev is "The Verses Rev booms 'Erupt! Pure!' then piously intones how weirdos not in line with the Diktat Kid's values need to be eradicated.".
talk-text of Wordy Drow is "It moans and points at the Liar Grail. They're forced together, somehow, but maybe you can change that."
talk-text of Yuge Guy is "'I'm ... ' / 'TMI!'"

volume gotoing

[?? rules for GT'ing a room]

printed name of Fun Nuf is "Fun [']Nuf".

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
		say "Your pace cap slows down as you [if noun is Fun Nuf]enter[else]cross[end if] Fun [']Nuf..." instead;
	if noun is location of player, say "Already there!";
	unless goto-available, say "You're at a point in the game where goto isn't available." instead;
	consider the avail-rule of noun;
	if the rule failed:
		if noun is Emo Dome and Emo Dome is visited, say "You'd run away from the Emo Dome too quickly. You need a plan of attack to deal with it." instead;
		say "[noun] isn't available yet, so you can't go there." instead;
	if noun is not visited, say "You can reach [noun], but you haven't visited there, yet. So I'm going to be a stickler and say you have to get there first." instead;
	consider the unavail-rule of noun;
	if the rule succeeded, say "[noun] is no longer worth going to. You don't want to go back. Onward!" instead;
	now gone-to is true;
	move player to noun;
	the rule succeeds;

section available rules

[we could get cute here and define availability by what item is moot, but that can go haywire once there's an exception. For instance, it's tricky to do stuff with the Spur Ups and the Psi Wisp, and Dirge Grid is tricky as well.]

a room has a rule called avail-rule. avail-rule of a room is usually the trivially true rule.

avail-rule of Fun Nuf is trivially true rule. [described elsewhere]

avail-rule of Worn Row is Dave-gone rule.

this is the Dave-gone rule:
	if Dave is moot, the rule succeeds;
	the rule fails;

avail-rule of Frush Surf is eels-gone rule.
avail-rule of Moo Room is eels-gone rule.

this is the eels-gone rule:
	if sleep eels are moot, the rule succeeds;
	the rule fails;

avail-rule of Yell Alley is lover-gone rule.
avail-rule of Trapeze Part is lover-gone rule.

this is the lover-gone rule:
	if Door Frood is moot, the rule succeeds;
	the rule fails;

avail-rule of Art Xtra is packed-it rule.
avail-rule of My Gym is packed-it rule.
avail-rule of Seer Trees is packed-it rule.
avail-rule of Evaded Ave is packed-it rule.
avail-rule of Yawn Way is packed-it rule.

this is the packed-it rule:
	if player has pact cap, the rule succeeds;
	the rule fails;

avail-rule of Cold Loc is rats-gone rule.
avail-rule of Ooze Zoo is rats-gone rule.
avail-rule of Apse Spa is rats-gone rule.
avail-rule of Flu Gulf is rats-gone rule.
avail-rule of Dumb Mud is rats-gone rule.

this is the rats-gone rule:
	if stark rats are moot, the rule succeeds;
	the rule fails;

avail-rule of Emo Dome is pulled-up rule.
avail-rule of Swept Pews is pulled-up rule.

this is the pulled-up rule:
	if pulled-up is true, the rule succeeds;
	the rule fails;

avail-rule of Dopy Pod is poorsick-gone rule.

this is the poorsick-gone rule:
	if Bond Nob is moot, the rule succeeds;
	the rule fails;

avail-rule of Drawl Ward is grail-gone rule.
avail-rule of Scrap Arcs is grail-gone rule.

this is the grail-gone rule:
	if liar grail is moot, the rule succeeds;
	the rule fails;

avail-rule of Toll Lot is puffed-up-yet rule.

this is the puffed-up-yet rule:
	if Spur Ups are moot, the rule succeeds;
	the rule fails;

avail-rule of Deft Fed is orc-block rule.
avail-rule of Gross Org is orc-block rule.

this is the orc-block rule: [similar to orc-gone but with no text]
	if cross orc is moot, the rule succeeds;
	the rule fails;

avail-rule of Pro Corp is gate-gone rule.

this is the gate-gone rule:
	if etage gate is moot, the rule succeeds;
	the rule fails;

avail-rule of Mire Rim is dung-gone rule.
avail-rule of Swamp Maws is dung-gone rule.
avail-rule of Den Ivy Vined is dung-gone rule.
avail-rule of Trial Lair is dung-gone rule.

this is the dung-gone rule:
	if gnu dung is moot, the rule succeeds;
	the rule fails;

avail-rule of Calcific Lac is wonk-book rule.

this is the wonk-book rule:
	if NULL ILLUN is moot, the rule succeeds;
	the rule fails;

avail-rule of Motto Bottom is ogre-gone rule.

this is the ogre-gone rule:
	if ergot ogre is moot, the rule succeeds;
	the rule fails;

avail-rule of Mont Nom is turf-gone rule.

this is the turf-gone rule:
	if turf rut is moot, the rule succeeds;
	the rule fails;

avail-rule of Le Babel is veil-gone rule.

this is the veil-gone rule:
	if lie veil is moot, the rule succeeds;
	the rule fails;

avail-rule of Sneer Greens is rocs-gone rule.

this is the rocs-gone rule:
	if scorn rocs are moot, the rule succeeds;
	the rule fails;

avail-rule of Red Roses Order is rose-tat rule.

this is the rose-tat rule:
	if soot tattoos are moot and player has Bro Orb, the rule succeeds;
	the rule fails;

avail-rule of Dirge Grid is tron-done rule.

this is the tron-done rule:
	if TNT is moot, the rule succeeds;
	the rule fails;

section unavailable rules

a room has a rule called unavail-rule. unavail-rule of a room is usually the trivially false rule.

unavail-rule of Dirge Grid is grid-unavail rule.

this is the grid-unavail rule:
	if player has x-ite tix, the rule succeeds;
	the rule fails;

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
	if chase-person is Kayo Yak and cap-pace is false:
		say "Oh no! The Kayo Yak was too fast for you! Maybe you can find a way to run faster.";
		reset-chase instead;
	if chase-person is in location of player:
		say "You've been caught! Aigh! Dazed and confused, you stagger back to...";
		reset-chase instead;
	else:
		say "The [chase-person] follows you.";
		move chase-person to location of player;

to reset-chase:
	wfak;
	if mrlp is Grebeberg, move player to Seer Trees;
	if mrlp is Yelpley, move player to Yawn Way;
	move chase-person to chase-room of chase-person;
	now being-chased is false;

after going when being-chased is true:
	now last-chase-direction is noun;
	continue the action;

check going when being-chased is true:
	if last-chase-direction is opposite of noun, say "The [chase-person] is blocking you from the [noun]. You try a gazelle-zag but don't have the moves." instead;

check going to Fun Nuf when being-chased is true: say "You feel yourself running up against an invisible barrier. Apparently, running away that way from the [chase-person] won't help." instead;

the Psi Wisp is a chaser in Pro Corp. chase-room of Psi Wisp is Pro Corp. description is "The Psi Wisp is very red, and it pulses fervently. If it had feelings, you'd be pretty sure it didn't like you.". "[one of]A Psi Wisp pulses here before lurching alarmingly in your direction![or]The Psi Wisp is still chasing you![stopping]".

after looking when being-chased is false (this is the start-chase-in-case rule):
	if player is in Pro Corp and psi wisp is not moot:
		start-chase Psi Wisp;
		say "The Psi Wisp begins to chase after you[one of][or] again[stopping]!";
		continue the action;
	if troll ort is moot and player is in Frush Surf and kayo yak is in Frush Surf:
		start-chase Kayo Yak;
		say "The Kayo Yak bounds after you[one of][or] again[stopping]!";
		continue the action;
	continue the action;

volume gender switching

chapter picking random genders for players

a person has a person called gender-oppo. gender-oppo of a person is usually Diktat Kid.

[??mike kim nora maron Marge Pegram lee mcmeel]

when play begins (this is the gender randomize rule):
	sort table of random authors in random order; [not strictly gender, but its gender can be changed]

this is the gender-too-late rule:
	if Art Xtra is visited, say "Too late to switch genders." instead;

chapter gender-sort

to table-comb (myp - a person):
	if gender-oppo of myp is Diktat Kid, continue the action;
	repeat through table of useons:
		if use2 entry is gender-oppo of myp:
			if debug-state is true, say "DEBUG: switched [use2 entry] to [myp].";
			now use2 entry is myp;
			continue the action;

volume unsorted

volume metarooms

[there is a little bit of cute code here. Odd Do's score = weird stuff, but it's also where DevReserved, the collect-all room for used objects, goes. TempMet is for items that temporarily disappear.]

part Odd Do region

[don't give the player any accidental access to the rooms]

DevReserved is a privately-named room in Odd Do. "Bug."

TempMet is a privately-named room in Odd Do. "Bug."

section debug helps - not for release

understand "zr/zero/DevReserved/ll/lll/DevReserved" as DevReserved. [DevReserved is my default for other games. So why not.]

understand "tm/TempMet" as TempMet.

volume bonus points and odd verbs

chapter aiding

aiding is an action out of world.

understand the command "dial aid" as something new.
understand the command "aid" as something new.

understand "aid" as aiding.
understand "dial aid" as aiding.

dial-yet is a truth state that varies.

more-later is a truth state that varies.

a room has a number called walkthru-prio. walkthru-prio of a room is usually 400.

to hint-bump-worn:
	shuffle-before Worn Row and Dirge Grid;

[this is the list of how I do things in the walkthrough.]

L is a list of rooms variable. L is { Fun Nuf, Art Xtra, My Gym, Worn Row, Evaded Ave, Yell Alley, Trapeze Part, Seer Trees, Cold Loc, Yawn Way, Ooze Zoo, Frush Surf, Emo Dome, Swept Pews, Apse Spa, Drawl Ward, Dopy Pod, Scrap Arcs, Flu Gulf, Toll Lot, Deft Fed, Gross Org, Pro Corp, Moo Room, Dumb Mud, Mire Rim, Swamp Maws, Calcific Lac, Den Ivy Vined, Trial Lair, Motto Bottom, Mont Nom, Le Babel, Sneer Greens, Red Roses Order, Dirge Grid }

[?? nothing game-critical to do here = if there is a LLP]

[LATER: establish partially done room rules as opposed to completely done, for a room]

to shuffle-before (ra - a room) and (rb - a room):
	let x1 be 0;
	let LE be number of entries in L;
	repeat with x running from 1 to LE:
		if entry x of L is ra:
			now x1 is x;
			break;
	if x1 is 0, continue the action;
	repeat with x2 running from x1 to LE:
		if entry x2 of L is rb:
			if debug-state is true, say "(DEBUG: Swapping room walkthrough order for [ra] and [rb])";
			add ra at entry x2 in L;
			remove entry x1 from L;
			if debug-verbose is true, say "DEBUG NEW LIST:[L].";
			continue the action;
	if debug-verbose is true, say "WARNING [rb] was already before [ra]. No shifting.";

check aiding:
	if dial-yet is false and word number 1 in the player's command is "dial":
		say "Your 'correct' way of asking for aid nets a last lousy point. You even throw in a 'Plea! Elp!' just to make sure.[paragraph break]Yay![paragraph break]";
		abide by the LLP rule; [DIAL AID]
		now dial-yet is true;
	if dial-yet is false:
		say "Aid... aid...[paragraph break]";
	if being-chased is true:
		if chase-person is kayo yak:
			if cap-pace is false, say "[one of]You're not quite fast enough to outrun the yak on your own. An item you have can help.[or]The pact cap.[or]The pact cap can become a PACE cap.[stopping]" instead;
			if player is in trial lair, say "[one of]The kayo yak can take out the ergot ogre.[or]You just need to give the right command to the kayo yak.[or]YAK, ????[or]YAK, OKAY.[stopping]" instead;
			say "[one of]The kayo yak will keep chasing you. Maybe you can find someone else for it to knock over.[or]Someone guarding something?[or]The ergot ogre.[or]You'll need to do one more thing once you get to the Trial Lair.[stopping]" instead;
		if player is in Worn Row, say "[one of]You have the Psi Wisp in the right place, but you can't do anything here in [Worn Row], yet.[or]You have to change it.[or]WORN ROW. The redness ender will take care of the psi wisp.[stopping]" instead;
		say "[one of]The psi wisp is certainly red. Maybe there's something that could neutralize it.[or]Do you remember a room at the start?[or]It sort of isn't there any more.[or]Go to Word/Work row, first.[stopping]" instead;
	abide by the done-rule of location of player;
	consider the done-for-good rule of location of player;
	let all-done-here be whether or not the rule succeeded;
	say "You're done here, for [if all-done-here is true]good[else]now[end if]. Would you like to be pointed to somewhere else relevant?"; [?? test case: remove Yuge Guy check in Sneer Greens but have him around. I should see an error]
	unless the player yes-consents, say "Okay." instead;
	now search-hint-room is true;
	repeat with Q running through L:
		if debug-verbose is true, say "Checking [Q] in order.[run paragraph on][line break]";
		consider the done-rule of Q;
		if the rule succeeded:
			if Q is location of player:
				if debug-state is true, say "OOPS! This is a bug in the hints. The game thinks you're done here but the rule to tell you what to do missed a case.";
				next;
			if Q is visited:
				say "As a general hint, [Q] might be a good place to look.";
			else:
				describe-nearby Q;
			now search-hint-room is false;
			if aid-detail is true:
				say "DEBUG: Here's what the hint would be: ";
				consider the done-rule of Q;
			break;
	if search-hint-room is true:
		now search-hint-room is false;
		say "I'm out of ideas for rooms you've visited. Maybe look around the map a bit more.";
	follow the notify score changes rule;
	the rule succeeds;

to describe-nearby (ro - a room):
	repeat with dir running through maindir:
		let DR be the room dir of ro;
		if DR is visited:
			say "Try looking [opposite of dir] of [if DR is location of player]here[else][DR][end if]. You haven't, yet.";
			continue the action;
	if player is in Fun Nuf and ro is Art Xtra:
		say "Try exploring Yelpley to the east.";
		continue the action;
	say "There's a room you haven't visited with something to do, but it's pretty far away.";
	if in-beta is true, say "(BETA TESTER NOTE) [ro] isn't being flagged correctly."

search-hint-room is a truth state that varies.

this is the trivially false rule: the rule fails;

this is the trivially true rule: the rule succeeds;

a room has a rule called done-rule. done-rule of a room is usually dunno-hint rule.

a room has a rule called done-for-good rule. done-for-good rule of a room is usually the trivially true rule.

this is the dunno-hint rule: [I should never have to use this in the final release.]
	say "I haven't determined hints for [location of player], yet.";
	the rule succeeds;

section bulk done-rule definitions

done-rule of Apse Spa is apse-spa rule.
done-rule of Art Xtra is art-xtra rule.
done-rule of Calcific Lac is calcific-lac rule.
done-rule of Cold Loc is cold-loc rule.
done-rule of Deft Fed is deft-fed rule.
done-rule of Den Ivy Vined is den-ivy-vined rule.
done-rule of Dirge Grid is dirge-grid rule.
done-rule of Dopy Pod is dopy-pod rule.
done-rule of Drawl Ward is drawl-ward rule.
done-rule of Dumb Mud is dumb-mud rule.
done-rule of Emo Dome is emo-dome rule.
done-rule of Evaded Ave is evaded-ave rule.
done-rule of Flu Gulf is flu-gulf rule.
done-rule of Frush Surf is frush-surf rule.
done-rule of Fun Nuf is fun-nuf rule.
done-rule of Gross Org is gross-org rule.
done-rule of Lair Trial is lair-trial rule.
done-rule of Le Babel is le-babel rule.
done-rule of Mire Rim is mire-rim rule.
done-rule of Mont Nom is mont-nom rule.
done-rule of Moo Room is moo-room rule.
done-rule of Motto Bottom is motto-bottom rule.
done-rule of My Gym is my-gym rule.
done-rule of Ooze Zoo is ooze-zoo rule.
done-rule of Pro Corp is pro-corp rule.
done-rule of Red Roses Order is red-roses-order rule.
done-rule of Scrap Arcs is scrap-arcs rule.
done-rule of Seer Trees is seer-trees rule.
done-rule of Sneer Greens is sneer-greens rule.
done-rule of Swamp Maws is swamp-maws rule.
done-rule of Swept Pews is swept-pews rule.
done-rule of Toll Lot is toll-lot rule.
done-rule of Trapeze Part is trapeze-part rule.
done-rule of Worn Row is worn-row rule.
done-rule of Yawn Way is yawn-way rule.
done-rule of Yell Alley is yell-alley rule.

section done-for-good rule definitions

[most of these will be the trivially right rule]

done-for-good rule of Apse Spa is apse-spa-complete rule.

done-for-good rule of Art Xtra is art-xtra-complete rule.

done-for-good rule of Cold Loc is cold-loc-complete rule.

done-for-good rule of Den Ivy Vined is den-ivy-vined-complete rule.

done-for-good rule of Fun Nuf is trivially false rule.

done-for-good rule of Swamp Maws is swamp-maws-complete rule.

done-for-good rule of Worn Row is worn-row-complete rule.

done-for-good rule of Yawn Way is yawn-way-complete rule.

done-for-good rule of Yell Alley is yell-alley-complete rule.

section Apse Spa rule

this is the apse-spa rule:
	if puce cup is soddy and Bond Nob is not moot, continue the action;
	if sage gas is not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Bond Nob is not moot:
		if player has puce cup, say "You need to USE the puce cup on the dose sod." instead;
		say "You need something to carry the dose sod with." instead;
	if maps-explained is true, say "USE MAPS ON BOG." instead;
	if player has spa maps, say "You need to find someone who can decipher the maps." instead;
	if player has el doodle, say "You have something that could become maps, but you need to find where to clear it up." instead;
	say "You need to find or develop maps to get through Go-By Bog." instead;

this is the apse-spa-complete rule:
	if sage gas is not off-stage, the rule succeeds;
	the rule fails;

section Art Xtra rule

this is the art-xtra rule:
	if trap art is not in Art Xtra and stark rats are not moot, continue the action;
	if state tats are not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if trap art is in Art Xtra, say "The trap art will be useful, with a change." instead;
	if el doodle is in Art Xtra, say "El doodle will be useful, with a change." instead;
	if straw arts is off-stage, say "You need to make some art for the Revolt Lover." instead;
	if player has straw arts, say "USE STRAW ARTS ON REVOLT LOVER." instead;
	if player has soot tattoos, say "USE SOOT TATTOOS ON GATE TAG." instead;
	say "Eep! There's a lot to do here, and I messed things up." instead;

this is the art-xtra-complete rule:
	if soot tattoos are moot, the rule succeeds;

section Calcific Lac rule

this is the calcific-lac rule:
	if dork rod is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player has dork rod, say "USE DORK ROD ON TAO BOAT." instead;
	say "You need to find an item somewhere else to feel the peace needed to enter the Tao Boat." instead;

section Cold Loc rule

this is the cold-loc rule:
	if King Nik is moot and puce cup is sappy, continue the action;
	if pulled-up is false, continue the action;
	if liar grail is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if King Nik is in Cold Loc, say "USE EPOCH COPE ON KING NIK." instead;
	if wash saw is in My Gym, say "Get the wash saw from My Gym." instead;
	if sap-takeable is true, say "USE WASH SAW ON PAST SAP." instead;
	if player does not have puce cup, say "You need the puce cup from the Emo Dome." instead;
	say "USE PUCE CUP ON PAST SAP." instead;

this is the cold-loc-complete rule:
	if King Nik is moot and puce cup is sappy, the rule succeeds;
	the rule fails;

section Deft Fed rule

this is the deft-fed rule:
	if Elan Ale is moot, continue the action;
	if Bond Nob is not moot and yob attaboy is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if yob attaboy is not moot, say "USE YOB ATTABOY ON SNIFFINS." instead;
	say "USE ELAN ALE ON SNIFFINS." instead;

this is the deft-fed-complete rule:
	if Elan Ale is moot, the rule succeeds;
	the rule fails;

section Den Ivy Vined rule

this is the den-ivy-vined rule:
	if wash saw is moot, continue the action;
	if maps-explained is true, continue the action;
	if search-hint-room is true, the rule succeeds;
	if porch crop is in Den Ivy Vined, say "USE WASH SAW ON PORCH CROP." instead;
	if tent net is off-stage, say "To make the Code Doc happy, there's something [if Trapeze Part is visited]west of Evaded Ave[else] in Trapeze Part[end if] you can get." instead;
	if player has tent net, say "USE TENT NET ON CODE DOC." instead;
	if player does not have el doodle, say "There's something back in [Art Xtra] to pick up." instead;
	if player does not have spa maps, say "You can change El Doodle into something the Code Doc can decipher." instead;
	say "USE SPA MAPS ON CODE DOC." instead;

this is the den-ivy-vined-complete rule:
	if wash saw is moot, the rule succeeds;

section Dirge Grid rule

this is the dirge-grid rule:
	if player has the X-ITE TIX, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Verses Rev is in Dirge Grid, say "Kill the Verses Rev." instead;
	if Knife Fink is in Dirge Grid, say "Kill the Knife Fink." instead;
	if Diktat Kid is in Dirge Grid, say "Kill the Diktat Kid." instead;

section Dopy Pod rule

this is the dopy-pod rule:
	if cassettes sac is moot and pill lip is moot, continue the action;
	if search-hint-room is true, the rule succeeds;

section Drawl Ward rule

this is the drawl-ward rule:
	if Bond Nob is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if puce cup is not soddy, say "[one of]You have the puce cup, but it needs to be filled with something other than the past sap/purist sirup that got you by the Liar Grail.[or]You need something healing.[or]If you navigated the Apse Spa, you'll see what's there.[or]Once you have the  dose sod from the Apse Spa, USE PUCE CUP ON [psu].[stopping]";
	say "USE PUCE CUP ON [psu]." instead;

to say psu:
	let X be the printed name of Bond Nob;
	say "[X in upper case]";

section Dumb Mud rule

this is the dumb-mud rule:
	if lie veil is moot and turf rut is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Moo Room is unvisited, say "There's a part of southeast Grebeberg you haven't explored yet[if Ooze Zoo is visited and sleep eels are in Ooze Zoo]. You need to get past the sleep eels[end if]." instead;
	if gnu dung is in Dumb Mud, say "[one of]You need a way to get rid of the gnu dung so you can go west.[or][if player does not have poo coop]The poo coop in the Moo Room will help you[else]USE POO COOP ON GNU DUNG[end if].[stopping]" instead;
	if turf rut is in Dumb Mud, say "[one of]You need a way to fill up the turf rut.[or]You'd love to get rid of the poo coop.[or]USE POO COOP ON TURF RUT.[stopping]" instead;
	say "[one of]You need something to cut the lie veil[or][if player has exam axe]You will need an item you don't have yet for the Lie Veil[else]USE EXAM AXE ON LIE VEIL[end if][stopping]." instead;

section Emo Dome rule

this is the emo-dome rule:
	if puce cup is not in Emo Dome and pulled-up is true, continue the action;
	if search-hint-room is true, the rule succeeds;
	if pulled-up is false, say "PULL UP." instead;
	say "Take the puce cup." instead;

section Evaded Ave rule

this is the evaded-ave rule:
	if Door Frood is moot and bunk nub is not in Evaded Ave, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Door Frood is in Evaded Ave:
		if My Gym is unvisited, say "Visit south of Yawn Way a bit." instead;
		if Worn Row is unvisited, say "See about west of My Gym." instead;
		if ever-wordrow is false, say "Worn Row can become something else[if ever-workrow is true], besides Work Row[end if]." instead;
		if player has TI, say "You have TI. Give it to the Door Frood." instead;
		say "[one of]Word Row has some interesting books. Maybe one would please the Door Frood.[or]You need something daring and obnoxious.[or]Get TI from Word Row.[stopping]" instead;
	say "You just need to take the bunk nub here." instead;

section Flu Gulf rule

this is the flu-gulf rule:
	if scorn rocs are moot, continue the action;
	if Bond Nob is in Drawl Ward, continue the action;
	if search-hint-room is true, the rule succeeds;
	if gulf lug is moot, say "The gulf lug needs medicine. The DEMO MED." instead;

this is the flu-gulf-complete rule:
	if scorn rocs are moot, the rule succeeds;
	the rule fails;

section Frush Surf rule

this is the frush-surf rule:
	if kayo yak is moot, continue the action;
	if player has stamp mats and gnu dung is in Dumb Mud, continue the action;
	if search-hint-room is true, the rule succeeds;
	if stamp mats are in Frush Surf, say "Take the stamp mats." instead;
	if cap-pace is false, say "You need to make the pact cap a PACE CAP." instead;
	if player does not have brag garb, say "You need some [if player has stinky knits]cooler [end if]clothes." instead;
	say "USE TROLL ORT ON BRAG GARB." instead;

this is the frush-surf-complete rule:
	if kayo yak is moot, the rule succeeds;
	the rule fails.

section Fun Nuf rule

this is the fun-nuf rule:
	now more-later is true; [ we will always have more to do here ]
	if Dirge Grid is not mapped north of Fun Nuf and Flee Elf is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Dirge Grid is mapped north of Fun Nuf and Diktat Kid is in Dirge Grid, say "You will need to go north to face the Diktat Kid[unless player has ME gem and player has taboo bat and murdered rum is moot], but you are worried you're not quite prepared[end if]!" instead; [?? indicate that you may need to pick off the bosses as well]
	if Flee Elf is in Fun Nuf, say "[one of]The Flee Elf wants you to take the cap. But not take. A simile. To show you're in tune with this place.[or]PAC* CAP is the way to go.[or]PACK CAP.[stopping]" instead;
	if player does not have epicer recipe, say "There's a useful list of items in Yelpley that may help you figure a way north." instead;
	say "You'll need to come back later to break open the North-Tron." instead;
	if player has X-ITE TIX, say "USE TIX ON TIX EXIT." instead;
	continue the action;

section Gross Org rule

this is the gross-org rule:
	if stinky knits are not in Gross Org, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Ned is not moot, say "DENY NED." instead;
	if stinky knits are in Gross Org, say "You need to take the stinky knits." instead;
	say "[one of]You need to get rid of Ned.[or]Ned wants a fight, which you want to decline.[or]A better way to say it is, DENY NED.[stopping]" instead;

section Lair Trial rule

this is the lair-trial rule:
	if ergot ogre is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if kayo yak is in Lair Trial, say "YAK OKAY." instead;
	say "[one of]You need to bring something that can knock the ogre off. You can't do it yourself.[or]Get the kayo yak to chase you.[stopping]";

section Le Babel rule

this is the le-babel rule:
	if Bro Orb is not in Le Babel, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player does not have tenet, say "You need something to help you take the Bro Orb. It's in [if Motto Bottom is visited]a place you haven't visited yet[else]Motto Bottom[end if]." instead;
	say "All you really have to do here is take the Bro Orb." instead;

section Mire Rim rule

this is the mire-rim rule:
	unless eroded ore is off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player does not have radar, say "There's something important behind the made dam, but you don't have the tool to detect it, yet." instead;
	say "[one of]There's something behind the made dam. How can you detect it?[or]You have one detection instrument.[or]The radar.[or]USE RADAR ON MADE DAM.[stopping]" instead;

section Mont Nom rule

this is the mont-nom rule:
	unless martini tram is off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Ian is in Mont Nom, say "NAIL IAN." instead;
	if number of solid ingredients carried by player > 0 and number of liquid ingredients carried by player > 0, say "[one of]You can make some food here.[or]USE [printed name of random solid ingredient carried by player in upper case] ON [printed name of random liquid ingredient carried by player in upper case].[stopping]" instead;
	say "You need to find some more food before using it here." instead;

section Moo Room rule

this is the moo-room rule:
	if yahoo hay is moot, continue the action;
	if art-free-warn is false:
		if poo coop is not in Moo Room and straw arts are not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if poo coop is in Moo Room, say "Take the poo coop." instead;
	if player has SOME DEMOS, say "USE SOME DEMOS ON YAHOO HAY." instead;
	say "You need to use a book on the hay to make art." instead;

section Motto Bottom rule

this is the motto-bottom rule:
	if tenet is moot or player has tenet, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player does not have sage gas, say "You need to get something from Apse Spa." instead;
	if player does not have tenet, say "USE SHARP RAHS ON GURU RUG." instead;

section My Gym rule

this is the my-gym rule:
	if wash saw is not in My Gym, continue the action;
	if search-hint-room is true, the rule succeeds;
	if wash saw is in My Gym and Dave is not in My Gym, say "Take the wash saw." instead;
	say "[one of]Dave is in the way, but he doesn't quite fit in Yelpley.[or]How could you expose him, appropriate to the whole game?[or]You need to sneak by.[or]EVADE DAVE.[stopping]" instead;

section Ooze Zoo rule

this is the ooze-zoo rule:
	if sleep eels are moot, continue the action;
	if search-hint-room is true, the rule succeeds;

section Pro Corp rule

this is the pro-corp rule:
	if resale laser is not off-stage and DNA band is not in Pro Corp and gold log is not in Pro Corp, continue the action;
	if search-hint-room is true, the rule succeeds;
	if DNA band is in Pro Corp, say "Take the DNA band." instead;
	if gold log is in Pro Corp, say "Take the gold log." instead;
	if Gorge Grog is off-stage, say "[one of]You need a liquid to pour down the butene tub. A caustic one.[or]Bon Snob has a liquid to pour down the tub.[stopping]" instead;
	say "USE GORGE GROG ON BUTENE TUB." instead;

section Red Roses Order rule

this is the red-roses-order rule:
	if taboo bat is not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if madam is in Red Roses Order, say "USE BRO ORB ON MADAM." instead;
	if player does not have balsa slab, say "You need to get the balsa slab from Frush Surf." instead;
	say "USE BALSA SLAB ON SWORD ROWS." instead;

section Scrap Arcs rule

this is the scrap-arcs rule:
	if Ye Key is not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player does not have stamp mats, say "[one of]You need something from Grebeberg to cut the slate metals.[or][if Frush Surf is visited]Get the stamp mats from Frush Surf.[else]Look south of [trees-zoo].[end if][stopping]";
	say "USE STAMP MATS ON SLATE METALS." instead;

to say trees-zoo:
	say "[if Ooze Zoo is visited]Ooze Zoo[else]Seer Trees[end if]"

section Seer Trees rule

this is the seer-trees rule:
	if stark rats are moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player has party trap, say "USE the party trap on the stark rats." instead;
	if player has trap art, say "The trap art can be made into something bigger. ";
	if ever-workrow is true, say "[one of]One of the machines in Work Row works.[or]USE TRAP ART ON REIFIER.[stopping]" instead;
	if Worn Row is visited, say "Worn Row is more than it seems[if ever-wordrow is true]. Yes, even more than Word Row[end if]." instead;
	say "There's a room you haven't been to, [if My Gym is visited]past My Gym[else if Yawn Way is unvisited]east in Yelpley[else]south of Yawn Way[end if]. Have a look there." instead;

section Sneer Greens rule

this is the sneer-greens rule:
	if Yuge Guy is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player has rep popper, say "USE REP POPPER ON YUGE GUY." instead;
	if dork rod is moot, say "You can take the item you need to defeat the Yuge Guy." instead;
	if Yuge Guy is in Sneer Greens, say "[one of]You need something from elsewhere to defeat the Yuge Guy. AID again to see where[or]What you need to defeat the Yuge Guy is in Yell Alley[stopping]."

section Swamp Maws rule

this is the swamp-maws rule:
	if dork rod is not moot and NULL ILLUN is moot, continue the action;
	if moor broom is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if NULL ILLUN is not moot, say "[if player has Known Wonk]USE NULL ILLUN ON KNOWN WONK[else]You need to give the Knowk Wonk a book[end if]." instead;
	if player does not have moor broom, say "The enact cane can be combined to better purpose." instead;
	say "USE MOOR BROOM ON TRU YURT." instead;

this is the swamp-maws-complete rule:
	if moor broom is moot, the rule succeeds;

section Swept Pews rule

this is the swept-pews rule:
	if liar grail is moot and troll ort is not in Swept Pews, continue the action;
	if search-hint-room is true, the rule succeeds;
	if troll ort is in Swept Pews, say "Take the troll ort." instead;
	if player does not have puce cup, say "You need the puce cup to pour something in the liar grail." instead;
	if puce cup is not sappy, say "[one of]You need to pour something [if puce cup is not empty]else [end if]in the puce cup.[or][if Cold Loc is unvisited]You haven't looked north of Seer Trees[else]Cold Loc has something. The past sap.[end if][stopping]" instead;
	if liar grail is not moot, say "Get the puce cup and use it on the liar grail." instead;

section Toll Lot rule

this is the toll-lot rule:
	if cross orc is moot and UFO tofu is not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if cash sac is off-stage, say "[one of]You need to bribe the cross orc with something in Grebeberg.[or]If you help someone in Grebeberg, you will get paid, and you can give that to the cross orc.[or][if Flu Gulf is visited]The cash sac from the Gulf Lug in Flu Gulf works[else]Check north of Cold Loc for someone to help.[end if][stopping]" instead;
	if cross orc is in Toll Lot, say "USE CASH SAC ON CROSS ORC." instead;

section Trapeze Part rule

this is the trapeze-part rule:
	unless epicer recipe is off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	say "[one of]The net needs you to do something to it.[or]TEND NET.[stopping]" instead;

section Worn Row rule

this is the worn-row rule:
	if ever-wordrow is true and ever-workrow is true and etage gate is in Gross Org:
		consider the got-machine-fodder rule;
		unless the rule succeeded, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Psi Wisp is in Worn Row, say "WORN ROW will get rid of the Psi Wisp." instead;
	if Rob is in Worn Row, say "BORE ROB." instead;
	if ever-wordrow is false, say "You can change this place to WORD ROW." instead;
	if ever-workrow is false, say "You can change this place to WORK ROW." instead;
	if Worn Row is worny, say "You can change Worn Row back to WORK ROW[if any-books-left] or WORD ROW[end if]." instead;
	if Worn Row is wordy:
		if number of not necessary books in Worn Row > 0:
			say "You'll need to use all the books eventually[if DWELT LEWD is not off-stage], except DWELT LEWD. [one of]AID again to see which book is probably next[or][stopping]." instead;
		say "You don't have anything more to do in Word Row. Change it back to Work Row." instead;
	if rotator is in Worn Row, abide by the find-machine rule;
	say "USE YARD RAY ON TEST SET." instead;

to say book-hint:
	say "[if player carries cur-book]You are carrying a good book to use[else]There's no strict order, but I'd suggest going with [cur-book]"

to decide whether any-books-left:
	if number of not necessary books in Worn Row > 0, yes;
	no;

to decide which book is cur-book:
	if Door Frood is not moot, decide on TI;
	if King Nik is not moot, decide on EPOCH COPE;
	if cross orc is not moot and gnu dung is moot, decide on NULL ILLUN;
	if YOB ATTABOY is not moot, decide on YOB ATTABOY;
	decide on NULL ILLUN;

machineables is a list of things variable. machineables is {stinky knits, gold log, you buoy, bunk nub, Dirt Rid, eroded ore, trap art, DNA band, not-a-baton}. [?? if we use this a lot maybe we should make a property]

this is the got-machine-fodder rule:
	repeat with Q running through machineables:
		if player has Q, the rule succeeds;
	the rule fails;

this is the find-machine rule:
	repeat with Q running through machineables:
		if player has Q:
			repeat through table of useons:
				if use1 entry is Q:
					say "USE [printed name of use1 entry in upper case] ON [printed name of use2 entry in upper case].";
					the rule succeeds;
	say "You don't have anything you could use on a machine at the moment." instead;

this is the worn-row-complete rule:
	if test set is moot, the rule succeeds;

section Yawn Way rule

this is the yawn-way rule:
	if stark rats are not moot, continue the action;
	if puffed-up is true, continue the action; [this is a trivial rule, but in case I decide to add something, it may be a help.]
	if search-hint-room is true, the rule succeeds;
	if player does not have Spur Ups, say "You may need to visit Cold Loc to receive an item to help you go east." instead;
	say "[one of]The spur ups can make you feel, if not go, UP. But how should you get more UP?[or]PUFF UP.[stopping]" instead;

this is the yawn-way-complete rule:
	if puffed-up is true, the rule succeeds; [this is a trivial rule, but in case I decide to add something, it may be a help.]
	the rule fails;

section Yell Alley rule

this is the yell-alley rule:
	if pity tip is moot and psi wisp is not moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if pity tip is not moot, say "USE PITY TIP ON NAVY VAN." instead;

this is the yell-alley-complete rule:
	if player has TNT or TNT is moot, the rule succeeds;

chapter balmlabing

balm-got is a truth state that varies.

balmlabing is an action applying to nothing.

understand the command "balmlab" as something new.
understand the command "balm lab" as something new.

understand "balm lab" as balmlabing when player is in Pro Corp and bald-lab is true.
understand "balmlab" as balmlabing when player is in Pro Corp and bald-lab is true.

carry out balmlabing:
	if balm-got is true, say "No double dipping." instead;
	now balm-got is true;
	abide by the LLP rule; [BALM LAB]
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
		abide by the LLP rule; [PEEP]
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
		abide by the LLP rule; [POOP]
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
	if slam-mam is true, say "You already did. Don't overdo it." instead;
	unless player is in Ooze Zoo, say "You have no sympathetic audience." instead;
	say "The sleep eels wake from their slumber [if bunk nub is moot]just out of sight [end if]briefly to squirm. They telepathically project their pleasure [if sleep eels are moot]from their stock cots [end if]before going back to sleep. You've ... done something, I guess? And hopefully without too much whataboutism?";
	now slam-mam is true;
	abide by the LLP rule; [SLAM MAMMALS]
	the rule succeeds;

chapter stacking

stacking is an action applying to one thing.

understand the command "stack" as something new.

understand "stack [something]" as stacking.

carry out stacking:
	if noun is not senile felines, say "Not worth stacking." instead;
	unless the player's command matches the text "cats", say "Refer to the felines by a simpler synonym, and you've got it." instead;
	say "You stack the cats so they can reach the late petal, but once you do, the top one bats it and it falls. They walk away, disinterested. But they still seemed to have fun. Well, cats are like that.";
	moot senile felines;
	moot late petal;
	abide by the LLP rule; [STACK CATS]
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
		abide by the LLP rule; [STATS]
		now stats-yet is true;
	follow the notify score changes rule;
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
	say "The mistakes file ([gt] mistakes.i7x) should have all the possible palindrome tries. You can read through there.[paragraph break]Similarly, the tables file ([gt] tables.i7x) should have all the random texts.";

chapter misses table

table of last lousy points [xxllp]
funstuff	mclu	finord	dorule	cluey
"BOOB or POOP or PAP to swear 'right"	false	1	pb-yet rule	"swear 'right'"
"REFER instead of THINK"	false	2	refer-yet rule	"THINK, or recall, information correctly"
"DIAL AID instead of AID"	false	3	dial-yet rule	"ask for AID"
"PEEP instead of looking"	false	4	peep-yet rule	"LOOK differently"
"STATS to get the score"	false	5	stats-yet rule	"get the SCORE differently"
"TRACE CART to find an 'extra' book"	false	6	cart-traced rule	"find an extra book in the tract cart"
"SLAM MAMMALS around the eels"	false	7	slam-yet rule	"apologize for mammals to the eels"
"STACK CATS to help the senile felines"	false	8	cats-stacked rule	"help the cats"
"SEE BEES in Moo Room"	false	9	bees-seen rule	"notice the source of the buzzing in Moo Room"
"BALM LAB in the Bald Lab"	false	10	balm-yet rule	"get one more item [if Pro Corp is unvisited]from the northwest room after looting it[else]from [Pro Corp][end if]"
"MUSS OPOSSUM to make a friend"	false	11	muss-yet rule	"be nice to [if Le Babel is visited]an opossum[else]the opossum in Le Babel[end if]"

this is the balm-yet rule:
	if balm-got is true, the rule succeeds;
	the rule fails;

this is the bees-seen rule:
	if bees-seen is true, the rule succeeds;
	the rule fails;

this is the cart-traced rule:
	if DWELT LEWD is off-stage, the rule fails;
	the rule succeeds;

this is the cats-stacked rule:
	if senile felines are moot, the rule succeeds;
	the rule fails;

this is the dial-yet rule:
	if dial-yet is true, the rule succeeds;
	the rule fails;

this is the muss-yet rule:
	if opossum is moot, the rule succeeds;
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

check quitting the game:
	display-dropbox-link;

chapter llping

llping is an action out of world.

understand the command "LLP" as something new.

understand "LLP" as llping.

carry out llping:
	now LLP-reject is whether or not LLP-reject is true;
	say "LLP reject is now [on-off of LLP-reject].";
	the rule succeeds;

chapter endgame

endgameing is an action applying to nothing.

understand the command "endgame" as something new.

understand "endgame" as endgameing.

carry out endgameing:
	say "Giving you all the cool stuff to defeat the Diktat Kid. NOTE: Also moving the test set to Fun [']Nuf. It should be in work row, but it's easier this way.";
	move test set to Fun Nuf;
	now player carries all tronparts;
	now martini tram is in Fun Nuf;
	now player carries murdered rum;
	now player carries yard ray;
	now player carries epicer recipe;
	moot Set O Notes;
	moot Darer Ad;
	moot elf;
	now player has pact cap;
	now player has taboo bat;
	now player has ME gem;
	now Tix Exit is in Fun Nuf;
	if player is not in Fun Nuf, move player to Fun Nuf;
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
			the rule succeeds;
		if use2 entry is reifier and use1 entry is noun:
			try useoning use1 entry with rotator;
			try useoning use1 entry with reviver;
			try useoning use1 entry with reifier;
			the rule succeeds;
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

include Put It Up Tests by Andrew Schultz. [must come first so blank-appear-okay is accepted]

Diktat Kid is blank-appear-okay.
Knife Fink is blank-appear-okay.
Verses Rev is blank-appear-okay.

the debug tweaks rule is listed first in the when play begins rulebook.

when play begins (this is the debug tweaks rule):
	now ignore-wait is true;
	now debug-state is true;

when play begins (this is the make sure everyone is chatty rule):
	let count be 0;
	repeat with Q running through people:
		if talk-text of Q is empty:
			if gender-oppo of Q is not Diktat Kid and talk-text of gender-oppo of Q is not empty:
				say "[Q] maps to [gender-oppo of Q]. This is okay.";
				next;
			increment count;
			say "[count]. [Q] needs basic talk-text.";
	if count is 0:
		say "YAY all people accounted for!";
	else:
		say "[count] of [number of people] unaccounted for.";

when play begins (this is the miscellaneous deep testing rule):
	if debug-state is true, try percing;

chapter adeing

adeing is an action out of world.

understand the command "ade" as something new.

understand "ade" as adeing.

carry out adeing:
	now aid-detail is whether or not aid-detail is false;
	say "Aid detail is now [on-off of aid-detail]. In other words, you [if aid-detail is true]will[else]won't[end if] see what hints would be in the room that's currently targeted for hints.";
	the rule succeeds;

chapter dving

dving is an action applying to nothing.

understand the command "dv" as something new.

understand "dv" as dving.

carry out dving:
	now debug-verbose is whether or not debug-verbose is false;
	say "Debug-verbose is now [on-off of debug-verbose].";
	the rule succeeds;

[below can be commented out.]

chapter ahing

ahing is an action out of world.

understand the command "ah" as something new.

understand "ah" as ahing.

carry out ahing:
	say "Order list: [L].";
	repeat with Q running through L:
		if Q is in Odd Do, next;
		if Q is unvisited, next;
		consider the done-rule of Q;
		if the rule succeeded:
			consider the done-for-good rule of Q;
			say "Q is done[unless the rule succeeded], but not[end if] for good.";
	the rule succeeds;

chapter finording

finording is an action out of world.

understand the command "finord" as something new.

understand "finord" as finording.

carry out finording:
	sort table of last lousy points in finord order;
	say "Last lousy point table now sorted according to finord column.";
	the rule succeeds;

chapter finordning

finordning is an action applying to one number.

understand "finord [number]" as finordning.

carry out finordning:
	if the number understood < 1 or the number understood > 20:
		say "[the number understood] is out of range. Use 1-20 instead." instead;
	try finording;
	let Q be number of entries in checkoffs;
	now hint-every-x is number understood;
	let Q2 be hint-every-x * number of rows in table of last lousy points;
	say "With clues every [hint-every-x] good guesses, you'll get a maximum of [Q2]. There are [Q] total checkoffs. You can[if Q < Q2][']t[end if] make it.";
	the rule succeeds;

chapter percing

percing is an action out of world.

understand the command "perc" as something new.

understand "perc" as percing.

carry out percing:
	let count be 0;
	repeat through table of periphery:
		if itm entry is not peripheral:
			if itm entry is state tats, next;
			say "[itm entry] is in periphery table but is not peripheral.";
			increment count;
	repeat with Q running through peripheral things:
		if Q is not an itm listed in table of periphery:
			say "Need periphery entry for [Q].";
			increment count;
	say "[if count is 0]Yay! Periphery succeeds![else][count] periphery errors.[end if]";
	the rule succeeds;

chapter full monty extension

include Full Monty Testing by Andrew Schultz.

table of monties (continued)
montopic (topic)	on-off	test-title (text)	test-action	topic-as-text (text)
"aid"	false	"AIDING"	try-aid rule	"aid"

exitsing is an action out of world.

carry out exitsing:
	repeat with Q running through maindir:
		let Q2 be the room Q of location of player;
		if Q2 is not nowhere, say "[Q2] is [Q] of [location of player].";

this is the try-aid rule:
	try aiding;

[?? test to see about any person/place/scenery that is in table of rejects or useons but not both]