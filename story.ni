"Put it Up" by Andrew Schultz

[blurb for comp = A *GASP* SAGA]

the story headline is "Yo, Joy! Wow!"

the release number is 1.

include Trivial Niceties Z-Only by Andrew Schultz.

include Basic Screen Effects by Emily Short.

include Put It Up Debug Tables by Andrew Schultz.

include Put It Up Mistakes by Andrew Schultz.

include undo output control by Erik Temple.

volume definitions

a thing can be drinkable. a thing is usually not drinkable.

an ingredient is a kind of thing. an ingredient is usually edible. an ingredient can be solid or liquid.

the description of a room is usually "[if number of viable directions is 1]An exit leads[else]Exits lead[end if] [list of viable directions]. NOTE: I need to change this generic text."

chapter region and room stuff

a region has a number called max-score. a region has a number called cur-score.

Grebeberg is a region. max-score of Grebeberg is 24.

Dim Mid is a region. max-score of Dim Mid is 8.

Yelpley is a region. max-score of Yelpley is 24.

Odd Do is a region. max-score of Odd Do is 5.

[El Live Ville is a region.]

volume unsorted

section part of a puzzle but not fully linked yet

section no precise function yet

The Balsa Slab is a thing.

The DNA Band is a thing.

The DNA Hand is a thing.

[?? tame mat would be sort of funny. Where does it go?]

section part of a puzzle but still floating

Sniffins is a person.

Otto is a person.

The Exam Axe is a thing. description is "Just looking at the exam axe, you feel as though you've been right about stuff. Maybe not right or morally superior, but you're able to see through obvious nonsense."

section stuff to move

the state tats are a thing. description is "They say OMG MO[']."

instead of doing something with state tats:
	if action is procedural, continue the action;
	say "You don't need to do anything to or with the state tats, now that you're wearing them.";

stamp mats are a thing.

Ye Key is a thing.

the stink knits are a thing. "They don't smell very good. In a failed attempt at irony, they are lettered DAFT FAD."

the brag garb is a thing.

section ingredients

the Mayo Yam is a liquid ingredient.

the UFO tofu is a liquid ingredient.

the gift fig is a solid ingredient.

the snack cans are a solid ingredient.

the Elan Ale is a drinkable thing. description is "It's labeled as CLASS Alc, unsurprisingly."

the yard ray is a thing. description is "It looks pretty lethal. It also has instructions: EMIT ********.[paragraph break]It's currently [if murk rum is in ZeroRez]loaded with energy from the Murk Rum[else]empty of fuel[end if]."

the murk rum is a drinkable thing. [put this in the yard ray]

section tronparts

a tronpart is a kind of thing.

description of a tronpart is usually "The [item described] is one of [number of tronparts] parts needed for the North-Tron."

the martini tram is a tronpart. [?? if we don't have the epicer recipe we don't know what the tram is for. Can we get the tram before the recipe?]

TNT is a tronpart.

Gorge Grog is a tronpart. description is "Unsurprisingly, it's produced by Grog-Org."

The Ore Zero is a tronpart.

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
	if location of player is not Emo Dome, now location of player is available;
	continue the action;

section set o notes

the set o notes is a thing. description is "There's some general vague advice about making a North Tron to defeat the Diktat Kid, but first you'll have to defeat Madam and the Yuge Guy, Evil Clive. The Set O Notes also points out you'll need to find items and use them together, but since you're on a quest, you already sort of knew that."

after examining set o notes for the first time, say "Maybe you'll get something even more detailed than the Set O Notes later."

part scoring

to score-inc:
	reg-inc mrlp;

check requesting the score:
	say "Your overall score so far is [score] of [maximum score][one of]. But don't worry, points pile up pretty quickly once you get going[or][stopping].";
	say "Broken down by regions, you have [regres of Dim Mid], [regres of Grebeberg], [regres of Yelpley] and [regres of Odd Do].";
	if player has set o notes and north tron is off-stage:
		let ni be number of tronparts carried by the player;
		say "You also have [ni] of [number of tronparts] piece[if ni is not 1]s[end if] of the North Tron, according to the set-o-notes.";
	the rule succeeds;

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

chapter unrecognized verb

Rule for printing a parser error when the latest parser error is the didn't understand error:
	say "[if gtv]You do need a special verb here, but not that one. It may not be a standard one, but given the game's theme, I bet you can figure it out. If you want standard verbs, y[else]I didn't recognize that action. Y[end if]ou can type VERB or VERBS to get a list of them.";

to decide whether gtv:
	if Ian is in location of player, yes;
	if Dave is in location of player, yes;
	if Curt is in location of player, yes;
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

chapter refering / thinking

refer-bonus is a truth state that varies.

refering is an action applying to nothing.

understand the command "refer" as something new.

understand "refer" as refering.

carry out refering:
	if refer-bonus is false:
		say "Yes! That's a slightly more appropriate way to think, here.";
		reg-inc Odd Do; [REFER]
		now refer-bonus is true;
	try thinking instead;

instead of thinking:
	say "[if refer-bonus is false]There might be a more appropriate way to think[else]You think for a bit[end if]."

chapter inventory

after printing the name of a tronpart while taking inventory: if player has epicer recipe, say " (recipe item)".

after printing the name of yard ray while taking inventory: say " ([unless murk rum is in ZeroRez]un[end if]charged)".

after printing the name of spa maps while taking inventory: say "([if maps-explained is true]deciphered[else]indecipherable[end if])".

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
	if wr-short-note is true and player is in Worn Row and workrow is true, say "[line break]REV, ROT and REI use an item on the reviver, rotator and reifier, respectively.";
	the rule succeeds;

wr-short-note is a truth state that varies.

chapter drinking

drink-warning is a truth state that varies.

check drinking:
	say "[if noun is drinkable]Pish! Sip?![else][']S not wet. Ew--TONS.[end if]";
	if drink-warning is false, say "(You don't need to drink anything. Any liquid is probably used for much more aggressive purposes.)[paragraph break]";
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

instead of attacking, next-rand table of attackings;

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
	if d is north and lp is Ned's Den and etage gate is in Ned's Den, no;
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
	if player has dork rod:
		now rod-smelled is true;
		say "You might expect a rod odor, but there isn't one. OR MAYBE IT IS SO INGRAINED IN YOU, YOU NO LONGER SMELL IT." instead;
	if player is in Bon Snob, say "Ham?! Ah!" instead;
	if player is in Sneer Greens, say "You smell an amoral aroma." instead;
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

understand the command "use" as something new.

understand "use [something] on [something]" as useoning it with.
understand "use [something] with [something]" as useoning it with.

useoning it with is an action applying to two things.

to build-the-tron:
	move north tron to Fun 'Nuf;
	now all tronparts are in ZeroRez;
	say "You build the north tron with the instructions from the epicer recipe. It points north and blasts a hole with a huge tron snort before collapsing into uselessness. You must be close now!";
	now Dirge Grid is mapped north of Fun 'Nuf;
	now Fun 'Nuf is mapped south of Dirge Grid;
	score-inc; [Dim Mid/USE TNT ON ORE ZERO]

chef-yet is a truth state that varies.

to chef (i1 - an ingredient) and (i2 - an ingredient):
	if player is not in Mont Nom:
		say "You're not in the right place to mix food together.";
		continue the action;
	if i1 is liquid and i2 is liquid:
		say "Those are both too liquid.";
	else if i1 is solid and i2 is solid:
		say "Those are both too solid to go together.";
	else:
		say "You mix [the i1] with [the i2] in front of the Ark of Okra. You hear a distant rumble. The Ark of Okra shakes visibly.[paragraph break]";
		now i1 is in ZeroRez;
		now i2 is in ZeroRez;
		score-inc; [Grebeberg/USE GIFT FIG ON MAYO YAM&USE SNACK CANS ON UFO tofu]
		if chef-yet:
			say "A martini tram pops out from behind the Ark of Okra. Now that you've made so much food, you need drinks! Except, well, the tram doesn't have any drinks. You notice, though, that it's on your epicer recipe, so you push it back to Fun [']Nuf.";
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
		chef noun and second noun;
	repeat through table of cantuse:
		if noun is use1 entry or second noun is use1 entry, say "[babble entry][line break]" instead;
	if noun is a person, say "[one of]You're not any good at using other people. In fact, if you tried, they'd wind up using YOU. Plus you don't want to be, really. There's another way. So, no[or]Using people is out[stopping]. Maybe you could use something on a person, though." instead;
	if noun is a tronpart or noun is epicer recipe:
		if second noun is a tronpart or noun is epicer recipe:
			if player does not have epicer recipe, say "Those two things seem to go together, but you don't have detailed instructions." instead;
			if number of tronparts carried by player < number of tronparts, say "You have the start of something, but not enough to make a north-tron." instead;
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
Curt	"Curt's not going to be obliging. You have to get rid of him, somehow."
Pact Cap	"Your pact cap is fine where it is, on your head."

[getit = item you get, d1/d2 = use1/use2 disappear(?) pre/post = rule to check, or rule to execute post-happening]
table of useons [xxuse]
use1	use2	getit	preproc (a rule)	postproc (a rule)	sco	d1	d2	reg-plus	babble
trap art	reifier	party trap	--	--	true	true	false	Yelpley	"The trap art crunches inside the reifier, then -- bam! Out comes what the trap art was imagined to be: a party trap. I bet it could trap more than one person, or thing, or whatever."
party trap	stark rats	gift fig	--	--	true	true	true	Grebeberg	"The rats all try to enter the trap, and SNAP! SNAP! SNAP! The party trap explodes as the last rat enters, but fortunately all the trap-stuff is gone. The Seer Trees seem to nod a bit. You watch as a gift fig rolls out. You take it."
demo med	gulf lug	cash sac	--	--	true	true	true	Grebeberg	"The Gulf Lug takes the demo med, inspects it, and says, 'Eh, why not...' he looks a lot better within a few seconds. 'Thank you so much!' he says, handing you a cash sac."
TO IDIOT	Revolt Lover	--	--	--	true	true	true	Yelpley	"The Revolt Lover begins to read and starts chuckling. Then keeps chuckling. 'Oh my goodness. This is funny. I'd try to explain it to you, but I'm not sure if you deserve to laugh at it yet. Maybe one day.' With uncontrollable laughter spasms, the Known Wonk runs away."
NULL ILLUN	Known Wonk	--	--	--	true	true	true	Grebeberg	"The Known Wonk begins to read. 'This is too simple. It has to be beneath me.' But the more the Wonk reads, the more it's clear...they have overlooked stuff. 'Hey. That makes sense. And if it's simple, well, I need to know when simple stuff works.' The Known Wonk apologizes--it's back to a Tru Yurt for a thought session."
cash sac	cross orc	--	--	--	true	true	true	Yelpley	"The cross orc looks at the cash sac suspiciously. It's not sure if the sac is enough. But you convince the orc that money isn't any good if you don't get out there and spend it, and ... with a payee yap, the orc goes to look for ... well, something else."
radar	crag arc	UFO tofu	orc-gone rule	--	true	true	false	Yelpley	"Beeeep... beeeep..... the radar has found something! A small saucer arises from a hidden part of the crag. Splat! something weird and warm drops from the UFO as it flies off. It bounces off you. 'O Furor! UFO!' you cry. You look at it and--it's unharmed, and still in a cubic shape. Looks like you got yourself some UFO tofu."
poo coop	gnu dung	--	--	--	true	true	true	Grebeberg	"The gnu dung is sucked towards the poo coop. In fact, it forms a crass arc as it seems like the dung inside the coop must be several times the volume of the coop itself. Whatever, you can now go south."
radar	made dam	eroded ore	--	--	true	true	false	Grebeberg	"You place the radar against the made dam and move back and forth. Suddenly--yes! You hear a few pings. There's something behind. You discover some eroded ore, which you take. It's not much in its current state, but maybe you can regenerate it somehow."
gold log	rotator	dork rod	--	--	true	true	false	Yelpley	"The gold log begins spinning until it cracks open--leaving a dork rod!"
dork rod	tao boat	--	--	--	true	true	false	Grebeberg	"The dork rod melds into the Tao Boat. You step aboard. After you leave, you feel much more peaceful."
ERA FARE	King Nik	Spur Ups	--	--	true	true	true	Grebeberg	"King Nik reads it, nods sagely, and reads. 'This will help me when I get back to South Ihtuos. Thank you!'"
debt bed	reviver	stock cots	--	--	true	true	false	Yelpley	"After some crunching and slurping, the debt bed is changed to a bunch of much smaller, but more comfortable looking, stock cots."
stock cots	sleep eels	--	--	--	true	true	true	Grebeberg	"The sleep eels seem intrigued by the upgrade in relaxation resources. You put the stock cots down and roll them out of the way. The eels follow. You can now go south!"
puce cup	past sap	--	--	sap-to-cup rule	true	false	false	Grebeberg	"You pour some sap into the cup."
puce cup	liar grail	--	sap-in-cup rule	empty-cup rule	true	false	true	Yelpley	"The past sap pours into the liar grail and exposes how bad the grail has been over the years. As it cracks to allow passage south, you snicker to yourself. Liar grail? More like Liar FRAIL!"
spa maps	go-by bog	sage gas	maps-readable rule	--	true	true	false	Grebeberg	"Everything clicks now! You see Go-By Bog, Gobs Bog, and how to pass through each of them. It's not a total breeze, but when you get through, you find sage gas all around. The Spa Maps are surprisingly sturdy, and you're able to reformat them into a receptacle for the sage gas. Lucky you! Or maybe being around that sage gas made you smart enough to figure the science out, there.[paragraph break]As you return to the Apse Spa, the Spa Maps turn into a salt atlas and crumble away."
stink knits	rotator	brag garb	--	wear-garb rule	true	true	false	Yelpley	"The stink knits fit into the rotator without stuffing them too much. After some spinning, you look in again and--they're something much shinier now. Brag garb!"
troll ort	brag garb	--	--	--	true	true	false	Grebeberg	"You rub the troll ort on the Brag Garb. It's now an entirely different smell from the Stink Knits, but a much more edible one. You guess."
DNA band	reifier	DNA hand	--	--	--	true	true	false	Yelpley	"After considerable gooping and whooshing, the reifier pops open to reveal something more lifelike than a DNA band: a DNA hand!"
Elan Ale	Ira Bari	Gorge Grog	--	--	true	false	false	Yelpley	"Ira looks the Elan Ale up and down, sniffs and...well, okay. It will do. 'Now take that Gorge Grog and get it out of here.'"
Eroded Ore	reviver	Ore Zero	--	--	true	true	true	Yelpley	"The reviver whirs as you drop the eroded ore in, and ... out pops some shiny Ore Zero!"
el doodle	edits tide	spa maps	--	--	true	true	false	Grebeberg	"The edits tide washes away enough of El Doodle to reveal maps...and not just any maps, but spa maps!"
puce cup	dose sod	--	--	sod-to-cup rule	true	false	false	Grebeberg	"You funnel the dose sod into the puce cup. It will keep the sod fresh enough."
puce cup	marge pegram	Elan Ale	sod-in-cup rule	empty-cup rule	true	true	true	Yelpley	"You give marge the puce cup. She drinks the dose sod and immediately feels better. 'Well... I have a lot of catching up to do. Can't hang around. Here's some Elan Ale for you, to celebrate how cool you are for helping.'"
tent net	Code Doc	--	--	--	true	true	false	Grebeberg	"Say! Thanks! I appreciate that. Let me know if I can share some knowledge in return."
spa maps	Code Doc	--	maps-explained-yet rule	maps-explain rule	true	false	false	Grebeberg	"The Code Doc looks at the maps. 'Ah! That's how to interpret them. You just do this... and this ...' and suddenly it makes complete sense to you."
elope pole	kayak	you buoy	--	--	true	true	false	Grebeberg	"You unfold the elope pole into two oars. And you take a journey ... well, you're not sure where, but you see Elided Ile in the distance. So you stop off there. First at the Yack Cay for some chat. You are invited to Nevah-Haven, where everyone is happy all the time, but ... it seems too good to be true. Apparently your declining means you passed some sort of test, and the citizens hand you a YOU BUOY to tell you they're glad you're you. They mention it may hold great treasures within, ones that will help you complete your quest."
you buoy	rotator	ME gem	--	--	true	true	false	Yelpley	"You hear a clunking as the rotator speeds up. When you open the rotator, the you buoy is in shreds, but a shiny ME gem appears. It's so tempting and beautiful, but you know it's not the main point of your quest. Maybe it can distract someone greedy."
sage gas	guru rug	tenet	--	--	true	true	false	Grebeberg	"The sage gas bubbles out under the guru rug and makes it float away. Under the guru rug is a tenet, which seems a bit corny at first, but it seems like it'll help you focus on who you are and what you need to do."
Ye Key	etage gate	gate tag	Ned-gone rule	--	true	true	true	Yelpley	"Ye Key fits perfectly into the Etage Gate, which retracts upward before you can pull Ye Key out. Well, you can't imagine needing it again. A gate tag falls off. It has a curious emblem, much like you saw at the Emo Dome, so you decide to keep it."
gate tag	soot tattoos	state tats	--	--	true	true	true	Yelpley	"You stamp the gate tag into the soot tattoos, and they take on an official shape. They look like official State Tats, which you can slap on if you ever need to impersonate an official goon, or something. Way to go!"
nat's tan	scorn rocs	--	--	--	true	true	true	Grebeberg	"The Nat's Tan burns into the scorn rocs, who were once pridefully spotless. Their fur turns an embarrassing shade of orange. You hear a bellow from the west."
rep popper	Yuge Guy	murk rum	--	--	true	true	true	Grebeberg	"The rep popper deflates the Yuge Guy, leaving behind only murk rum."
Exam Axe	Lie Veil	--	--	--	true	true	true	Grebeberg	"The Exam Axe cuts through the Lie Veil easily. As it does so, it shortens--oh, about 28.57%--before glowing and turning into, well, an ex-axe. You can go north now."
Bro Orb	Madam	Yard Ray	--	--	true	true	true	Yelpley	"The Bro Orb shines and drives Madam to rage. 'Live not on evil, madam, live not on evil!' you boom, as the ray does its work. She runs away, sobbing. The Yard Ray is left unguarded. You take it."
murk rum	yard ray	--	--	--	true	true	false	Dim Mid	"The yard ray gleams with energy. It seems like it could do some damage now."
Yard Ray	test set	--	ready-to-test rule	--	true	false	true	Dim Mid	"Fzzt! Zap! The test set goes up in smoke. Okay, you had something to practice on. Now for the final battle."
Yard Ray	Diktat Kid	X-ITE TIX	--	--	true	true	true	Dim Mid	"Fzzt! Zap! The yard ray zaps the Diktat Kid. Both explode."
X-ITE TIX	TIX EXIT	--	--	you-win rule	true	false	false	Dim Mid	"Yes, it's time to go. You put the X-Ite Tix in the Tix Exit and walk through."

section pre-use rules

[please add alphabetically]

this is the ready-to-test rule:
	if location of player is Fun 'Nuf, the rule succeeds;
	if emitted is false:
		say "You aren't sure how the Yard Ray works, or what it needs to zap people with. Maybe you should review it to figure things out.";
		the rule fails;
	say "That seems right, but you should probably go where there aren't many people. Like back to Fun [']Nuf.";
	the rule fails;

this is the in-mont-nom rule:
	if location of player is not Mont Nom:
		say "Eww! Maybe if you were somewhere more magical with food, it would work.";
		the rule succeeds;
	if Curt is not in Mont Nom, the rule succeeds;
	say "Curt is distracting you. Maybe you can get rid of him, first.";
	the rule fails;

this is the maps-explained-yet rule:
	if maps-explained is true, the rule succeeds;
	say "[if tent net is not in ZeroRez]'I might, but I need some help here first, to make my home here properly homey.'[else]You already got the Code Doc to decipher the spa maps.[end if]";
	the rule fails;

this is the maps-readable rule:
	if maps-explained is true, the rule succeeds;
	say "Hmm. Maybe if the maps were a bit clearer to you, that would work. But not now.";
	the rule fails;

this is the Ned-gone rule:
	if Ned is in Ned's Den, the rule succeeds;
	say "Good idea, but not with Ned around.";
	the rule fails;

this is the orc-gone rule:
	if orc is not in Toll Lot, the rule succeeds;
	say "The cross orc prevents you from trying anything possibly constructive. Maybe with the orc gone, you should try it again.";
	the rule fails;

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

this is the empty-cup rule:
	now puce cup is empty;
	if marge pegram is in ZeroRez and liar grail is in ZeroRez, say "You probably don't need the puce cup any more.";
	the rule succeeds;

this is the maps-explain rule:
	now maps-explained is true;
	the rule succeeds;

this is the sap-to-cup rule:
	repeat through table of useons:
		if use1 entry is puce cup and use2 entry is past sap:
			now sco entry is false;
			the rule succeeds;
	the rule succeeds;

this is the sod-to-cup rule:
	repeat through table of useons:
		if use1 entry is puce cup and use2 entry is dose sod:
			now sco entry is false;
			the rule succeeds;
	the rule succeeds;

this is the wear-garb rule:
	now player wears the brag garb;
	the rule succeeds;

this is the you-win rule:
	say "You head off to saner arenas for a while, just to reflect on all you did.";
	the rule succeeds;

chapter failed useons

table of useons (continued)
use1	use2	getit	preproc (a rule)	postproc (a rule)	sco	d1	d2	reg-plus	babble
yard ray	Tru Hurt	--	--	--	false	true	true	--	"The yard ray bounces harmlessly off the Tru Hurt. Maybe it needs to be used nonviolently."
yard ray	Diktat Kid	--	--	--	false	true	true	--	"The yard ray bounces harmlessly off the Diktat Kid. Maybe it needs to be used nonviolently."

volume rooms

part Dim Mid region

book Fun 'Nuf

Fun 'Nuf is a room in Mid Dim. "[if elite tile is in Fun 'Nuf]Elite tile has replaced the old tile lit. Probably all that's left to do is to read it, or just go back south through the Tix Exit[else]Some tile lit is carved out here, describing what is the various directions[xit-ave][end if][if north tron is in Fun 'Nuf]. Also, the North Tron has carved a passage north[end if]."

to say xit-ave:
	say ". The [if tix exit is in Fun 'Nuf]Tix Exit prevents passage back south[else]Evac Ave is south, if you want to chicken out[end if]"

the north tron is scenery. "It seems to have pushed a passage north here in Fun [']Nuf. Do you have the guts to follow it to your destiny?"

chapter Flee Elf

The Flee Elf is a person in Fun 'Nuf. "A Flee Elf stands here by Evac Ave to the south.". description is "You'd expect to see the Flee Elf wearing a gateman nametag, but maybe that's in some other, even more insanely brilliant, adventure."

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
	if noun is north:
		if Diktat Kid is in ZeroRez, say "No need to go back." instead;
		if north tron is not in Fun 'Nuf, say "Not until you built the North-Tron." instead;
		if player does not have yard ray, say "You don't have a weapon to take down the Diktat Kid." instead;
		if murk rum is not in ZeroRez, say "You have the yard ray, but it isn't, well, charged." instead;

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
	say "Yes, that's how to get the cap. You are ready to go![paragraph break]'Good job! Here's a set o['] notes to replace that darer ad,' the Flee Elf says. It salutes you before becoming, err, the FLED Elf. Where the elf went, a big TIX EXIT sprouts up. You don't have any tickets or anything, though, so you'll have to worry about that later.[paragraph break]Perhaps it's not the most stylish thing ever, but at least they didn't make you wear a bib.";
	move flee elf to ZeroRez;
	now Tix Exit is in ZeroRez;
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
	if pact cap is in Fun 'Nuf, say "That'll work later, but you need something a little different to actually TAKE the pact cap." instead;
	if cap-pace is true, say "It's already a pace cap." instead;
	if cap-ever-pace is false:
		score-inc; [Dim Mid/pace cap]
		now cap-ever-pace is true;
	say "You suddenly feel [if cap-pace is false]swifter[else]slower[end if].";
	now cap-pace is whether or not cap-pace is true;
	the rule succeeds;

chapter tile lit

the tile lit is scenery in Fun 'Nuf. "It's a rough compass, with GREBEBERG west by it, YELPLEY east, Evac Ave south and Dirge Grid north. You can't seem to go [if flee elf is in ZeroRez]south and [end if]north, though." [ic]

check taking tile lit: say "It's sort of embedded into the ground. It looks nice there, anyway, and it's useful for information."

chapter elite tile

the elite tile is scenery. "Done? Nod![line break]Nif-T-Fin!"

book Dirge Grid

Dirge Grid is a room in Mid Dim. "The only way back is south[if Diktat Kid is in Dirge Grid], but you can't really run away from the Diktat Kid[else], and you might as well go that way, now you've vanquished the Diktat Kid[end if]."

printed name of Dirge Grid is "[if Yuge Guy is in ZeroRez]Top Spot[else]Dirge Grid[end if]"

Diktat Kid is a proper-named person in Dirge Grid.

after looking in Dirge Grid for the first time:
	say "The Diktat Kid booms 'Engage le jeu que je le gagne!'";
	continue the action;

check going south in Dirge Grid: if Diktat Kid is in Dirge Grid, say "'Mom! SOS! LOL! SOS! Mom!' the Diktat Kid mocks you.[paragraph break]You can't chicken out. You must be close!" instead;

chapter x-ite tix

the x-ite tix are a plural-named thing. understand "xite" and "xite tix" as x-ite tix.

chapter tru hurt

the tru hurt is a thing in Dirge Grid. "The Tru Hurt is here, and it's aimed at you!"

instead of doing something with the tru hurt, say "You need to take care of the Diktat Kid. With the Yard Ray."

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
		say "BOOM! The yard ray emits too much light for the Diktat Kid to bear. 'Liven evil!' the Kid booms, but it's not enough. The Kid runs off, but not before dropping some X-Ite Tix, which you take.";
		now player has X-Ite Tix;
		now emitted is true;
		score-inc; [Dim Mid/emit noontime]
		the rule succeeds;
	say "No, that's not quite what to emit.";
	the rule succeeds;

part Grebeberg region

book Seer Trees

Seer Trees is west of Fun 'Nuf. It is in Grebeberg.

check going in Seer Trees:
	if noun is not east and stark rats are in Seer Trees, say "The stark rats block you from going anywhere. At least they are not banging stop pots." instead;

the stark rats are a plural-named thing in Seer Trees.

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

the Spur Ups are a plural-named thing.

book Flu Gulf

Flu Gulf is north of Cold Loc. It is in Grebeberg. "North and east, it's, oh, too H2O. The passage is clear back south, but [if scorn rocs are in Flu Gulf]scorn rocs['] gaze blocks you going west[else]west past the scorn rocs seems a bit treacherous[end if]."

the Gulf Lug is a proper-named person in Flu Gulf. "The Gulf Lug stands here, holding his stomach.". description is "He looks slightly ill. Maybe you could help him."

the cash sac is a thing.

chapter scorn rocs

The scorn rocs are scenery in Flu Gulf. "While they're motionless, their stare drives you back. They're fiercely proud and blazingly colored."

check going west in Flu Gulf when scorn rocs are in Flu Gulf:	say "The scorn rocs remain motionless, but their gaze freezes you as you try to go west." instead;

book Sneer Greens

every turn when player is in Sneer Greens:
	if a random chance of 1 in 2 succeeds, say "The Yuge Guy mumbles '[one of]Soros! Soros![or]Huge! Guh![or]Rofl! For...[or]Gibe! Big![in random order]'";

check going east in Sneer Greens:
	if Yuge Guy is in Sneer Greens, say "'LOW AWOL!' the Yuge Guy booms, as you run away."

Sneer Greens is west of Flu Gulf. It is in Grebeberg. "Despite the impressive view, this place still feels like it's gone to pot."

Sneer Greens is above Flu Gulf.

after looking in Sneer Greens for the first time:
	say "The Yuge Guy calls 'BOO! NOOB!' just to reinforce his contempt.";
	continue the action;

Yuge Guy is a proper-named person in Sneer Greens. understand "evil/clive" and "evil clive" as Yuge Guy.

book Dumb Mud

Dumb Mud is west of Seer Trees. It is in Grebeberg.

The lie veil is scenery in Dumb Mud. "It looks untrustworthy."

the gnu dung is in Dumb Mud. "Gnu dung blocks exit south from the Dumb Mud.". description is "You're not an expert in this sort of biology, but given what you've seen so far, it's probably from a gnu."

check going south in Dumb Mud:
	if gnu dung is in Dumb Mud, say "Not through the Dumb Mud you aren't." instead;

check going north in Dumb Mud:
	if lie veil is in Dumb Mud, say "As you touch the lie veil, you shake your head. No. You don't really want or need to explore north. Surely there's some better place to be? Perhaps you're not 100% prepared for the lie veil's thought provoking paradoxes, and it's doing you a favor pushing you back? You try to walk further north, but somehow you wind up walking back south." instead;

instead of doing something with gnu dung:
	if action is procedural, continue the action;
	say "Eewee! (You probably want to deal with the gnu dung indirectly.)"

book Le Babel

Le Babel is north of Dumb Mud. It is in Grebeberg.

chapter Bro Orb

the Bro Orb is a thing in Le Babel.

check taking Bro Orb:
	if player has Bro Orb, say "You already have it." instead;
	if player does not have tenet, say "You aren't sure you can handle the potentially corrupting power of the Bro Orb. [if player has sage gas]The sage gas helps you to understand how things could go wrong, but still, you're a bit worried[end if]. Maybe if you had some more balance to your thinking." instead;
	say "With the tenet, you feel balanced enough to take the Bro Orb and accept the responsibility for doing so."

[?? if you tried to take the Bro Orb or rep popper before, put up a warning saying, ok, you can do this now, if you have the right items.]

book Mont Nom

Mont Nom is south of Dumb Mud. It is in Grebeberg. "An ark of okra blocks passage every way except back north here."

Mont Nom is above Dumb Mud.

The ark of okra is scenery in Mont Nom. "You always found okra, or the idea, icky, but the ark is beautiful enough, you sort of wonder how it'd taste."

the martini tram is a thing in Mont Nom.

instead of eating ark of okra: say "You don't know how long it's been out here. It's probably, like, the vegetable version of wax fruit."

chapter trucking

Curt is a person in Mont Nom.

trucking is an action applying to one thing.

understand the command "truck" as something new.

understand "truck [something]" as trucking.

carry out trucking:
	if noun is not Curt, say "Wrong thing to truck." instead;
	move Curt to ZeroRez;
	score-inc; [Grebeberg/truck curt]
	the rule succeeds.

book Ooze Zoo

Ooze Zoo is south of Seer Trees. It is in Grebeberg. "[if sleep eels are in Ooze Zoo]Sleep eels block passage south, but you can still go back north[else]With the sleep eels gone, you can go north, or south to [s-dray][end if]."

the sleep eels are plural-named people in Ooze Zoo. "Some eels are blocking passage west."

to say s-dray:
	say "[if Dray Yard is visited]Dray Yard[else]a yard[end if]"

book Dray Yard

Dray Yard is south of Ooze Zoo. It is in Grebeberg.

Line Nil is in Dray Yard.

slate metals are scenery in Dray Yard. "They aren't leet steel. You could probably carve something out of them, with the right implement(s)."

The Kayo Yak is a person in Dray Yard.

chapter yakokaying

yakokaying is an action applying to nothing.

understand the command "yakokay" as something new.
understand the command "yak okay" as something new.

understand "yak okay" as yakokaying.

carry out yakokaying:
	if ergot ogre is in ZeroRez, say "[if yak is in location of player]The yak has served you well. It deserves a rest.[else]You relive past glories. Why not?[end if]" instead;
	if yak is in location of player and ergot ogre is in location of player:
		say "The kayo yak surges at the ergot ogre and knocks it over! The ergot won't spread to the yak's horns, so that's good. The ogre dusts itself off and walks away, embarrassed. The yak, for its part, heads back to the Dray Yard.";
		score-inc; [Grebeberg/YAK OKAY]
		now yak is in Dray Yard;
		now ergot ogre is in ZeroRez;
		the rule succeeds;
	if yak is in location of player, say "The yak sees nothing to attack." instead;
	say "There's no yak to say okay to." instead;
	the rule succeeds;

book Moo Room

Moo Room is east of Dray Yard. It is in Grebeberg.

the poo coop is in Moo Room. "A poo coop sits here. Thankfully, it looks empty.". description is "While it's 1/4 too small to be a pooch coop, it's 1) empty and 2) somehow bigger on the inside than the outside. Maybe it can clean up a dirty area. Well, a less dirty area than the Moo Room where you found it."

book Mire Rim

Mire Rim is west of Dumb Mud. It is in Grebeberg. "A made dam blocks your way west. You can go north, south and east here."

the made dam is scenery in Mire Rim.

The Eroded Ore is a thing.

book Birch Crib

Birch Crib is south of Mire Rim. It is in Grebeberg.

Code Doc is a person in Birch Crib.

chapter Spa Maps

Spa Maps are a plural-named proper-named thing. description is "[if sage gas is not off-stage]The maps seem old hat now you've gotten the sage gas[else if maps-explained is false]You can't quite make sense out of them. There's Gobs-Bog and Go-By Bog, and one is a lot safer than the other, but you're not sure which[else]The spa maps clearly demark Go-By Bog and Gobs Bog and even Goblin-Nil Bog, which probably contains a troll or two. And no hospitality[end if]."

check examining spa maps:
	if player is not in Apse Spa, say "It doesn't look like the maps are useful here." instead;
	try useoning spa maps with go-by bog instead;

maps-explained is a truth state that varies.

book Lair Trial

Lair Trial is south of Birch Crib. It is in Grebeberg.

the ergot ogre is a person in Lair Trial. "An ergot ogre blocks the way east.".

check going east in Lair Trial: if ergot ogre is in Lair Trial, say "Not with the ergot ogre guarding the way." instead;

book Motto Bottom

Motto Bottom is east of Lair Trial. It is in Grebeberg.

chapter guru rug

The guru rug is a thing in Motto Bottom. "A guru rug lies here. It looks like it's about to float away, but at the same time, it looks like something you're not good enough to touch."

check taking guru rug: say "'Egad! Adage!' you think to yourself. You're not up to any great philosophy. Maybe something less heavy than the guru rug." instead;

chapter tenet

The tenet is a thing. description is "It seems a bit too cliche, but you have the wisdom to get the encouragement you need from it."

[?? take tenet/take Bro Orb = use sage gas on tenet/use tenet on Bro Orb]

book Swamp Maws

Swamp Maws is north of Mire Rim. It is in Grebeberg. "An edits tide blocks your way west. You can go north or south here."

The Known Wonk is a person in Swamp Maws. "The Known Wonk [one of]figures you'll have to do, even though you're not as interesting as a book[or]paces around, waiting for intellectual conversation[stopping]."

check going north in Swamp Maws when Known Wonk is in Swamp Maws: say "The Known Wonk pushes you back. 'You don't know how weird it is to the north. But I know a thing or two about adventuring theory.'" instead;

The Edits Tide is scenery in Swamp Maws. "A voice from the edits tide seems to say [if spa maps are off-stage]that you could use its proofreading skills[else]it has labored enough for you[end if]."

book Calcific Lac

Calcific Lac is north of Swamp Maws. It is in Grebeberg. "A Tao Boat rests at the edge of Calcific Lac. [eli-ile].[paragraph break][if dork rod is in ZeroRez]The Tao Boat that helped you get at peace with things is here[else]A Tao Boat rests on the shore, here[end if]."

to say eli-ile:
	if elope pole is in ZeroRez:
		say "That kayak you took to Elided Ile is here, too";
	else:
		say "There's a kayak, too. ";
		if null illun is in ZeroRez:
			say "[one of]And wait! If you look into the distance, you see something! Elided Ile! Just as the Known Wonk said it had to be somewhere! The Wonk's calculations and predictions were all right[or]You see Elided Ile in the distance. Maybe some day, you will get there[stopping]";
		else:
			say "You scan in the distance for anywhere the kayak might take you, but you can't find anywhere, yet";

chapter kayak

The kayak is scenery in Calcific Lac.

chapter tao boat

The Tao Boat is scenery in Calcific Lac.

chapter dork rod

The dork rod is a thing. description is "It's kind of neat and quirky, but it's not shiny enough to be the famed Dorada Rod."

chapter you buoy

the you buoy is a thing.

book Apse Spa

Apse Spa is east of Cold Loc. It is in Grebeberg. "The Apse Spa is covered with dose sod, which you can't take--you're not sick--but it looks beautiful. Also, Go-By Bog expands every way except back west[if sage gas is off-stage]. You could traverse it, if you knew what you were doing[else]You already went through it, though[end if]."

the dose sod is scenery in Apse Spa.

Go-By Bog is scenery in Apse Spa.

chapter sage gas

the sage gas is a thing. [It's found in Apse Spa, but it is not in Apse Spa.]

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

chapter evadeing

evadeing is an action applying to one thing.

understand the command "evade" as something new.

understand "evade [something]" as evadeing.

does the player mean evadeing Dave: it is very likely.

Dave-evade is a truth state that varies.

carry out evadeing:
	if noun is Dave:
		if Dave-evade is true, say "You don't need to evade Dave again.";
		say "You evade Dave! Deked! Deked!";
		now Dave is in ZeroRez;
		now Dave-evade is true;
		score-inc; [Yelpley/evade dave]
		now all davey rooms are available;
	else:
		say "There's only one person you need to evade in this game.";
	the rule succeeds.

book Worn Row

Worn Row is west of My Gym. It is in Yelpley. "[if workrow is true]Three machines are here[else if wordrow is true]A library is here, just full of books[else]It's pretty empty here, but maybe you could make it a bit more active and cheery[end if]."

printed name of Worn Row is "[if wordrow is true]Word[else if workrow is true]Work[else]Worn[end if] Row"

understand "work row" and "work" as Worn Row when workrow is true.
understand "word row" and "word" as Worn Row when wordrow is true.

chapter test set

The test set is a thing.

check taking the test set: say "It's too unwieldy. But it has to be useful for something." instead;

chapter Ian

Ian is a person in Worn Row.

chapter workables

a workable is a kind of thing. a workable has a number called useleft.

the reifier is a workable. useleft is 2.
the reviver is a workable. useleft is 2.
the rotator is a workable. useleft is 3.

to wear-down (w - a workable):
	decrement useleft of w;
	if useleft of w is 0, say "You watch as [the w] sputters and dies. Well, you got a lot of good use out of it, and hopefully you won't need any more.";
	if useleft of w is 1, say "[the w] wheezes emphatically. Hopefully, you won't need to use it too much more.";
	if machuses is 0:
		say "[line break]With [list of workables] all destroyed, Work Row shakes a bit more. The machines fall out from a wall, revealing something behind ... a test set. It's big and huge and you can't move it, but who knows what it'll be useful for later?";

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

a book is a kind of thing. description of a book is "It [if player carries the item described]is[else]looks[end if] really heavy and incomprehensible to you."

section books with purpose so far

TO IDIOT is a proper-named book. [Revolt Lover]
NULL ILLUN is a proper-named book. [Known Wonk]
ERA FARE is a proper-named book. [King Nik]
EMOTE TOME is a proper-named book. [Sniffins]

section books without purpose so far

SOME DEMOS is a proper-named book.
WONDERED NOW is a proper-named book.

gap-yet is a truth state that varies.

after examining a book:
	if gap-yet is false, say "You look for a page gap, and you're surprised there isn't one.";
	now gap-yet is true;
	continue the action;

section book verbs

books-carried-yet is a truth state that varies.

check taking a book:
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

the party trap is a thing. "It looks really complex, like it could trap more than one thing if you USE it right. That would be cool. I mean, if you used it on things that deserved it."

chapter nailing

nailing is an action applying to nothing.

understand the command "nail ian" as something new.

understand "nail ian" as nailing when player is in Worn Row and Ian is in Worn Row.

carry out nailing:
	say "Boom! There goes Ian.";
	move Ian to ZeroRez;
	score-inc; [Yelpley/nail ian]
	the rule succeeds;

chapter workrowing

workrowing is an action applying to nothing.

understand the command "workrow" as something new.

understand "work row" and "workrow" as workrowing when player is in Worn Row.

workrow is a truth state that varies.

ever-workrow is a truth state that varies.

carry out workrowing:
	if Ian is in Worn Row, say "That'll work when Ian is gone." instead;
	if workrow is true, say "You're already in Work Row." instead;
	now workrow is true;
	now wordrow is false;
	say "Three machines [one of][or]re[stopping]appear[if wordrow is true], replacing the books[end if].";
	if ever-workrow is false, score-inc; [Yelpley/work row]
	now ever-workrow is true;
	now all workables are in Worn Row;
	now all books in Worn Row are in TempMet;
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
	if Ian is in Worn Row, say "That'll work when Ian is gone." instead;
	if wordrow is true, say "You're already in Word Row." instead;
	now wordrow is true;
	now workrow is false;
	now all workables are in TempMet;
	if ever-wordrow is false, score-inc; [Yelpley/word row]
	now ever-wordrow is true;
	say "A bunch of books appear.";
	now all books in TempMet are in Worn Row;
	the rule succeeds;

book Art Xtra

Art Xtra is north of Yawn Way. It is in Yelpley. "The only way out is north."

the trap art is a thing in Art Xtra. "Some trap art sits here. It's free. You might as well take it.". description is "The trap art depicts a bunch of nasty, dirty animals being trapped--it's not a real trap, but maybe it could become one."

El Doodle is a thing. "It looks like it could be a map--or something--but it sure could use some paring down."

chapter Mike Kim

Mike Kim is a person in Art Xtra.

chapter soot tattoos

the soot tattoos are a plural-named thing. description is "They're blank now, but maybe if they were the right shape, they could help your image, somehow."

book Toll Lot

Toll Lot is east of Emo Dome. It is in Yelpley. "[if cross orc is in Toll Lot]While it's easy enough to go back west to the Emo Dome, that cross orc doesn't seem to want to let you go north or south[else]You can go north or south with the cross orc gone or, well, back west, too[end if]. A crag arc rises to the east[if UFO tofu is not in ZeroRez]--maybe it is hiding something[end if]."

[??snuff funs]

check going in Toll Lot:
	if cross orc is in Toll Lot:
		if noun is north or noun is south, say "The cross orc stops you from going [noun]. 'GIVE VIG!' it booms." instead;

chapter cross orc

The cross orc is a person in Toll Lot.

chapter crag arc

the crag arc is scenery in Toll Lot. "It soars high and is too dangerous to climb[if UFO tofu is off-stage]. It's so intricate, maybe it is hiding something you can find[end if]."

book Ned's Den

Ned's Den is north of Toll Lot. It is in Yelpley. printed name of Ned's Den is "[if Ned is in Ned's Den]Ned's Den[else]Den, Evened[end if]". description is "[if etage gate is in Ned's Den]An etage gate blocks your way north. You can go back south[else]With the etage gate gone, you can go north or south[end if]."

the etage gate is scenery in Ned's Den. "It is locked and too strong to move."

instead of opening etage gate, try going north;

[instead of unlocking etage gate:
	if player has Ye Key, try useoning Ye Key on etage gate;
	try going north;]

check going north in Ned's Den: if etage gate is in Ned's Den, say "The etage gate blocks you."

understand "evened" and "den evened" as Ned's Den when Ned is in ZeroRez

Ned is a person in Ned's Den.

The Puce Cup is a thing in Ned's Den.

the puce cup can be empty, sappy or soddy. the puce cup is empty.

check taking puce cup: if Ned is in Ned's Den, say "Not with Ned around, you won't." instead;

chapter Gate Tag

the Gate Tag is a thing. "It has an emblem a lot like what you saw north of the Emo Dome."

chapter denting

denting is an action applying to one thing.

understand the command "dent" as something new.

understand "dent [something]" as denting.

does the player mean denting Ned: it is likely.

carry out denting:
	if noun is Ned:
		say "Bam! Bye bye Ned.";
		now Ned is in ZeroRez;
		score-inc; [Yelpley/dent ned]
	the rule succeeds;

book Bon Snob

Bon Snob is south of Toll Lot. It is in Yelpley. "A deli, tiled."

Ira Bari is a person in Bon Snob.

The Gorge Grog is a thing in Bon Snob. "Unsurprisingly, it is a product of Grog-Org."

check taking Gorge Grog: say "Ira Bari chides you. 'It's worthless to us, but if there's anything tackier than bad alcohol, it's people who want to steal it!'[paragraph break]Maybe you could trade something for it." instead;

Nat's Tan is a thing in Bon Snob. "A container of something called Nat's Tan is here."

Le Falafel is a proper-named thing in Bon Snob.

a tame mat is in Bon Snob. "A tame mat reading Bon Snob here."

check taking tame mat:
	say "That would be stealing." instead;

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

Evaded Ave is north of Art Xtra. It is in Yelpley.

the Revolt Lover is a person in Evaded Ave.

the debt bed is a thing in Evaded Ave.

the stock cots are a plural-named thing.

check going in Evaded Ave:
	if Revolt Lover is in Evaded Ave:
		if noun is west or noun is east, say "The Revolt Lover blocks you. Maybe if you gave them a gift, they'd be more generous." instead;

book Trapeze Part

Trapeze Part is west of Evaded Ave. It is in Yelpley. "[if epicer recipe is off-stage]There's a ten level net on the floor, here. It could protect you from a long fall. You're convinced there must be something at the far end, but it's probably not safe to use the trapeze to get over until, well, you've done safety checks[else]The ten level net still sits here, and it'd be handy if there was anything else on the other side of it, but there isn't[end if]."

the ten level net is scenery in Trapeze Part. "[if epicer recipe is off-stage]It doesn't quite look sturdy enough. Maybe you could do something to fix it[else]It was sturdy enough to help you get the epicer recipe, and that's enough[end if]."

the epicer recipe is a thing. description is "You've seen recipes before, but this is a big interesting one! It describes how to make a north-tron, which will get you north of Fun [']Nuf.[paragraph break][tronpartlist]"

to say tronpartlist:
	repeat with Q running through tronparts:
		say "--[t][if player has t] (got it!)[end if][line break]"

chapter tending

tending is an action applying to one thing.

understand the command "tend" as something new.

understand "tend [something]" as tending.

carry out tending:
	if noun is not level net, say "That doesn't need tending." instead;
	if player has epicer recipe, say "You already did what you needed with the net." instead;
	say "You adjust the ten level net. You're not sure how to make it work, but with some common sense, you make it. The set o['] notes gives surprising help. You climb and swing from the trapeze to the other side--falling into the ten level net about a hundred or so times--but the hundred and first bam! You notice an epic-er recipe on the other side.[paragraph break]It's a clear step up from the set o['] notes, which you won't be needing any more. Yay! There's also something labeled an elope pole, which you suspect may help you get away if and when you need to.";
	now player has elope pole;
	now set o notes is in ZeroRez;
	now player has epicer recipe;
	score-inc; [Yelpley/TEND NET]
	the rule succeeds.

chapter elope pole

The elope pole is a thing. description is "It looks foldable, maybe even separable. You wonder where it could help you get."

book Yell Alley

Yell Alley is east of Evaded Ave. It is in Yelpley.

the rep popper is a thing in Yell Alley.

check taking rep popper:
	if player has dork rod, say "With the dork rod, you aren't THAT worried about your rep, but you're still worried enough not to take it. Maybe you can do a bit better..." instead;
	if dork rod is not in ZeroRez, say "No way! You're not sure how much rep you have, but taking that rep popper would drop it a notch or more." instead;

report taking rep popper:
	say "Your experiences in the Tao Boat leave you feeling the rep popper cannot really harm you. Taken.";

chapter back cab

The back cab is a thing in Yell Alley. description is "It's here but doesn't look like you can actually ride it.". "A run-down back cab waits here."

instead of entering back cab, say "Too dumpy."

chapter puffuping

chapter puffuping

puffuping is an action applying to nothing.

understand the command "puffup" as something new.
understand the command "puff up" as something new.

understand "puffup" as puffuping.
understand "puff up" as puffuping.

carry out puffuping:
	if spur ups are in ZeroRez, say "You already did." instead;
	if player does not have spur ups, say "You don't possess anything that would help you feel more up." instead;
	say "As you hold the Spur-Ups, you thik about how great you are and can and will be. Surprisingly, it works! It works so well, you figure you don't even need the spur-ups for a boost in the future. You feel more confident, more able to deal with sadness now.";
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

check going to Emo Dome:
	if pulled-up is true:
		now emo-dir is noun;

check going north in Emo Dome:
	unless player has state tats, say "The Red Roses Order is, like, double-intensity. Just the name leaves you pondering you probably aren't ready for it yet until you're, like, totally ready. As you get close, you are intimidated by a voice: 'DIFF-ID?'[paragraph break]You don't have anything identifying yourself. 'Oh, who? Go jog!' the voice continues. You think, hang? Nah." instead;
	if Red Roses Order is unvisited, say "You step into what may be your final challenge in Yelpley..."

book Red Roses Order

Red Roses Order is north of Emo Dome. It is in Yelpley.

Red Roses Order is above Emo Dome.

Madam is a person in Red Roses Order.

understand "la gal" and "la/gal" as Madam.

book Swept Pews

Swept Pews is south of Emo Dome. It is in Yelpley.

The Liar Grail is a thing in Swept Pews. description is "It's carved with 'LIAR TRAIL? NOT ON!' You don't know if this means there is a liar trail and you can't get there, or there isn't one. Either way, it annoys you enough to want to get rid of the liar grail."

check taking liar grail: say "A small voice cries 'Da cad! Da cad!' You probably don't want the liar grail corrupting you." instead;

check going south when Liar Grail in Swept Pews: say "Maybe there's a path where you could get rid of the grail, but not yet."

chapter Demo Med

a Demo Med is an edible thing in Swept Pews. "A demo med sits here, on a pill lip.". description is "You're not sure what it could be. Xanax? Whatever, you feel calmer just looking at it."

the pill lip is scenery in Swept Pews. "A Demo Med rests on the Pill Lip."

instead of doing something with pill lip, say "The pill lip is just there to prevent the demo med from getting dirty on the ground."

report taking demo med:
	say "The pill lip retracts as you take the demo med.";
	move pill lip to ZeroRez.

chapter troll ort

the troll ort is a thing in Swept Pews.

chapter Tract Cart

The tract cart is a thing in Swept Pews.

book Drawl Ward

Drawl Ward is south of Swept Pews. It is in Yelpley.

Marge Pegram is a person in Drawl Ward. "[one of]'Hi! I'm Marge Pegram. I ain't feeling so good, but I wondered if maybe I could get some medicine.'[or]Marge Pegram continues to moan colloquially about how sick she is.[stopping]"

book Scrap Arcs

Scrap Arcs is east of Drawl Ward. It is in Yelpley.

The gate tag is in Scrap Arcs.

book Dope Pod

Dope Pod is west of Drawl Ward. It is in Yelpley.

the radar is a thing in Dope Pod.

book Pro Corp

Pro Corp is north of Ned's Den. It is in Yelpley.

Pro Corp is above Ned's Den.

chapter gold log

the gold log is a thing in Pro Corp.

chapter dna band and hand

The DNA band is a thing in Pro Corp.

The DNA hand is a thing.

volume gotoing

a room can be notyet, available, cappy, davey, ratsy, pully, tamey, or gatey.

Fun 'Nuf is available.

Seer Trees, Yawn Way, Art Xtra and My Gym are cappy.

Worn Row is davey.

chapter gotoing

gotoing is an action applying to one visible thing.

understand the command "gt" as something new.
understand the command "goto" as something new.
understand the command "go to" as something new.

understand "go to [room]" as gotoing.
understand "goto [room]" as gotoing.
understand "gt [room]" as gotoing.

to decide whether goto-available:
	if player is in Dirge Grid and Diktat Kid is in Dirge Grid, no;
	yes. [obviously we don't want this to be trivial once the game's complete, but we want the code in place.]

carry out gotoing:
	if noun is location of player, say "Already there!";
	unless goto-available, say "You're at a point in the game where goto isn't available." instead;
	if noun is not available, say "[noun] isn't available yet, so you can't go there." instead;
	if noun is available and noun is not visited, say "You can reach [noun], but you haven't visited there, yet. So I'm going to be a stickler and say you have to get there first." instead;
	if noun is Dirge Grid, say "You already beat the Diktat Kid. You don't need to go back." instead;
	move player to noun;
	the rule succeeds;

section gotocheck - not for release

[this is to make sure that rooms are unfolded]

when play begins:
	say "[if number of notyet rooms is 0]All rooms have a switch saying you can go there[else]Rooms that are still notyet: [list of notyet rooms][end if]."

volume unsorted

chapter crap arc

volume metarooms

[there is a little bit of cute code here. Odd Do's score = weird stuff, but it's also where ZeroRez, the collect-all room for used objects, goes. TempMet is for items that temporarily disappear.]

part Odd Do region

ZeroRez is a room in Odd Do.

TempMet is a room in Odd Do.

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
		reg-inc Odd Do; [DIAL AID]
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
		reg-inc Odd Do; [PEEP]
	the rule succeeds;

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
		reg-inc Odd Do; [POOP]
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
	reg-inc Odd Do; [SLAM MAMMALS]
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
	say "All random text for [mytab]:[line break]";
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

chapter endgame

endgameing is an action applying to nothing.

understand the command "endgame" as something new.

understand "endgame" as endgameing.

carry out endgameing:
	say "Giving you all the cool stuff to defeat the Diktat Kid.";
	now player carries all tronparts;
	now player carries murk rum;
	now player carries yard ray;
	now player carries epicer recipe;
	now set o notes is in ZeroRez;
	now Darer Ad is in ZeroRez;
	now elf is in ZeroRez;
	now player has pact cap;
	now Tix Exit is in Fun 'Nuf;
	the rule succeeds;

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

[comment out if/when memory is tight]

include Put It Up Tests by Andrew Schultz.
