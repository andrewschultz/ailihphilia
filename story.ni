"Ailihphilia" by "N. Y. Llewellyn and Sir Apollo Paris"

[blurb for comp = Fit IF: A *GASP* SAGA]

[blurb: It is what you think, you. What, is it? Warning: not recommended for those with aibohphobia.]

[Here are tips on navigating the source code.

First, Ailihphilia Tables.i7x contains all the random responses. It doesn't contain tables for using one item on another. I suppose I could divide things into "random tables" and "tables," but that'd be in the future.
Second, Ailihphilia Tables.i7x contains responses to mistakes e.g. palindrome verbs/phrases that don't advance the game but are good tries.
Third, good tries are all located in Ailihphilia Mistakes.i7x.
There is also Ailihphilia Tests.i7x, but that is probably only of interest to programmers.

There may be tables you want to look at. But searching for them is not so easy. If you want to find the table of big fun, for instance, what will happen is that you'll probably find several lines referencing the table of big fun first. This is slightly inconvenient!

So, my solution was to put an x or two before each of these to find the beginning of a table, ZZ for the end:
START XX/ZZ DIR
CANT for can't-use default messages
USE / GOOD for the table of goodacts (USE X ON Y gives a point, or other things in REV OVER)
UR for use redirect
BKR for bookrejects
PSR for person specific rejects
REJ or FAIL or SUR for Useons that don't work
LAT for later uses
TALK for talk texts
WIN for winning the game
PER for table of periphery
PRE for pre-rules in the table of goodacts
POST for post-rules in the table of goodacts
LLP for last lousy points
SHI for table of shiftables
TSR for table of silly ranks

to search for an item, look for chapter [item].
]

the story headline is "A *GASP* SAGA!"

the release number is 2.

Release along with an interpreter.

Release along with cover art.

include Trivial Niceties by Andrew Schultz.

include Old School Verb Carnage by Andrew Schultz.

include Basic Screen Effects by Emily Short.

[The debug tables were an old file that only listed 2 entries per random text, to make it easier to test the looping case. They're a bit obsolete now that I wrote a function to set random text to just before the looping case, but maybe you'll find the idea useful.]

include Ailihphilia Tables by Andrew Schultz.
[include Ailihphilia Debug Tables by Andrew Schultz.]

include Ailihphilia Mistakes by Andrew Schultz.

include Undo Output Control by Erik Temple.

include Glulx Text Effects - New by Emily Short.

use American dialect.

volume definitions

definition: a thing is moot:
	if it is in DevReserved, yes; [ic]
	no;

definition: a thing is had-or-done: [I'd like to use the "handled" property here, but unfortunately, if you warp through the game, the Note Object Acquisitions Rule doesn't fire. It's easier to do things this way than to search through all the code to drop that rule in.]
	if it is moot, yes;
	if it is carried by the player, yes;
	no;

to moot (Q - a thing):
	if Q is moot and debug-state is true, say "DEBUG NOTE: Oops! Mooting [Q], but it is already in DevReserved.";
	move Q to DevReserved; [ic]

to say hc: say "ch"

to say bb: say "https://bitbucket.org/andrews[hc]ultz/ailihphilia"

to say gh: say "https://github.com/andrews[hc]ultz/ailihphilia"

to say email: say "blurglecrun[hc]eon@gmail.com"

chapter person stuff

a person can be talked-yet. A person is usually not talked-yet.

definition: a person (called per) is npcish:
	if per is the player, no;
	yes;

the player is neuter. the player is female. [I wanted full neutrality but female/male is binary and I want to avoid collisions with NAME ME MAN]

chapter thing properties

a thing can be drinkable. a thing is usually not drinkable.

a thing can be peripheral, semiperipheral or integral. a thing is usually integral. [ semiperipheral allows for USE ON ]

a thing can be ordinary, beepy or llpish. a thing is usually ordinary.

a thing can be beeped. a thing is usually not beeped.

beep-yet is a truth state that varies.
beep-LLP-yet is a truth state that varies.

after examining a not ordinary thing (this is the bee-boo-beeb rule):
	beep-if-vol the noun;
	continue the action;

to beep-if-vol (th - a thing):
	if cap-vol is false, continue the action;
	say "You hear [if beep-yet is false]an odd[else]that weird[end if] [if th is llpish]but very quiet [end if]BEE-BOO-BEEB from [if beep-yet is false]somewhere. It seems like [end if]the inside of your pac[if cap-pace is true]e[else]t[end if] cap[if beep-yet is true] again[end if].";
	now noun is beeped;
	if beep-LLP-yet is false and noun is llpish:
		say "[line break]Hmm. That wasn't very loud. Maybe you don't need to deal with [the th], but it'd be nice.";
		now beep-LLP-yet is true;
	now beep-yet is true;

the cap-beep rules are an object-based rulebook.

a cap-beep rule for a thing (called x):
	if revving-over is false and cap-vol is true, say "You hear a [if x is llpish]bizarre WOO-WAA-WOOW[else]BOO-WEE-WOOB[end if] from the Pact Cap after dealing with [the X][one of]. Well, that jibes with what the Flee Elf said about how it makes weird noises when special actions are needed[or][stopping].[paragraph break]";
	the rule succeeds;

section machine actions

a thing can be rotated. a thing is usually not rotated.

a thing can be revived. a thing is usually not revived.

a thing can be reified. a thing is usually not reified.

section examining

a thing can be nox or xed. A thing is usually nox.

after examining (this is the nox to xed rule):
	if the noun provides the property xed, now the noun is xed;
	continue the action;

section gender stuff

understand "man" as a person when the person is male.
understand "man/woman" as a person when the person is neuter.
understand "woman" as a person when the person is female.

Fun Enuf is a room. [just to be sure where the player starts]

section procedural rules

Procedural rule while eating something: ignore the carrying requirements rule.

section compiler constants

use MAX_VERBS of 560. [-40/50 from max_verbs debug]

use MAX_ACTIONS of 210.

use MAX_VERBSPACE of 5300. [-400 from max_verbspace debug]

use MAX_SYMBOLS of 24000.

section debug compiler globals - not for release

use MAX_VERBS of 610. [290 for 125 mistakes, so, gap of 165 as of 3/10/18]

use MAX_ACTIONS of 230. [+10?]

use MAX_VERBSPACE of 5700. [4096 = original max]

use MAX_SYMBOLS of 25000. [-1000 for release]

chapter room utilities

to decide which number is exit-count of (r1 - a room):
	let ret be 0;
	repeat with DR running through maindir:
		if the room DR of r1 is not nothing, increment ret;
	decide on ret;

to decide which direction is exit-dir of (r1 - a room):
	repeat with DR running through maindir:
		if the room DR of r1 is not nothing, decide on DR;
	decide on up;

chapter kinds of things

section kinds of things

a chaser is a kind of person. a chaser has a room called chase-room. a chaser has a room called stix-room.

a guhthug is a kind of person. [Ian, Rob, Ned, Dave]

a guhthug is usually beepy.

understand "guh/thug/guhthug" and "guh thug" as a guhthug.

a phonebook is a kind of thing. a phonebook is usually proper-named. a phonebook has a number called initseed. a phonebook has a number called curseed. a phonebook has a table name called booktable.

an ingredient is a kind of thing. an ingredient is usually edible. an ingredient can be solid or liquid.

chapter region and room stuff

a region has a number called max-score. a region has a number called cur-score.

Grebeberg is a region. max-score of Grebeberg is 30.

Dim Mid is a region. max-score of Dim Mid is 10.

Yelpley is a region. max-score of Yelpley is 37.

Odd Do is a region. max-score of Odd Do is 11.

the change default appearance for blank rooms rule is listed after the room description body text rule in the carry out looking rules.

carry out looking (this is the change default appearance for blank rooms rule):
	if the description of the location is empty, say "[if number of viable directions is 1]An exit leads[else]Exits lead[end if] [list of viable directions]. NOTE: I need to change this generic text.";
	continue the action;

chapter for (beta) testers

[these are variables that are not used in the final release, but often, they have to be defined in the release, because major verbs use them for debugging purposes.]

LLP-reject is a truth state that varies. [for my own tests: walkthrough with LLPs and without]

LLP-quick is a truth state that varies.

endgame-test is a truth state that varies.

in-beta is a truth state that varies.

aid-detail is a truth state that varies.

debug-verbose is a truth state that varies.

volume i6 modification(s)

section What Do You Want to X

Include (-
Replace LanguageVerb;
-) after "Definitions.i6t".

Include (-
[ LanguageVerb i;
    switch (i) {
      'i//','inv','inventory':
               print "take inventory";
      'l//':   print "look";
      'x//':   print "examine";
      'z//':   print "wait";
	 'about':  print "see info about the game";
	 'aid': "ask for AID";
	 'balm lab', 'balmlab':  print "change a lab";
	 'boob', 'pap', 'poop': print "swear palindromically";
	 'credits': print "see the credits";
	 'dial aid': "dial AID";
	 'deep speed', 'deepspeed':  print "deep-speed through the game";
	 'dev ed', 'deved':  print "read about development with DEV ED/DEVED";
	 'epi wipe', 'epiwipe':  print "wipe (epically) records of what you've examined";
	 'grammar g':  print "toggle KAOS Oak grammar";
	 't', 'greet', 'ta', 'talk': print "talk to";
      'gt', 'go to', 'goto':   print "go to";
	 'help':  print "ask for HELP";
	 'love vol', 'lo vol', 'lovol', 'lovevol':  print "tweak the pact cap";
	 'niwin':  print "list game warping actions with NIWIN";
	 'map':  print "look at the MAP";
	 'mem':  print "MEMory recall some things";
	 'meta':  print "read META commands";
	 'pace cap', 'pacy cap':  print "toggle the pack cap";
	 'pack cap':  print "pick up the pack cap";
	 'puffup':  print "puff up";
	 'pullup':  print "pull up";
      'rad':   print "scan with the radar";
      'rei':   print "put in the reifier";
      'rot':   print "put in the rotator";
      'rev':   print "put in the reviver";
	 'sce recs', 'scerecs':  print "see recommended unexamined scenery";
	 'shuttuhs':  print "toggle shuttuhs/shutters";
	 'stats':  print "get stats/the score";
      'tip it', 'tipit': print "tip off one game progress activity";
	 'v//', 'verbs', 'verb':  print "see basic verbs";
      'wordrow', 'wornrow', 'workrow', 'worn row', 'work row', 'word row': print "twiddle Worn Row";
      'yakokay', 'yak okay': print "tell the kayo yak OKAY";
	 'xyzzy', 'plugh': print "say a silly spell";
      default: rfalse;
    }
    rtrue;
];
-) after "Language.i6t".

section something dramatic has happened bug

[this is to fix GET ALL in Emo Dome when there is only 1 thing to get. It appears to be a bug in the core, fixed in later versions of Inform.]

Include (-

[ GenerateMultipleActions initial_location k item;
	initial_location = location;
	for (k=1: k<=multiple_object-->0: k++) {
		item = multiple_object-->k;
		RunParagraphOn();
		if (inp1 == 0) { inp1 = item; BeginAction(action, item, second, item); inp1 = 0; }
		else { inp2 = item; BeginAction(action, noun, item, item); inp2 = 0; }
		if (deadflag) return;
		if ((location ~= initial_location) && (k < multiple_object-->0)) { L__M(##Miscellany, 51); return; }
	}
];

-) instead of "Generate Multiple Actions" in "OrderOfPlay.i6t".

section KAOS Oak NoNsEnSe

Include (-

Array kaos --> 7  11 1 15 19 15 1 11;

[ kaosblab i j;
  if ( (+ grammarg +) == 1) {
    print "KAOS Oak";
	rfalse;
  }
  j = (+ kaos-num +);
  for (i = 1: i < 8: i++) {
	print (char) (64 + kaos-->i + 32 * (j % 2));
	if (i == 4) { print " "; }
	j = j / 2;
  }
  rfalse;
];

-)

to say kaoscaps:
	kaos-adj;
	say "[kcb]";

to say kcb:
	(- kaosblab(); -)

to kaos-adj: now kaos-num is 1 + the remainder after dividing (kaos-num + a random number between 1 and 126) by 127;

kaos-num is a number that varies.

volume parser simplification

chapter oldschooling

understand "taste" as eating.
understand "taste [thing]" as eating.

carry out os2ing: try oldschooling instead;

check oldschooling:
	say "[chase-pass]An old school verb like [word number 1 in the player's command] isn't strictly necessary in this game. See [verb-suggest] for what is used/useful." instead;

chapter hug/kiss why not

chapter huging

huging is an action applying to one thing.

understand the command "hug" as something new.

understand "hug [something]" as huging.

carry out huging:
	say "Hug? Uh...";
	the rule succeeds.

instead of kissing, say "[one of]XOXOX[or]OXOXO[or]Hug? Uh[at random]!"

volume room specifications

chapter room-dist and loc-num sorting out

a room has a number called loc-num. loc-num of a room is usually -1. loc-num of Fun Enuf is 23. [loc num = 10 * south of lac + 1 * east of lac]

a room has a number called room-dist. room-dist of a room is usually -1. room-dist of Fun Enuf is 0. [room-dist = # of rooms you are away from Fun 'Nuf]

a direction has a number called locdelt. locdelt of a direction is usually -1. locdelt of west is -1. locdelt of east is 1. locdelt of north is -10. locdelt of south is 10.

a room has a direction called in-dir. in-dir of a room is usually down.

to decide which direction is out-dir of (rm - a room):
	decide on opposite of in-dir of rm;

to decide which room is in-room of (rm - a room):
	if rm is in Odd Do or rm is in Dim Mid, decide on rm;
	let idr be in-dir of rm;
	decide on the room idr of rm;

when play begins (this is the procedural room number assignments rule): assign-room-dist-and-loc Fun Enuf;

to visit-up-to (rm - a room):
	if rm is visited or in-dir of rm is down, continue the action;
	now rm is visited;
	visit-up-to the room (in-dir of rm) of rm;

to assign-room-dist-and-loc (j - a room):
	let k be room-dist of j + 1;
	[say "Sniffing out [j] room-dist [k - 1] locdelt [loc-num of j].";]
	repeat with Q running through maindir:
		let Q2 be room Q of j;
		unless Q2 is nowhere or room-dist of Q2 > -1:
			now room-dist of Q2 is k;
			now loc-num of Q2 is loc-num of j + locdelt of Q;
			now in-dir of Q2 is opposite of Q;
			assign-room-dist-and-loc Q2;
[		else:
			say "-->[Q] failed in [j]: to [Q2] [unless Q2 is nowhere]room-dist = [room-dist of Q2] locnum = [loc-num of Q2].";]

chapter internal mapping

index map with Dirge Grid mapped east of Toll Lot.

volume unsorted

to say etg:
	say "[paragraph break]    * * * Deliverer? Re-reviled! * * *[paragraph break]";
	wfak;
	say "Eh, nah, that's too mean. Let's pretend that didn't happen.[paragraph break]";
	wfak;
	say "[b][location of player][r][paragraph break]";

section helpdocs

a helpdoc is a kind of thing. a helpdoc has a number called importancy. the indefinite article of a helpdoc is usually "the".

before printing the name of a helpdoc while taking inventory:
	if Dave is off-stage, say "the ";
	continue the action;

after printing the name of a helpdoc (called hd) while taking inventory:
	if hd is not xed, say " [b](unread yet)[r]";
	continue the action;

to say other-docs:
	let L be the list of still-useful helpdocs carried by player;
	sort L in reverse importancy order;
	say "the [L]";

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

description of a tronpart is usually "The [item described] is one of [number of tronparts in words] parts needed for the North-Tron. This is a bad default and should be changed."

volume the player

description of player is "Flesh. Self.". initial appearance of player is "U R U".

does the player mean dropping the trap art: it is likely;
does the player mean dropping the party trap: it is likely;

rule for supplying a missing noun when dropping:
	if player has trap art, now noun is trap art;
	if player has party trap, now noun is party trap;

check dropping:
	if player is in Ooze Zoo and sleep eels are in Ooze Zoo:
		if noun is bunk nub or noun is stock cots,
		say "Dropping might be too rough, so you look for ways to USE the [noun] on the sleep eels.";
		try useoning noun with sleep eels instead;
	say "An unseen voice whispers 'Keep! Eek!' There is no met-ill item in this game. In other words, you don't need to drop anything[if party trap is not moot], though dropping is an alternative solution in one puzzle[end if]. Most items will disappear from your inventory once they're no longer useful." instead;

to decide which region is mrlp:
	decide on map region of location of player;

part scoring and turn count

chapter mostly scoring

to score-inc:
	if debug-state is true, say "DEBUG standard score-inc.";
	reg-inc mrlp;

when play begins:
	let rank-count be 0;
	let rank-score be 0;
	sort table of silly ranks in random order;
	sort table of silly ranks in pre-prio order;
	repeat through table of silly ranks:
		increment rank-count;
		now rank-score is ((min-win - 5) * rank-count) / (number of rows in table of silly ranks);
		increment rank-score;
		now max-sco entry is rank-score;
		if debug-state is true, say "[rank-count] ([the-rank entry]) is your rank up to [max-sco entry].";

rank-track-note is a truth state that varies.
rank-track is a truth state that varies.

to decide which number is rank-row:
	if main-score is 0, decide on 0;
	let temp be 0;
	repeat through table of silly ranks:
		increment temp;
		if max-sco entry >= main-score, decide on temp;
	if main-score is min-win, decide on temp + 1;
	decide on temp;

to say give-rank:
	say ". You've found [main-score] necessary points, giving you a (nonsensical) rank of ";
	if main-score is 0:
		say "ebohphobe[if score > 0] (but not completely)[end if]";
	else if main-score >= min-nec - 1:
		say "tsilihphilist";
	else if main-score >= min-nec - 4:
		say "eilihphile";
	else:
		repeat through table of silly ranks:
			if max-sco entry >= main-score:
				say "[the-rank entry]";
				if rank-track-note is false:
					now rank-track-note is true;
					say " (rank changes can be tracked with [b]SCO DOCS[r], or you can see them all at game's end)";
				continue the action;
		say "(guuu... buuug)";

table of silly ranks [xxtsr]
pre-prio	max-sco	the-rank [pre-prio exact numbers aren't important. It's just that there should be certain ones at the end for the second sort-through.]
-10	0	"de-ug-no-tongue'd"
0	--	"rednifinder"
0	--	"tsigologist"
0	--	"revitalativer"
0	--	"rezippuppizer"
0	--	"cainamaniac"
0	--	"rekampmaker"
0	--	"cilohaholic"
0	--	"res. opposer"
7	--	"c-it's-a-[']tastic"
8	--	"ruenerpreneur"
9	--	"resists-iser"
10	--	"de-lytse-styled" [delights ... geddit?]

check requesting the score:
	say "Your overall score so far is [score] of [maximum score] in [turn count] [if turn count is nontrivially-palindromic](!) [end if]turn[plur of turn count][if score < 4]. But don't worry, points pile up pretty quickly once you get going[end if]. [to-get-max][give-rank].";
	say "[line break]Broken down by regions, you have [regres of Dim Mid], [regres of Grebeberg], [regres of Yelpley] and [regres of Odd Do]. Note some acts you can perform in one region may be scored for another.";
	if My Gym is visited or Evaded Ave is visited:
		let nmg be number of moot guhthugs;
		if number of guhthugs is not nmg, say "[line break][if nmg is 0]You haven't gotten any guh-thugs out of the way yet[else]You currently disposed of [number of moot guhthugs] guh-thug[plur of nmg] blocking your way: [list of moot guhthugs][end if].";
	if Yuge Guy is moot, say "[line break]You've gotten rid of the Yuge Guy.";
	if Ms Ism is moot, say "[line break]You've gotten rid of La Gal/Ms. Ism.";
	if player has x-ite tix:
		let Q be roving-LLP;
		let Q2 be fixed-LLP;
		if Q is 0 and Q2 is 0:
			say "[line break]Now you're in [Fun Enuf] and have all the points, there's seemingly not much to do but go south through the Tix Exit.";
		else if Q is 0:
			say "You've got all the roving LLPs. You have [Q2] non-roving LLP[plur of Q2] remaining to figure out before going [if player is not in Fun Enuf]back to [Fun Enuf] and [end if]south through the Tix Exit.";
		else:
			say "You have [Q] roving last lousy point[plur of Q] left and [Q2] non-roving LLP[plur of Q2] left.";
	if player has epicer recipe and KAOS Oak is not moot:
		say "[if epicer recipe is nox]You realize a score is only an abstract indicator of how well you're doing, and maybe that epicer recipe would help you figure what's what. So you read it, and you note y[else]Y[end if]";
		say "ou [if tron-got is 0]don't have any of the [number of tronparts in words][else]also have [tron-got] piece[plur of tron-got] of [number of tronparts][end if] North-Tron pieces you need to destroy the [kaoscaps], according to the epicer recipe[hint-tron].";
		now epicer recipe is xed;
	if mist-found > 0, say "[line break]You've also found [mist-found] of [number of entries in checkoffs] palindromes that were there but not critical to the story. [if mist-found * 2 > number of entries in checkoffs]Very impressive! You've earned whatever hints you've gotten or used[else]This won't affect the ending in any way, but the more you find, the more clues you can get, so hopefully it will be fun[end if].";
	if score-cheat > 0, say "[line break]Also, you used a warp command or commands to plow past [score-cheat] point-giving activities, but I won't hold it against you. I'm glad you were motivated to try and see the end!";
	if stats-yet is false, say "[line break]In addition, there may be a more 'correct' five-letter way to request all the numbers above, and so forth. It's not critical, but you might get a style point.";
	the rule succeeds;

to decide which number is tron-got:
	if KAOS Oak is moot, decide on number of tronparts + 1;
	let temp be number of tronparts carried by player;
	if martini tram is in Fun Enuf, increment temp;
	decide on temp;

to say to-get-max:
	if cur-score of Odd Do is max-score of Odd Do:
		say "You got all LLPs";
	else:
		say "You need at least [min-win] to win[if cur-score of Odd Do > 0], since you got [cur-score of Odd Do] bonus point[plur of cur-score of Odd Do][end if]"

to decide which number is min-win:
	decide on maximum score - max-score of Odd Do + cur-score of Odd Do;

to decide which number is min-nec:
	decide on maximum score - max-score of Odd Do;

this is the LLP rule:
	if LLP-reject is true, the rule succeeds;
	let prev-rov be roving-LLP;
	reg-inc Odd Do;
	if player has x-ite tix and prev-rov is 1 and roving-LLP is 0, say "You have all the roving LLPs. You can go back to [Fun Enuf] now.";

to reg-inc (re - a region):
	now last-move-scored is turn count;
	if debug-state is true and re is not Odd Do and re is not mrlp, say "DEBUG NOTE: scored [re] point in [mrlp].";
	increment cur-score of re;
	increment the score; [this is the only incidence that shouldn't be replaced]
	if debug-state is true:
		say "DEBUG: player in [mrlp], increased points for [re].";
		say "DEBUG TALLY: Grebeberg [cur-score of Grebeberg] Yelpley [cur-score of Yelpley] Dim Mid [cur-score of Dim Mid] Odd Do [cur-score of Odd Do], useful points = [main-score].";
		if cur-score of mrlp > max-score of mrlp, say "DEBUG WARNING: REGION SCORE TOO HIGH!";
		if debug-state is true and score > maximum score, say "DEBUG WARNING: OVERALL SCORE TOO HIGH!";
		if mrlp is not re and re is not Odd Do, say "DEBUG WARNING: potential region misdirected point!";
	consider the shuttuhs-after-scoring rule;

to say regres of (re - a region):
	say "[cur-score of re] of [max-score of re] ";
	if re is Odd Do:
		say "extra points";
	else:
		say "for [re][if mrlp is re] (current region)[end if]"

section new weird score

the LLP or normal score changes rule is listed instead of the notify score changes rule in the turn sequence rulebook.

LLP-last is a number that varies.

This is the LLP or normal score changes rule:
	if the score is not the last notified score:
		say "[bracket][if cur-score of Odd Do > LLP-last]You found [a-verylast] Last Lousy Point![close bracket][else]Your score has just gone up by one point[notify-rank-bump].[close bracket][end if][paragraph break]";
		now the last notified score is the score;
		now LLP-last is cur-score of Odd Do;

prev-rank-row is a number that varies.

to say notify-rank-bump:
	let got-main be whether or not LLP-last is cur-score of Odd Do;
	if rank-row > prev-rank-row and got-main is true and rank-track is true:
		say ", and you gained a rank, too";
		now prev-rank-row is rank-row;

to say a-verylast: say "[if cur-score of Odd Do is max-score of Odd Do]the very last[else]a[end if]"

section scodocsing

rank-track is a truth state that varies.

scodocsing is an action applying to nothing.

understand the command "sco docs" as something new.
understand the command "scodocs" as something new.

understand "scodocs" and "sco docs" as scodocsing.

carry out scodocsing:
	now rank-track is whether or not rank-track is false;
	say "Documenting score ranks is now [on-off of rank-track].";
	the rule succeeds.

chapter turn count

every turn (this is the don't increment trivial turns rule):
	if action is procedural or chase-mulligan is true:
		if debug-state is true, say "DEBUG: no turn count added: [if chase-mulligan is true]Chase mulligan![else][current action] is a procedural action.[end if]";
		decrement turn count;

the don't increment trivial turns rule is listed first in the every turn rulebook.

definition: a number (called n) is nontrivially-palindromic:
	if n < 100, no;
	let cutnum be n;
	let revnum be 0;
	while cutnum > 0:
		now revnum is revnum * 10;
		increase revnum by the remainder after dividing cutnum by 10;
		now cutnum is cutnum / 10;
	if revnum is turn count, yes;
	no;

this is the check palindrome turns rule: [this could be at the end but those are item based rules]
	if KAOS Oak is not moot, continue the action;
	let revnum be 0;
	let cutnum be turn count;
	say "Final stats (score/turn/maximum score): [score]/[turn count]/[maximum score].";
	if Yawn Way is unvisited, say "Because you zipped through the quest, you get impatient when you're unable to open it when you get home. You throw it in a dumpster and spend the rest of your life upset at the universe for not letting you save a more interesting, violent fantasy world." instead;
	say "[line break]When you get home, you hear a click from the X/O box. Yes, you can open it now.[paragraph break]";
	if turn count is nontrivially-palindromic:
		if score is maximum score:
			say "Inside is a spiffy CERT REC for being cosmically in tune and covering even the smallest details. On the other side is an interesting tenet--an antimetabole that changes magically every day. It is a rec indeed nicer. Well done!";
			choose row with final response activity of loafing in table of final question options;
			blank out the whole row;
			continue the action;
		say "[sox]. Yet you feel you did something weird right, beyond fixing every small thing in Yelpley and Grebeberg, which you didn't [if score > 84]quite [end if]do.";
	else if score is 88:
		say "Wow! You did everything you could, you think. [sox].[paragraph break]You have a vision of Grebeberg and Yelpley being, well, not quite perfect as they could be years down the line. You probably missed out on some sort of style points. Well, it's too late now. And maybe someone else will have fun going there and fixing things back up.";
	else:
		say "[sox]. Well, you had a feeling you left a few things undone."

to say sox: say "As you open it, you see a nice, spiffy tenet. An antimetabole (look it up) that somehow magically changes every day. It's nice, but it still feels a bit like getting socks for your birthday"

the check palindrome turns rule is listed instead of the print final score rule in for printing the player's obituary.

part when play begins

to say dir-summary:
	let Q be the room north of location of player;
	if Q is not nowhere, say " N[run paragraph on][if Q is not available]-[else if Q is not visited]![run paragraph on][end if]";
	let Q be the room south of location of player;
	if Q is not nowhere, say " S[run paragraph on][if Q is not available]-[else if Q is not visited]![run paragraph on][end if]";
	now Q is the room east of location of player;
	if Q is not nowhere, say " E[run paragraph on][if Q is not available]-[else if Q is not visited]![run paragraph on][end if]";
	now Q is the room west of location of player;
	if Q is not nowhere, say " W[run paragraph on][if Q is not available]-[else if Q is not visited]![run paragraph on][end if]";

read-intro is a truth state that varies.

when play begins (this is the begin ailihphilia for reals rule):
	now eyespoil of tix exit is number of rows in table of goodacts; [the flee elf gives you the clue right off the bat]
	repeat with Q running through regions:
		increase maximum score by max-score of Q;
	if debug-state is true:
		say "DEBUG NOTE: Maximum score is [maximum score].";
		say "[if max-score of Odd Do is number of rows in table of last lousy points]LLPs = LLP table rows[else]Uh oh, [max-score of Odd Do] Odd Do points and [number of rows in table of last lousy points] LLP table rows. We need to fix this[end if].";
	now right hand status line is "[if cur-score of mrlp < 10] [end if][cur-score of mrlp]/[max-score of mrlp] [if score < 10] [end if][score]/[if min-win < maximum score][min-win]-[end if][maximum score]";
	now left hand status line is "[location of player] ([mrlp])[dir-summary]";
	say "First, would you like to see the introduction (I), restore a previous game (R), or skip the introduction (S)?";
	intro-restore-skip;
	now use-custom-screenread is true; [see the Trivial Niceties extension for details. This wipes TN's default generic nag question.]
	say "Next, are you using a screen reader? Some of Ailihphilia's features, like the text map, don't work well with them.";
	if the player no-consents, now screenread is true;
	say "[line break]You can always toggle the screen reader with SCR.";
	sort table of last lousy points in random order;
	repeat through table of all randoms:
		sort tabnam entry in random order;
	now initseed of Name ME Man is a random number between 0 and prime-constant / 2 - (number of rows in table of random palindrome lastfirst names);
	now initseed of Oh Who is a random number between prime-constant / 2 + 1 and prime-constant - (number of rows in table of random palindrome firstlast names);
	if read-intro is false, continue the action;
	say "[line break]It's not your first dream about how awful high school was, but it's the worst in a while. A few 'favorite' classmates chanting 'Diary raid!' and passing it around as they mock 'Beefy? Feeb! Bony Nob!' Of course, you never HAD a diary in high school, but that doesn't matter.[wfak]";
	say "You check your mail as you go out to the grocery store. A junk-mail magazine! It's been so long since you got one, you're almost intrigued.[wfak]";
	say "It just says GAME MAG. But the cover isn't telling you to actually buy anything, so you look inside. You have a whole backlog of games, but you can just recycle it when you get to the store. No, not the erot-store![wfak]";
	say "Nothing really catches your mind until you see a DARER AD. It's a bit vague, but it catches your eye.[wfak]";
	say "[fixed letter spacing](MA'AM)/ SIR, TETRIS?!                    EVIL'S LIVE![line break]LIVE DEVIL!                               BOSSES! SOB![roman type][line break][wfak]";
	say "You fold the Darer Ad and start off to the store.[paragraph break]'[unicode 161]Aloha. Hola!' someone, or something, cries. 'Steer-greets! Steer-greets!'[paragraph break]You run in the general direction of the voice. You look up, and you're no longer on the way to the store. You're somewhere else. Your smartphone starts blinking: LOAD AOL! You look up. Who is responsible for this? Someone/something who sees you futzing with your smartphone. 'No El Google on?' You nod. Awkward silence. 'Poll op! Poll op!' the someone/something continues.[wfak]";
	say "'I'm the Flee Elf. Name, man? Eve? Pip? Otto? Anna? Bob? Nan? Aviva? Hannah? Elle? Ebbe?' The elf grows more desperate. 'Reinier? Lieseil?' You back away--it doesn't seem to care if you're male or female, but it's a persis-rep. And you realize YOU weren't paying attention to ITS gender.[wfak]";
	say "There's a bit more of this narrative nonsense, if you're into that sort of thing. Would you like to see it? I won't be hurt if you say no.";
	if the player yes-consents:
		say "'Mind Nim?' You shrug. 'Put it up.' You win several games in a row, because you looked up the winning strategy on the Internet after it confused you. 'Hanoi? On, ah!' the Flee Elf says. You quickly shuffle five-high towers. Then 'Is reversi...?'";
		say "After your fifth win in a row, the Flee Elf yells 'GRAAAARG!' You stumble back and fall to the ground.[wfak]";
		say "The Flee Elf gives a mournful headshake. 'Lame? Mal. Not physical enough for Ares[']s Era, Raw Level War, Rebus: Uber, Base Sab, (Wo)Men O['] Venom (Ow), Dragons O['] Snogard or Mista-T Sim. Mega-Tag [']Em?'[wfak]";
		say "You chase the Flee Elf around a few minutes, failing to catch it. '[']S poor. Oops!' The Flee Elf thinks for a minute. '[Fun Enuf] is open.'[wfak]";
	else:
		say "After more tedious palindrome riffing, the Flee Elf deems you most suitable (or least unsuitable) for the relatively obscure bunker called [Fun Enuf].[wfak]";
	say "The Flee Elf points to a cap. 'This here isn't any cap. It's a PACT cap. And you can't quite TAKE it. You have to do something else.'[wfak]";
	say "[paragraph break]([b]NOTE[r]: if you want to know more about Ailihphilia and the commands used, type [b]ABOUT[r].)[paragraph break]";
	do nothing; [debug information below here. I've had problems putting it in and not deleting it, so I want to make things clear.]

after looking in Fun Enuf for the first time:
	if read-intro is false:
		say "[bracket][b]NOTE[r]: though you opted to skip the introduction, you may still wish for [b]ABOUT[r] or [b]VERBS[r] as a refresher.[close bracket][line break]";
		continue the action;

section when play begins - not for release

[diagnostic stuff I don't want to reveal to the player]

volume parser errors operations and death

check saving the game: say "Eh, cache...";

check quitting the game: say "Aibohphobia?!";

check restarting the game: say "Warp ... raw.";

part parser errors

chapter nothing to say

nothing-txt is a number that varies.

parser error flag is a truth state that varies.

Rule for printing a parser error when the latest parser error is the nothing to do error:
	say "It looks like you tried a command like TAKE ALL, but nothing registered as something you could take. While the game individually rejects taking individual scenery, ALL only looks at what you can realistically take."

the last-command is indexed text that varies.

Rule for printing a parser error when the latest parser error is the noun did not make sense in that context error:
	if word number 1 in the player's command is "go" or word number 1 in the player's command is "gt":
		say "I didn't recognize the room, and unfortunately, I don't recognize GO TO (item or person)[if screenread is false]. You may wish to use the Pyx for that[end if].";
		the rule succeeds;
	if the player's command includes "yak" and yak is quicknear:
		say "[if being-chased is true]The yak blinks. Perhaps a different command would work[else]The yak seems lazy. Maybe it needs to be prodded right, first[end if]." instead;
	say "The object didn't mix well with the verbin your command. I wish I could give more help, but you're likely trying something more obscure than you need to."

Rule for printing a parser error when the latest parser error is the only understood as far as error:
	let nw be number of words in the player's command - 1;
	if nw > 6:
		now nw is 6;
	say "That command seemed like it was longer than it needed to be, or maybe the last word was a typo [one of](e.g. Set O Notes vs. Set o Totes.) [or]. [stopping]You may wish to cut a word or two down. Push 1 to retry [word number 1 in the player's command in upper case][if nw > 1], or a higher number to re-try only the first [nw] words of your command, or 9 to cut off the final word[end if]. Or just push any other key to pass and try another command.";
	let Q be the chosen letter;
	if Q is 57 and nw > 1, now Q is nw + 47; [9 = special case]
	if Q >= 49 and Q <= 48 + nw: [since it's ascii, 49 = the number 1]
		now parser error flag is true;
		now the last-command is "[word number 1 in the player's command]";
		let temp be 50;
		while temp <= Q:
			now the last-command is "[the last-command] [word number temp - 48 in the player's command]";
			increment temp;
		say "OK, new command: [the last-command in upper case].";
		the rule succeeds;
	else:
		say "OK. If you change your mind, you can up-arrow and backspace to erase the last word.";
	the rule succeeds;

to cut-command-down:
	say "[line break]";
	now parser error flag is true;
	now the last-command is "[word number 1 in the player's command]";

Rule for reading a command when the parser error flag is true:
	d "Reading [last-command].";
	now the parser error flag is false;
	change the text of the player's command to the last-command.

Rule for printing a parser error when the latest parser error is the i beg your pardon error:
	next-rand table of nothings;
	consider the notify cycling rule;

Rule for printing a parser error when the latest parser error is the can't see any such thing error:
	if player is in Worn Row:
		if the player's command includes "cart" and Worn Row is worky, say "You need to summon Word Row back before doing anything with the cart." instead;
		if ever-wordrow is true or ever-workrow is true, say "You can't see any such thing--but in case you're looking for something from another configuration of Worn Row, you don't see why you couldn't call back [if ever-wordrow is true and Worn Row is worky]Word Row[else if ever-workrow is true and Worn Row is wordy]Work Row[else]Worn Row[end if]." instead;
	if bees-seen is false and player is in Moo Room:
		if the player's command matches the regular expression "bee(s)?", case insensitively:
			say "You can't (quite) [one of]spot[or]look at[or]view[in random order] anything like that here.";
			the rule succeeds;
	if player is in Worn Row and Worn Row is worky and the player's command matches the text "machine":
		say "You need to refer to each machine by its proper name.";
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
		if the player's command matches the text " [Y]", case insensitively: [?? not perfect--try a regex to be super done. But this avoids misstakenly flagging USE in Uneven U]
			if player is in Worn Row and row-prog < 3, say "Yes. [Worn Row] can become something else. But what?" instead;
			say "It looks like you tried to do something with [if myr is location of player]this[else]an adjacent[end if] location. [row-clue], [if balm-LLP-yet is true]and you got the sneaky obscure bonus point for doing so elsewhere[else]and while there's another place that gets an obscure bonus point, location names are generally just to describe unnecessary scenery[end if].";
			if gone-to is false, say "[line break]However, GO TO/GT (room or thing) may be a nice shortcut to visit a previous location.";
			the rule succeeds;
	continue the action;

to say row-clue:
	if row-prog is 0:
		say "There's only one place you need to do this";
	else if row-prog > 1:
		say "You found the place where you need to twiddle things";
	else:
		say "You've half twiddled [Worn Row]";

Rule for printing a parser error when the latest parser error is can only do that to something animate error:
	if debug-state is true, say "DEBUG: [noun] [second noun][if noun is ti or second noun is ti]--OK, got one[end if].";
	continue the action;

chapter unrecognized verb

to say verb-suggest: say "[b]V[r]/[b]VERB[r]/[b]VERBS[r]"

Rule for printing a parser error when the latest parser error is the didn't understand error or the latest parser error is the not a verb I recognise error:
	if player is in Lair Trial and kayo yak is in trial lair:
		if the player's command includes "yak" or the player's command includes "kay":
			say "The yak makes a weird noise, which surprises you and the ergot ogre. Maybe you said things wrong. The right thing to say can't be too complex." instead;
	if player has spur ups:
		if the player's command includes "spur", say "You look at the spur ups, unsure how to use them. It's more that they're, well, UP than SPURs." instead;
		if number of words in the player's command > 1:
			if word number 2 in the player's command is "ups", say "There is only one you, so you only need to be, or do something, UP." instead;
			if word number 2 in the player's command is "up", say "Hmm, not the right way to be or do UP, but something must work." instead;
	if flee elf is in fun enuf and the player's command includes "cap":
		say "The Flee Elf cocks its head. 'Y'r try ... not quite. Do something with the cap, though.'" instead;
	say "[if gtv]You do need a special verb here to deal with [random guhthug in location of player], but not that one. It may not be a standard one, but given the game's theme, I bet you can figure it out. If you want standard verbs, y[else]I didn't recognize that action. Y[end if]ou can type [verb-suggest] to get a list of them[if cur-score of Odd Do < 11], and there are a few you can guess for bonus points[any-here][end if].";

to say any-here: say "[if LLP-now], including one right here[else if fixed-LLP > 0], including [fixed-LLP in words] available anywhere[end if]"

to decide whether LLP-now:
	if player is in Moo Room:
		if senile felines are in Moo Room or bees-seen is false, yes;
	if player is in Ooze Zoo and slam-mam is false, yes;
	if player is in Le Babel and opossum is in Le Babel, yes;
	if player is in Worn Row and Worn Row is wordy and DWELT LEWD is off-stage, yes;
	if player is in Pro Corp and balm-LLP-yet is false, yes;
	no;

to decide whether gtv:
	if number of guhthugs in location of player > 0, yes;
	no;

part after command

period-warn is a truth state that varies.
say-warn is a truth state that varies.

after reading a command:
	if period-warn is false:
		if the player's command matches the text ".":
			say "NOTE: Periods mean separate moves. If you want to move around quickly, use GT (room).";
			now period-warn is true;
	if in-beta is true and the player's command matches the regular expression "^<;\*>":
		say "(Noted.)[paragraph break]";
		reject the player's command;
	let XX be indexed text;
	if the player's command matches the regular expression "<A-Z>":
		let XX be the player's command;
		change the text of the player's command to "[XX in lower case]";
		if debug-state is true, say "(LOWERCASING) [XX][line break]";
	if the player's command matches the regular expression "^say ":
		if say-warn is false:
			now say-warn is true;
			say "NOTE: you never need to SAY anything. Just type it in. In other words, WHOAH is the same as SAY WHOAH. Ailihphilia will cut SAY off of the start of all commands.";
			let XX be the player's command;
			replace the regular expression "^say " in XX with "";
			change the text of the player's command to XX;
	if player is in uneven u and the player's command matches the regular expression "dr\. ?d":
		say "(replacing the period in Dr. D)[paragraph break]";
		let XX be the player's command;
		replace the regular expression "dr\. ?d" in XX with "dr d";
		change the text of the player's command to XX;
	if ti is quicknear:
		if the player's command matches the regular expression "to$":
			replace the regular expression "to$" in XX with "ti";
			change the text of the player's command to XX;
			if debug-state is true, say "(DEBUG NOTE) (TO -> TI) Changed to: [XX].";
		if the player's command matches the text "to idiot":
			let XX be the player's command;
			replace the text "to idiot" in XX with "ti";
			change the text of the player's command to XX;
			if debug-state is true, say "(DEBUG NOTE) (TO IDIOT -> TI) Changed to: [XX].";
	if phonebook-near:
		if the player's command matches the regular expression "<0-9>-<0-9>" or the player's command matches the regular expression "<0-9>{7}":
			say "(assuming you're trying to make a phone call)[paragraph break][no-calls]!'";
			reject the player's command;
	if the player's command matches the text "-":
		if debug-state is true and word number 1 in the player's command is "test":
			do nothing;
		else:
			let XX be the player's command;
			replace the regular expression "-" in XX with " ";
			change the text of the player's command to XX;
			if debug-state is true, say "(DASH TO SPACE) Changed to: [XX].";
	if the player's command matches the regular expression "<^-\.a-z 0-9>":
		if no-punc-flag is false:
			say "(NOTE: you don't need to use anything but letters to get through the game. Even commas for addressing NPCs aren't necessary. The parser simply strips out non-alphabetic characters.)[paragraph break]";
			now no-punc-flag is true;
		let XX be the player's command;
		replace the regular expression "-" in XX with " ";
		replace the regular expression "<^-\.a-z 0-9>" in XX with "";
		change the text of the player's command to XX;
		if debug-state is true, say "(PUNCTUATION REMOVAL) Changed to: [XX][line break]";
	repeat through table of homonym rejects:
		if to-reject entry is quicknear and the player's command exactly matches the text "[mytxt entry]":
			say "A homonym is a good try, but you need to do something more active with [the to-reject entry][if there is a longer-desc entry]. [longer-desc entry][end if].";
			reject the player's command;
	if the player's command includes "all":
		unless the player's command includes "get" or the player's command includes "take":
			say "Ailihphilia currently blocks using ALL except for get/take. Sorry.";
			reject the player's command;
	if the player's command includes "n i win", try niwining instead;
	if player is in Le Babel and opossum is in Le Babel and the player's command matches the regular expression "\bpossum\b":
		say "You feel as though you are misssing something calling the opossum just a possum. Something non-critical, but something nonetheless.";

no-punc-flag is a truth state that varies.

table of homonym rejects
to-reject	mytxt	longer-desc
trap art	"trap art"	"Also, you [if player has trap art]already took[else]can just take[end if] the art. You need to make it more interesting"
scorn rocs	"scorn rocs"	"They'd out-scorn you easily. But that's okay. If you were too good at scorning, you wouldn't be one of the good guys. You need to do something more drastic"
tame mat	"tame mat"	"Also, the mat's already harmless. You need to make it more interesting"
kayak	"kayak"	"[if kayak is moot]Plus, you already used the kayak[else if Lac Oft Focal is visited]Besides, one kayak is enough for this game[else]Spoiler: there's a kayak you haven't found yet[end if]"

part dying

to die:
	end the story saying "Offed? Deffo! / Story Rots! / Stung! Nuts! / To Pot!"

volume verbs (standard or semi-standard to Inform)

check taking scenery: say "Grab? Arg! (Scenery doesn't need to be taken.)[paragraph break]" instead;
check taking a workable: say "Grab? Arg! (Machines don't need to be taken.)[paragraph break]" instead;

the can't push what's fixed in place rule is not listed in any rulebook.
the can't pull what's fixed in place rule is not listed in any rulebook.

the can't push scenery rule is not listed in any rulebook.
the can't pull scenery rule is not listed in any rulebook.

the can't push people rule is not listed in any rulebook.
the can't pull people rule is not listed in any rulebook.

the can't push unpushable things rule is not listed in any rulebook.

this is the generic-push-pull rule:
	if noun is cart, say "For a cart, it's not mobile." instead;
	if noun is martini tram, say "It'd just roll back down here. It probably should be here." instead;

check pushing:
	abide by the generic-push-pull rule;
	say "Push?! [']Sup?! [one of](You never need to push anything in Ailihphilia.)[or][line break][stopping]" instead;

check pulling:
	abide by the generic-push-pull rule;
	say "You never need to pull anything in Ailihphilia. Well, nothing concrete, [if pulled-up is false]but maybe you can figure what or how to pull[else]and you already pulled up in the Emo Dome[end if]." instead;

chapter putting on

instead of putting on rut: say "Placing any one item in the rut manually won't fill it, but maybe you can use a tool to do so.";

instead of putting on:
	if second noun is turf rut, try inserting noun into second noun instead;
	if second noun is put-to-use, try useoning noun with second noun instead;
	continue the action;

definition: a thing (called th) is put-to-use:
	if th is a workable, yes;
	if th is sword rows, yes;
	if th is tract cart, yes;
	if th is me totem, yes;
	if th is liar grail, yes;
	if th is DNA hand, yes;
	no;

chapter opening / closing

check closing, say "You never need to close anything in this game." instead;

check opening: [??]
	if noun is a book, try examining the noun instead;
	if noun is a workable, say "[if noun is workedout]It's broken. You can't constructively put anything in it[else]Just [b]USE[r] something on it, or [verb-abbrev of noun][end if]." instead;
	if noun is bros' orb, say "The Bros['] Orb would be destroyed, its virtue gone, if you tried to force its secrets out." instead;
	if noun is etage gate:
		if player has Ye Key, try useoning Ye Key with etage gate instead;
		try going north;
	if noun is gold log, say "You can't find an opening." instead;
	if noun is lie veil, say "It's not that easy. You need to be forceful." instead;
	if noun is mayo yam, say "That's not something you want to open." instead;
	if noun is poo coop, say "And get doo-doo'd?" instead;
	if noun is snack cans, say "[if player is in Mont Nom]You wonder if they might go better with something else[else]You will open the snack cans when the time comes to use them[end if]." instead;
	if noun is sto lots, say "You can automatically open it when you need to." instead;
	if noun is stole lots, say "You can't get to the STOLE LOTS with Dave around." instead;
	if noun is yard ray, say "You just need to know how to fire it, not its inner workings." instead;
	if noun is you buoy, say "You can't find an opening. Sadly, this is slightly trickier than Zork I. Slightly." instead;
	say "You never need to open anything in this game.";

chapter inserting into

instead of inserting into pact cap:
	say "The cap needs to stay on your head[if noun is carried]. You don't need any special place to put things[insert-cap-lots][end if]."

instead of inserting into rut:
	if noun is poo coop:
		say "Eh, why not just empty it totally, you think.";
		try useoning poo coop with turf rut instead;
	say "Placing any one item in the rut manually won't fill it, but maybe you can use a tool to do so.";

instead of inserting into sto lots:
	if number of entries in multiple object list > 1:
		alter the multiple object list to { };
		add noun to multiple object list;
	if noun is sto lots, say "You don't need to make a sto-lots-to-lots or anything like that. The Sto Lots has enough space." instead;
	say "The sto lots is already carrying what it can and needs to."

definition: a thing (called th) is insertable-to-use:
	if noun is past sap or noun is dose sod, yes;
	no;

definition: a thing (called th) is insert-to-use:
	if th is a workable, yes;
	if th is tract cart, yes;
	if th is eye, yes;
	if th is navy van, yes;
	if th is stole lots, yes;
	if th is yard ray, yes;
	if th is butene tub, yes;
	if th is sword rows, yes;
	if th is me totem, yes;
	if th is liar grail, yes;
	if th is DNA hand, yes;
	no;

instead of inserting into (this is the convert insert to useon when sensible rule):
	if noun is moot or second noun is moot, stop the action;
	if noun is insertable-to-use, try useoning noun with second noun instead;
	if second noun is insert-to-use, try useoning noun with second noun instead;
	if noun is eels:
		if second noun is bunk nub or second noun is stock cots, try useoning noun with second noun instead;
	continue the action;

chapter search replacement

search-warn is a truth state that varies.

check searching:
	if search-warn is false:
		say "You never need to search something. Nothing is hidden in this game. Examining (X/EXAMINE) serves the same purpose.";
		now search-warn is true;
	try examining noun instead;

chapter give replacement

give-warn is a truth state that varies.

Understand "show [someone] [something preferably held]" as giving it to (with nouns reversed).
Understand "show [something preferably held] to [someone]" as giving it to.

check giving to a person:
	if give-warn is false:
		now give-warn is true;
		say "(NOTE: USE X ON Y is the preferred syntax, though (SHOW/GIVE) TO should work too and sometimes gives separate rejects.)[paragraph break]";
	if noun is wash saw or noun is cave vac or noun is Dirt Rid, say "If there's any manual work to be done, you need to do it yourself." instead;
	if noun is gift fig, say "Hmm. It was a gift FOR you. You need to figure what to do with it." instead; [?? send to USE ON ??]
	if noun is snack cans, say "A nice gesture, but you're convinced the snack cans have some deeper purpose. If only by this text I just wrote, here." instead;
	if noun is an ingredient, say "Alas, [the noun] would not be a very nice gift for [the second noun]." instead;
	try useoning noun with second noun instead;

chapter undoing

report undoing an action:
	next-rand table of undoings;
	consider the notify cycling rule;
	the rule succeeds;

chapter taking people

the can't take other people rule is not listed in any rulebook.

check taking a person:
	say "While you need to 'take' some people metaphorically, doing so physically is unrealistic, even in a weird world filled with silly palindromes. So you need to specify how to get around, defeat or help someone." instead;

chapter procedurality

to decide whether the action is procedural: [aip]
	if examining, yes;
	if reading, yes;
	if os2ing, yes;
	if oldschooling, yes;
	if attacking, yes;
	if saying yes, yes;
	if saying no, yes;
	if dropping, yes;
	if looking, yes;
	if listening, yes;
	if rading, yes;
	if gotothinging, yes;
	if eyeing, yes;
	if xpyxing, yes;
	if thinking, yes;
	if reving, yes;
	if roting, yes;
	if reiing, yes;
	if useoning:
		if noun is radar or second noun is radar, yes;
	if taking inventory, yes;
	no;

[these are debug commands, but they need to be placed here so that we can compile and quickly unit-test the USEON command.]

uuxing is an action applying to one visible thing.
uuying is an action applying to one visible thing.
uuing it on is an action applying to two visible things.

[pro-and-use is for doing stuff to items]
to decide whether the action is pro-and-use: [aip2] [redefined in debug part]
	if useoning, yes;
	if uuxing, yes;
	if uuying, yes;
	if uuing, yes;
	if gotothinging, yes;
	if the action is procedural, yes;
	no;

chapter climbing

the block climbing rule is not listed in any rulebook.

check climbing: say "You haven't drunk enough Klimb-Milk. Err, Climb-Milc. Whichever. You don't need to climb to win the game." instead;

chapter listening

check listening:
	if noun is pact cap, say "The pact cap will make noise when needed[if cap-vol is false], though you may want to turn it back on with [b]LOVE VOL[r] first[end if]." instead;
	if noun is bomb mob or noun is navy van, say "Yell-ey." instead;
	if player is in My Gym:
		say "[if debug-state is true]DEBUG NOTE RANDOM SONG: [end if][if Dave is in My Gym]Behind Dave's grunts, y[else]Y[end if]ou [one of]tolerate[or]imagine your favorite English teacher giving you a D+ for a poem with the lyrics of[or]are inspired to move, but not in the intended way, by[or]can't escape[or]dread a casual conversation containing the lyrics of[or]imagine the marketers earned their keep promoting[or]feel guilty liking the beats but loathing the words of[or]have a great idea what to do next, but it's interrupted by[or]realize you're going to forget something important someday when remembering the lyrics of[or]feel glad it's the low-volume version of[or]hate yourself for not completely loathing[or]hope nobody got paid too much for writing[or]guess the title from the repeated words of[or]hear, and guess some people are inspired by,[in random order] [next-rand-txt of table of My Gym songs]." instead;
	if player is in Apse Spa, say "Surprisingly, no spa yaps." instead;
	if player is in Mont Nom, say "The Ark of Okra is almost saying 'Nom on!' or 'Nom! C'mon!' or even 'Tum-Smut!'" instead;
	if player is in Yack Cay and moor broom is not moot, say "[if Known Wonk is not moot]The Known Wonk is just babbling on about stuff you aren't be interested in[else]The Known Wonk, from inside the Tru-Yurt, complains about how messy it is[end if]." instead;
	if player is in Uneven U, say "The Code Doc mumbles [next-rand-txt of table of university primary targets] or [next-rand-txt of table of university secondary targets] would make a good colleague.";
	if player is in Yell Alley and bomb mob is in Yell Alley, try listening to bomb mob instead;
	if player is in Moo Room, say "[if bees-seen is false]An ominous buzzing. Where is it coming from? Bees sure can hide![else]You think you hear [next-rand-txt of table of Moo Room animals] in addition to the mooing.[end if]" instead;
	if player is in Le Babel, say "Freakish whisperings of the apocryphal [next-rand-txt of table of babel babble] swirl in the air." instead;
	if player is in Sneer Greens and Yuge Guy is moot, say "You still hear the Yuge Guy utter 'Et Tu?' He has a weird sense of loyalty." instead;
	say "Noise lesion." instead;

chapter seebeesing

seebeesing is an action applying to nothing.

understand the command "see bees" as something new.

understand "see bees" as seebeesing.

bees-seen is a truth state that varies.

carry out seebeesing:
	if bees-seen is true, say "You already saw the bees [if player is in Moo Room]here[else]in Moo Room[end if]." instead;
	if player is not in Moo Room, say "There are no bees to see here." instead;
	say "You look carefully around until you see what could be causing the soft buzzing. Bees are difficult to see, without too much light, but you focus, and now you know where they are, you're not afraid. With the bees less fearsome, you can zone out their buzzing and hear many different farm-related noises, if you're interested.";
	abide by the LLP rule; [SEE BEES]
	now bees-seen is true;
	the rule succeeds;

chapter thinking

last-move-scored is a number that varies.
basic-hint-yet is a truth state that varies.
thought-yet is a truth state that varies.

every turn when basic-hint-yet is false:
	if turn count - last-move-scored is 20 and score > 0:
		say "You've gone without any point scoring for a while. So I'd like to break the fourth wall and [if thought-yet is true]remind[else]tell[end if] you that [b]THINK[r] can give you a general overview of where you've been and what places are blocked. This nag won't appear again, but I want to give you less chance of feeling lost and frustrated.";
		now basic-hint-yet is true;

definition: a room (called rm) is available: [?? mix this with viable directions so 'cant go that way' makes more sense]
	consider the avail-rule of rm;
	if the rule succeeded, yes;
	no;

definition: a thing (called x) is beep-think:
	if x is moot, no;
	if x is kayo yak and kayo-known is true, no;
	if x is beepy and x is beeped, yes;
	no;

understand "th" as thinking.
understand "thin" as thinking.

the block thinking rule is not listed in any rulebook.

check thinking:
	now last-move-scored is turn count;
	if thought-yet is false, say "A knihtg (sic) appears and taps you on the shoulder, and you suddenly recall big-picture things.";
	let LLP-yet be false;
	let got-later-use be false;
	now thought-yet is true;
	repeat through table of lateruses:
		if in-limbo entry is false:
			if there is a to-get entry and to-get entry is moot, next;
			if there is no combo-rule entry, next;
			consider the combo-rule entry;
			if the rule failed, next;
			if got-later-use is false:
				say "Stuff you've partially figured out:[line break]";
			else:
				skip upcoming rulebook break;
			say "[remind-msg entry]";
			now got-later-use is true;
	if cap-ever-pace is true and kayo yak is not moot, say "You need to figure [if yak-lair is true]what to say to the yak to get rid of the ogre[else if cap-during-yak is true]where to end up when you run with the pact/pace cap[else]when to make the pact cap a pace cap[end if].";
	if got-later-use is true, say "[paragraph break]";
	if got-later-use is false, say "As far as you know, there are no challenges where you were pretty sure what to do, but you didn't have the right item yet.";
	if number of beep-think things > 0, say "You need to do something weird to deal with [the list of beep-think things].";
	let wayoutrooms be 0;
	let wv be number of worth-visiting rooms;
	let wv-got be 0;
	say "Other things to try, in random order:[line break]";
	if wv > 0:
		repeat with Q running through worth-visiting rooms:
			increment wv-got;
			if wv-got is 1, say "You may wish to visit";
			if wv-got > 1 and wv-got < wv, say ",";
			if wv-got is wv and wv > 1, say " and";
			let od be opposite of in-dir of Q;
			let ir be in-dir of Q;
			say " [od] of [the room ir of Q][run paragraph on]";
		say ".";
	if wayoutrooms > 0:
		say "You'll want to visit [number of way-out rooms] place[plur of wayoutrooms] more than one move away from everywhere you've currently explored. I won't spoil them, but they're available.";
		if debug-state is true, say "WAY OUT: [list of way-out rooms].";
	let nwe be number of worth-examining things;
	repeat with Q running through visited rooms:
		process stuck-rule of Q;
	let got-LLP-notes be false;
	repeat through table of last lousy points:
		if mclu entry is true:
			process the dorule entry;
			if the rule failed:
				if LLP-yet is false:
					now LLP-yet is true;
					say "[line break]LAST LOUSY POINTS NOTES:[line break]";
				say "[cluey entry].[line break]";
				now got-LLP-notes is true;
	skip upcoming rulebook break;
	if LLP-yet is true, say "[line break]";
	let nsb be number of sober books in devreserved;
	if nsb < 4 and ever-wordrow is true, say "[if nsb is 0]Those books in Word Row seemed useful--if not for you, for someone else[else]You managed to help someone with a book from Word Row. Perhaps you can help someone else[end if].";
	if player has epicer recipe and epicer recipe is xed, say "You have [tron-got] of [number of tronparts] pieces of the North-Tron[hint-tron].";
	say "[line break][if nwe > 0]You may want to examine [this-these of nwe] item[plur of nwe] you haven't, yet: [the list of worth-examining things][else]You've examined all your carried items for clues[end if][if sce-to-see]. You can also try [b]SCE RECS[r] to see scenery you haven't examined[end if].";
	if revisited-u is false and revisit-clue is true, say "You may wish to visit the Code Doc again in [uneven u] to see what the fuss was about.";
	if LLP-yet is false, say "You don't have any last lousy points to figure that've been clued in-game.";
	if player has yard ray and murdered rum is not moot, say "You need to figure how to charge the yard ray.";
	let Q be the list of eyed things;
	if number of entries in Q > 0:
		sort Q in eyespoil order;
		say "[line break][b]Things eyed (tix exit is 79):[r][line break]";
		repeat with Q2 running through Q:
			say "[Q2] ([if player has Q2]carried[else][hn-ext of location of Q2][end if]): [eyespoil of Q2][if eyespoil of Q2 <= score + 1] (hmm, worth looking into)[end if][line break]";
	if eye-charges > 0, say "[line break][pip-charges].";
	the rule succeeds;

to say hn-ext of (rm - a room):
	say "[if rm is dropord]dropped during the chase[else if rm is devreserved]done with--should not happen[else]hn of rm[end if]";

definition: a thing (called th) is eyed:
	if th is moot, no;
	if th is tix exit, no;
	if eyespoil of th > 0, yes;
	no;

to decide whether sce-to-see:
	repeat with q running through xable things:
		if q is scenery and q is nox, yes;
	no;

definition: a room (called rm) is worth-visiting:
	if rm is visited, no;
	if rm is not available, no;
	let idr be in-dir of rm;
	if the room idr of rm is visited, yes;
	no;

definition: a room (called rm) is way-out:
	if rm is visited, no;
	if rm is not available, no;
	let idr be in-dir of rm;
	if the room idr of rm is visited, no;
	no;

definition: a thing (called th) is worth-examining:
	unless th is enclosed by the player, no;
	if th is sto lots, no;
	if th is pact cap, no;
	if th is nox, yes;
	no;

to say hint-tron:
	if tron-got is 4, say ". You probably want to [if player is not in fun enuf]go back to Fun Enuf and[end if] USE one North-Tron part on another";

section stuck-rules

[honly = here only. Hn-in = here or "in room x." Hn = here or room x.]

to say itm-place of (th - a thing): say "[th][if th is not in location of player] in [location of th]"

to say in-not-here of (rm - a room): if player is not in rm, say " in [rm]"

to say honly of (rm - a room):
	say "[if player is in rm] here[end if]"

to say hn-in of (rm - a room):
	say "[if player is in rm]here[else]in [rm][end if]"

to say hn-of of (rm - a room):
	say "[if player is in rm]here[else]of [rm][end if]"

to say hn-the of (rm - a room):
	say "[if player is in rm]here[else]the [rm][end if]"

to say hn-in-blank of (rm - a room):
	say "[if player is not in rm] in [rm][end if]"

to say hn of (rm - a room):
	say "[if player is in rm]here[else][rm][end if]"

a room has a rule called stuck-rule. stuck-rule of room is usually the trivially false rule.

stuck-rule of Drawl Ward is drawl-ward-stuck rule.
stuck-rule of Dumb Mud is dumb-mud-stuck rule.
stuck-rule of Emo Dome is emo-dome-stuck rule.
stuck-rule of Evaded Ave is evaded-ave-stuck rule.
stuck-rule of Flu Gulf is flu-gulf-stuck rule.
stuck-rule of Fun Enuf is fun-enuf-stuck rule.
stuck-rule of Gross Org is gross-org-stuck rule.
stuck-rule of Lair Trial is lair-trial-stuck rule.
stuck-rule of Ooze Zoo is ooze-zoo-stuck rule.
stuck-rule of Seer Trees is seer-trees-stuck rule.
stuck-rule of Yack Cay is yack-cay-stuck rule.
stuck-rule of Swept Pews is swept-pews-stuck rule.
stuck-rule of Toll Lot is toll-lot-stuck rule.
stuck-rule of Yawn Way is yawn-way-stuck rule.

this is the drawl-ward-stuck rule:
	if Bond Nob is moot, the rule fails;
	say "You need to find a way to help the Bond Nob [hn-in of Drawl Ward].";
	the rule succeeds;

this is the dumb-mud-stuck rule:
	if lie veil is moot and gnu dung is moot and poo coop is moot, the rule fails;
	let any-yet be false;
	say "You need to get by ";
	unless gnu dung is moot:
		now any-yet is true;
		say "the gnu dung (west)";
	unless poo coop is moot:
		if any-yet is true:
			say " / ";
			now any-yet is true;
		say "the turf rut (south)";
	unless lie veil is moot:
		if any-yet is true:
			say " / ";
			now any-yet is true;
		say "the lie veil (north)";
	say " [hn-in of Dumb Mud].";
	the rule succeeds;

this is the emo-dome-stuck rule:
	if Red Roses Order is visited, the rule succeeds;
	say "[if pulled-up is false]You need to figure a way to slow down in [else]You need to figure a way north from [end if][hn of Emo Dome].";
	the rule succeeds;

this is the evaded-ave-stuck rule:
	if Door Frood is moot, the rule fails;
	say "You need a way by the Door Frood [hn-in of Evaded Ave].";
	the rule succeeds;

this is the flu-gulf-stuck rule:
	if scorn rocs are moot, the rule fails;
	say "You need a way by the scorn rocs [hn-in of Flu Gulf].";
	the rule succeeds;

this is the fun-enuf-stuck rule:
	if Dirge Grid is mapped north of Fun Enuf, the rule fails; [??not good enough -- need to make sure have weapons]
	say "You need to blast through the [kaoscaps] north of [hn of Fun Enuf], eventually.";
	the rule succeeds;

this is the gross-org-stuck rule:
	if etage gate is moot, the rule fails;
	say "You need to [if Ned is in Gross Org]get rid of Ned and [end if]unlock the etage gate [hn-in of Gross Org].";
	the rule succeeds;

this is the lair-trial-stuck rule:
	if ergot ogre is moot, the rule fails;
	say "You need to get by the ergot ogre [hn-in of Lair Trial].";
	the rule succeeds;

this is the ooze-zoo-stuck rule:
	if sleep eels are moot, the rule fails;
	say "You need to get by the sleep eels [hn-in of Ooze Zoo].";
	the rule succeeds;

this is the seer-trees-stuck rule:
	if stark rats are moot, the rule fails;
	say "You need a way past the stark rats [hn-in of Seer Trees].";
	the rule succeeds;

this is the yack-cay-stuck rule:
	if NULL ILLUN is moot, the rule succeeds;
	say "You need to figure a way to get by the mist-sim [hn-in of Yack Cay]. The Known Wonk is also a bit of a nuisance.";
	the rule succeeds;

this is the swept-pews-stuck rule:
	if liar grail is moot, the rule succeeds;
	say "You need to figure how to get past the Liar Grail and release the Wordy Drow [hn-in of Swept Pews].";
	the rule succeeds;

this is the toll-lot-stuck rule:
	if cash sac is moot, the rule succeeds;
	say "You need to figure a way past the cross orc [hn-in of Toll Lot].";
	the rule succeeds;

this is the yawn-way-stuck rule:
	if puffed-up is true, the rule succeeds;
	say "You need to figure how to get east [hn-in of Yawn Way].";
	the rule succeeds;

volume irregular verbs

check looking under:
	if noun is tame mat or noun is guru rug, say "No secret passages." instead;
	say "You never need to look under anything in Ailihphilia." instead;

chapter inventory

the take what you got rule is listed instead of the can't take what's already taken rule in the check taking rulebook.

this is the take what you got rule:
	if noun is enclosed by the player, say "You shuffle [the noun] listlessly from one hand to another, which is in the spirit of the game, even if it doesn't do anything." instead;

after printing the name of spur ups while taking inventory: if puffed-up is true, say " (tarnished slightly)";

after printing the name of pact cap while taking inventory: say ", set to LO[if cap-vol is true]VE[end if] VOL";

after printing the name of brag garb while taking inventory: say " (smelling of [if troll ort is moot]the troll ort[else]Turbo-Brut[end if])";

after printing the name of a book (called bk) while taking inventory: say " (by [auth-name of bk])"

after printing the name of the poo coop while taking inventory: if gnu dung is moot, say " (full of gnu dung)"

definition: a book (called bk) is lugged:
	if bk is SOME DEMOS, no;
	if bk is carried by the player, yes;
	no;

to say along-w-pyx: if player has pyx, say ", and you kept the x/y pyx";

check taking inventory when Dave is moot (this is the ailihphilia inventory rule) :
	if being-chased is true:
		now chase-mulligan is true;
		say "[if player is in Pro Corp or player is in Frush Surf]You don't have time to track all your possessions with the [chase-person] chasing you[else]You dropped everything out of surprise when the [chase-person] started chasing you! You're only wearing [list of worn things][along-w-pyx]. But hey, this way you can go faster[end if]." instead;
	now all things enclosed by the player are marked for listing;
	now all ingredients are unmarked for listing;
	now all tronparts are unmarked for listing;
	now all helpdocs are unmarked for listing;
	now all things worn by the player are unmarked for listing;
	now state tats are unmarked for listing;
	now x y pyx is unmarked for listing;
	now sto lots is unmarked for listing;
	now all books are unmarked for listing;
	say "'Met item' list[if number of things carried by player > 7]--man, your STO-LOTS can hold a lot[else if player has sto lots] in your sto-lots[end if]:[line break]";
	list the contents of the player, with newlines, indented, including contents, giving inventory information, with extra indentation, listing marked items only;
	if number of lugged books > 0, say "Currently lugging (oof) [list of lugged books].";
	if player has SOME DEMOS, say "You've [if number of lugged books is 0]still[else]also[end if] got that small book, [SOME DEMOS].";
	if number of ingredients carried by player > 0, say "Food found[if chef-yet is true] (not including what you mixed in Mont Nom)[end if]: [a list of ingredients carried by player].";
	if number of things worn by player > 0, say "You are wearing: [a list of things worn by player].";
	if player carries x y pyx, say "The X/Y pyx you're carrying will let you see a MAP anywhere.";
	if number of helpdocs carried by the player is 1:
		say "So far, you only have [the list of helpdocs carried by the player] as reference, and it's not very useful. More later, maybe?";
	else:
		say "AIDE MEDIA: [if player has epicer recipe]The epicer recipe seems most important and straightforward. [end if]";
		if player has Set O Notes, say "The Set O Notes [if player has epicer recipe]also has some clues but is less straightforward[else]has some information, but you'd like something even better[end if]. ";
		say "The Darer Ad--well, it suckered you into this whole mess. Pure fluff.";
	if number of tronparts carried by player > 0:
		say "North-tron parts found: [the list of tronparts carried by player][unless martini tram is off-stage]. The martini tram is in [Fun Enuf], too[end if][hint-tron].";
	else if martini tram is in fun enuf:
		say "You aren't carrying it, but the martini tram[if epicer recipe is xed] listed on the epicer recipe[else], which must be good for something,[end if] is in Fun Enuf.";
	if player has state tats, say "You've also stamped yourself with state tats.";
	if number of carried exhausted things > 0 and reviver is not moot, say "(x) = exhausted (tried all 3 machines in Work Row)[line break]";
	if being-chased is true and number of things in DropOrd is 0, say "Once this chase is done, you'll be able to find your dropped items in .";
	the rule succeeds;

to say drop-room: say "[if chase-person is psi wisp][Gross Org][else]Ooze Zoo[end if]"

after printing the name of an exhausted thing while taking inventory: say " (x)";

[??use pace cap on machine]

after printing the name of pact cap while taking inventory: if cap-pace is true, say ", and bent slightly to be a PACE cap too".

after printing the name of pact cap while taking inventory: if eye-charges > 0, say " ([eye-charges] pip charge[plur of eye-charges])".

after printing the name of yard ray while taking inventory: say " ([unless murdered rum is moot]un[end if]charged)".

after printing the name of spa maps while taking inventory: say " ([if maps-explained is true]deciphered[else]indecipherable[end if])".

after printing the name of the puce cup while taking inventory:
	if puce cup is sappy, say " (full of [if player is in Cold Loc]past sap[else]purist sirup[end if])";
	if puce cup is soddy, say " (full of dose sod)";
	continue the action;

after printing the name of the radar while taking inventory:
	if radar-used is 1, say " (damaged)";
	if radar-used is 2, say " (BUG--should be destroyed)";

chapter epiwipeing

epiwipeing is an action out of world.

understand the command "epiwipe" as something new.
understand the command "epi wipe" as something new.

understand "epiwipe" as epiwipeing.
understand "epi wipe" as epiwipeing.

carry out epiwipeing:
	say "Epically wiping records of what you examined.";
	now all things are nox;
	now all people are not talked-yet;
	repeat through table of readables:
		now read-yet entry is false;
	the rule succeeds;

chapter scerecsing

scerecsing is an action out of world.

understand the command "sce" as something new.
understand the command "scerecs" as something new.
understand the command "sce recs" as something new.
understand the command "sce rec" as something new.

understand "scerecs" as scerecsing.
understand "sce recs" and "sce rec" as scerecsing.
understand "sce" as scerecsing when sce-warn is true.

sce-warn is a truth state that varies.

carry out scerecsing:
	let count be 0;
	if sce-warn is false:
		now sce-warn is true;
		say "[b]NOTE: most scenery doesn't need to be examined, so this is just a non-spoiler command to make sure you've checked everything. Also, you can abbreviate this with SCE in the future.[r]";
	repeat with SC running through xable scenery:
		increment count;
		if count is 11, break;
		if count is 1, say "Scenery unexamined yet: ";
		if count > 1, say ", ";
		say "[SC] in [location of SC][run paragraph on]";
	say "[if count is 11] (there's more, but this is long enough.)[else if count is 0]You've examined all the scenery you could[any-open-rooms].[else].";
	now count is 0;
	skip upcoming rulebook break;
	let XP be number of xable people;
	repeat with SC running through xable people:
		increment count;
		if count is 1, say "[if xp is 1]One person/animal[else]People/animals[end if] unexamined/talked to yet: ";
		if count > 1, say ", ";
		say "[SC] [if SC is nox and SC is need-talk](talk/examine)[else if SC is nox](examine)[else](talk to)[else][end if] in [location of SC][run paragraph on]";
	say "[if count is 0]You've examined/talked to all the people you could[any-open-rooms][end if].";
	now XP is number of need-read things;
	let count be 0;
	repeat with SC running through need-read things:
		increment count;
		if count is 1, say "[if XP is 1]Something[else]Things[end if] to READ: ";
		if count > 1 and count < XP, say ", ";
		if count is XP and count > 1, say " and ";
		say "[SC]";
	if XP > 0, say ".";
	the rule succeeds;

to decide whether any-unvisited:
	if number of unvisited rooms > number of rooms in Odd Do, yes;
	no;

to say any-open-rooms: say "[if any-unvisited], at least for the rooms explored so far[end if]"

definition: a person (called ani) is need-talk:
	if ani is talked-yet, no;
	if ani is sleep eels or ani is kayo yak, no;
	if ani is opossum or ani is felines, no;
	if ani is psi wisp, yes;
	no;

definition: a thing (called sce) is xable:
	if sce is not a person and sce is xed, no;
	if location of sce is unvisited, no;
	if location of sce is ungoable, no;
	unless location of sce is available, no;
	if sce is a phonebook, no;
	if sce is Evac Ave, no;
	if sce is scenery, yes;
	if sce is a person:
		if sce is the player, no;
		if sce is nox, yes;
		if sce is need-talk, yes;
	no;

chapter abouting

abouting is an action applying to nothing.

understand the command "about" as something new.

understand "about" as abouting.

carry out abouting:
	now show-dev is true;
	say "Ailihphilia was originally written for IFComp 2018. It was conceived in October 2017 as 'Put It Up' (and a side part of a bigger game) before I realized there was an actual word for, well, liking palindromes. I started coding in November.";
	say "[line break]Like many of my games, I got the idea from [i]Nord and Bert Couldn't Make Head or Tail of It[r], at least partially. Another game that gave me ideas was Nick Montfort's [i]I Palindrome I[r], part of the Apollo 18+20 collection Kevin Jackson-Mead organized back in 2012. I felt there could be more that could be done with palindromes, but I didn't know what, and I didn't know how much.[paragraph break]Also, the Palindome in Kingdom of Loathing prompted my curiosity back in 2010. I would still be playing it today, if it hadn't inspired me to try to write my own games, which left less time for KoL (spoiler: I still ascended over 100 times.) I tried to avoid palindromes it already considered, though the Dumb Mud from the special Heavy Rains was too good to pass up. It's an item there but a location here, so I can't claim to copycat too much.";
	say "[line break]In my continuing quest to nail down my Python knowledge, I realized that even if I didn't get MANY palindromes on my own, a few scripts could print things out. I had word and name lists from my anagram games Shuffling Around and A Roiling Original, so I had the raw materials--but at the same time, I needed to weed out overlaps. There wound up being more material to work with than I thought. I hope there is quality as well as quantity.";
	say "[line break]The result of all my work is some guess-the-verb, but hopefully with the game's general idea, you'll see what's going on. Ailihphilia is meant to be polite on the Zarfian cruelty scale, although I hope you enjoy some of the impolite jokes and even the deliberate misspellings to force palindromes, as well as the room name-changes that occur (for esthetic effect only) as you solve puzzles.";
	say "[line break]So Ailihphilia doesn't have any deep philosophy, but I hope you enjoy it. If you write games yourself, I hope it inspires you to go through with anything unusual you weren't sure if you should try, even if Ailihphilia rubs you the wrong way. (Spoiler: you should write that game! Just start early and take all the notes you can, but don't think the first draft needs to be perfect!)[paragraph break]";
	say "I'm at [email] if you have suggestions for bug fixes, etc. Or you can report a bug in a repository. [b]DEV ED[r] is the command to see that.[paragraph break]";
	say "If you're confused what to do or type, [b]VERBS[r] will give an outline of the basic verbs you need to get through Ailihphilia.";
	the rule succeeds;

chapter creditsing

creditsing is an action applying to nothing.

understand the command "credits" as something new.

understand "credits" as creditsing.

showed-sites is a truth state that varies.

carry out creditsing:
	now show-dev is true;
	say "I'd like to thank my testers for finding so much that left me free to think up more weirdness. They are, in alphabetical order: Marnix Van Den Bos, Mike Carletta, Wade Clarke, Arthur DiBianca, Viv Dunstan, Anssi Raissanen, Brian Rushton, Mike Spivey, Brian Stovall, and Jack Welch. While I made an effort to run tests to minimize silly errors, they found a lot and still gave positive suggestions about cluing and so forth. In-comp, Victor Gijsbers, a fellow competitor in IFComp 2018, helped point me to some tricky bugs. Post-comp, David Welbourn pointed me to another handful of bugs.";
	say "[line break]If you want to join this elite club, and you find a bug, write me at [email].[paragraph break]IFComp organizers past and present. Without them, I wouldn't have started and kept going. Whether that's good for gaming is up for debate, but it's been good for me.[paragraph break]Various Python communities, especially StackOverflow, helped me to organize source control and write utilities that helped not only to extract palindromes but also to tune up Inform code (obligatory thanks to all past and current Inform developers, from whom I've stolen game code and/or used extensions) and run simple tests.[paragraph break]I also found some websites useful. [b]DEV ED[r] or [b]DEVED[r] will show which helped me and how.";

chapter deveding

deveding is an action out of world.

understand the command "deved" as something new.
understand the command "dev ed" as something new.

understand "deved" as deveding.
understand "dev ed" as deveding.

show-dev is a truth state that varies.

carry out deveding:
	say "Websites that helped with this game:[paragraph break]";
	say "  --http://www.angelfire.com/in2/sedavis/palindromes.html STOP LAUGHING ANGELFIRE WAS COOL WHEN IT FIRST CAME OUT ANYWAY GEOCITIES WAS MORE MY BEAT[line break]";
	say "  --https://www.reddit.com/r/AskReddit/comments/4z899e/whats_your_favorite_palindrome/";
	say "[paragraph break]From a technical standpoint, Bitbucket helped me get started, and Github is/will be used for the post-release.";
	say "  --Github: [gh][line break]";
	say "  --BitBucket: [bb][line break]";
	the rule succeeds;

chapter verbing

verbing is an action out of world.

understand the command "help" as something new.
understand the command "v" as something new.
understand the command "verb" as something new.
understand the command "verbs" as something new.

understand "verbs brev" and "verb brev" as verbing.
understand "verbs" and "verb" and "v" and "help" as verbing.

any-sit-cmd is a truth state that varies.

to say got-sit:
	if any-sit-cmd is false, say "Location/situation-specific commands:[line break]";
	now any-sit-cmd is true.

to say work-both-all: say "[if number of moot workables is 1]both[else]all[end if]"

to say verb-mach-abbrevs:
	let sofar be 0;
	if number of moot workables is 2:
		let lastleft be random workable in Worn Row;
		say "[verb-abbrev of lastleft] lets you use an item on the [lastleft]";
		continue the action;
	repeat with ma running through workables:
		if ma is in Worn Row:
			if sofar > 0, say " / ";
			say "[verb-abbrev of ma]";
			increment sofar;
	say "uses an item on, respectively, the [list of workables in Worn Row]"

this is the situational commands show rule:
	now any-sit-cmd is false;
	if player is in Fun Enuf and KAOS Oak is xed, say "[got-sit][2da][b]GRAMMAR G[r] toggles the [kaoscaps] between chaotic to sane punctuation, which is purely cosmetic.";
	if wr-short-note is true and in-work and number of moot workables < 3, say "[got-sit][line break][2da][verb-mach-abbrevs][if rr-available is true and number of moot workables < 2]. [b]RR[r] goes through them [work-both-all][end if].";
	if player has radar, say "[got-sit][2da][b]RAD[r] is shorthand to use the radar on something. [b]SCAN[r] or [b]RDR[r] works too.";
	if chase-aware, say "[got-sit][2da][no-time-note].";
	if any-sit-cmd is false, say "There are currently no special situational verbs, but when there are, they will show up here.";

to decide whether chase-aware:
	if ever-chased is true and psi wisp is not moot and kayo yak is not moot, yes;
	no;

to say eye-v-note: if eye-charges is 0, say ", once you recharge the pip with some good guesses"

carry out verbing:
	say "[2da]The four basic directions ([b]N, S, E, W[r]) are the main ones, along with [b]USE[r], in order to get through the game. Also, in some places, specific verbs will be needed. None are terribly long, and---well, there is a thematic pattern to them[if Dave is moot], as you've already seen with Dave[end if].";
	say "[line break][2da]Standard verbs like [b]X[r] ([b]EXAMINE[r]) and [b]LOOK[r] also work.";
	say "[2da][b]GT[r] or [b]GO TO[r] lets you go to a room, thing or person you've seen before. It fails if the person or thing has been removed from the game. You can also use [b]GR[r] for rooms only, or [b]GI[r] for individuals or items only. It's meant to save thought, keystrokes and even turn count.";
	say "[2da][b]T[r], [b]TA[r], [b]TALK TO[r], or [b]GREET[r] talks to someone. There's not much in the way of conversation in this game, but basic chat may be helpful or even amusing. You usually won't need an object with this verb, since there's usually no more than one person per room.";
	say "[2da][b]USE (item) ON (item)[r] is frequently used. It replaces a lot of verbs like [b]GIVE[r] or [b]THROW[r].";
	say "[2da][b]THINK[r]/[b]TH[r] gives general non-spoiler hints, including where you may wish to visit, what you haven't examined, or what is blocking you[if ever-pip is true][b]EYE[r] lets you look at something to see if it is useful to your quest, and when[eye-v-note][end if].";
	say "[2da][b]AID[r] gives you spoiler hints for where you are, though it may indicate you need to visit other places first. [b]MEM[r] pinpoints where useful people and things are[if pyx is quicknear]. [pyx-x] give a game map[end if].";
	say "[2da]sub-commands of [b]THINK[r]: [b]SCE RECS[r] clues scenery you haven't examined yet, and [b]EPI WIPE[r] resets the game's records on things and scenery you examined.";
	if cur-score of Odd Do < max-score of Odd Do:
		say "[line break]There are also a few guess-the-verb bonus points that are hidden. Some relate to objects or people that need help but can't help you, and some are riffs on standard commands. [if refer-yet is false]There's a different way to revisit, rehash or recap this very command, for example[else]For instance, you got [b]REFER[r] as [b]VERBS[r][end if]";
	say "[line break]Also, many verbs that are standard for earlier text adventures give random reject text I hope you will enjoy. If you miss them, you'll see the entire list at the end.";
	say "[2da][b]META[r] (or [b]META AT EM[r]) has information on meta-verbs, which includes options (e.g. turning some minor hints on or off), cheat/warp commands for judges near the two-hour limit, scoring, and information on how the game was created and who helped.";
	if in-beta is true, say "[b]META[r] also gives beta tester commands.";
	if debug-state is true, say "[2da]SMITIMS = win after Deep Speed.[line break][2da]TCC/TCCC aligns move to palindrome or palindrome + 1.";
	abide by the situational commands show rule;

section meta

metaing is an action out of world.

understand the command "meta" as something new.

understand "meta" and "meta at em" as metaing.

carry out metaing:
	if player wears pact cap, say "[2da][b]LO VOL[r] and [b]LOVE VOL[r] turn the pact cap's hints volume down and up, respectively.";
	if shuttuhs-known is true, say "[2da][b]SHUTTUHS[r] toggles blocking off areas you're done with--currently [on-off of shuttuhs]. NOTE: if there are any LLPs, you'll still be blocked.";
	say "[b]SCORE[r] tracks the score[if rank-track-note is true], and [b]SCO DOCS[r] toggles tracking the nonsense ranks[end if]. [b]ABOUT[r] and [b]CREDITS[r] tell about the game[if show-dev is true], and [b]DEV ED[r] shows technical details[end if].";
	say "If you wish to see commands that jump ahead and maybe spoil some puzzles (for instance, if you're near the 2-hour judging limit for IFComp,) [b]N I WIN[r] (no apostrophe) will show you several warp commands. This may be useful if you are near the end of IFComp judging.";
	if in-beta is true:
		say "[line break](start beta commands)";
		say "[line break][2da][b]RR[r] lets you try all three items in the Word Row machines. If one nets a point, it goes last.";
		say "[line break][2da][b]ENDGAME[r] kicks you to the endgame, where you have all the weapons to win the game, though you will be limited to [Fun Enuf] and the Dirge Grid. It's different from [b]DEEP SPEED[r] because you need to shoot up the test set, too.";
		say "[line break](end beta commands)";
	if debug-state is true:
		say "[line break]PROGRAMMER TESTING COMMANDS: WIN lets you win, PER describes peripheral things, and IA flags everything without an initial appearance.";
	the rule succeeds;

wr-short-note is a truth state that varies.

chapter niwining

niwining is an action out of world.

understand the command "niwin" as something new.

understand "niwin" as niwining.
understand "ni win" as niwining.

to say LLP-if-want: say "[if cur-score of Odd Do < max-score of Odd Do]. You can search for LLPs if you want, though[end if]"

carry out niwining:
	if score is min-win - 1, say "The only thing to do to win the game is to go south through the Tix Exit[in-not-here of Fun Enuf][LLP-if-want]." instead;
	if score >= min-win - 4, say "The only warp command that is helpful now is [b]TIP IT[r]. The others are for getting to the point where you can face the Dirge Grid[LLP-if-want]." instead;
	say "WARNING! These may spoil the game if used too early. Their use is primarily for IFComp judges who are close to the two-hour limit and want to see the game's end or ending scenes.[paragraph break]";
	say "[2da][b]DEEP SPEED[r] jumps you to where you have blown a hole in the [kaoscaps] so you can go north of [Fun Enuf]. You will have the weaponry to take on the Diktat Kid. If the [kaoscaps] and the Diktat Kid's two lieutenants are gone, it has no effect. [b]DEEP SPEED[r] does not tell you what you've done, so it does not spoil puzzles for later. It, like [b]REV OVER[r] below, stops at the Dirge Grid so the player can work through the finale, which was meant to be fun and not too taxing.";
	say "[2da][b]REV OVER[r] allows you to skip five puzzles at a time. It stops when you have the weapons to defeat the Diktat Kid, but unlike [b]DEEP SPEED[r], [b]REV OVER[r] details each step, providing a narrative but maybe spoil puzzles you'll want to solve later.";
	say "[2da][b]TIP IT[r] allows you to skip the next puzzle in the game's walkthrough/test order. It can even be used for the final fight in the Dirge Grid, where [b]DEEP SPEED[r] and [b]REV OVER[r] won't work. Like [b]REV OVER[r], it also details each step you take.";
	say "[line break]There are also three commands that will warp you over major quests: [b]TOOLS LOOT[r] [if tron-got >= 4](done) [end if]acquires all North-Tron parts. [b]SMH MS[r] [if Bros' Orb is had-or-done](done) [end if]gets you prepared for Ms. Ism. [b]GUY UG[r] [if rocs are moot and rep popper is had-or-done](done) [end if]gets you prepared for the Yuge Guy. Note these three warp commands have puzzles in common to solve, and also, using them all does not quite give you any of the finished items you need to defeat the Diktat Kid. But they get you close.";
	if cur-score of Odd Do < max-score of Odd Do, say "[line break]Also, warping does not help you with any remaining optional points.";
	the rule succeeds;

chapter shuttuhsing

after taking:
	consider the shuttuhs-after-scoring rule;
	continue the action;

shuttuhs is a truth state that varies.

shuttuhsing is an action out of world.

understand the command "shuttuhs" as something new.

understand "shuttuhs" as shuttuhsing.

this is the cant-shuttuhs rule:
	if being-chased is true, say "This is too distracting when you're in a chase. I want to help you focus, and it's totally not about me overlooking a possible tricky coding exception." instead;
	if player is in Dirge Grid, say "Dispose of the Diktat Kid." instead;
	continue the action;

carry out shuttuhsing:
	if shuttuhs is false and location of player is shutted, say "CLICK! The shuttuhs come down. You should be able to go back inwards okay, but you probably can't come back.";
	abide by the cant-shuttuhs rule;
	now shuttuhs is whether or not shuttuhs is false;
	say "The invisible shutters/shuttuhs blocking completed areas are now [on-off of shuttuhs].";
	the rule succeeds;

this is the shuttuhs-after-scoring rule:
	if shuttuhs is true and location of player is shutted, say "You hear the click of invisible shuttuhs/shutters. You imagine you can escape before they drop."

section shuttuhs check

after going when shuttuhs is true:
	let d2 be opposite of noun;
	if d2 is up or d2 is down:
		repeat with d3 running through maindir:
			if the room d3 of location of player is the room d2 of location of player:
				now d2 is d3;
				break;
	let rd2 be the room d2 of location of player;
	if rd2 is nowhere, continue the action; [this should never happen but just in case]
	if rd2 is shutted, say "You hear the shuttuhs/shutters click down behind you. You must be [if exit-count of rd2 > 1]completely [end if]done to the [d2], now.";
	continue the action;

to decide whether LLP-hunting:
	unless player has x-ite tix, no;
	if score < maximum score - 1, no;
	yes;

check going when shuttuhs is true:
	let Q be the room noun of location of player;
	if Q is nowhere, continue the action;
	if location of player is shutted and room-dist of location of player > room-dist of Q, continue the action; [without this, the player would get stuck in Dopy Pod or Scrap Arcs, as Drawl Ward would be shutted. Also, you can go to the center but not away.]
	if Q is shutted, say "Invisible shuttuhs, err, shutters block passage [noun]. You must be done in [Q][if exit-count of Q > 1] and the room(s) behind it[end if], so you'll need to toggle the shutters with [b]SHUTTUHS[r] to go back[if LLP-hunting]. If you are hunting for LLPs, you may need to toggle [b]SHUTTUHS[r][end if]." instead;

section checking what's shuttuhs-ed

definition: a room (called myr) is shutted:
	consider the finished-rule of myr;
	if the rule failed, no;
	repeat with q running through maindir:
		let qr be the room q of myr;
		if qr is nowhere, next;
		if room-dist of qr < room-dist of myr, next;
		if qr is not shutted, no;
	yes;

chapter lovoling

cap-vol is a truth state that varies. cap-vol is true.

lovoling is an action out of world.

understand the command "lovol" as something new.
understand the command "lo vol" as something new.

understand "lovol" as lovoling.
understand "lo vol" as lovoling.

carry out lovoling:
	abide by the cap-check rule;
	say "The pact cap's volume is [if cap-vol is false]already[else]now[end if] off, so it won't make a noise when you examine stuff that requires a weird action.";
	now cap-vol is false;
	the rule succeeds;

chapter lovoling

lovevoling is an action out of world.

understand the command "lovevol" as something new.
understand the command "love vol" as something new.

understand "lovevol" as lovevoling.
understand "love vol" as lovevoling.

this is the cap-check rule:
	if player does not have pact cap, say "You need to figure how to get the pact cap, first." instead;

carry out lovevoling:
	abide by the cap-check rule;
	say "The pact cap's volume is [if cap-vol is true]already[else]now[end if] on, so it will make a noise when you examine stuff that requires a weird action.";
	now cap-vol is true;
	the rule succeeds;

chapter refering

refer-yet is a truth state that varies.

refering is an action out of world.

understand the command "refer" as something new.

understand "refer" as refering.

carry out refering:
	if refer-yet is false:
		say "Yes! That's a slightly more appropriate way to look at the verb list, here.";
		abide by the LLP rule; [REFER]
		now refer-yet is true;
	try verbing;
	consider the LLP or normal score changes rule;
	the rule succeeds;

chapter ting

talktoing is an action applying to one thing.

understand the command "t" as something new.
understand the command "ta" as something new.
understand the command "greet" as something new.
understand the command "talk" as something new.
understand the command "talk to" as something new.

understand "t [something]" as talktoing.
understand "ta [something]" as talktoing.
understand "greet [something]" as talktoing.
understand "talk [something]" as talktoing.
understand "talk to [something]" as talktoing.

does the player mean talktoing an NPCish person: it is very likely.

carry out talktoing:
	if noun is scorn rocs, say "The rocs do not let up their scornful gaze." instead;
	if noun is stark rats, say "The rats squeak combatively." instead;
	if noun is not a person, say "Talking to people or, at least, animals is your best bet." instead;
	now noun is talked-yet;
	if talk-text of noun is empty, say "Nothing. (change this)" instead;
	say "[talk-text of noun][line break]" instead;
	the rule succeeds. [see volume dialogue for all the specifics]

a person has text called talk-text.

after doing something when noun is a person (this is the let player assume gender rule):
	if noun is not Ms Ism:
		set the pronoun him to the noun;
		set the pronoun her to the noun;
	continue the action;

after doing something when second noun is a person (this is the let player assume second noun gender rule):
	if noun is not Ms Ism:
		set the pronoun him to the noun;
		set the pronoun her to the noun;
	continue the action;

after talktoing:
	beep-if-vol the noun;
	continue the action;

check asking someone about:
	say "You don't ever need to ask about specific subjects. ASKing about redirects to TALKing TO a person... which itself only gives minimal clues. If you want to give or use something, USE X ON Y.";
	try talktoing the noun instead;

chapter drinking

drink-warning is a truth state that varies.

the block drinking rule is not listed in any rulebook.

check drinking:
	if noun is past sap, say "Too thick." instead;
	if noun is dose sod, say "You're not sick." instead;
	if noun is puce cup:
		if puce cup is empty, say "There's nothing to drink in the puce cup." instead;
		say "Ugh. The [if puce cup is soddy]sod[else][sir-sap][end if] looks unpalatable, unless you had a good reason. You don't." instead;
	if noun is Elan Ale, say "No drinking on the job. Besides, you've already done enough swapping to realize you might be able to trade it for something more useful." instead;
	if noun is Gorge Grog, say "One look at the grog, and you realize you're not up to such super-powered alcohol." instead;
	if noun is murdered rum, say "The rum part is drinkable, but the murdered rum isn't." instead;
	say "[if noun is drinkable]Pish! Sip?![else][']S not wet. Ew--TONS.[end if]";
	if drink-warning is false, say "(You don't need to drink anything in this game. Liquids have other purposes. Be glad I didn't implement Pee Keep, Loo Pool or Lav Oval.)[paragraph break]";
	now drink-warning is true instead;

chapter eating

eat-warning is a truth state that varies.

check eating:
	if noun is SOME DEMOS, say "You haven't used [i]SOME DEMOS[r] yet, so you devour its essence. Something ordinary could become...well, ART." instead;
	if noun is DWELT LEWD, say "I really don't want to know." instead;
	if noun is a book, say "There's no real information for you to devour, but who knows, maybe someone else can. Figuratively, at least." instead;
	if noun is a helpdoc, say "This is not a spy game. If it were, [the noun] would already have self-destructed." instead;
	if noun is gnu dung, say "Gag!" instead;
	if noun is ark of okra, say "You don't know how long it's been out here. It's probably, like, the vegetable version of wax fruit[if number of carried ingredients > 0]. But after staring at the ark, the food in your inventory looks more delicious[end if]." instead;
	if noun is demo med, say "That would only be a temporary reprieve from your troubles. Plus, what if it is a demon-o-med?" instead;
	say "[if noun is edible]Food? Oof![else]You contemplate a wan gnaw, but no voice says 'Naw. G'wan!'[end if]";
	if eat-warning is false, say "[line break](You don't need to eat anything to win. [if martini tram is off-stage]Food may be more useful in other ways[else]You already worked with food enough in Mont Nom[end if].)[paragraph break]";
	now eat-warning is true instead;

chapter jumping

the block jumping rule is not listed in any rulebook.

check jumping:
	if player is in Trapeze Part, say "While bouncing up and down is sort of palindromic in its own way, it won't help you in the game. [if epicer recipe is off-stage]Or help you to fix[else]You already fixed[end if] the ten-level net." instead;
	if player is in Moo Room and hay is not moot, say "There's not enough hay to jump on or into. Besides, this game is obviously far too serious for such frivolity!" instead;
	say "You only manage a po['] hop (you don't need to jump in this game)." instead;

chapter burning

the block burning rule is not listed in any rulebook.

check burning: next-rand table of burnies instead;

chapter saying yes

to say ynret: say "[line break]NOTE: if the game asks you a question, and the usual prompt appears, the question is usually rhetorical"

yes-yet is a truth state that varies.

the block saying yes rule is not listed in any rulebook.

check saying yes:
	next-rand table of yessies;
	if yes-yet is false:
		now yes-yet is true;
		say "[ynret].";
	the rule succeeds;

chapter saying no

no-yet is a truth state that varies.

check saying no:
	next-rand table of noesies;
	if no-yet is false:
		now no-yet is true;
		say "[ynret].";
	the rule succeeds;

chapter attacking

check attacking:
	if noun is trap mart rampart, say "You'd suffer zoo boobooz if you tried." instead;
	if noun is pact cap, say "But it's decidedly a pacifi-cap!" instead;
	if noun is made dam, say "You don't want to make it a ... maddened dam." instead;
	if noun is eels, say "Eel emo melee?!" instead;
	if noun is a workable, say "Bash?! Sab!" instead;
	if noun is KAOS Oak, say "Would you believe ... you did no damage? Sorry about that, chief." instead;
	if noun is ergot ogre, say "The ogre could beat you up, but even if it couldn't, it'd do a pox-op or worse on you." instead;
	if noun is player, say "PvP!" instead;
	if noun is senile felines, say "You don't want to hear them go RWOWR." instead;
	if noun is kayo yak, say "Maybe there is a less violent way to motivate the yak to [if being-chased is true]move as you want or need it to[else]get moving[end if]." instead;
	if noun is cross orc, say "It's not a Cro Magnon-Am Orc, but it'd still trounce you." instead;
	if noun is ME Totem, say "The Yuge Guy, momentarily scared, calls 'Heh! Eh?' once he sees you're too weak to do any REAL damage." instead;
	if player is in Dirge Grid:
		if noun is a person, say "You're up against more than physical force could solve[if player has taboo bat]. Plus, you have two weapons: the taboo bat and the yard ray[end if]." instead;
		if taboo bat is moot:
			say "You really only have one weapon, the yard ray.";
			try useoning yard ray with noun instead;
		say "You need to specify your weapon with USE." instead;
	next-rand table of attackings;
	the rule succeeds;

chapter going

definition: a room (called rm) is wally:
	if rm is Moo Room, yes;
	if map region of rm is not Yelpley, no;
	yes;

to say chase-pass: if being-chased is true, now chase-mulligan is true;

to say up-down-check:
	let xud be 0;
	unless the room up from location of player is nowhere, increment xud;
	unless the room down from location of player is nowhere, increment xud;
	if xud is 0, continue the action;
	say " (";
	unless the room up from the location of player is nowhere, say "up=[othdir of up] here";
	if xud is 2, say ", ";
	unless the room down from the location of player is nowhere, say "down=[othdir of down] here";
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

section rules to be shuffled

the new generic going reject rule is listed before the can't go that way rule in the check going rules.

check exiting: try going outside instead;

check going (this is the new generic going reject rule): [check going nowhere rules are listed individually by room, so they come first]
	if noun is outside:
		if number of viable directions is 1, try going a random viable direction instead;
		say "OUT or any synonym is never necessary in the game, though if there is only one exit direction, you'll go that way." instead;
	if noun is inside, say "You don't ever need to use IN in the game. Just the four cardinal directions." instead;
	if the room noun of location of player is nowhere:
		let nvi be number of viable directions;
		say "[chase-pass][if location of player is wally][one of][or]Hall, ah? [in random order]Wall! Aw.[paragraph break][end if]You can [if nvi is 1]only [end if]go [if nvi is 1]back [else if nvi is 3]the other ways: [else if nvi is 2]both [end if][list of viable directions] here[up-down-check]." instead;

check going (this is the reject noncardinal directions rule):
	if noun is diagonal, say "Diagonal directions aren't used in this game." instead;
	if noun is up or noun is down:
		if the room noun of location of player is nowhere:
			say "You never need to go up or down in this game. It's pretty ... level. There is no Elavata[']-Vale.[paragraph break]Though sometimes these directions act as a backup to the main cardinal directions--for instance, up to or down from [if player is in Mont Nom]here[else if Mont Nom is visited]Mont Nom[else]a hill[end if].";
			if player has Spur Ups, say "[line break]You DO have to do something up-ish with the Spur Ups, though. Just not GOing.";
			the rule succeeds;

the reject noncardinal directions rule is listed first in the check going rulebook.

chapter smelling

check smelling when noun is the location:
	say "[one of]NOTE: smelling with no argument will most likely smell the location, not anything in your inventory.[or][stopping]";
	if in-work and stinky knits are not moot, try smelling rotator instead;
	if stinky knits are quicknear, now noun is stinky knits;
	if y-poopy, try smelling gnu dung instead;
	if player is in Flu Gulf, now noun is mush sum;
	if player is in Emo Dome or player is in Red Roses Order, say "Roses ... or ..." instead;
	if player is in Yack Cay or player is in Swamp Maws, say "A morass aroma." instead;
	if player is in Moo Room, say "Hay! Ah!" instead;
	if player is in Deft Fed, say "Ham?! Ah!" instead;
	if player is in Mont Nom, say "Everything smells delicious. Life is good[if Ian is in Mont Nom], even with Ian around[end if][if martini tram is off-stage]. And there's a smell from the Ark of Okra. Hmm[end if]." instead;
	if player is in My Gym, say "Well ... ew." instead;
	if butene tub is quicknear, try smelling butene tub instead;
	if Yuge Guy is quicknear, try smelling Yuge Guy instead;
	continue the action;

check smelling an ingredient:
	if player is in Mont Nom, say "You didn't expect [the noun] would smell this nice, but maybe that is the magic of Mont Nom. You are feeling a bit hungry." instead;
	if noun is snack cans, say "Delicious, if not nutritious." instead;
	if noun is gift fig, say "Nice and fruity and not too young or ripe." instead;
	say "It smells a bit better than it looks. Maybe it could be used as a condiment to spice up 'real' foods, in the right place." instead;

check smelling:
	if noun is gnu dung, say "Gag! The gnu dung [if gnu dung is moot]in the poo coop[end if] is worse than an emu fume!" instead;
	if noun is stinky knits, say "The stinky knits take over your senses and smell of stunk-nuts." instead;
	if noun is brag garb, say "[if troll ort is moot]IT smells odd, now. It makes you both mad and happy at the same time[else]It smells almost too perfumed. It's a bit choking, and maybe you could use something to mitigate or eliminate the smell[end if]." instead;
	if noun is dork rod, say "You might expect a rod odor, but there isn't one. OR MAYBE IT IS SO INGRAINED IN YOU, YOU NO LONGER SMELL IT." instead;
	if noun is butene tub, say "The butene tub smells kind of nice. You were a bit worried there, because around here, a tub COULD smell really nasty, if you think about it." instead;
	if noun is mush sum, say "Unsurprisingly, the mush sum emits an unavoidable musk sum." instead;
	if noun is troll ort, say "The troll ort is too dusty to get a whiff of, at least for your relatively insensitive human nose. Maybe you could probably USE it on something to bring its smell out. But it LOOKS like it should smell weird." instead;
	if noun is rotator, say "[if stinky knits are moot]It no longer smells of detergent. I guess it used it all on the stinky knits.[else]There's a whiff of detergent coming from the rotator. It probably has some way to know if something is dirty enough. Technology![end if]" instead;
	if noun is poo coop, say "[if gnu dung is moot]You risk it, and ... it doesn't smell bad at all. Technology![else]If the poo coop's been used before, you can't smell the evidence." instead;
	if noun is Yuge Guy, say "The Yuge Guy smells of an amoral aroma[if brag garb is not off-stage] even worse than the Turbo-Brut from the Brag Garb[end if]." instead;
	if noun is ergot ogre, say "The ergot ogre smells of torn rot." instead;
	if noun is Sniffins, say "One whiff is proof enough [Sniffins] doesn't deserve an[if YOB ATTABOY is moot]other [end if]alternate name of Smellems." instead;
	if noun is cross orc, say "If a sentient being could, the cross orc would smell of desperate get-rich-quick schemes." instead;
	if noun is a person:
		if noun is a guhthug, say "[noun] is only morally dirty, I guess. You'll need another action to get rid of him." instead;
		if player is in Dirge Grid, say "You'd need some smelling salts after if you got close enough." instead;
	if noun is Ark of Okra, say "[if martini tram is off-stage]You think you vaguely smell alcohol[else]It smells just like okra with the martini tram gone[end if]." instead;
	if noun is a person, say "That'd be a bit rude, even to people who ARE in your way." instead;
	say "Noses, on[one of]! (you don't need to smell anything in this game, though some specific items give silly text.)[or]![stopping]" instead;

to decide whether y-poopy: [also used in mistakes file]
	if gnu dung is quicknear, yes;
	if player has poo coop and gnu dung is not moot, yes;
	no;

chapter singing

the block singing rule is not listed in any rulebook.

check singing:
	if player is in Deft Fed or Bond Nob is quicknear, say "[if player is in Deft Fed]The Bond Nob[else][Sniffins][end if] tells you not to sing unless you've had your fill of Regale-Lager.[paragraph break]There is none in this game." instead;
	next-rand table of singstuff;
	the rule succeeds;

chapter silly swearing

the block swearing mildly rule is not listed in any rulebook.
the block swearing obscenely rule is not listed in any rulebook.

check swearing mildly, try swearing obscenely instead;

swearies is a number that varies.

check swearing obscenely:
	if poop-boob-yet is true, say "[one of]Despite having found the right way to swear here, you reaffirm your respect for the classics. How thoughtful! Anyway...[paragraph break][or][stopping]";
	next-rand table of swearstuff instead;

chapter sleeping

slept-yet is a truth state that varies.

the block sleeping rule is not listed in any rulebook.

check sleeping:
	if slept-yet is false:
		now slept-yet is true;
		say "Zzz.[paragraph break]Wait, no. That's cheating...[paragraph break]To cot?[paragraph break]No, that's a bit forced.[paragraph break]Let's pretend you're waiting, instead.[paragraph break]";
	try waiting instead;

chapter waiting

check waiting: next-rand table of waittxt instead;

chapter plughing

plughing is an action out of world.

understand the command "plugh" as something new.

understand "plugh" as plughing.

carry out plughing: say "GULP." instead;

chapter xyzzying

xyzzying is an action out of world.

understand the command "xyzzy" as something new.

understand "xyzzy" as xyzzying.

carry out xyzzying:
	if screenread is true:
		say "XYZZZY.[paragraph break]X.";
	else:
		say "...[paragraph break]...[paragraph break][fixed letter spacing]\   /[line break] \ /[line break]  X[line break] / \[line break]/   \[line break]" instead;

chapter useing

useoning it with is an action applying to two things.

does the player mean useoning the noun with the noun: it is very unlikely.

understand the command "use" as something new.

understand "use [something] on [something]" as useoning it with.
understand "use [something] with [something]" as useoning it with.

to build-the-tron:
	now all tronparts are in devreserved; [ic]
	if redact-postrule:
		say "You use the epicer recipe you found in the Trapeze Part to build a north-tron that destroys the KAOS Oak to the north of Fun Enuf!";
	else:
		say "[if epicer recipe is nox]You're clueless how, at first. But then you take a look at the epicer recipe[else]You build the North-Tron with the instructions from[end if] the epicer recipe after a few 'How? OH!' moments. It points north and blasts a hole in the [kaoscaps] with a huge tron snort, but some of the energy bounces back and vaporizes it! I guess you could call it a martyry tram, now.[paragraph break]Anyway, you tear up the epicer recipe and throw it in the air to make confetti as celebration. You must be close now!";
	moot epicer recipe;
	moot KAOS Oak;
	now Dirge Grid is mapped north of Fun Enuf;
	now Fun Enuf is mapped south of Dirge Grid;

chef-yet is a truth state that varies.

chef-gen-clue is a truth state that varies.
chef-Ian-clue is a truth state that varies.

to chef (i1 - an ingredient) and (i2 - an ingredient):
	if player is not in Mont Nom:
		now chef-gen-clue is true;
		say "You're not in the right place to mix food together.";
		continue the action;
	if Ian is in Mont Nom:
		now chef-Ian-clue is true;
		say "Hey! That's an idea. But not with Ian around.";
		continue the action;
	if i1 is liquid and i2 is liquid:
		say "Those are both too liquid to go together.";
	else if i1 is solid and i2 is solid:
		say "Those are both too solid to go together.";
	else:
		now chef-gen-clue is false;
		say "You mix [the i1] with [the i2] in front of the Ark of Okra. You hear a distant rumble as the mixture is swept from your hands and through the Ark of Okra, which shakes visibly.[paragraph break]";
		moot i1;
		moot i2;
		score-inc; [Grebeberg/USE GIFT FIG ON MAYO YAM&USE SNACK CANS ON UFO TOFU]
		if number of moot ingredients is 4:
			verify-done rev-second-food-combo rule;
			say "A martini tram rattles out, de-garaged, from behind the Ark of Okra. Guess you need drinks with your, uh, food![paragraph break][if player does not have the epicer recipe]You're shocked to see it, and it rolls further down, over the turf rut to Dumb Mud, then back through the Seer Trees to [Fun Enuf], and you follow[else]But you're prepared for it, with your epicer recipe. You move it back to [Fun Enuf], where it looks like a good base structure for your North-Tron[end if].";
			move martini tram to Fun Enuf;
			drop-player-at Fun Enuf;
			say "After all that excitement, you realize that the martini tram could've been a KO wok. You feel relief at dodging something worse.";
		else:
			verify-done rev-first-food-combo rule;
			say "You suspect something is behind there! Maybe if you can find another combination, you'll see what.";
			now chef-yet is true;

definition: a thing (called th) is notyet:
	if th is off-stage, yes;
	if th is in TempMet, yes;
	no;

to decide what number is useprio of (th - a thing): [saving a lot of space for numbers. The higher the number, the more likely it is to be a 2nd item and one whose "reject" text trumps the first. High priority is given to blocker or fixed-in-place items. The player is highest, because that gives an automatic reject.]
	if th is the player, decide on 30;
	if th is test set, decide on 29;
	if th is yard ray, decide on 28;
	if th is resale laser, decide on 27; [resale laser/yard ray etc. should always be just above everything else, because shooting stuff up shouldn't work.]
	if th is a workable, decide on 25; [workables need to be pretty high up]
	if th is stole lots or th is sto lots, decide on 24; [stole lots is only there briefly, and you want to reject sto lots ASAP]
	if th is lie veil, decide on 22;
	if th is scorn rocs, decide on 22;
	if th is wash saw, decide on 22;
	if th is Gal Flag, decide on 21;
	if th is tract cart, decide on 20;
	if th is DIFF ID, decide on 18;
	if th is a person, decide on 15;
	if th is a tronpart, decide on 10;
	if th is Ark of Okra, decide on 8;
	if th is an ingredient, decide on 5;
	decide on 1;

to verify-done (ru - a rule):
	repeat through table of goodacts:
		if there is a preproc entry and preproc entry is ru:
			now done entry is true;
			continue the action;
	if debug-state is true, say "DEBUG: Couldn't find [ru] in table of goodacts.";

noun-person-note is a truth state that varies.

definition: a person (called per) is dialoguey:
	if per is kayo yak, no;
	if per is ergot ogre, no;
	if per is stark rats, no;
	if per is sleep eels, no;
	if per is opossum, no;
	if per is scorn rocs, no;
	yes;

noun-flip is a truth state that varies.

check useoning it with (this is the main useon function rule):
	if noun is a person and noun-person-note is false and noun-flip is false:
		now noun-person-note is true;
		say "NOTE: it's semantic, but usually, you'll want to use something ON a person. The game should flip the nouns appropriately.";
	now noun-flip is false;
	if useprio of noun > useprio of second noun:
		if debug-state is true, say "DEBUG switching X on Y to Y on X: [noun] [useprio of noun] [second noun] [useprio of second noun].";
		now noun-flip is true;
		try useoning second noun with noun instead; [e.g. machines in work row always go second]
	if noun is second noun, say "It's not productive to use something on itself, even with this game being full of palindromes." instead;
	if noun is a workable and second noun is a workable, say "The machines are fixed in place. You can't use one on the other." instead;
	if second noun is tract cart:
		if noun is SOME DEMOS, say "No, [i]SOME DEMOS[r] is yours, now." instead;
		say "Very thoughtful, but you [if any-books-left]can just take books one at a time[else]don't need to replace [noun] if you don't know what to do with it yet[end if]." instead;
	if noun is a helpdoc or second noun is a helpdoc:
		if noun is epicer recipe and second noun is a tronpart:
			if number of off-stage tronparts is 1, say "You can't do too much with just [the second noun]." instead;
		else:
			say "[if second noun is code doc]The basic instructional materials you find don't need the Code Doc to decipher them[else]All the help literature you find is for review only[end if]." instead;
	if second noun is the player:
		if noun is a book, say "You can just READ [noun]. You don't need to do any deep reading or analysis." instead;
		if noun is soot tattoos, say "That'll work, when you find a way to make a pattern of the soot tattoos. They're too plain, now." instead;
		say "You never need to use anything explicitly on yourself." instead;
	if noun is a workable or second noun is a workable: [may not need "noun is a workable" with useprio now but want to make sure of it]
		if wr-short-note is false:
			say "(NOTE: You can abbreviate this command with [b]ROT[r], [b]REI[r] and [b]REV[r] for the respective machines, later.)[paragraph break]";
			now wr-short-note is true;
	if noun is a book and second noun is a workable:
		say "You can't alter what's in a book. You don't need to[if noun is not SOME DEMOS]. Someone may appreciate it as it is[end if]." instead;
	if second noun is a workable and second noun is workedout, say "No point. The [second noun] is broken." instead;
	if noun is an ingredient:
		if second noun is an ingredient:
			chef noun and second noun;
			the rule succeeds;
		if second noun is ark of okra, say "No--the okra doesn't seem to mix with anything. But you feel like you could mix other foods together, here." instead;
	if noun is a tronpart or noun is epicer recipe:
		if second noun is a tronpart or noun is epicer recipe:
			if player does not have epicer recipe, say "Those two things seem to go together, but you don't have detailed instructions." instead;
			if number of notyet tronparts is 1, say "[recxcheck of false]You see how everything fits--even the [random notyet tronpart], which you don't have yet. Rats, so close!" instead;
			if number of notyet tronparts is 2, say "[recxcheck of false]That looks like the start of something. But you still need to find a couple things." instead;
			if player is not in Fun Enuf: [this could happen, since the martini tram only stays in Fun Enuf.]
				if Ms Ism is quicknear or Yuge Guy is quicknear, say "[recxcheck of false]But you'll need to deal with [if player is in Red Roses Order]Ms. Ism[else]the Yuge Guy[end if] first." instead;
				say "[recxcheck of false]You might be better served using these things in [Fun Enuf], where the martini tram is. Go there?";
				if the player no-consents, say "OK, but protip: that's where you need to assemble things." instead;
				move player to Fun Enuf, without printing a room description;
			score-inc; [Dim Mid/USE TNT ON ORE ZERO]
			build-the-tron instead;
	let got-any be false;
	repeat through table of goodacts:
		if there is no use1 entry:
			if debug-state is true and there is a use2 entry, say "WARNING: there is a blank use1 entry with use2 of [use2 entry].";
			next;
		if there is no use2 entry:
			if debug-state is true, say "WARNING: there is a blank use2 entry with use1 of [use1 entry].";
			next;
		if noun is use1 entry and second noun is use2 entry, now got-any is true;
		if noun is use2 entry and second noun is use1 entry, now got-any is true;
		if got-any is true:
			if there is a preproc entry:
				consider the preproc entry;
				unless the rule succeeded, the rule succeeds;
			if there is a getit entry, now player has getit entry;
			if d2 entry is true, moot use2 entry;
			if d1 entry is true, moot use1 entry;
			now done entry is true;
			if sco entry is true:
				if there is a reg-plus entry:
					reg-inc reg-plus entry;
				else:
					score-inc; [ignore]
			else:
				if debug-state is true, say "DEBUG: not giving point for [use1 entry]/[use2 entry] use.";
			say "[babble entry][line break]";
			if there is a postproc entry:
				[if debug-state is true, say "(considering [postproc entry])[line break]";]
				consider the postproc entry;
				consider the shuttuhs-after-scoring rule;
			if second noun is a workable, wear-down second noun;
			if there is a getit entry and player has getit entry: [try to let "it" be defined]
				set the pronoun it to getit entry;
			else if use1 entry is moot and use2 entry is not moot:
				set the pronoun it to use2 entry;
			the rule succeeds;
	repeat through table of specific use rejects:
		if noun is use1 entry and second noun is use2 entry, say "[babble entry][line break]" instead;
		if noun is use2 entry and second noun is use1 entry, say "[babble entry][line break]" instead;
	if second noun is a workable, abide by the machine message rules for the noun; [order is important here. This can get trumped if placed below the following rules, but it is specific to Work Row, so it needs to be here.]
	let found-shift be false;
	repeat through table of shiftables:
		if noun is use1 entry and second noun is use2 entry, now found-shift is true;
		if noun is use2 entry and second noun is use1 entry, now found-shift is true;
		if found-shift is true:
			if there is a use-text entry, say "[use-text entry][line break]";
			try useoning use3 entry with use2 entry instead;
	repeat through table of use redir:
		if noun is use1 entry:
			if second noun is a dialoguey person and there is a person-reject entry, say "[person-reject entry][line break]" instead;
			if there is a thing-reject entry, say "[thing-reject entry][line break]" instead;
		else if second noun is use1 entry:
			if noun is a dialoguey person and there is a person-reject entry, say "[person-reject entry][line break]" instead;
			if there is a thing-reject entry, say "[thing-reject entry][line break]" instead;
	if noun is a book:
		if second noun is a person and noun is SOME DEMOS, say "You glance [if SOME DEMOS is xed]again [end if]at SOME DEMOS and can't help feeling it speaks to you and not other people." instead;
		repeat through table of bookrejects:
			if second noun is use2 entry, say "[book-reject entry][line break]" instead;
	repeat through table of cantuse:
		if noun is use1 entry or second noun is use1 entry, say "[babble entry][line break]" instead;
	repeat through table of person specific rejects:
		if noun is use1 entry or second noun is use1 entry, say "[babble entry][line break]" instead;
	say "You think of ways to do that productively, but nothing comes up." instead;

The machine message rules are an object-based rulebook.

definition: a thing (called t) is exhausted:
	unless test set is off-stage, no;
	unless t is reified or reifier is workedout, no;
	unless t is rotated or rotator is workedout, no;
	unless t is revived or reviver is workedout, no;
	yes;

a machine message rule for a thing (called t):
	if t is an ingredient, say "The only machine you should put food in is a microwave. Or, maybe, a BAKE-KAB. Or a heata['], eh?" instead;
	if t is a tronpart, say "No, [the t] [if epicer recipe is xed]is[else]seems[end if] too important." instead;
	if t is exhausted, say "Drat. None of the machines worked for [the t]. You may need to use it somewhere else." instead;
	if second noun is reifier, now t is reified;
	if second noun is rotator, now t is rotated;
	if second noun is reviver, now t is revived;
	if t is Nat's Tan, say "Ugh. Nat's Tan is hopelessly awful. You'll need to fob it off on someone or something." instead;
	if t is pact cap, say "The pace cap has the VOL option, as well as [if cap-ever-pace is false]another option[else]PACE[end if], but that's probably enough. It doesn't need drastic fixing." instead;
	if t is el doodle, say "None of the machines seems equipped for deciphering. A person might be able to do it better." instead;
	if t is radar, say "The radar is pretty intricate. There's no way to [if radar-used is 2]super[else]re[end if]charge it." instead;
	if t is wash saw, say "Nothing happens when you put the wash saw in [the second noun]. The saw also isn't sharp enough to cut [the second noun] either, not that that would be productive." instead;
	if t is psi wisp, say "[chase-pass]Alas, the psi wisp isn't just going to fit in there willingly. Maybe another machine, though..." instead;
	if t is listed in postmachines, say "The [second noun] hums ominously as you bring [the t] close. You already used the [prem of t] to make or reveal [the t]. Maybe you should do something else." instead;
	if t is listed in premachines, say "Nothing happens. And you felt optimistic there! Hmm." instead;
	say "Nothing happens at all. Maybe [the t] do[unless t is plural-named]es[end if]n't need any sort of machine augmentation." instead;

to say prem of (th - a thing):
	repeat through table of goodacts:
		if there is a getit entry and getit entry is th:
			say "[if there is a use2 entry]the [use2 entry][else]a machine[end if]";
			the rule succeeds;
	say "a machine";

section failed useons

table of bookrejects [xxbr]
use2 (an object)	book-reject
Bond Nob	"The Bond Nob was probably too cool for school and is definitely too cool for reminders of school."
Code Doc	"'That's probably a nice easy read, but I'd rather have something challenging to work through.'"
cross orc	"The cross orc is not big on books."
Door Frood	"'Pfft, nah, not clever and edgy enough.'"
Ian	"'I'm a food snob, not a book snob. Geez!'"
King Nik	"'Hm, maybe, but I need some serious policy discussions.'"
Known Wonk	"'I have enough hard knowledge. I need something clever and fun.'"
Ms Ism	"Any simple book you could find would be beneath Ms. Ism."
Sniffins	"'[if yob attaboy is moot]I'm too busy to read! I have a thriving business[else]That won't help my business thrive[end if]!'"
tao boat	"You sense that the tao boat requires more than just wordy knowledge. It requires ... feeling."
Yuge Guy	"The Yuge Guy doesn't bother with books--not even a ghostwritten, self-serving autobiography."
[zzbr]

[??table of generic fails for if an item has something that works with it]
[?? perl script to make sure nothing in the cantuse is in the use1 or use2 slot of table of goodacts]

table of cantuse [xxcant]
use1	babble
ark of okra	"While the ark inspires you to want to mix foods, you don't want to mix anything with IT. You don't know how long that okra's been there!"
balsa slab	"You'll probably need to make something out of the balsa slab, but not like that."
Bros' Orb	"[if orb is in voodoo v]Nothing physical seems to work on the orb. You need a psychological push, here[else]The orb needs something to shine its light on, something to reveal a truth[end if]."
cassettes sac	"You need something powerful to clean up the cassettes sac."
cave vac	"The Cave Vac doesn't seem like it could clean [the noun] productively."
Dave	"Dave's not useful, man."
DIFF ID	"The DIFF ID remains impassive. [if player has state tats]You look at your state tats, which seem like they'd work better[else]Perhaps you need to find something that could identify you better[end if]."
Dirt Rid	"The Dirt Rid doesn't seem like it could clean [the noun] productively."
DNA band	"The DNA band is useless on its own. It probably needs some sort of jolt to become useful, or sentient."
DNA hand	"The DNA hand remains motionless. It needs mobility, somehow, to be useful to you."
dork rod	"You sense the dork rod doesn't need changing. Just holding it makes you a bit more comfortable with your own faults, big or small."
el doodle	"El doodle definitely needs a cleaning. But that doesn't seem to work."
enact cane	"The enact cane needs to be augmented, but not quite like that."
ergot ogre	"The ogre can't be bribed or baited. At least, not by you. You're not fast or strong enough to outfox (or out-any other animal) it on your own. Plus, you worry anything that touches the ergot ogre might shrivel up. Maybe you need the services of someone or something that can beat up the ogre without touching its skin." [?? how to pick off duplicates in a table?]
gnu dung	"There's a lot of gnu dung. You'll need something tailored specifically to it, to clean it up."
Gorge Grog	"The Gorge Grog is so concentrated, it's probably only good for chemical warfare."
Gulf Lug	"The Gulf Lug groans. You probably need to find some sort of treatment. It might not have to be fancy."
guru rug	"The guru rug remains a bit too esoteric."
Ian	"Ian's worse than useless. You need to use your wit on him."
Kayo Yak	"The Kayo Yak grunts. Looks like you can't, or don't want to, use anything directly on it."
King Nik	"King Nik scratches his head and shrugs. He needs a confidence booster."
level net	"There's got to be a way to untangle the net on your own, so it doesn't get cut or destroyed."
lie veil	"The lie veil remains undisturbed. It's as if it's pretending you're not even trying. Maybe you'll have to be really violent."
martini tram	"The martini tram is a good base to build [if epicer recipe is xed]the north-tron[else]something big[end if]. Putting random items on it won't help."
mist sim	"Anything used on the mist sim might disappear into it."
Nat's Tan	"[if player does not have Nat's Tan]You may need to steel yourself to take the Nat's Tan, somehow[else]No, you need to look for something that would be utterly disgusted by having Nat's Tan squirted on it[end if]."
Ned	"Ned wants a fight, and you need some other way around him. Bribery or violence doesn't seem sufficient. It might be simpler than you think. Ned's pretty ... basic."
opossum	"The opossum isn't useful, but perhaps you could be nice and show it a way that it doesn't have to be. A simple gesture."
Pact Cap	"Your pact cap is fine where it is, on your head[if current action is useoning][cap-use][end if]."
past sap	"The past sap needs an appropriate container to hold it when it liquefies in warmer areas."
Psi Wisp	"The Psi Wisp is impervious to bribery or normal physical attacks. You need to outrun and outsmart it."
radar	"The radar detects no dark radon ... and nothing less harmful/more useful. But maybe there's something hidden elsewhere."
redness ender	"The redness ender is good for destroying stuff. Probably evil stuff. You don't need to vaporize anything you're carrying[if Rob is in Worn Row]. Or even Rob[end if]."
rep popper	"[if player does not have popper and dork rod is moot]Hmm. You get the feeling you don't have to do anything fancy. Just TAKE the popper[else if player does not have popper]When the time comes, you may be able to just TAKE the popper. Now, it's a bit too intimidating[else]The rep popper needs to attack something with, well, REP. Something that needs taking down a peg[end if]."
resale laser	"The resale laser is super powerful and limited. You should probably use it to [if epicer recipe is xed]make the North-Tron[else]some greater purpose than zapping someone or something[end if]."
Rob	"Rob's not going to be obliging. You have to get rid of him, somehow."
scorn rocs	"The scorn rocs are unfazed by much. Even violence doesn't seem to affect them. They sit, looking dignified, or at least superior. You'll need something special and weird to displace them."
senile felines	"It might be more productive to use the felines on themselves, in a certain way."
sharp rahs	"The rahs need to be combined (USEd) with some other motivational material. Something less, well, rah-rah."
SOME DEMOS	"Paging through SOME DEMOS again, you get the feeling it's really un-serious and can't help you except with unpractical or self-contradictory items. It must be good with something, but not that."
Spur Ups	"The Spur Ups can't physically levitate anything, but they make you want to do something for yourself, by yourself, to yourself, for a pick up or something like it. You're not sure what, but something-or-other UP."
stinky knits	"The stinky knits remain stinky."
sto lots	"You don't need to do anything with the sto lots. It carries what you need to."
stole lots	"The Stole Lots is not a Tax-At. In other words, bribing Dave to get by won't work. You need to outsmart him."
tame mat	"The tame mat stays, uh, tame. Perhaps you need to enhance it metaphysically, since its message is a bit wack."
tao boat	"The tao boat remains impassive. But surely something you can show it will prove your worth. Probably something with only spiritual value, though."
test set	"You need to use something violent on the test set."
tix exit	"The only thing that could be used on the tix exit are [if player has x-ite tix]your X-Ite Tix[else]tickets, which you don't have yet[end if]."
tract cart	"You don't need to do much with the tract cart except take books from it."
tru yurt	"[if Known Wonk is in Yack Cay]Probably best not to mess with the yurt while the Known Wonk doesn't trust you[else]The yurt needs a good cleaning, but that won't help[end if]."
turf rut	"[if poo coop is moot]You can walk across the tur(f/d) rut now, and that's more than good enough[else]Hmm. Not quite. You'd need a lot of material to fill the turf rut in[end if]."
wordy drow	"The wordy drow moans 'Er ... eh ... there,' pointing to the Liar Grail. The wordy drow must be too incorporeal to accept anything."
x-it stix	"They're just there to block you."
XILE helix	"The XILE helix is there as a memorial. You don't want to alter it in any way."
yahoo hay	"[if SOME DEMOS is not moot]Boy! The hay is weird. You'd like instructions to use it, but at the same time, you don't know if you want or need it[else]The coarser hay should be used for more practical things, now that you made the straw arts, but that's not quite it[end if]."
[zzcant]

to say cap-use: say ". It doesn't need to be used with or on anything else[if kayo yak is not moot]. though it may help you in a pinch later on[end if]"

table of person specific rejects [xxpsr]
use1	babble
cross orc	"The cross orc squints a bit. It doesn't seem big on culture or gifts for their own sake. You may have to be unsubtle, here."
Door Frood	"The Door Frood yawns. A gift would be nice, but THAT seems kind of boring."
liar grail	"The grail just sits there. You may need something to disrupt its grayness."
[zzpsr]

table of use redir [xxur]
use1	person-reject	thing-reject
cave vac	"You need to clean out some bad people figuratively, not clean them up literally."
Dirt Rid	"You need to clean out some bad people figuratively, not clean them up literally."
el doodle	"[if second noun is not proper-named]The [end if][second noun] do[unless second noun is plural-named]es[end if]n't seem up to deciphering things."	"You'd probably need a person to help you decipher El Doodle." [?? x on el doodle]
enact cane	"That could be painful for [if second noun is not proper-named]the [end if][second noun]."
gift fig	"[no-food-share]."
mayo yam	"[no-food-share]."
ME gem	"[if second noun is not proper-named]The [end if][second noun] looks a bit frightened by the power of the ME gem. It must only work on, or for, really bad people or things."	--
murdered rum	"Oof. Brutal. The rum is NOT for drinking. Or poisoning people, good or bad."
Nat's Tan	"You are greeted with a look of revulsion."	--
party trap	"The trap can't work on a person. It's too small, and people are too smart."	"You need to use the party trap on something animate."
pity tip	"You don't want to give it away! You [if navy van is xed]should maybe use it, yourself. Now where was Seedy Dee's?[else]have a feeling you can find Seedy Dee's, if you look hard enough.[end if]"	--
poo coop	"Eww. Gross. Nobody deserves that."	"[if gnu dung is moot]No, you need to find the right thing to empty the poo coop into[else]The poo coop is only good for vacuuming up a certain kind of item[end if]."
snack cans	"[no-food-share]."
UFO tofu	"[no-food-share]."
wash saw	"The saw isn't built for gory violence."	"The saw is best used to trim things there's an excess of, not just to cut stuff down."
yard ray	"Shooting any person would be too violent."	"[ray-rej]."
you buoy	"But it's a YOU buoy. You were meant to figure how to open it, not them."
[zzur]

to say ray-rej:
	if murdered rum is moot:
		say "You can't go shooting stuff up at random. You need to [if test set is not moot]at least test it first[else]find what it can destroy[end if]";
	else:
		say "That doesn't charge the yard ray"

to say no-food-share: say "There's not really enough of [if noun is an ingredient][the noun][else if second noun is not nothing][second noun][else]that[end if] to share, and anyway, most people here need help or comeuppance, not food"

section table of specific use rejects

to say not-thing of (nt - a thing): say "[if nt is noun][second noun][else][noun][end if]"

table of specific use rejects [xxrej] [xxfail] [xxsur]
use1	use2	babble
brag garb	butene tub	"The brag garb is clean enough, and it's not a washtub."
brag garb	tao boat	"[too-boast]."
bros' orb	Gal Flag	"The Gal Flag flutters backwards a bit but remains steady. The Bros['] Orb must work on something!"
bros' orb	ME Totem	"The Bros['] Orb's light bounces off the ME Totem! It seems logically like that should have worked, but the Yuge Guy subverts standard definitions of decency and community."
Bros' Orb	Ms Ism	"As you lift the Bros['] Orb to throw at Ms. Ism, you see yourself in the Mirror Rim. You don't look so great or heroic. In fact, you feel unusually self-conscious. More than you deserve to, you think. The Bros['] Orb is really pulsing right now. Whatever you used it on, you'd likely destroy it, and you're not out to KILL anyone."
bros' orb	tao boat	"[too-boast]."
bros' orb	Yuge Guy	"The Bros['] Orb's light bounces off the Yuge Guy! It seems logically like that should have worked, but the Yuge Guy subverts standard definitions of decency and community."
bunk nub	sleep eels	"That -- well, it almost works. But the bunk nub isn't shaped right to house that many small animals. Maybe it could be changed."
bunk nub	stark rats	"The rats don't need to sleep, and the bunk nub won't make them feel drowsy. You need to get rid of the rats."
Cave Vac	gnu dung	"The Cave Vac sputters. You may need something more specifically suited to the, uh, material to clean up."
cave vac	go by bog	"The bog is too big for that."
cave vac	guru rug	"The guru rug's message is clean. It's just overblown."
cave vac	lie veil	"The Cave Vac doesn't work on morally dirty tricks."
cave vac	soot tattoos	"No, the soot tattoos are good for something. No need to wipe them out."
cave vac	stinky knits	"The smell is crusted into the stinky knits. The cave vac would work better than the Dirt Rid, but it would only make the stinky knits look a bit better."
cave vac	tame mat	"The tame mat's message is clean. It's just not inspiring."
cave vac	troll ort	"The troll ort is crusted over enough that the cave vac wouldn't really clean it."
cave vac	Yuge Guy	"That won't clean up all his dirty tricks."
demo med	Elan Ale	"No, combining alcohol and pills is a bad, bad idea."
demo med	Gorge Grog	"No, combining alcohol and pills is a bad, bad idea."
Dirt Rid	cassettes sac	"[get-rej of cassettes sac]The Dirt Rid wheezes but is unable to clean up the cassettes sac. You need something more powerful."
Dirt Rid	gnu dung	"The Dirt Rid is ineffective and too small. You may need something stronger."
Dirt Rid	go by bog	"The bog is too big for that."
Dirt Rid	guru rug	"The guru rug's message is clean. It's just overblown."
Dirt Rid	lie veil	"The Dirt Rid doesn't work on morally dirty tricks."
Dirt Rid	soot tattoos	"No, the soot tattoos are good for something. No need to wipe them out."
Dirt Rid	stinky knits	"The smell is crusted into the stinky knits. You need a heavier duty tool than the Dirt Rid to clean them up."
Dirt Rid	tame mat	"The tame mat's message is clean. It's just not inspiring."
Dirt Rid	troll ort	"The troll ort is crusted over enough that the Dirt Rid wouldn't really clean it."
Dirt Rid	Yuge Guy	"That won't clean up all his dirty tricks."
DNA band	Code Doc	"You don't know what the Code Doc's degree is in, but you doubt you have to do anything TOO sophisticated with the DNA."
DNA hand	Bomb Mob	"If only the hand were alive, maybe it could steal the TNT from the bomb mob!"
DNA hand	Code Doc	"You don't know what the Code Doc's degree is in, but you doubt you have to do anything TOO sophisticated with the DNA."
DNA hand	DIFF ID	"The DIFF ID doesn't even seem to recognize the DNA hand. Apparently, it is not alive enough."
DNA hand	enact cane	"[man-lab]."
DNA hand	gate tag	"That would mark up the DNA hand, but it might be painful. Perhaps the tag should be impressed on something else."
DNA hand	moor broom	"[man-lab]."
DNA hand	soot tattoos	"The DNA hand doesn't need augmentation, and besides, the soot tattoos are sort of generic. Maybe there's a way to make a pattern of them."
DNA hand	TNT	"If only the hand were alive, maybe it could steal the TNT from the bomb mob!"
DNA hand	Yuge Guy	"The hand doesn't seem to willing or able to move toward the Yuge Guy."
dork rod	Code Doc	"The Code Doc may or may not have gotten picked on in high school for wanting to learn things, so the gift of a dork rod might be upsetting."
dork rod	DIFF ID	"You sense using the dork rod to identify yourself would be especially unhelpful. Well, here, at least."
dork rod	DNA band	"The dork rod remains inert. You gain no brilliant biochemical insight."
dork rod	DNA hand	"The dork rod remains inert. You gain no brilliant biochemical insight." [?? hand/band]
dork rod	kayak	"The dork rod is too weak and wimpy to be an effective paddle."
dork rod	lie veil	"Unfortunately, dorkiness often sees the opposition is lying but is powerless to stop it. You're going to need something more violent to dispel the lie veil."
dork rod	rep popper	"The rep popper would probably make quick work of the dork rod, which must be useful for SOMETHING. So you decide against it."
dork rod	Yuge Guy	"Unfortunately, the dork rod doesn't change people into dorks. Though in the Yuge Guy's case, that'd be an improvement."
dose sod	pact cap	"[cap-is-not-cup]."
el doodle	code doc	"'[get-rej of El Doodle]This isn't quite clear enough for me. If you could clean it up, though, I could help you.'"
el doodle	Known Wonk	"The Known Wonk looks at El Doodle, thinks, and says 'Ugh, sorry, never could decipher these things. No good rules to. Maybe you could use the edits tide, though.'"
el doodle	Revolt Lover	"But the Revolt Lover pretty much offered it to you in the first place."
Elan Ale	cassettes sac	"The Elan Ale isn't high-proof enough to peel any dirt off the cassettes sac."
Elan Ale	DIFF ID	"No electrical wiring is exposed, so you can't short the DIFF ID out."
Elan Ale	el doodle	"There's mp invisible ink here. That'd make El Doodle even more messy." [?? use alcohol on]
Elan Ale	Gulf Lug	"Alcohol is not effective medicine."
Elan Ale	Revolt Lover	"'I can't drink on the job, here!'"
elope pole	code doc	"'[if tent net is moot]I bet you could go neat places with that[else]That might help build something, but I need something that's more a roof[end if].'"
elope pole	crag arc	"The pole is for navigation, not for vaulting. Also, the crag art is too high, even for AK Bubka, Sergei's little-known but even more athletic cousin."
elope pole	go by bog	"The bog is too wide for that."
elope pole	lie veil	"The veil resists the pole easily. You need a more violent implement."
elope pole	made dam	"The pole is for navigation, not for vaulting."
elope pole	Tao Boat	"The Tao Boat is too big to control with the elope pole."
elope pole	TNT	"Ooh! You might be able to touch the TNT, but you wouldn't be able to hook it. You'd get caught. Maybe a more sophisticated implement..."
elope pole	trap mart rampart	"It's not a vaulting pole, and the rampart is too high."
elope pole	turf rut	"Interesting! That'd get you across, but you wouldn't have a way to get back."
elope pole	yahoo hay	"Poking through the yahoo hay with the elope pole turns up nothing. The pole is probably meant more for eloping than searching."
enact cane	guru rug	"The guru rug needs a more metaphysical enhancement."
enact cane	kayak	"The enact cane doesn't seem like the right tool to propel the kayak. It's more for chores."
enact cane	kayo yak	"[if being-chased is true][chase-pass]The yack can already act. Fact![else]That's not the way to get the yak going. Maybe a carrot, not a stick.[end if]"
enact cane	lie veil	"The lie veil is already plenty activated."
enact cane	rep popper	"But that might bust your own rep, since you are the nearest person."
enact cane	tame mat	"The tame mat needs a more metaphysical enhancement."
enact cane	tru yurt	"The enact cane would only be so useful for thwacking the Known Wonk to clean the Tru Yurt, already. It needs something more to help out."
Epoch Cope	Revolt Lover	"'Wish I could be interested in politics, but I'm not.'"
exam axe	balsa slab	"You're not sure what to cut the slab into, and you don't need firewood."
exam axe	Code Doc	"The Code Doc declines your offer. Instruments of violence have no place at [uneven u]."
exam axe	porch crop	"That seems like the right idea, but the Code Doc is the person who should be giving out punishing exams, here. The wash saw, on the other hand..."
gate tag	DIFF ID	"You wave the gate tag in front of the DIFF ID, which beeps for a second, then ... nothing. Maybe the gate tag (or its pattern) needs to be read a different way."
gift fig	cross orc	"[if cross orc is talked-yet]'FIG?! FIG?! VIG! VIG!'[else]That's about the least valuable thing you could give. I suppose, if you're open to spelling abuse, it'd make the orc the crossess['] orc.[end if]"
gift fig	sleep eels	"It seems they want comfort and not food. Besides, it'd be a pain to split up fairly."
gnu dung	turf rut	"That's a good idea, but you can't move the gnu dung onto the turf rut with your bare hands."
gold log	kayak	"The gold log is too heavy to be an effective paddle."
Gorge Grog	bomb mob	"There isn't enough for everyone, so that would probably make them even more unruly."
Gorge Grog	cassettes sac	"That'd clean up the cassettes sac, but it'd probably dissolve it, too."
Gorge Grog	DIFF ID	"No electrical wiring is exposed, so you can't short the DIFF ID out."
Gorge Grog	el doodle	"There's mp invisible ink here. That'd make El Doodle even more messy."
Gorge Grog	Gulf Lug	"Alcohol is not effective medicine."
Gorge Grog	Revolt Lover	"'I can't drink on the job, here!'"
Gorge Grog	yard ray	"The Gorge Grog is pretty strong stuff, but you may need something even stronger."
Gorge Grog	Yuge Guy	"The Yuge Guy doesn't drink, and neither does Johnny. Also, the Yuge Guy may or may not be a germaphobe."
ME gem	cross orc	"The ME gem causes the cross orc to moan and shield its eyes for a bit. Perhaps the ME gem is too much even for the orc's greed. Something more straightforward may work better."
ME gem	Diktat Kid	"The ME gem would be appealing[henchy-list]."
ME gem	Liar Grail	"That might make the liar grail's lies TOO grandiose."
ME gem	lie veil	"Two wrongs don't make a right way through here. The ME gem is about greed. You need force, here."
ME gem	ME Totem	"The egotistical forces in the gem and totem repel each other. Just as well. You don't know if you could survive if such insufferability synergized."
ME gem	Tao Boat	"The tao boat lurches uncontrollably, and a gust of wind blows you back ten feet. It seems like the ME gem is about the worst thing you could possibly have shown to impress it, but on the other hand, that's a potential hint. You need something that's the opposite of the ME gem."
ME gem	Verses Rev	"The Verses Rev sniffs and waves away the ME gem. Perhaps it could entice less spiritual types, but not the Verses Rev!"
ME gem	Yuge Guy	"That might make the Yuge Guy's ego too much to handle."
mr arm	bros' orb	"Mr. Arm seems intimidated by the Bros['] Orb[if orb is not carried], too. You need mental assistance[end if]."
mr arm	enact cane	"[man-lab]."
mr arm	Gal Flag	"This isn't capture the flag."
Mr Arm	gate tag	"Mr. Arm doesn't seem markable."
mr arm	moor broom	"[man-lab]."
mr arm	Ms Ism	"That might be creepier than even Ms. Ism deserves."
mr arm	navy van	"Mr. Arm shakes his/its fist at the navy van, as if the van is in the way of something more important."
mr arm	rep popper	"Having Mr. Arm as an intermediary won't affect whether you can hold on to the rep popper. Maybe Mr. Arm is better suited to steal something else."
Mr Arm	soot tattoos	"The tattoos wouldn't stay on someone/something as metallic as Mr. Arm."
Mr Arm	Yuge Guy	"Mr. Arm doesn't seem to want to move toward the Yuge Guy."
murdered rum	butene tub	"You tremble at the thought of opening the murdered rum. It's spooky beyond having a high alcohol content. Maybe you can use something less drastic on, or in, the tub."
murdered rum	el doodle	"There's mp invisible ink here. That'd make El Doodle even more messy."
murdered rum	test set	"Chemical experiments are not your thing. The murdered rum's pretty caustic, but perhaps it can act as fuel for something else."
NULL ILLUN	Door Frood	"'Like I need it! Other people do! And what's worse, some who read it become less easy to make fun of. Hmmph.'"
NULL ILLUN	King Nik	"'That would help me feel better about failure. But, and I feel kinda guilty for asking, you got any book that would help me avoid failure in the first place?'"
NULL ILLUN	liar grail	"The liar grail would twist the words of [i]NULL ILLUN[r] so badly, you'd be worse for the experience."
NULL ILLUN	Revolt Lover	"'I guess we all could use it a little. But someone else might need it more than me. Um, I hope.'"
pact cap	kayo yak	"The yak already looks faster than you. You might want to use the cap to get away, if the yak started chasing you [if chased-yet of yak is true]again[else]for whatever reason[end if]."
Party Trap	Revolt Lover	"'Whoah! Neat! That's a lot more useful than my art.'"
past sap	pact cap	"[cap-is-not-cup]."
pity tip	DIFF ID	"Nothing happens. The DIFF ID seems to be guarding something important, and while the pity tip can be scanned, it probably helps with something simpler."
pity tip	Door Frood	"The Door Frood is too good for a mere pity tip. Well, in the Door Frood's mind."
poo coop	kayo yak	"You don't need to capture the yak."
poo coop	Liar Grail	"[if gnu dung is in Dumb Mud]There's nothing inside the coop to empty into the liar grail.[else]Maybe if the contents came from a bull and not a gnu, it would be appropriate (this is not a palindrome 'joke.')[end if]"
poo coop	Lie Veil	"The lie veil is only figuratively full of ... oh, wait, this is a family game."
poo coop	pool gloop	"You can't think of anything to do with the pool gloop. There's too much of it to remove to make a path. But on the other hand, the coop is suitable to handle much worse than the gloop."
poo coop	Yuge Guy	"That could be fun, but he might be too normalised to the stuff in the coop to do damage."
puce cup	cross orc	"The only elixir the cross orc might want would be one it could sell to rubes for a huge markup."
puce cup	DIFF ID	"[if puce cup is empty]Even if the puce cup contained liquid, n[else]N[end if]o electrical wiring is exposed, so you can't short the DIFF ID out."
puce cup	gulf lug	"[if puce cup is empty]The Gulf Lug doesn't need trinkets.[else if puce cup is soddy]The Gulf Lug sniffs at the puce cup a bit. 'Ugh. That might be right for someone, but not me.'[else]The Gulf Lug makes a face at the [sap-sirup] in the puce cup.[end if]"
puce cup	scorn rocs	"The rocs [if puce cup is empty]seem extra scornful of your empty puce cup[else if puce cup is sappy]are pure enough. Not a good pure, but pure nonetheless. Maybe the purist sirup could short-circuit something more ambiguous[else]don't look sick. They look sickened, but not sick[end if]."
radar	Code Doc	"The Code Doc inspects the radar briefly. 'Hmm. I bet the radar could detect hidden valuable metals and such behind walls, or places you can't go. Who knows what you might find?'"
radar	girt rig	"The rig is sort of complex, so maybe there's something hidden there, but you don't find anything."
radar	gnu dung	"In dung: nud'in."
radar	go by bog	"The radar detects nothing. So there is probably no horribly bogy gob. But [if sage gas is off-stage]there are plenty of other places you could slip and fall and disappear forever[else]you got the sage gas, already[end if]."
radar	lie veil	"There is nothing wildly metallic behind the lie veil. Or if there is, the lie veil is disrupting the radar. In any case, you probably need to break through the lie veil, and sadly, the radar doesn't help with this."
radar	sleep eels	"A radar isn't supposed to work this way, but somehow, you detect some bitterness at mammals in general. But it's secondary to needing a more comfortable place to sleep."
radar	trap mart rampart	"You detect nothing to the east or west. Maybe other structures like the rampart will hide something, though."
rep popper	Ms Ism	"Ms Ism's rep is of the 'You may find it disreuptable, but...' variety. This might work elsewhere, though."
rep popper	scorn rocs	"The scorn rocs scorn such abstract concepts as 'rep' and, hence, are not affected. Perhaps there is a more productive way to neutralize their ability to shield you."
Rep Popper	Yuge Guy	"It seems like the Rep Popper should work, but it doesn't, quite. Maybe there is something that is giving the Yuge Guy all his rep?"
resale laser	DIFF ID	"Oh, the sparks that would fly! But no. The laser has another purpose."
resale laser	lie veil	"The resale laser might cut a hole in the lie veil, but the way lies expand, that hole would be neutralized. You need something more brutal."
resale laser	made dam	"[if eroded ore is off-stage]There might be something behind the dam. But you need to be subtler looking for it[else]You already got the eroded ore. Don't destroy part of Grebeberg looking for more[end if]."
roto motor	eroded ore	"The roto motor probably runs on some sort of battery, so the ore would not be helpful. The motor seems charged, anyway."
roto motor	etage gate	"The gate is in good condition. It's just locked, so you need a way around that."
roto motor	kayak	"The kayak is not electrical, and besides, the roto motor is too small."
roto motor	made dam	"The dam is running smoothly on its own. Perhaps there is another fun small project for the dam."
roto motor	ore zero	"The roto motor probably runs on some sort of battery. It seems charged, anyway."
roto motor	tao boat	"The tao boat is not electrical, and besides, the roto motor is too small."
sage gas	bomb mob	"Using the sage gas on the bomb mob might wisen them up to you, which would be unpleasant."
sage gas	Bond Nob	"The Bond Nob could use a little wisdom, but more immediately, a bit of medical attention would help."
sage gas	butene tub	"The sage gas needs to work with something more metaphysical."
sage gas	code doc	"The Code Doc needs no artificial intelligence or wisdom boost."
sage gas	Dork Rod	"There's no place to squeeze gas into the Dork Rod. Sometimes, dorkiness is ready for wisdom, but not here and now. You'll need another receptacle."
sage gas	gulf lug	"The gulf lug needs a physical boost, not a mental one."
sage gas	King Nik	"[nik-self]."
sage gas	Known Wonk	"[wonk-sage]."
sage gas	rep popper	"The popper would surely make the sage gas's profundity seem impractical."
sage gas	sharp rahs	"[rah-gas]Hmm! The contrast between the two...that should work. But maybe you need some sort of intermediary that could hold them both."
sage gas	Sniffins	"[Sniffins] needs something more practical."
sage gas	Tao Boat	"[too-boast]. Besides, the boat doesn't run on gas and doesn't need to go anywhere."
sage gas	Yuge Guy	"The sage gas would be wasted on the Yuge Guy, who seems all about dumbing things--and other people--down."
Set O Notes	opossum	"No, you're overthinking it. Oppo... op(p)ossum. Something simpler."
sharp rahs	Bros' Orb	"You feel a shock--perhaps you approached the Bros['] Orb too eagerly! But it seems you were on the right track."
sharp rahs	dork rod	"You have a vision of Cool Kids 'helpfully' telling a Not-So-Cool Kid about how and why to be more exciting. No, the rahs won't work with the rod, which feels natural."
sharp rahs	King Nik	"King Nik needs more than just platitudes. Something rigorous."
sharp rahs	Known Wonk	"[wonk-sage]."
sharp rahs	rep popper	"The popper would surely ruin the incisiveness of the rahs."
sharp rahs	Tao Boat	"[too-boast]."
sharp rahs	Yob Attaboy	"[i]YOB ATTABOY[r] is, um, direct enough."
snack cans	DIFF ID	"The DIFF ID is not a grocery scanner."
SOME DEMOS	Revolt Lover	"[one of]The Revolt Lover nods slightly. 'An excellent book! I have a copy, myself. It's helped me make art out of just about ANYTHING. The best stuff is, you know, boring and interesting at the same time.' You make a note of the Revolt Lover's words[or]The Revolt Lover already mentioned you should find something both boring and interesting at the same time[stopping]."
soot tattoos	DIFF ID	"The Diff-ID doesn't respond. Maybe you need a way to put them on you, somehow."
soot tattoos	etage gate	"The etage gate pattern is interesting and distinctive. Maybe if you had something similar that was not just a drawing, you could rub the pattern off on the tattoos."
soot tattoos	Revolt Lover	"But the Revolt Lover pretty much offered them to you in the first place."
spa maps	pool gloop	"The pool gloop doesn't expand far enough to need mapping. Go-By Bog, on the other hand..."
spa maps	spa taps	"The spa taps don't expand far enough to need mapping. Go-By Bog, on the other hand..."
spur ups	lie veil	"The Lie Veil flaps a bit but soon returns to stability. You remember King Nik saying the Spur Ups made for a metaphorical up. You need to do something UP with them."
spur ups	tao boat	"The spur ups are meant to bring you up. You probably need them for Yawn Way and east."
spur ups	turf rut	"Unfortunately, the spur ups are about being mentally up, not physically up. So they don't work."
stamp mats	lie veil	"They wouldn't make a big enough hole in the lie veil to matter. You need something more brutal."
stamp mats	made dam	"The stamp mats would barely make a dent in the made dam, and if they did, making the dam to burst could not be a good thing."
stamp mats	Revolt Lover	"'Hmm. Those aren't art by themselves, but maybe with the right tools, they could make something interesting. Or useful.'"
stamp mats	soot tattoos	"Hmm. If the soot tattoos had a pattern, that would be interesting. But they don't, yet."
stamp mats	Tru Yurt	"The stamp mats aren't a home-y sort of mat."
stamp mats	yahoo hay	"The mats don't quite work on the hay. They might work better on something with more surface area."
state tats	DIFF ID	"The DIFF ID emits a soft tone. Looks like you can just walk [if Red Roses Order is visited]back [end if]north to get through."
stinky knits	butene tub	"The stinky knits need something stronger than a washtub, which the butene tub is not."
stinky knits	kayo yak	"The yak sniffs at the knits for a while but loses interest after a bit. Maybe something else will interest the yak longer."
stinky knits	scorn rocs	"The knits are only one thing, so only one roc could wear it. But the knits don't seem to fit. Rats.[paragraph break]There's got to be some other way to make the rocs look bad, though."
stir writs	tao boat	"[too-boast]."
stock cots	stark rats	"The rats don't need to sleep, and the stock cots won't make them feel drowsy. You need to get rid of the rats."
taboo bat	bomb mob	"No way. You'd be outnumbered. You'll need stealth."
taboo bat	Diktat Kid	"The taboo bat could be dangerous[henchy-list]."
taboo bat	Knife Fink	"The Knife Fink probably doesn't care about taboos."
taboo bat	ME Totem	"Violence isn't the answer. The ME Totem is not repelled by moral turpitude, anyway."
taboo bat	test set	"This isn't cricket. You do, however, need to use SOME weapon on the test set."
taboo bat	Yuge Guy	"Violence isn't the answer. The Yuge Guy is not repelled by moral turpitude, anyway."
tent net	kayo yak	"You don't need to capture the yak."
tent net	sleep eels	"The tent net might catch thicker fish--but what would you do with the eels? They'd start shocking you and stuff before you got anywhere. Better to try and make them happy."
tent net	stark rats	"Ooh! That would catch them, but the rats would gnaw through it. You need something more solid."
ti	liar grail	"The liar grail would twist the words of [TI] so badly, you'd be worse for the experience."
TI	Revolt Lover	"'Hmm. A bit too mean for me. Maybe it's more someone else's speed.'"
Trap Art	Revolt Lover	"But the Revolt Lover gave it to you in the first place."
trap art	stark rats	"The plans on the trap art are interesting, but they're only an idea. Whatever they are supposed to make might be effective, though."
troll ort	cross orc	"The cross orc mutters something unrepeatable about prejudiced people who can't tell the DIFFERENCE between them and trolls and don't WANT to. But the way it looks at you, you suspect it'd forgive you if you gave the right gift."
troll ort	ergot ogre	"The ergot ogre mutters something unrepeatable about prejudiced people who can't tell the DIFFERENCE between them and trolls and don't WANT to. Perhaps you need a less coercive way to dispose of the ogre."
troll ort	gulf lug	"You need something to make the Gulf Lug better, not worse."
troll ort	kayo yak	"As you hold the troll ort out, the Kayo Yak butts your hand! The troll ort goes flying. You walk over to pick it up. The yak seems weirdly attracted to it. Like it's the animal form of hate click bait. But it might be too much for the yak to hack all in one crack. Jack."
troll ort	Known Wonk	"The Known Wonk launches into an overly detailed explanation about how its weird smell could attract certain animals and make them playful and minimally violent."
troll ort	senile felines	"The senile felines sniff lazily at the troll ort, but despite its saying PINT-A-CATNIP, they do nothing. Perhaps they are just too inactive."
wash saw	Bond Nob	"Alas, you are not a surgeon."
wash saw	bros' orb	"But the Bros['] Orb is about unity. Cutting it in half would be counterproductive."
wash saw	bunk nub	"The bunk nub is small enough."
wash saw	cassettes sac	"The wash saw doesn't have enough fluid to clean up the cassettes sac. It'd probably cut whatever's in the sac, too. You need a more powerful, dedicated cleaner."
wash saw	crag arc	"The crag arc is much too big for the saw to get anywhere. [if UFO tofu is off-stage]Maybe there's a better way to find what's behind there[else]Besides, you found enough[end if]."
wash saw	el doodle	"The doodle is a mess all over. Besides, cutting it down might lose valuable information once you clean it up."
wash saw	etage gate	"Ooh! Breaking and entering! Unfortunately, it's the wash saw that'd break. Looks like you'll need a good old-fashioned key."
wash saw	gold log	"The log would break the saw."
wash saw	gulf lug	"Alas, you are not a surgeon."
wash saw	KAOS Oak	"The wash saw isn't big enough or sharp enough to take down the [kaoscaps]. You need a much more powerful machine[if player has epicer recipe and epicer recipe is nox], and you notice the epicer recipe could help with that[else if epicer recipe is xed], which you can build if you follow the epicer recipe[end if]."
wash saw	lie veil	"Not even the wash saw could clean off the lie veil. You need something much more brutal."
wash saw	made dam	"The made dam is much too big for the saw to get anywhere. [if eroded ore is off-stage]Maybe there's a better way to find what's behind there[else]Besides, you found enough[end if]."
wash saw	scorn rocs	"The rocs are too big and solid for the wash saw to vandalize them."
wash saw	slate metals	"The wash saw is nowhere near sharp enough to cut the metals. [if stamp mats are not moot]Maybe there's something else[else]You got Ye Key from the metals, and that's enough[end if]."
wash saw	stark rats	"You couldn't catch and hold a rat long enough to cut it with the wash saw."
wash saw	stock cots	"That'd undo the reviver's work on the cots."
wash saw	you buoy	"The buoy would break the saw."
yard ray	Diktat Kid	"The Diktat Kid laughs as you point the yard ray. 'Destroy me, but my work--my dezaz-ed--will remain!'"
yard ray	Knife Fink	"[yard-hench]."
yard ray	Tru Hurt	"The Tru Hurt is dangerous, but maybe you should use the yard ray on something even more harmful."
yard ray	Verses Rev	"[yard-hench]."
yard ray	Waster Fretsaw	"The Waster Fretsaw is dangerous, but maybe you should use the yard ray on something even more harmful."
YE KEY	DIFF ID	"You wave Ye Key in front of the DIFF ID. Nothing happens. The engraving on Ye Key seems to match up with what the DIFF ID wants to see, but maybe you need something else."
yob attaboy	bomb mob	"The bomb mob is past redemption. Maybe the book can motivate someone else, though."
yob attaboy	Ian	"Ian is too much of a food snob to be interested."
yob attaboy	King Nik	"King Nik is no yob, and he needs more concrete information than that."
yob attaboy	Ned	"Ned's a fighter, not a reader. A book won't change that."
you buoy	Known Wonk	"The Known Wonk could tell you all about the buoy's physical properties, but opening it? Not so much."
[zzrej] [zzfail]

to say man-lab: say "Nothing happens. [hand-broom] doesn't seem suited for manual labor. But it must be useful to grab SOMETHING"

to say hand-broom: say "[if noun is DNA hand or second noun is DNA hand]The DNA hand[else]Mr. Arm[end if]"

rah-gas-tried is a truth state that varies.

to say rah-gas: now rah-gas-tried is true

to say henchy-list: say " to the Diktat Kid, but you can't get close enough, with [the list of henchy people] in the way"

to say yard-hench: say "The [not-thing of yard ray] isn't quite an important enough target. You may not need such a drastic solution"

to say wonk-sage: say "Even if the [noun] could help the Wonk, the Wonk would figure a reason it wouldn't ... and be right! You need a gift in line with the Wonk's values"

to say nik-self: say "You get the feeling King Nik needs to learn to do for himself. The [noun] is more in the realm of theoretical knowledge"

to say too-boast: say "You feel you have been a bit too boastful in presenting [if noun is tao boat][the second noun][else][the noun][end if] to the tao boat"

to say cap-is-not-cup: say "That might short the pact cap out. [if player has puce cup]The puce cup is a better container[else]You need a more dedicated container[end if]"

[below is something to cut and paste to the table of failed useons]
[item1	item2	"[fill-in-here]"]

section table of shiftables

table of shiftables [xxshi]
use1	use2	use3 [use 3, not 1, on 2]	use-text
den ivy vined	tent net	code doc	"[tent-to-doc]."
ivy villa	tent net	code doc	"[tent-to-doc]."
mist sim	NULL ILLUN	Known Wonk	"You hold out [i]NULL ILLUN[r], point to the mist, and point to the Known Wonk."
navy van	pity tip	eye	"Nothing happens until you wave the pity tip across the eye."
pool gloop	spa maps	go by bog	"The maps seem to be meant more for the bog than the gloop, so you try the bog."
rift fir	wash saw	past sap	--
spa taps	spa maps	go by bog	"The maps seem to be meant more for the bog than the taps, so you try the bog."
TNT	Mr Arm	bomb mob	--
wordy drow	puce cup	liar grail	--

to say tent-to-doc: say "The [if noun is tent net][second noun][else][noun][end if] looks complete. It doesn't need a tent net. You look over to the Code Doc, who looks back awkwardly. You decide the Code Doc could find a better use for the tent net"

section table of goodacts

[the table of goodacts approximately follows not only the test commands but also the walkthrough]
[getit = item you get, d1/d2 = use1/use2 disappear(?) pre/post = rule to check, or rule to execute post-happening]
table of goodacts [xxuse] [xxgood]
use1	use2	getit	preproc	postproc	sco	d1	d2	guy-need	ms-need	tool-need	reg-plus	room-to-go	room-after	done	babble
--	--	--	rev-pack-cap rule	--	true	--	--	true	true	true	Dim Mid	Fun Enuf	Fun Enuf	false	--
--	--	--	rev-evade-Dave rule	--	true	--	--	true	true	true	Yelpley	My Gym	My Gym	false	--
--	--	--	rev-bore-Rob rule	--	true	--	--	true	true	true	Yelpley	Worn Row	Worn Row	false	--
--	--	--	rev-word-row rule	--	true	--	--	true	true	true	Yelpley	Worn Row	Worn Row	false	--
TI	Door Frood	bunk nub	pre-ti-on-frood rule	tube-to-ave rule	true	true	true	true	true	true	Yelpley	Evaded Ave	Evaded Ave	false	"The Door Frood begins to read and starts chuckling. Then keeps chuckling. 'Oh my goodness. Some people are stupid. Good thing I obviously have too much self-awareness to be one of them. Funny stuff! A cut above [i]To Laff a Lot[r]! I'd try to explain it to you, but either you don't need it explained to you, or you don't deserve it explained to you.'[paragraph break]With uncontrollable laughter spasms, the Door Frood skulks away, through a tube ... but ... it's probably useless to follow. Instead, you pick up the bunk nub. Might as well." [b4:PACK CAP/EVADE DAVE/BORE ROB/WORD ROW]
pity tip	eye	snack cans	pre-tip-on-eye rule	mob-to-alley rule	true	true	false	false	false	true	Yelpley	Yell Alley	Yell Alley	false	"The eye scans the pity tip, and the navy van beeps and boops and spits out some snack cans, which roll on the ground. You take them. Then you hear a loud whisper: 'Dee? Weed?' The navy van then activates its VANS-NAV and whooshes off to leave for good. And there's something behind it! Apparently, a whole bomb mob! That's who was making all the noise!" [af:TEND NET/WORK ROW]
--	--	--	rev-tend-net rule	--	true	--	--	false	true	true	Yelpley	Trapeze Part	Trapeze Part	false	--
--	--	--	rev-work-row rule	--	true	--	--	true	true	true	Yelpley	Worn Row	Worn Row	false	--
trap art	reifier	party trap	pre-art-on-reifier rule	--	true	true	false	true	true	true	Yelpley	Worn Row	Worn Row	false	"The trap art crunches inside the reifier, then -- bam! Out comes what the trap art was imagined to be: a party trap. You pull it out of the reifier and inspect it. It could probably capture more than one thing."
bunk nub	reviver	stock cots	pre-nub-on-reviver rule	--	true	true	false	true	true	true	Yelpley	Worn Row	Worn Row	false	"After some crunching and slurping, the bunk nub is changed to a bunch of much smaller, but more comfortable looking, stock cots. You take them."
party trap	stark rats	gift fig	pre-trap-on-rats rule	oh-who-to rule	true	true	true	true	true	true	Grebeberg	Seer Trees	Seer Trees	false	"The rats all try to enter the trap, and SNAP! SNAP! SNAP! The party trap explodes as the last rat enters, but fortunately none of it gets over you. The Seer Trees seem to nod a bit.[paragraph break]THUMP! They left you a present--good thing you were wearing that pact cap, because a book fell on your head. One glance reveals it to be [b]Oh, Who[r]--a phone book for Grebeberg, like [b]Name ME Man[r] for Yelpley.[paragraph break]You also find a gift fig, which you pick up."
EPOCH COPE	King Nik	Spur Ups	pre-cope-on-nik rule	cold-loc-hint-bump rule	true	true	true	true	true	true	Grebeberg	Cold Loc	Cold Loc	false	"King Nik takes it, nods sagely, and reads. 'Wow! It makes a lot more sense now. I feel like I can understand the more in-depth stuff Sir Kris and Crisp Sir C told me I needed to one day from those other books: ERA FARE, Era Care, Era Ware ... and maybe even Era Dare! Thank you! Now I can make sure the Rim Emir and his emir crim and emir grime do not become Emir Prime! I will defeat the Mrifk Firm, too, and be a regal ager! My rule will not be an EGAD age!' He hands you some Spur Ups in gratitude. 'These may not spur you, but they can give you an UP or two, when you are just scared or worried for no reason in general. Now...back to my vidette div. Gotta RAFT FAR back to Dragon-o-gard. If you ever stop by there, well... Nik's kin!'"
stock cots	sleep eels	--	pre-cots-on-eels rule	--	true	true	true	true	true	true	Grebeberg	Ooze Zoo	Ooze Zoo	false	"The sleep eels seem intrigued by the upgrade in relaxation resources. You put the stock cots down and roll them out of the way. The eels follow. You can now go south!" [af:puff up/pull up]
--	--	--	rev-puff-up rule	post-puff-up rule	true	--	--	true	true	true	Yelpley	Yawn Way	Yawn Way	false	--
--	--	--	rev-pull-up rule	post-pull-up rule	true	--	--	true	true	true	Yelpley	Emo Dome	Emo Dome	false	--
wash saw	past sap	--	pre-saw-on-sap rule	sap-loose rule	true	false	false	true	true	true	Grebeberg	Cold Loc	Cold Loc	false	"You hack away at the past sap with the wash saw, first squirting some loosening/thawing liquid. It's tricky, but the saw holds out, and with some perseverance, you're able to twist the sap off the rife fir[if player does not have puce cup]. You don't have anything to put the sap in, but it's there for later[end if]."
puce cup	past sap	--	pre-cup-on-sap rule	sap-to-cup rule	true	false	false	true	true	true	Grebeberg	Cold Loc	Cold Loc	false	"You pour some sap into the cup. There's still plenty left over, if you ever wind up needing more."
puce cup	liar grail	--	pre-cup-on-grail rule	empty-grail rule	true	false	true	true	true	true	Yelpley	Swept Pews	Swept Pews	false	"You pour the purist sirup into the liar grail. As the sirup bubbles, the Wordy Drow slips away from it and ... yes! It breaks free! 'Wend new! Wend new!' it calls to you.[paragraph break]Thoughts flow into your head from the liar grail, but the purist sirup has mutated its complex manipulations into much simpler cries of protestation: it just doesn't want you to go there! You shrug, no longer mystified by its sophistry, and the grail cracks and rolls away.[paragraph break]The passage south looks clear. You snicker to yourself. Liar grail? More like Liar FRAIL! Or Liar TRAIL! You look around, worried a nun will say 'Tut!' But all is still."
puce cup	dose sod	--	pre-cup-on-sod rule	sod-to-cup rule	true	false	false	true	true	true	Grebeberg	Apse Spa	Apse Spa	false	"You funnel the dose sod (not enough for a doses OD) into the puce cup. It will keep the sod fresh enough." [sc2-ignore]
puce cup	Bond Nob	Elan Ale	pre-cup-on-nob rule	empty-nob rule	true	true	true	true	true	true	Yelpley	Drawl Ward	Drawl Ward	false	"You give the Bond Nob the puce cup. Gulp! Gulp! The Bond Nob smashes the Puce Cup and looks embarrassed. 'Oops! Maybe you could still have used that...or not. Please accept some Elan Ale with my apologies. Oh, and enjoy my digs to the west. So many places to visit: [next-rand-txt of table of Bond Nob bars], [next-rand-txt of table of Bond Nob bars], [next-rand-txt of table of Bond Nob bars]... well, everywhere except Bar Drab or Soda Do's or Jo's OJ.' The Bond Nob proceeds to regale lager while vanishing north."
stamp mats	slate metals	Ye Key	pre-mats-on-metals rule	--	true	true	false	true	true	true	Yelpley	Scrap Arcs	Scrap Arcs	false	"Impressing the stamp mats on the slate metals, a design pops out! A key! An important looking one emblazoned ... YE KEY. You find it hard to pull the stamp mats out, and when you take YE KEY, the mats quickly morph into the slate metals. Eh, well. Less inventory to worry about."
demo med	gulf lug	cash sac	pre-med-on-lug rule	bump-gulf rule	true	true	true	true	true	true	Grebeberg	Flu Gulf	Flu Gulf	false	"The Gulf Lug takes the demo med, inspects it, and says, 'Eh, why not...' and looks a lot better within a few seconds. 'Mute tum!' the Lug cries gratefully before handing you a cash sac and running away."
cash sac	cross orc	--	pre-sac-on-orc rule	--	true	true	true	true	true	true	Yelpley	Toll Lot	Toll Lot	false	"The cross orc looks at the cash sac suspiciously. Maybe the sac isn't enough. But it hasn't been taking its Negot-O-Gen! You say 'Invests! Ev'n I...' and your folksiness convinces the cross orc that, well, ANYONE can get rich investing. With a payee yap, the orc goes off, mumbling how it will eclipse those snooty scroll orcs. It shall be as rich as ... CROESUS E. ORC!"
YOB ATTABOY	Sniffins	Dirt Rid	pre-attaboy-on-Sniffins rule	toons-to-den rule	true	true	false	false	false	true	Yelpley	Deft Fed	Deft Fed	false	"Sniffins accepts your gift, with sniffs slowly changing from sadness to something more snooty. Your thanks for helping Sniffins be too good for you is a Dirt Rid. Sniffins shoos you back out to the Toll Lot: 'No, yob! Yon!' There is remodeling to be done! Sniffins will outdo Rentner, whoever that is! From the south, you hear frantic cries of 'Repaper! Repaper! Repaper!'[paragraph break][b]Toll Lot[r]"
Elan Ale	Sniffins	Gorge Grog	pre-ale-on-Sniffins rule	--	true	true	false	false	false	true	Yelpley	Deft Fed	Deft Fed	false	"Smuggums looks the Elan Ale up and down, sniffs and...well, okay. It will do. 'Now take that Gorge Grog and get it out of here.' Hey, you're not one to say 'stuff free stuff.'" [af:stand nat's]
--	--	--	rev-stand-nats rule	--	true	--	--	true	false	false	Yelpley	Deft Fed	Deft Fed	false	--
Dirt Rid	reviver	Cave Vac	pre-rid-on-reviver rule	--	true	true	false	false	false	true	Yelpley	Worn Row	Worn Row	false	"You watch as the Dirt Rid swirls and becomes shinier and much more powerful--and lighter, too, when you retrieve it. A Cave Vac! It will be capable of cleaning...well, somewhere."
Cave Vac	cassettes sac	radar	pre-vac-on-sac rule	bump-pod rule	true	true	true	false	false	true	Yelpley	Dopy Pod	Dopy Pod	false	"The Cave Vac has the power to clean up the cassettes sac (and even clean up part of the floor to reveal 'DA PAD,') but it chokes and sputters at the end of the effort.[paragraph break]And while a lot of the cassettes are beyond repair, there's something at the very bottom.[paragraph break]Wow! Radar![paragraph break]You hear noises from the pod, as a hidden robot appears and whisks the garbage away. That's pretty slick! Looking back, the pod doesn't seem so dopy any more, between how the Demo Med already helped and how you're sure the radar will.[paragraph break](NOTE: You can RAD something to use the radar on it.)"
radar	crag arc	UFO tofu	pre-radar-on-arc rule	radar-crag rule	true	false	false	false	false	true	Yelpley	Toll Lot	Toll Lot	false	"Beeeep... beeeep..... the radar has found something! Two small saucers arise from a hidden part of the crag. So Full UFOs! And splat! something weird and warm drops from them and lands on the radar, which fizzles a bit from the impact and wetness. It hardens quickly and weirdly into a cubic shape. What could it be? You think a minute, rejecting a profane acronym to shout at the departed UFO. The stuff must be UFO tofu.[paragraph break]Fortunately, your Sto-Lots has a handy sealed place where the UFO tofu can be kept dry. You put it there." [af:deny Ned]
--	--	--	rev-deny-Ned rule	--	true	--	--	true	true	true	Yelpley	Gross Org	Gross Org	false	--
Ye Key	etage gate	gate tag	pre-key-on-gate rule	tag-later-wipe rule	true	true	true	true	true	true	Yelpley	Gross Org	Gross Org	false	"Ye Key fits perfectly into the Etage Gate.[paragraph break]'A hall! Aha! Etage-gate? More like Etage-NEGATE!' you brag, not noticing the gate retracting, Ye Key with it. Well, you can't imagine needing it again.[paragraph break]A gate tag falls off. You pick it up." [af:Worn Row]
--	--	--	rev-worn-row rule	--	true	--	--	true	true	true	Yelpley	Worn Row	Worn Row	false	--
stinky knits	rotator	brag garb	pre-knits-on-rotator rule	wear-garb rule	true	true	false	false	true	false	Yelpley	Worn Row	Worn Row	false	"The stinky knits fit into the rotator without stuffing them too much. After some spinning (and a smell of Soapa-Os detergent--where'd that come from?) you look in again and--they're something much shinier now. Brag garb! If this were an RPG, it'd give some neato armor class. You can't resist wearing your flashy new duds, though once you put them on, they do smell a bit ... intense. Looking at a hidden label, you note it has been liberally sloshed with Turbo-Brut."
Gorge Grog	Butene Tub	resale laser	pre-grog-on-tub rule	make-sag rule	true	true	true	false	false	true	Yelpley	Pro Corp	Pro Corp	false	"The Gorge Grog starts fizzing as it pours down the tub, and nothing seems to happen, until you hear a FOOMP below and the tub starts shaking. There must've been an open spark below the tub, perhaps a noir ion. You find it best to hide, and that's the right thing to do, because the butene tub explodes into pieces. Under it is a resale laser! You figure the really good stuff is hidden way back for security reasons, and this is probably just an emergency gadget, but it's got to be good for something.[paragraph break]Soon after you take the resale laser, a small gash sag fills in the explosion you made. Technology! Also, you're not saddled with a bath-tab for the damage you did."
gold log	rotator	dork rod	pre-log-on-rotator rule	--	true	true	false	true	true	false	Yelpley	Worn Row	Worn Row	false	"The gold log begins spinning until it cracks open--leaving a dork rod! You wonder briefly if you deserve to take it, or if there's something wrong with you if you deserve to, but once you hold it, memories of past silliness come back, and they're easier to deal with, now. You have some perspective. You even feel sorry for people who pointed out you were a dork. They'd be barred from a cool adventure like this. So you keep the dork rod."
SOME DEMOS	yahoo hay	straw arts	pre-demos-on-hay rule	hay-gone rule	true	true	false	false	true	false	Grebeberg	Moo Room	Moo Room	false	"With the help of SOME DEMOS, you (after several grunts of 'STRAIN! I! ARTS!') manage to rejig and bend and snap the hay into something more aesthetically pleasing: straw arts! You're so enthusiastic, you even tear up SOME DEMOS and garnish your new straw arts. It just feels right."
straw arts	Revolt Lover	soot tattoos	pre-arts-on-lover rule	rebump-art-xtra rule	true	true	false	false	true	false	Yelpley	Art Xtra	Art Xtra	false	"'Brilliant! Brilliant! Such expressive art! Subversive, yet straightforward! I ... I'd like to sell it on commission. I'd also like to see what else you can do. Here, have these soot tattoos. They seem pretty plain, but if you can make something out of hay and an old pamphlet, I'm sure you'll be able to work with them.'"
gate tag	soot tattoos	state tats	pre-tag-on-tattoos rule	tats-peripheral rule	true	true	true	false	true	false	Yelpley	Art Xtra	Art Xtra	false	"You stamp the gate tag into the soot tattoos, and they take on an official shape: tat, STAT! They look like official State Tats, which you can slap on if you ever need to impersonate an official goon, or something. Way to go!"
poo coop	gnu dung	--	pre-coop-on-dung rule	unlimbo-coop rule	true	false	true	true	true	true	Grebeberg	Dumb Mud	Dumb Mud	false	"A heretofore hidden poos scoop pops out from the poo coop. It shovels and vacuums the offending dung into the coop, forming a crass arc that seems to contain several times the volume of the coop itself. Whatever, you can now go west."
poo coop	turf rut	--	pre-coop-on-rut rule	shift-dumb-mud rule	true	true	true	false	false	true	Grebeberg	Dumb Mud	Dumb Mud	false	"The poo coop releases its contents into the turf rut but explodes as the last bit oozes out. You dump it into the hardening mixture.[paragraph break]A bold(ened) lob! The rut isn't filled, but you have clear passage across, and the ... bridge ... hardens visibly and quickly. You poke it with your foot to make sure. I guess you could call the turf rut something else, now, but I'm trying to keep this game PG."
radar	made dam	eroded ore	pre-radar-on-dam rule	radar-blink rule	true	false	false	false	false	true	Grebeberg	Swamp Maws	Swamp Maws	false	"You place the radar against the made dam and move back and forth. Suddenly--yes! You hear a few pings. There's something behind. You discover some eroded ore, which you take. It's not much in its current state, but maybe you can regenerate it somehow. The radar plays a weird scale. Being close to the ore has damaged it somehow."
NULL ILLUN	Known Wonk	--	pre-illun-on-wonk rule	bump-maws rule	true	true	true	true	true	false	Grebeberg	Yack Cay	Yack Cay	false	"The Known Wonk begins to read. 'Old, lo! Too simple. It has to be beneath me. I mean, it's almost as bad as [i]EBB?! BE[r].' But the more the Wonk reads, the more it's clear...they have overlooked stuff. 'Hey. That makes sense. Rid a nadir. Rid ANY nadir! Tiny nit? Not on! Wonk, now! Sometimes, simple stuff works.' As the Known Wonk babbles, the mist sim lifts, too. 'Wow!' But no, your acts deserve a better cheer than that. 'H/t! A path!'[paragraph break]What could lie to the north?"
el doodle	edits tide	spa maps	pre-doodle-on-tide rule	rahs-too rule	true	true	false	false	true	false	Grebeberg	Yack Cay	Yack Cay	false	"The edits tide washes away enough of El Doodle to reveal maps...and not just any maps, but spa maps! And there is a bonus! It appears El Doodle was so jumbled, there were two things. Sharp rahs appear on another sheet of paper, as some sort of confused motivation, and you take them."
elope pole	kayak	you buoy	pre-pole-on-kayak rule	--	true	true	false	false	false	false	Grebeberg	Lac Oft Focal	Lac Oft Focal	false	"You unfold the elope pole into two oars. And you take a journey ... well, you're not sure where. You whisper 'Row, or' whenever you get tired. Then you see Elided Ile in the distance. It can't be Elsif Isle, because there are no computers on the shore.[paragraph break]So you stop off there. You are invited to Nevah-Haven, where everyone is happy all the time, but ... it seems too good to be true. Apparently your declining means you passed some sort of test, and you are worthy to fight the vicious Bar Crab. It is no match for your elope pole. The citizens hand you a YOU BUOY to tell you they're glad you're you, asking only for the elope pole as a souvenir. Well, it was getting a bit awkward to carry.[paragraph break]They mention it may hold great treasures within, ones that will help you complete your quest. 'Barge! Grab!' they call as one speeds past, in the direction of Lac Oft Focal. As it gets near and bends away, you jump off, using the buoy to paddle and float back all the way."
dork rod	tao boat	enact cane	pre-rod-on-boat rule	--	true	true	false	true	true	false	Grebeberg	Lac Oft Focal	Lac Oft Focal	false	"The dork rod vibrates and causes the Tao Boat to open. You step aboard. Inside are stave vats. You put the dork rod in them, and it shimmers and pops back out as ... an enact-cane. You could stay here forever...but then a voice calls 'Re-rise, desirer!'[paragraph break]You think back to the rep popper in the alley. Suddenly, you don't feel as though you'd feel silly holding it. You're sure you need it, though for what, you can't say."
tent net	Code Doc	--	pre-net-on-doc rule	--	true	true	false	false	true	false	Grebeberg	Uneven U	Uneven U	false	"Together, you figure out what to do to make the tent net proper cover for Uneven U. 'Tie it ... tie it ...' then 'Net: safe. fasten!'[paragraph break]Once the work is done, the Code Doc thanks you. 'Let me know if you need help learning ... well, anything. Oh, and call me Dr. D., if you'd like.'[paragraph break]How thoughtful! That could save a few keystrokes in the future[if spa maps are preclued]! Maybe the very near future, if you ask about the spa maps again[end if]."
spa maps	Code Doc	--	pre-maps-on-doc rule	maps-explain rule	true	false	false	false	true	false	Grebeberg	Uneven U	Uneven U	false	"The Code Doc looks at the maps. 'Hmm. I learned a few tricks from Edu-Dude. But I'll need my for-prof math tam for this one. One second, let's see--Aha! Oho...'[paragraph break]You each split an Ed-Ade to make sure the lesson is taught and remembered well. Despite a minor pupil slip-up, the Code Doc is never edu-rude. It soon makes complete sense to you. You don't know how to say thanks. Everything seems too long-winded or said before, until ... 'Def ed!'"
spa maps	go by bog	sage gas	pre-maps-on-bog rule	gas-think-wipe rule	true	true	false	false	true	false	Grebeberg	Apse Spa	Apse Spa	false	"Everything clicks now! You see Go-By Bog, Gobs Bog, and how to pass through each of them. It's not a total breeze, but when you get through, you find sage gas all around. But how to carry it? Voila, a pouch in the Sto Lots you hadn't seen before is just the thing. Perhaps the sage gas helped you find it! As you fiddle with it, though, you drop the Spa Maps, which get hopelessly muddy.[paragraph break]You reach to pick them up, but somehow, bizarrely, the Spa Maps turn into a salt atlas and crumble away. Hooray, biodegradability!"
enact cane	yahoo hay	moor broom	pre-cane-on-hay rule	hay-gone rule	true	true	false	false	true	false	Grebeberg	Moo Room	Moo Room	false	"You stick some strands of yahoo hay into the damaged end of the enact cane. It's now a moor broom!"
--	--	--	rev-pace-cap rule	--	true	--	--	false	true	false	Dim Mid	--	--	false	--
troll ort	brag garb	--	pre-ort-on-garb rule	chase-in-zoo rule	true	true	false	false	true	false	Grebeberg	--	--	false	"You rub the troll ort on the Brag Garb. Whew! Somehow the ort mixed with the garb's materials to make a really strong odor. It's an entirely different smell from the stinky knits, but still quite distinctive. The ort must've been covered by the dirt for a long time, because it disintegrates as its essence is leaked onto the brag garb." [b4:pace cap] [af:yak okay]
--	--	--	rev-yak-okay rule	brag-garb-bye rule	true	--	--	false	true	false	Grebeberg	Lair Trial	Lair Trial	false	--
sage gas	tame mat	guru rug	pre-gas-on-mat rule	rug-to-bottom rule	true	true	true	false	true	false	Grebeberg	Motto Bottom	Motto Bottom	false	"'Mix a maxim...' you mutter to yourself. The sage gas bubbles out under the tame mat, and the message changes. To something wiser. But perhaps a bit stuffy: a guru rug!"
sharp rahs	guru rug	stir writs	pre-rahs-on-rug rule	--	true	true	true	false	true	false	Grebeberg	Motto Bottom	Motto Bottom	false	"The sharp rahs meld into the guru rug, which feels less weighted down by philosophy and floats away. Under it there are stir-writs, which seem oversimplified at first, but on re-reading, they strike just the right balance between emotional and intellectual stimulation."
--	--	--	rev-nail-Ian rule	--	true	--	--	false	false	true	Grebeberg	Mont Nom	Mont Nom	false	--
--	--	--	rev-first-food-combo rule	--	true	--	--	false	false	true	Grebeberg	Mont Nom	Mont Nom	false	--
--	--	--	rev-second-food-combo rule	--	true	--	--	false	false	true	Grebeberg	Mont Nom	Fun Enuf	false	--
Moor Broom	Tru Yurt	Exam Axe	pre-broom-on-yurt rule	bump-ivy rule	true	true	false	false	true	false	Grebeberg	Yack Cay	Yack Cay	false	"You begin to clean the Known Wonk's Tru Yurt, and as you do, all sorts of things turn up. The moor broom even shifts into a pomp mop when you need it to, for a bit. The Known Wonk looks shocked at how a clean space frees one's mind for ideas and how your simple advice works. You're pretty shocked, but you're even more shocked when the Known Wonk bolts out and yells 'Wait a second!'[paragraph break]After a bit, the Known Wonk returns, babbling about FINALLY impressing the Code Doc. In gratitude, the Known Wonk hands you something long-hidden and unusable for an intellectual, but maybe you will find it handy ... an Exam Axe! You trade the moor broom for it, now that the Known Wonk is committed to cleanliness." [b4:nail ian/use snack cans on UFO tofu/use gift fig on mayo yam]
wash saw	porch crop	balsa slab	pre-saw-on-crop rule	--	true	true	false	false	false	false	Grebeberg	Uneven U	Uneven U	false	"You start hacking away with the wash saw, and the whole operation is fun...almost a mirth trim. The Code Doc frowns briefly: 'Bonsai! ... A snob?' before you counter with 'Hep, eh?' The Code Doc nods.[paragraph break]'Yes! Yes! We have achieved AIMED ACADEMIA! It is time for a name chanege, but to what? ... Idea-ed, I! UNITIN['] U! How can I thank you?'[paragraph break]You see the wash saw became dull while you sawed, and you've no way to sharpen it. The Code Doc should be able to before the porch crop grows back. So when you notice a balsa slab is lying under where the porch crop was, you propose a trade. The Code Doc accepts. Now, you ... do own wood!"
Exam Axe	Lie Veil	--	pre-axe-on-veil rule	--	true	true	true	false	true	false	Grebeberg	Dumb Mud	Dumb Mud	false	"The Exam Axe cuts through the Lie Veil easily. As it does so, it shortens--oh, about 28.57%--before glowing and swirling and vanishing. I guess now it's an ex-axe. You can go north now."
--	--	--	rev-get-bros orb rule	--	false	--	--	false	true	false	--	Le Babel	Le Babel	--	--
DNA band	reifier	DNA hand	pre-band-on-reifier rule	--	true	true	false	false	false	true	Yelpley	Worn Row	Worn Row	false	"After considerable gooping and whooshing, the reifier pops open to reveal something more lifelike than a DNA band: a DNA hand! It doesn't have any slime or blood leaking, and when you take it, it doesn't twitch too much."
roto motor	DNA hand	Mr Arm	pre-motor-on-hand rule	--	true	true	true	false	false	true	Yelpley	Worn Row	Worn Row	false	"Some of the stuffing inside the hand has to pop out to make space for the roto motor to fit in. There's enough to make a whole arm! The hand glows a bit and wiggles its fingers nimbly and even pinches you before you can react. You notice something inscribed on the arm (MR. ARM) and hand: BANG NAB. The arm will probably give the hand a bit more reach."
Eroded Ore	reviver	Ore Zero	pre-ore-on-reviver rule	--	true	true	false	false	false	true	Yelpley	Worn Row	Worn Row	false	"The reviver whirs as you drop the eroded ore in, and ... out pops some shiny Ore Zero!"
you buoy	rotator	ME gem	pre-buoy-on-rotator rule	--	true	true	false	false	false	false	Yelpley	Worn Row	Worn Row	false	"You hear a clunking as the rotator speeds up. When you open the rotator, the you buoy is in shreds, but a shiny ME gem appears. 'You BOFFO buoy!' you can't help shouting.[paragraph break]The gem's so tempting and beautiful, you grab it quickly, but you know it's not the main point of your quest. Maybe it can distract someone greedy."
Mr Arm	bomb mob	TNT	pre-arm-on-mob rule	mob-bye rule	true	true	true	false	false	true	Yelpley	Yell Alley	Yell Alley	false	"Mr. Arm walks on his index and middle finger to the TNT, then nudges it away as the Bomb Mob isn't watching. Being an arm, it/he has more leverage than just a DNA hand would've. It flicks the TNT over your way, then quickly skedaddles off to its old home: DNA Land, of course. Perhaps Mr. Arm will find a Do-Bod or even an Evol-Glove to be truly complete. The bomb mob, for their part, becomes a poor troop once they see what they've lost. They wander away."
Nat's Tan	scorn rocs	--	pre-tan-on-rocs rule	post-tan-on-rocs rule	true	true	true	true	false	false	Grebeberg	Flu Gulf	Flu Gulf	false	"The Nat's Tan burns into the scorn rocs, who were once pridefully spotless. Their fur turns an embarrassing shade of orange. You hear a bellow from the west."
rep popper	ME Totem	murdered rum	pre-popper-on-totem rule	totem-out rule	true	true	true	false	false	false	Grebeberg	Sneer Greens	Sneer Greens	false	"'BOO! NOOB!' the Yuge Guy booms, but his face has turned derp-red. You hold the rep popper at the Yuge Guy until he ducks behind the ME Totem, but by now, the popper is charged, and it splits the totem in half. The Yuge Guy deflates like a balloon and whooshes out over the smirk rims. 'Had, ah!' he cries. 'On U! Y U No ... ?' From his babbling, he's apparently retreating to a glam-amalg (Loot Stool included) or ego loge in his residence, the Exult-Luxe. Sounds horrendously gaudy![paragraph break]'Pol? Flop!' you think to yourself, before the ME Totem, sliced several ways, collapses and sinks into the ground. As it does, something rolls out ... some murdered rum! It looks powerful. You can't resist a 'He? Meh!' before picking the rum up carefully."
Bros' Orb	Mirror Rim	Yard Ray	pre-orb-on-rim rule	sword-rows-reveal rule	true	true	true	false	false	false	Yelpley	Red Roses Order	Red Roses Order	false	"The Bros['] Orb shines and blinks. The Mirror Rim dissipates under the brutal light, revealing Sci-Pics (hard and soft science) that detail how Ms. Ism has been in cahoots with the Yuge Guy and the Diktat Kid. 'Live not on evil, Ms. Ism, live not on evil!' you boom, as the Orb does its work. Ms. Ism looks much less intimidating now. 'Does it mean...? It does!' She runs away, sobbing. 'Mom! Mom! Mom!' An E-Divide shimmers and pops up, blocking you from following.[paragraph break]Behind the Mirror Rim is a Yard Ray, which looks useful and destructive. You take it. Mumbling 'Eh, she...' you also wipe off your state tats. You won't need them any more."
balsa slab	sword rows	not-a-baton	pre-slab-on-rows rule	moot-rows-and-tats rule	true	true	false	false	false	false	Yelpley	Red Roses Order	Emo Dome	false	"The sword rows hum and rotate as the balsa slab approaches. They whir and grind as they cut through it, carving and honing it into something that almost seems like a weapon. It's pretty generic, and you wonder what it is, but you notice NOT-A-BATON carved into it. It seems kind of cool if you need self-defense, but you bet it could be so much more, since violence hasn't really been important so far, even to dispose of Ms. Ism."
not-a-baton	reifier	taboo bat	pre-not-a-baton-on-reifier rule	--	true	true	false	false	false	false	Yelpley	Worn Row	Worn Row	false	"The reifier coughs and spits out something even more counter culture than the dork rod: a taboo bat! You practice swatting some imaginary enemies. One of these will be able to smite a bad-faith pearl-clutcher for sure."
murdered rum	yard ray	--	pre-rum-on-ray rule	ray-beepy-now rule	true	true	false	false	false	false	Dim Mid	--	--	false	"As you combine the spoils from the Yuge Guy and Ms. Ism, the yard ray gleams with energy. It seems like it could do some damage now somewhere even more important than [Sneer Greens] or [Red Roses Order]. Maybe somewhere right between them."
--	--	--	rev-emit-noontime rule	ray-not-beepy-now rule	true	--	--	false	false	false	Dim Mid	--	--	false	--
Yard Ray	test set	--	pre-ray-on-set rule	test-set-zapped rule	true	false	true	false	false	false	Dim Mid	Worn Row	Worn Row	false	"Fzzt! Zap! The test set goes up in smoke. Okay, you had something to practice on. Now for the final battle." [b4:emit noontime]
--	--	--	rev-create-tron rule	--	true	--	--	false	false	false	Dim Mid	Fun Enuf	Fun Enuf	false	--
ME gem	Knife Fink	--	pre-gem-on-fink rule	kid-left rule	true	true	true	false	false	false	Dim Mid	Dirge Grid	Dirge Grid	false	"The Knife Fink pauses, dazzled by the gem's brightness. 'Wow! It must be valuable!' [if Verses Rev is in Dirge Grid]The Verses Rev stops to tut-tut the Knife Fink, who ignores that.[end if] The Knife Fink grabs the gem and runs off, perhaps to create the Red Ronin Order." [b4:use TNT on ore zero]
taboo bat	Verses Rev	--	pre-bat-on-rev rule	kid-left rule	true	true	true	false	false	false	Dim Mid	Dirge Grid	Dirge Grid	false	"You raise the Taboo Bat, yelling 'El Bat-Able,' (and ignoring the actual archaic meaning) and suddenly the Verses Rev senses the Taboo Bat's ancient untapped power. It's not particularly violent or lethal, but it is just perfect to scare an orthodoxy as warped as the Verses Rev's, who mutters 'Rev, off, over' and stumbles away! Perhaps to the safety of ... a rev reserver. Whatever. Someone's de-revered."
Yard Ray	redivider	X-ITE TIX	pre-ray-on-redivider rule	kid-bye rule	true	true	true	false	false	false	Dim Mid	Dirge Grid	Dirge Grid	false	"'Havoc, OVAH!' you shout as you aim and fire the yard ray. A direct hit! The redivider begins to fizzle.[paragraph break]'Bub?!' the Diktat Kid asks.[paragraph break]Fzzt! Zap! The entire Dirge Grid brightens, and the yard ray hums and explodes. But it's too late for the Diktat Kid to avoid an electro-shock. 'Deleveled!' the Kid screams several times, before breaking down into tears. 'You haven't won for good! You think everyone's living in harmony, but I will build my ...[paragraph break]'... RETRO PORTER! It will make things as before you came!'[paragraph break]'What if it moves things to before YOU came?' you taunt.[paragraph break]'PUT, UH, SHUT UP!'[paragraph break]You wonder if you should've said that. The Kid grows redder ... redder ... and suddenly the remains of the redivider begin swirling, and they catch the Diktat Kid, who moans 'Lo, a Gaol' before being whisked off.[paragraph break]With the Kid gone, the Dirge Grid grows less dark, the no-go gon winks out, and saner arenas are revealed all around. The swirling remains of the redivider harden into what can only be an XILE helix.[paragraph break]Revel, clever! Revel, ever![paragraph break]You close your eyes and boom 'DE-DIVIDED! DE-SUFFUSED!' When you open them, you notice something else fell out of the redivider: X-ITE TIX! You pick them up. Wow! Yo, joy! Wow!"
X-ITE TIX	TIX EXIT	--	pre-tix-on-exit rule	you-win rule	true	false	false	false	false	false	Dim Mid	Fun Enuf	Fun Enuf	false	"Yes, it's time to go. You put the X-Ite Tix in the Tix Exit and walk through."
[zzuse] [zzgood]

[the 3 sections below are automatically sorted with sc2.py]

section rev rules [xxrr]

[?? change word row some more: write in text]

this is the rev-bore-Rob rule:
	if Rob is moot, the rule fails;
	if in-sos is true:
		if Worn Row is unvisited:
			say "You should visit [Worn Row] west of [hn of My Gym].";
		else:
			say "[one of]You need to get rid of Rob[or]He sure does like to talk about himself, and you probably can't talk over him.[or]An action to subterfuge Rob will help[or]The pact cap gives you a hint that you need to do a palindrome-ish action[or]BOR* ROB[or]Bore Rob[stopping].";
		the rule succeeds;
	if say-unless-speed, say "You BORE ROB, and he leaves Worn Row out of boredom.";
	boot-Rob;
	the rule succeeds;

this is the rev-create-tron rule:
	if KAOS Oak is moot, the rule fails;
	if in-sos is true:
		if tron-got is not 4, the rule fails;
		say "Use any piece of the North-Tron (or the epicer recipe) with any other piece, or the recipe, to break through the [kaoscaps].";
		the rule succeeds;
	build-the-tron;
	the rule succeeds;

this is the rev-deny-Ned rule:
	if Ned is moot, the rule fails;
	if in-sos is true:
		if player is in Gross Org:
			say "[one of]Ned wants a fight! But you're not equipped for fighting[or]You need to do something to Ned.[or]DENT NED is too violent. Grind him down with passive resistance[or]DENY NED[stopping].";
		else if Gross Org is unvisited:
			say "You will want to visit [if Toll Lot is visited]the room north of [hn of Toll Lot][else]the east a bit more[end if].";
		else:
			say "Ned in Gross Org may be next to deal with now.";
		the rule succeeds;
	if say-unless-speed, say "You DENY NED a chance at fighting.";
	moot Ned;
	the rule succeeds;

this is the rev-emit-noontime rule:
	if emitted is true, the rule fails;
	if in-sos is true:
		if emitted is false and player has yard ray and murdered rum is moot:
			say "[one of]The Yard Ray needs to emit something[or]An eight tletter word.[or]The last four are ****TIME.[or]Something bright.[or]EMIT NOONTIME to practice with the Yard Ray.[stopping]";
			the rule succeeds;
		the rule fails;
	if say-unless-speed, say "You EMIT NOONTIME with the Yard Ray.";
	now emitted is true;
	the rule succeeds;

this is the rev-evade-Dave rule:
	if Dave is moot, the rule fails;
	if in-sos is true:
		if My Gym is unvisited:
			say "Try looking around [if Yawn Way is unvisited]east and south of [hn of fun enuf][else]south of [hn of Yawn Way][end if].";
		else if player is not in My Gym:
			say "Go to My Gym to deal with Dave.";
		else:
			say "[one of]Dave is big and strong but slow. Fighting is out, but maybe you can outfox him[or]The pact cap gives a hint you need to do something odd[or]EVA DAVE is out[or]EVAD* DAVE, maybe[or]EVADE DAVE until he gets exhausted[stopping].";
		the rule succeeds;
	moot Dave;
	if say-unless-speed, say "You EVADE DAVE, and he leaves My Gym out of frustration. You loot a wash saw, too.";
	now player has wash saw;
	moot stole lots;
	the rule succeeds;

this is the rev-first-food-combo rule:
	if number of moot ingredients >= 2, the rule fails;
	if in-sos is true:
		if number of carried ingredients is 2:
			say "You can mix [random carried liquid ingredient] with [random carried solid ingredient] by USEing one on the other.";
		else: [you must have the gift fig by now]
			say "You may need to look elsewhere for food to go with the gift fig. The easy one to find is the mayo yam [if Yell Alley is visited]in Yell Alley[else]east of Evaded Ave[end if].";
		the rule succeeds;
	if say-unless-speed, say "You mix the snack cans and the UFO tofu together in Mont Nom.";
	moot snack cans;
	moot UFO tofu;
	the rule succeeds;

this is the rev-get-bros orb rule:
	if Bros' Orb is not in Le Babel, the rule fails;
	if in-sos is true:
		say "You can just [if player is not in Le Babel]go to Le Babel and [end if]take the Bros['] Orb.";
		the rule succeeds;
	if say-unless-speed, say "You get the Bros['] Orb from Le Babel.";
	moot stir writs;
	now player has Bros' Orb;
	the rule succeeds;

this is the rev-nail-Ian rule:
	if Ian is moot, the rule fails;
	if in-sos is true:
		say "[one of]Ian is a lot like Rob, according to the pact cap.[or]What action can you take against Ian to bring him down a peg?[or]He seems to be hiding something.[or]NAI* IAN -- there are a few wrong ones.[or]NAIL IAN to remove him.[stopping]";
		the rule succeeds;
	if say-unless-speed, say "You NAIL IAN to cast him from Mont Nom.";
	moot Ian;
	the rule succeeds;

this is the rev-pace-cap rule:
	if in-sos is true:
		unless tried-yak, the rule fails;
		if cap-pace is true, the rule fails;
		if cap-ever-pace is true:
			say "You managed tp make a PACE CAP before. Now is the time to do it again.";
		else:
			say "[one of]You need to do something with/to the pact cap.[or]The pact cap can help you go faster, longer, so the Kayo Yak doesn't catch you.[or]It can also become a PAC* CAP (2 letters.)[or]PACY CAP or PACE CAP.[stopping]";
		the rule succeeds;
	if cap-ever-pace is true, the rule fails;
	now cap-ever-pace is true;
	if say-unless-speed, say "You tweak your pact cap to a PACE CAP";
	if mrlp is not Grebeberg:
		if say-unless-speed, say ", moving to Seer Trees in Grebeberg when it doesn't seem right to run in Yelpley or [Fun Enuf].";
		if in-warp-command: [??warp-player-to function instead]
			move player to Seer Trees, without printing a room description;
		else:
			move player to Seer Trees;
	else:
		say ".";
	the rule succeeds;

this is the rev-pack-cap rule:
	if flee elf is moot, the rule fails;
	if in-sos is true:
		say "[one of]You need to do something with the Pact Cap[or]The palindromic nature of the game suggesra PA CAP, PAC CAP, or PAC* CAP[or]PACK CAP to please the flee elf[stopping].";
		the rule succeeds;
	else:
		if say-unless-speed, say "You PACK CAP to please the flee elf.";
		get-cap;
	the rule succeeds;

this is the rev-puff-up rule:
	if puffed-up is true, the rule fails;
	if in-sos is true:
		if Dave is not moot, the rule fails;
		if Worn Row is unvisited:
			say "You need to visit west of [hn of My Gym].";
		else if ever-workrow is false:
			say "The main puzzle [hn-in of Yawn Way] is how to get east. You need to change [Worn Row], to start.";
		else if stark rats are in Seer Trees:
			say "To go east [hn-in of Yawn Way], you first need to clear a way west beyond [if Seer Trees is visited]Seer Trees[else]Fun Enuf[end if].";
		else if player does not have Spur Ups:
			say "[if Cold Loc is not visited]You need to visit [vague-dir of Cold Loc][else]King Nik in Cold Loc has an item you need, if you help him.[end if]."; [?? clues still bounce you around a bit]
		else:
			say "[one of]King Nik's Spur Ups are handy to go east of [hn of Yawn Way].[or]Each Spur of King Nik's will help you do something else UP.[or]You need to feel more confident in yourself [hn-in of Emo Dome].[or]PU* UP turns up nothing, though PUT UP seems promising, but...[or]PU** UP has possibilities.[or]PUFF UP [hn-in of Yawn Way] to gain access to the east.[stopping]";
		the rule succeeds;
	if say-unless-speed, say "You use the spur ups to PUFF UP.";
	now puffed-up is true;
	the rule succeeds;

this is the rev-pull-up rule:
	if pulled-up is true, the rule fails;
	if in-sos is true:
		say "[one of]Now you can stand it in [hn-the of Emo Dome], it would be nice to stop[or]You can run past your fears but not stay still to face them[or]The Spur Ups have one more use[or]PU* UP, again, gives nothing[or]PU** UP again has something worthwhile[or]You can PULL UP in Emo Dome to stay and bear things[stopping].";
		the rule succeeds;
	if say-unless-speed, say "You PULL UP in the Emo Dome.";
	moot spur ups;
	now pulled-up is true;
	the rule succeeds;

this is the rev-second-food-combo rule:
	if number of moot ingredients is 4, the rule fails;
	let si be random not moot solid ingredient;
	let mi be random not moot liquid ingredient;
	if in-sos is true:
		if number of carried ingredients is 2:
			say "Mix the [si] and [mi] together [hn-in of Mont Nom], just like you did the [list of moot ingredients].";
		else if pity tip is not moot:
			say "The pity tip will get you some food, if you know where to look.";
		else if player does not have mayo yam:
			say "You can just take the mayo yam from Yell Alley.";
		else if UFO tofu is not carried:
			say "One food is hidden. You need the radar to find it.";
		the rule succeeds;
	if say-unless-speed, say "You mix the [si] and [mi] together in Mont Nom, causing a martini tray to roll out from the Ark of Okra all the way to [Fun Enuf].";
	move martini tram to Fun Enuf;
	if in-warp-command:
		move player to Fun Enuf, without printing a room description;
	else:
		move player to fun enuf;
	moot si;
	moot mi;
	the rule succeeds;

this is the rev-stand-nats rule:
	if Nat's Tan is moot or player carries Nat's Tan or Deft Fed is unvisited, the rule fails; [?? capitalize Nat's?]
	if in-sos is true:
		say "[one of]The Nat's Tan [hn-in of Deft Fed] will be useful. You need to take it[or]TAKE NAT'S doesn't work[or]***** NAT'S, maybe[or]STAND NAT'S[stopping].";
		the rule succeeds;
	if say-unless-speed, say "You STAND NAT'S in [Deft Fed].";
	now player has Nat's;
	the rule succeeds;

this is the rev-tend-net rule:
	if epicer recipe is not off-stage, the rule fails;
	if in-sos is true:
		if Door Frood is in Evaded Ave, the rule fails;
		say "[one of]You'll want to deal with the ten-level net [hn-in of Trapeze Part].[or]What can you do with the net to check it's okay?[or]TEN* NET.[or]TEND NET.[stopping]";
		the rule succeeds;
	if say-unless-speed, say "You TEND NET in the Trapeze Part.";
	get-tended-stuff;
	the rule succeeds;

this is the rev-word-row rule:
	if ever-wordrow is true, the rule fails;
	if in-sos is true:
		say "[one of][Worn Row] can be changed into something else[or]You may need to do a bit of guesswork what to change it into, but there are only twenty-odd possibilities[or][Worn Row] can become WORD ROW[stopping].";
		the rule succeeds;
	if say-unless-speed, say "You transform [Worn Row] into WORD ROW.";
	word-row-open;
	the rule succeeds;

this is the rev-work-row rule:
	if ever-workrow is true, the rule fails;
	if in-sos is true:
		say "[one of][Worn Row] can be changed into something else[or]You may need to do a bit of guesswork what to change it into, but there are only twenty-odd possibilities[or][Worn Row] can become WORK ROW[if number of carried books is 0], though you may wish to take a book from the tract cart first[end if][stopping].";
		the rule succeeds;
	if say-unless-speed, say "You transform [Worn Row] into WORK ROW.";
	work-row-open;
	the rule succeeds;

this is the rev-worn-row rule:
	if psi wisp is moot, the rule fails;
	if in-sos is true:
		if Pro Corp is unvisited, the rule fails;
		say "You need to lure the Psi Wisp back to [Worn Row], then change it back to Worn Row.";
		the rule succeeds;
	if say-unless-speed, say "You lure the Psi Wisp back to Wor(k/d) row, changing it to Worn Row, then back to Word Row.";
	win-wisp-chase;
	word-row-open;
	the rule succeeds;

this is the rev-yak-okay rule:
	if yak is moot, the rule fails;
	if in-sos is true:
		say "[one of]You need to give the kayo yak an order to knock off the Ergot Ogre[or]YAK OKAY (no comma) does the trick[stopping].";
		the rule succeeds;
	if say-unless-speed, say "You say YAK OKAY to dispose of the Ergot Ogre.";
	banish-ogre;
	the rule succeeds;

[zzrr]

section pre-use rules [xxpre]

this is the pre-ale-on-Sniffins rule:
	if in-sos is true:
		if Elan Ale is moot, the rule fails;
		if player does not have yob attaboy and yob attaboy is not moot:
			say "[one of]Sniffins[hn-in-blank of Deft Fed] needs some help[or]Sniffins doesn't need financial help but motivational help. A confidence booster[or]Perhaps a book from Word Row could help Sniffins[or]TAKE YOB ATTABOY [hn-in of Worn Row][stopping].";
		else if player has yob attaboy:
			say "[one of]You have something Sniffins could use for motivation[or]That book you have won't help you, but it will help Sniffins[or]USE YOB ATTABOY ON SNIFFINS[stopping].";
		else if player does not have Elan Ale:
			say "You need classier alcohol to trade for the Gorge Grog.";
		else:
			say "[one of]You have something [Sniffins] wants. An upgrade from the Gorge Grog[or]Look in your inventory for alcohol[or]USE ELAN ALE ON SMUGGUMS[stopping].";
		the rule succeeds;
	if yob attaboy is moot, the rule succeeds;
	say "Sniffins is too distraught to conduct any business. Perhaps a gift of self-help would be more appropriate right now.";
	the rule fails;

this is the pre-arm-on-mob rule:
	if in-sos is true:
		if TNT is moot or player does not carry mr arm, the rule fails;
		say "[one of]If you examine Mr. Arm, he is pointing somewhere[or]If you go to several different locations, Mr. Arm points at different angles[or]Find rooms where Mr. Arm points west or north or east or south, then draw lines to find where they intersect[or]Mr. Arm is pointing to Yell Alley[or]USE MR ARM ON TNT in Yell Alley[stopping].";
	the rule succeeds;

this is the pre-arts-on-lover rule:
	if in-sos is true:
		if player does not have straw arts, the rule fails;
		say "[one of]You don't have a use for the straw arts, but someone else does[or]The Revolt Lover could use more art[or]USE STRAW ARTS ON REVOLT LOVER[stopping].";
	the rule succeeds;

this is the pre-axe-on-veil rule:
	if in-sos is true:
		if exam axe is off-stage, the rule fails;
		say "[one of]You need something that can really cut through the lie veil[or]USE EXAM AXE ON LIE VEIL[stopping].";
		the rule succeeds;
	the rule succeeds;

this is the pre-bat-on-rev rule:
	if in-sos is true:
		if taboo bat is moot or player is not in Dirge Grid, the rule fails;
		say "[one of]The Verses Rev is very orthodox and opposed to unusual things. Maybe you can shock the Rev[or]You have something outlandish[or]USE TABOO BAT ON VERSES REV[stopping].";
	the rule succeeds;

this is the pre-broom-on-yurt rule:
	if in-sos is true:
		if moor broom is moot, the rule fails;
		if NULL ILLUN is not moot, the rule fails;
		if player has moor broom:
			say "[one of]The Tru Yurt still needs cleaning, and you've got something that'll work[or]USE MOOR BROOM ON TRU YURT[stopping].";
		else if player has enact cane:
			say "You're close to having something that will clean out the Tru Yurt, but you're not there yet.";
		else:
			say "It'll take a while before you're able to clear out the Tru Yurt here.";
	the rule succeeds;

this is the pre-cane-on-hay rule:
	if in-sos is true:
		if enact cane is moot or enact cane is off-stage, the rule fails;
		say "[one of]There's still a bit more you can do with the yahoo hay. Only coarse bits are left.[or]Did you notice something that might have some prongs missing?[or]The enact cane may have been a KARE-RAK(E) once.[or]USE ENACT CANE ON YAHOO HAY.[stopping]";
	the rule succeeds;

this is the pre-coop-on-dung rule:
	if in-sos is true:
		if dung is moot, the rule fails;
		say "[one of]You need some implement to get rid of the gnu dung[or]There is something that is specifically meant to take care of dung-ish stuff[or]The poo coop [hn-in of Moo Room] can handle the gnu dung[or]USE POO COOP ON GNU DUNG[stopping].";
	the rule succeeds;

this is the pre-coop-on-rut rule:
	if in-sos is true:
		if poo coop is moot, the rule fails;
		if gnu dung is not moot:
			say "[one of]Since you've got the coop, what you need to fill in the rut is right nearby[or]You need to use the coop on the dung first[stopping].";
		else:
			say "[one of]You want to fill in the rut with something.[or]Do you have anything that is expendable, or that you want to get rid of, that could fill in the rut?[or]It would be nice to dispose of the coop's contents.[or]USE COOP ON RUT.[stopping]";
		the rule succeeds;
	if gnu dung is moot, the rule succeeds;
	say "The poo coop is empty, but if it wasn't, that could work.";
	the rule fails;

this is the pre-cope-on-nik rule:
	if in-sos is true:
		if epoch cope is moot, the rule fails;
		if ever-wordrow is false:
			say "[one of]King Nik needs a book[or]There's (sort of) a location you gaven't found yet that holds books[or][Worn Row] can become one more thing. Go back there to check it out[stopping].";
		else if player does not have epoch cope:
			say "[one of]King Nik needs a book[or]Word Row has the tract cart, which can hold books[or]King Nik needs a book to help him with ruling[or][i]EPOCH: COPE[r] is the best book for King Nik[or][if Worn Row is not wordy]WORD ROW in [Worn Row]. [end if]Get [i]EPOCH: COPE[r][hn-in-blank of Worn Row]. USE EPOCH COPE ON KING NIK[stopping].";
		else:
			say "[one of]You have what King Nik needs[or]USE EPOCH COPE ON KING NIK[stopping].";
	the rule succeeds;

this is the pre-cots-on-eels rule:
	if in-sos is true:
		if stock cots are moot, the rule fails;
		if player has bunk nub:
			say "You'll want to use the reviver on the bunk nub.";
		else if player has stock cots:
			say "[one of]The eels need to be more comfortable. You have an item that could help[or]USE STOCK COTS ON EELS[stopping].";
		else:
			the rule fails;
	the rule succeeds;

this is the pre-cup-on-grail rule:
	if in-sos is true:
		if player does not have puce cup, the rule fails;
		if liar grail is moot, the rule fails;
		if puce cup is soddy:
			say "[one of]You don't need the dose sod in the puce cup until later. Something else belongs in the puce cup, first[or]USE PAST SAP ON PUCE CUP to replace the dose sod, for now[stopping].";
		else if puce cup is sappy:
			say "[one of]You need to find the right place for the cup with the [sir-sap-long][or]Another place has a receptacle for the [sir-sap-long][or]The Liar Grail [hn-in of Swept Pews][or]USE CUP ON GRAIL [hn-in of Swept Pews][stopping].";
		else:
			say "[one of]The puce cup needs to be filled with two things. First, something you've already seen[or]Use some liquid-ish thing on the cup[or]USE PAST SAP ON CUP[stopping].";
		the rule succeeds;
	if puce cup is sappy, the rule succeeds;
	get-reject liar grail;
	say "[if puce cup is soddy]The sod doesn't seem to belong in the Liar Grail, but maybe something else does[else]The puce cup is empty[end if].";
	the rule fails;

this is the pre-cup-on-nob rule:
	if in-sos is true:
		if puce cup is moot, the rule fails;
		if puce cup is not soddy:
			say "You need to put the dose sod in the puce cup.";
			the rule succeeds;
		say "[one of]The dose sod in the puce cup can help someone, but whom?[or]The dose sod doesn't help the Gulf Lug north of Cold Loc.[or]However, the dose sod can help the Bond Nob [hn-in of Drawl Ward].[stopping]";
		the rule succeeds;
	if puce cup is soddy, the rule succeeds;
	get-reject Bond Nob;
	say "[if puce cup is sappy]The Bond Nob makes a face at the sap in the cup. Maybe something less unpalatable would help, here[else]The puce cup is empty. It wouldn't help the Bond Nob[end if].";
	the rule fails;

this is the pre-cup-on-sap rule:
	if liar grail is moot:
		if revving-over is false and in-sos is false, say "You doubt you will need the past sap again, since it got you by the Liar Grail[if puce cup is soddy]. In fact, the sod seems like a good thing to have[else]. But maybe something else[end if].";
		the rule fails;
	if puce cup is sappy:
		if revving-over is false and in-sos is false, say "The puce cup already contains past sap.";
		the rule fails;
	if sap-takeable is false:
		if in-sos is true:
			say "[one of]You need to cut the sap off[or]USE SAW ON SAP [in-not-here of Cold Loc][stopping].";
			the rule succeeds;
		if revving-over is false, say "The sap is stuck to the rift fir. You can't [if player has puce cup]quite lump it in the puce cup[else]just take it with your hands[end if].";
		unless player has puce cup, now sap-with-hands is true;
		the rule fails;
	if in-sos is true:
		if liar grail is moot, the rule fails;
		if puce cup is sappy, the rule fails;
		say "You need to USE the sap on the puce cup.";
		the rule succeeds;
	later-wipe past sap;
	if puce cup is soddy:
		if revving-over is false and in-sos is false:
			say "The puce cup already contains dose sod. Apse Spa had enough, you could get more sod later. Pour it out to get the past sap?";
			if the player yes-consents:
				say "The sod dissolves into the ground.";
				the rule succeeds;
			say "Maybe later, then.";
		if in-sos is true:
			say "You may wish to replace the dose sod with past sap.";
			the rule succeeds;
		the rule fails;
	the rule succeeds;

this is the pre-cup-on-sod rule:
	if in-sos is true:
		if puce cup is moot, the rule fails;
		if liar grail is not moot, the rule fails;
		if puce cup is soddy, the rule fails;
		say "[one of]One thing besides the past sap can go in the puce cup[or]You will find something else [hn-in of Apse Spa] that you can't take bare-handed[or]USE DOSE SOD ON PUCE CUP[stopping].";
		the rule succeeds;
	if puce cup is soddy:
		if revving-over is false and in-sos is false, say "The puce cup already contains dose sod.";
		the rule fails;
	later-wipe dose sod;
	if puce cup is sappy:
		if in-sos is true:
			say "You need to replace the past sap with dose sod.";
			the rule succeeds;
		say "The puce cup already contains past sap. Pour it out to get the dose sod?";
		if the player yes-consents:
			say "The purist sirup, formerly the past sap, oozes out and soaks into the ground.";
			the rule succeeds;
		the rule fails;
	the rule succeeds;

this is the pre-demos-on-hay rule:
	if in-sos is true:
		if player does not have SOME DEMOS, the rule fails;
		say "[one of]SOME DEMOS talks about making art with contradictory items[or]There is one item that is contradictory enough for SOME DEMOS to apply[or]The item SOME DEMOS can be used with is both exciting and boring[or]USE SOME DEMOS ON YAHOO HAY[in-not-here of Moo Room][stopping].";
	the rule succeeds;

this is the pre-doodle-on-tide rule:
	if in-sos is true:
		if player does not have el doodle, the rule fails;
		say "[one of]The doodle needs modification, but it doesn't seem like anyone can do it[or]The machines in Work Row don't help with the doodle, either[or]Look carefully for scenery which could change something[or][if Yack Cay is unvisited]You haven't yet been to the place where you can chance the doodle[else]USE DOODLE ON TIDE in Yack Cay[end if][stopping].";
	the rule succeeds;

this is the pre-gas-on-mat rule:
	if in-sos is true:
		if sage gas is moot, the rule fails;
		say "[one of]The tame mat needs a stronger, smarter message[or]You may have something that can make things smarter[or]USE SAGE GAS ON TAME MAT[stopping].";
		the rule succeeds;
	the rule succeeds;

this is the pre-gem-on-fink rule:
	if in-sos is true:
		if ME gem is moot or player is not in Dirge Grid, the rule fails;
		say "[one of]The Knife Fink is pretty mercenary. Maybe you can use bribery[or]You have something valuable that even other bad guys didn't like, but the Knife Fink might[or]USE ME GEM ON KNIFE FINK[stopping].";
		the rule succeeds;
	the rule succeeds;

this is the pre-grog-on-tub rule:
	if in-sos is true:
		if butene tub is moot, the rule fails;
		if psi wisp is not moot:
			say "You need to get rid of the psi wisp before tackling the butene tub.";
		else if player does not have Gorge Grog:
			say "[one of]The warning on the butene tub is too prominent to ignore. It would be fun to blow up[or]You need something powerful to blow up the butene tub[or]There's nothing too explosive, except for [if navy van is moot]the TNT[else]something[end if] in Yell Alley, which is useful elsewhere[or]The Gorge Grog is 100+ proof. It's pretty flammable[or][if player does not have Gorge Grog]After trading Sniffins for the Gorge Grog, [end if]USE GORGE GROG ON BUTENE TUB[stopping].";
		else:
			say "[one of]You have what you need to destroy the butene tub[or]Some powerful or concentrated chemical will work to destroy the butene tub[or]USE GORGE GROG ON BUTENE TUB[stopping][in-not-here of Pro Corp].";
		the rule succeeds;
	the rule succeeds;

this is the pre-illun-on-wonk rule:
	if in-sos is true:
		if wonk is moot, the rule fails;
		if player has NULL ILLUN:
			say "[one of]You have what the [itm-place of Known Wonk] needs, to feel clearer[or]USE NULL ILLUN ON KNOWN WONK[in-not-here of Yack Cay][stopping].";
		else:
			say "[one of]The [itm-place of Known Wonk] probably likes books, but which one from [hn of Worn Row]?[or]The [itm-place of Known Wonk] overthinks things and may not be high on emotional intelligence[or]USE NULL ILLUN ON KNOWN WONK[in-not-here of Yack Cay][stopping].";
	the rule succeeds;

this is the pre-key-on-gate rule:
	if in-sos is true:
		if Ye Key is moot, the rule fails;
		if player has Ye Key:
			say "[one of]You have the item you need to open the etage gate[or]USE YE KEY ON ETAGE GATE[stopping].";
		else:
			say "[one of]You may wish to explore some areas and their scenery more carefully to make a key[or]The stamp mats can work with something[or]Look around in Yelpley for materials the stamp mats could go with[or]The missing key part is in Scrap Arcs in the southeast[or]USE STAMP MATS ON SLATE METALS[stopping].";
		the rule succeeds;
	if Ned is moot, the rule succeeds;
	say "Good idea, but not with Ned around.";
	get-reject gate tag;
	the rule fails;

this is the pre-maps-on-bog rule:
	if in-sos is true:
		if spa maps are moot, the rule fails;
		if maps-explained is false:
			if uneven u is unvisited:
				say "You haven't found anyone who could help you with the maps yet.";
			else:
				say "[one of]You need someone smart to help you with the maps. Someone who knows how to do things[or]The Code Doc can help you with the maps[stopping].";
		else:
			say "[one of]The spa maps may be tough to follow, but you can guess where they might help you[or]You should go to the Apse Spa with the spa maps[or]USE SPA MAPS ON BOG[in-not-here of Apse Spa][stopping].";
		the rule succeeds;
	if maps-explained is true, the rule succeeds;
	say "Hmm. Maybe if the maps were a bit clearer to you, that would work. But not now.";
	get-reject sage gas;
	the rule fails;

this is the pre-maps-on-doc rule:
	if in-sos is true:
		if maps-explained is true, the rule fails;
		if uneven u is unvisited:
			say "You haven't found anyone who could help you with the maps yet.";
		else:
			say "[one of]You need someone smart to help you with the maps. Someone who knows how to do things[or]The Code Doc can help you with the maps[stopping].";
		the rule succeeds;
	if maps-explained is true:
		say "You already got the Code Doc to decipher the spa maps.";
		the rule fails;
	if tent net is not moot:
		say "'I might, but I need some help here first, to make my home here properly homey. I've got everything except a roof.'";
		get-reject Spa Maps;
		the rule fails;
	the rule succeeds;

this is the pre-motor-on-hand rule:
	if in-sos is true:
		if player does not have roto motor, the rule fails;
		if player has DNA band:
			say "Look for ways to improve the DNA band.";
		else if DNA band is in Pro Corp:
			say "You need to get the DNA band[in-not-here of Pro Corp].";
		else:
			say "[one of]The roto motor can bring something else alive[or]What the roto motor works with has already been boosted slightly[or]USE ROTO MOTOR ON DNA HAND[stopping].";
	the rule succeeds;

this is the pre-net-on-doc rule:
	if in-sos is true:
		if player does not have tent net, the rule fails;
		say "[one of]The Code Doc needs a few more materials to build Uneven U[or]You have something that could help the Code Doc[or]You don't have much you could do with a tent net[or]USE TENT NET ON CODE DOC[in-not-here of uneven u][stopping].";
	the rule succeeds;

this is the pre-nub-on-reviver rule:
	if in-sos is true:
		if bunk nub is moot, the rule fails;
		if bunk nub is in Evaded Ave:
			say "You'll need to find a way to get the bunk nub from the Door Frood in Evaded Ave.";
		else:
			say "[one of]The bunk nub is worn out and no longer good for sleeping on[or]It would be nice to make the bunk nub a bit better to sleep on[or]You could breathe life into the bunk nub with some machine action[or]USE BUNK NUB ON REVIVER[stopping].";
	the rule succeeds;

this is the pre-orb-on-rim rule:
	if in-sos is true:
		if player is not in Red Roses Order or Ms Ism is not in Red Roses Order, the rule fails;
		say "[one of]The Bros['] Orb got you in, and it seems extra powerful and reflectivee, but it's not clear what to use it on[or]Trial and error can tell what to use the Orb on, but you may notice one thing is good at showing your faults[or]The mirror rim shows how silly your cap looks on you[or]USE BROS ORB ON MIRROR RIM to shatter the mirror[stopping].";
	the rule succeeds;

this is the pre-ort-on-garb rule:
	if in-sos is true:
		if troll ort is not quicknear, the rule fails;
		if brag garb is not carried and brag garb is not worn, the rule fails;
		say "[one of]The brag garb is a bit too strong-smelling. You may have noticed it causes a weird reaction from the kayo yak.[or]Perhaps it smells differently.[or]Do you have any other item that smells funny? More appealing?[or]The troll ort is apparently PINT-A-CATNIP.[or]USE TROLL ORT ON BRAG GARB.[stopping]";
	the rule succeeds;

this is the pre-pole-on-kayak rule:
	if in-sos is true:
		if kayak is moot, the rule fails;
		if elope pole is off-stage:
			say "There's something in Yelpley that could steer the kayak.";
		else if player has elope pole:
			say "[one of]You need a kind of paddle to steer the kayak[or]You have something that could act like a kayak paddle. It's long enough, at least[or]USE ELOPE POLE ON KAYAK[in-not-here of Lac Oft Focal][stopping].";
	the rule succeeds;

this is the pre-popper-on-totem rule:
	if in-sos is true:
		if me totem is moot, the rule fails;
		if rep popper is in Yell Alley:
			say "You don't yet have the item you need to defeat the Yuge Guy.";
		else:
			say "[one of]The Yuge Guy is intimidating, but it's the ME TOTEM[in-not-here of Sneer Greens] that amplifies his obnoxiousness.[or]You could say the ME TOTEM inflates the Yuge Guy's public perception...[or]...or the totem increases the Yuge Guy's Rep.[or]USE REP POPPER ON ME TOTEM[in-not-here of Sneer Greens].[stopping]";
	the rule succeeds;

this is the pre-radar-on-arc rule:
	if in-sos is true:
		if UFO tofu is not off-stage, the rule fails;
		if cross orc is not moot:
			say "You need to bribe the cross orc to leave [hn of Toll Lot].";
		else if radar is off-stage:
			say "You need to clean up the [Dopy Pod] for a useful item.";
		else:
			say "[one of]The crag arc is more than just scenery[or]Something might be hidden behind the crag arc[or]You need an item to find what's behind the crag arc[or]The radar will detect something behind the crag arc[stopping].";
		the rule succeeds;
	if UFO tofu is not off-stage:
		say "You already scanned the crag arc successfully.";
		the rule fails;
	if orc is not in Toll Lot, the rule succeeds;
	say "The cross orc prevents you from trying anything possibly constructive. Maybe with the orc gone, you should try it again.";
	get-reject UFO tofu;
	the rule fails;

this is the pre-radar-on-dam rule:
	if in-sos is true:
		if eroded ore is off-stage:
			if player does not have radar:
				say "[one of]You'll need something to scan the made dam[or]The something to scan the made dam is back in Yelpley[or][if Dopy Pod is visited]The item you want is under the cassettes sac[else]You haven't visited the place in Yelpley to get the item to scan the dam yet[end if][stopping].";
			else:
				say "[one of]There's something behind the [itm-place of made dam], but you can't just see it. If only you had an item to sense such things[or]USE RADAR ON MADE DAM[in-not-here of Swamp Maws][stopping].";
			the rule succeeds;
		the rule fails;
	if eroded ore is not off-stage:
		say "You already scanned the made dam successfully.";
		the rule fails;
	the rule succeeds;

this is the pre-rahs-on-rug rule:
	if in-sos is true:
		if sharp rahs are moot, the rule fails;
		say "[one of]The guru rug is now a bit too esoteric compared to the tame mat. Maybe some other odd item, a bit more down-to-earth, could change that[or]Something that mixes emotion with the guru rug could help[or]USE SHARP RAHS ON GURU RUG[stopping].";
	the rule succeeds;

this is the pre-ray-on-redivider rule:
	if in-sos is true:
		if yard ray is moot or player is not in Dirge Grid, the rule fails;
		say "[one of]You've got one shot with the Yard Ray, but what to use it on?[or]Killing the Diktat Kid won't stop the other machines from working.[or]The purely violent machines aren't critical, either.[or]USE YARD RAY ON REDIVIDER.[stopping]";
	if Knife Fink is in Dirge Grid or Verses Rev is in Dirge Grid:
		say "You can't get a clear shot with [the list of henchy people] in the way.";
		the rule fails;
	the rule succeeds;

this is the pre-ray-on-set rule:
	if in-sos is true:
		if test set is moot, the rule fails;
		if murdered rum is off-stage:
			say "You need to find ammo for the Yard Ray.";
		else if player has murdered rum:
			say "[one of]You'll need something powerful as ammo for the yard ray[or]The murdered rum should work as ammo for the yard ray[or]USE RUM ON RAY[stopping].";
		else if emitted is false:
			say "[one of]From examining the yard ray, you can see EMIT ********. You need to figure what the eight letters are[or]TIME is the last four letters of what to emit. You need something bright with four letters[or]EMIT NOONTIME[stopping].";
		else:
			say "[one of]You need practice with the yard ray[or]You need to USE YARD RAY ON TEST SET[if player is not in Worn Row or Worn Row is not worky] in Work Row[end if][stopping].";
		the rule succeeds;
	if emitted is true, the rule succeeds;
	get-reject test set;
	say "[if murdered rum is not moot]The yard ray is empty, but maybe you could load it with something[else]You aren't sure how the Yard Ray works, or what it needs to zap people with. Maybe you should review it to figure things out[end if].";
	the rule fails;

this is the pre-rod-on-boat rule:
	if in-sos is true:
		if dork rod is moot, the rule fails;
		say "[one of]The Tao Boat[in-not-here of Lac Oft Focal] seems to be a sort of test[or]The Tao Boat is not impressed by showings of wealth, only by self-acceptance[or]An item that seems useless but may be slightly self-effacing would please the Tao Boat[in-not-here of Lac Oft Focal][or]USE DORK ROD ON TAO BOAT[in-not-here of Lac Oft Focal][stopping].";
	the rule succeeds;

this is the pre-rum-on-ray rule:
	if in-sos is true:
		if player does not have yard ray, the rule fails;
		if murdered rum is moot, the rule fails;
		if murdered rum is off-stage:
			say "You need to defeat the Yuge Guy to get what you need to load the yard ray.";
		else:
			say "[one of]You need something to fill the yard ray with[or]The murdered rum is strong enough[or]USE MURDERED RUM ON YARD RAY anywhere[stopping].";
	the rule succeeds;

this is the pre-saw-on-crop rule:
	if in-sos is true:
		if porch crop is moot, the rule fails;
		if moor broom is not moot, the rule fails;
		if porch crop is in uneven u and revisit-clue is false:
			say "Try visiting Uneven U.";
		else:
			say "[one of]You'd like to trim the [itm-place of porch crop][or]You have an item that can cut stuff down. It did, much earlier in the game[or]USE WASH SAW ON PORCH CROP[in-not-here of Uneven U][stopping].";
	the rule succeeds;

this is the pre-saw-on-sap rule:
	if in-sos is true:
		if Cold Loc is unvisited, the rule fails;
		if sap-takeable is true, the rule fails;
		say "[one of]You can hack off some of the sap [hn of Cold Loc]. You already have the item for it[or]USE SAW ON SAP[in-not-here of Cold Loc][stopping].";
		the rule succeeds;
	if sap-takeable is true:
		if revving-over is false, say "You already hacked more than enough sap off.";
		the rule fails;
	the rule succeeds;

this is the pre-slab-on-rows rule:
	if in-sos is true:
		if sword rows are moot, the rule fails;
		if player does not have balsa slab:
			say "You don't have anything the sword rows can cut right now.";
		else:
			say "[one of]The [itm-place of sword rows] can cut through something, but what?[or]You may have an inventory item that can be carved into something more artistic by the [itm-place of sword rows][or]The [itm-place of sword rows] would work well on a soft wood item[or]USE BALSA SLAB ON SWORD ROWS[stopping].";
	the rule succeeds;

this is the pre-tag-on-tattoos rule:
	if in-sos is true:
		if player does not have tag or player does not have tattoos, the rule fails;
		say "[one of]You can make the ID you need to get past the DIFF-ID[or]You may notice the patterns of roses, or ... throughout the game[or]The gate tag has the pattern to get by the DIFF ID[or]The soot tattoos can be used to press the pattern on your skin[or]USE GATE TAG ON SOOT TATTOOS anywhere[stopping].";
	the rule succeeds;

this is the pre-tan-on-rocs rule:
	if in-sos is true:
		if rocs are moot, the rule fails;
		if player does not have tan:
			say "[one of]You need to get something gross to deface the scorn rocs and ruin their shininess[or]What is gross and discolored in Yelpley?[or]Nat's Tan in [Deft Fed] is weird and orange[or]Find a way to get Nat's Tan and then use it on the scorn rocs[stopping].";
		else:
			say "[one of]You have what you need to vandalize the rocs and dent their pride[or]USE NAT'S TAN ON SCORN ROCS[in-not-here of Flu Gulf][stopping].";
	the rule succeeds;

this is the pre-tix-on-exit rule:
	if in-sos is true:
		if x-ite tix are off-stage, the rule fails;
		say "[if player is in Dirge Grid]You just need to go back south with the Tix[else if player is not in fun enuf]You can win by going back to Fun Enuf[else]You just need to use the X-Ite Tix on the Tix Exit here[end if][if cur-score of Odd Do < 11], though you can keep hunting for LLPs if you want[end if].";
		the rule succeeds;
	the rule succeeds;

this is the pre-vac-on-sac rule:
	if in-sos is true:
		if cassettes sac is moot, the rule fails;
		if Dopy Pod is not visited, the rule fails;
		if player has Dirt Rid:
			say "You'd like to clean up the cassettes sac, but you need something stronger than the Dirt Rid.";
		else if player has cave vac:
			say "[one of]You have what you need to clean the cassettes sac[or]USE CAVE VAC ON CASSETTES SAC[stopping][in-not-here of Dopy Pod].";
		else:
			say "[one of]You need a cleaning tool. You can trade for one elsewhere[or]Look south of Toll Lot to get started on how to clean the cassettes sac[stopping].";
		the rule succeeds;
	the rule succeeds;

[zzpre]

section post-use rules [xxpost]

[please add alphabetically]

this is the brag-garb-bye rule:
	moot brag garb;
	the rule succeeds;

this is the bump-gulf rule:
	shuffle-before Flu Gulf and Sneer Greens;
	the rule succeeds;

this is the bump-ivy rule:
	shuffle-before Uneven U and Red Roses Order;
	move porch crop to Uneven U;
	moot Known Wonk;
	the rule succeeds;

this is the bump-maws rule:
	moot mist sim;
	now Yack Cay is not chase-blocked;
	shuffle-before Dumb Mud and Le Babel;
	shuffle-before Yack Cay and Dumb Mud;
	the rule succeeds;

this is the bump-pod rule:
	shuffle-before Dopy Pod and Toll Lot;
	later-wipe cassettes sac;
	the rule succeeds;

this is the chase-in-zoo rule:
	if location of player is Frush Surf, start-chase Kayo Yak;
	the rule succeeds;

this is the cold-loc-hint-bump rule:
	shuffle-before Cold Loc and Emo Dome;
	the rule succeeds;

this is the empty-cup rule: [ignore rule check]
	moot puce cup;
	shuffle-before Apse Spa and Motto Bottom;
	the rule succeeds;

this is the empty-grail rule:
	later-wipe liar grail;
	now puce cup is empty;
	moot wordy drow;
	the rule succeeds;

this is the empty-nob rule:
	later-wipe Bond Nob;
	consider the empty-cup rule;
	choose row with tabnam of table of Bond Nob bars in table of all randoms;
	if thru-yet entry is 0, now thru-yet entry is 1; [to make sure a weird 'cycling' message is not printed]
	the rule succeeds;

this is the gas-think-wipe rule:
	later-wipe sage gas;
	the rule succeeds;

this is the hay-gone rule:
	if SOME DEMOS is moot and enact cane is moot:
		unless redact-postrule, say "You used up all the hay! You're sad it's gone but excited you could be so efficient with it. Yahoo!";
		moot yahoo hay;
		later-wipe yahoo hay;
	else:
		get-reject yahoo hay;
		unless redact-postrule, say "There's still some hay (yah!) left over for another creative project.";
	the rule succeeds;

this is the kid-bye rule:
	move saner arenas to Dirge Grid;
	move day away ad to Yawn Way;
	move XILE helix to Dirge Grid;
	move relate taler to Worn Row;
	now Worn Row is wordy;
	moot nogo gon;
	moot Diktat Kid;
	if nogo gon is xed, say "The No-Go Gon having burned away, you're sort of curious how many sides it had. You miscount the first few times but eventually wind up counting [rand-pal]. Well, you sort of expected that.";
	the rule succeeds;

this is the kid-left rule:
	unless redact-postrule:
		if Verses Rev is moot and Knife Fink is moot:
			say "Two-nowt, you muse to yourself. The Diktat Kid, clearly angry, mutters 'OW! TWO?! Meh, THEM! I should've gone with [next-rand-txt of table of rejected kid sidekicks]. Or [next-rand-txt of table of rejected kid sidekicks]. Or...'";
		else:
			say "The Diktat Kid mutters the [if Verses Rev is moot]Verses Rev[else]Knife Fink[end if] was sorta flaky anyway. Shoulda gone with [next-rand-txt of table of rejected kid sidekicks].";
	the rule succeeds;

this is the make-sag rule:
	move gash sag to Pro Corp;
	unless redact-postrule, consider the notify Bald Lab rule;
	the rule succeeds;

this is the maps-explain rule:
	later-wipe spa maps;
	now maps-explained is true;
	the rule succeeds;

this is the mob-bye rule:
	the rule succeeds;

this is the mob-to-alley rule:
	moot navy van;
	now Line Nil is in Yell Alley;
	now bomb mob is in Yell Alley;
	shuffle-before Yell Alley and Sneer Greens;
	the rule succeeds;

this is the moot-rows-and-tats rule:
	if in-warp-command:
		moot-tats-and-rows;
		move player to Emo Dome, without printing a room description;
	the rule succeeds;

this is the oh-who-to rule:
	now Oh Who is in Seer Trees;
	the rule succeeds;

this is the post-puff-up rule:
	now puffed-up is true;
	the rule succeeds;

this is the post-pull-up rule:
	now pulled-up is true;
	the rule succeeds;

this is the post-tan-on-rocs rule:
	if debug-state is true and Flu Gulf is chase-blocked, say "Un-chase-blocking Flu Gulf.";
	now Flu Gulf is not chase-blocked;
	the rule succeeds;

this is the radar-blink rule:
	if radar-used is 1:
		unless redact-postrule, say "One more hit like that, and the radar might give out for good.";
	else:
		unless redact-postrule, say "Between the UFO tofu dropped on the radar and the eroded ore getting too close to it, the radar shorts out. After a pop, it splits open. A roto motor falls out and looks undamaged, so you take it.";
		now player has roto motor;
		moot radar;
	the rule succeeds;

this is the radar-crag rule:
	consider the radar-blink rule;
	later-wipe UFO tofu;
	the rule succeeds;

this is the rahs-too rule:
	now player has the sharp rahs;
	later-wipe el doodle;
	the rule succeeds;

this is the ray-beepy-now rule:
	now yard ray is beepy;
	the rule succeeds;

this is the ray-not-beepy-now rule:
	now yard ray is ordinary;
	the rule succeeds;

this is the rebump-art-xtra rule:
	shuffle-before Art Xtra and Red Roses Order;
	the rule succeeds;

this is the rug-to-bottom rule:
	now guru rug is in Motto Bottom;
	the rule succeeds;

this is the sap-loose rule:
	now sap-takeable is true;
	if player has puce cup:
		unless redact-postrule, say "Hmm, the puce cup would be perfect to carry the past sap in[if cup is not empty], though you'd need to empty the cup, first[end if].";
		the rule succeeds;
	later-wipe past sap;
	if eyespoil of wash saw > 0, now eyespoil of wash saw is rowcount of wash saw; [?? this looks really hacky. I should have a more general rule to track the rowcount/eyespoil of a thing.]
	the rule succeeds;

this is the sap-to-cup rule:
	now puce cup is sappy;
	now puce-ever is true;
	now sap-ever-in-cup is true;
	now sap-with-hands is false;
	no-extra-cup-points;
	the rule succeeds;

this is the shift-dumb-mud rule:
	shuffle-before Dumb Mud and Le Babel;
	later-wipe poo coop;
	the rule succeeds;

this is the sod-to-cup rule:
	now puce cup is soddy;
	now puce-ever is true;
	now sap-with-hands is false;
	no-extra-cup-points;
	the rule succeeds;

this is the sword-rows-reveal rule:
	if not say-unless-speed, say "You defeat Ms. Ism in the Red Roses Order.";
	move sword rows to Red Roses Order;
	moot Ms Ism;
	move E Divide to Red Roses Order;
	the rule succeeds;

this is the tag-later-wipe rule:
	later-wipe gate tag;
	the rule succeeds;

this is the tats-peripheral rule:
	now state tats are peripheral;
	the rule succeeds;

this is the test-set-zapped rule:
	later-wipe test set;
	the rule succeeds;

this is the toons-to-den rule:
	moot decal placed;
	move snooty toons to Deft Fed;
	now Sniffins-reintro is true;
	unless redact-postrule, move the player to Toll Lot, without printing a room description;
	the rule succeeds;

this is the totem-out rule:
	unless say-unless-speed, say "You defeat the Yuge Guy in Sneer Greens.";
	moot ME Totem;
	moot Yuge Guy;
	the rule succeeds;

this is the tube-to-ave rule:
	now Art Xtra is visited; [this is necessary for if the player tried WRW]
	move tube but to Evaded Ave;
	the rule succeeds;

this is the unlimbo-coop rule:
	if gnu dung is preclued, get-reject poo coop;
	later-wipe gnu dung;
	the rule succeeds;

this is the wear-garb rule:
	now player wears the brag garb;
	the rule succeeds;

this is the you-win rule: [xxwin]
	follow the notify score changes rule;
	say "[line break]You wonder how you'll get back, but then you see the Flee Elf running towards you. 'Tardy, drat! ... 'This, I h/t! [if cur-score of Odd Do is max-score of Odd Do]Decay?! ACED[else]Won enow[end if]!' You ask hesitantly about what's next. You don't want or need people chanting 'Deified! Deified! Deified!', but...[wfak]";
	say "'The X-ITE TIX lead BACK TO THE REAL WORLD WHICH WILL BE FAR MORE EXCITING AND ILLUMINATING FOR YOUR EXPERIENCE HERE!'[wfak]Well, given all the palindromes you dealt with, you probably should've expected a there-and-back-but-wiser summary. Books like that always kind of annoyed you once you figured the whole schtick out, but you did have fun here. Probably more than if you'd stood around and leveled up a whole bunch in some more 'exciting' world. So that's something! The Flee Elf shakes your hand says, 'I'll need the pact cap back. It will go to our new museum.'[paragraph break]'What's it called?' you ask, despite yourself.[wfak]";
	say "[paragraph break]'Well, there's still argument over We-I-View, Show-Ohs and Trofy Fort.' (Trofee?) The Flee Elf asks which you prefer, and after an awkward silence, you mention they all seem equally appropriate and unforced. Another awkward silence! How palindromic![paragraph break]'Well, anyway. This RIDE-DIR will help you return to your own world. And here is an x/o box.'[wfak]";
	say "The x/o box isn't much. It's engraved 'U Remem'er, U,' 'Done? NOD' and 'U Did U.' You can't even open it! But if it were too obvious and gaudy, how would you explain it back home?[paragraph break]Soon after you blurt out 'Oh, t/y! My, tho['],' arguments begin nearby over if Yelpley needs a name change and if so to what: Tropiciport? El Live Ville? Grub Burg? Not-Dud-Ton? Not-Kook-Ton? Or even Prodded-Dorp (sounds motivational!) You realize you're probably not going to stop that sort of silly argument, but on the other hand, why be bothered with stuff you can't fix?[wfak]";
	say "Toot! Toot! A ride pulls up. You were sort of expecting a racecar or maybe a TekCo Rocket, but it turns out it's just a Back Cab labeled 'Redi-Rider.' (A Toyota would also have worked.) 'Race fast, safe car,' you mutter unconsciously, but it doesn't. Maybe it needs an XLR8R-LX engine.[paragraph break]Still, you enjoy the extra time reflecting. You don't have the tech savvy to make a DVD, so to remember this, you'd like ... to jot. What to call your writing? RECAP: ACER, NOW I WON and EL BIBLE are way too pompous, but some brainstorming gives DARN RAD, SOME MEMOS, I SAW [']TWAS I, DRAWN INWARD, WENT NEW, WENDED NEW, SAGAS or SOLOS. Or--no, that's it. ELATE TALE.";
	end the story finally saying "Roxor! Roxor! Roxor!";
	sort the table of last lousy points in finord order;
	the rule succeeds;
[zzwin]

to move-opt-show (rm - a room): [?? this is currently orphaned after I fiddled with the Sniffins/YA code.]
	if deep-speeding is true:
		move the player to rm, without printing a room description;
	else:
		move the player to rm;

[zzpost]

chapter peripherals

instead of doing something when noun is a direction or second noun is a direction:
	if current action is going, continue the action;
	if current action is examining:
		if noun is east and location of player is Yawn Way and puffed-up is false, say "You're ... scared a bit. You feel very down, and you probably need to feel up to get across." instead;
		say "You don't need to look far in any direction. Nothing is waiting sneakily to kill you around the corner." instead;
	say "You don't need to do anything fancy with directions. Just go that way."

instead of doing something when second noun is a peripheral thing:
	if noun is radar and current action is useoning, continue the action;
	if action is procedural, continue the action;
	blanket-reject second noun instead;

instead of doing something with a peripheral thing:
	if second noun is radar and current action is useoning, continue the action;
	if action is procedural, continue the action;
	if current action is taking and noun is pyx, continue the action;
	blanket-reject noun instead;

instead of useoning something with a peripheral thing:
	if action is procedural, continue the action;
	if noun is radar, continue the action;
	blanket-reject second noun instead;

instead of doing something when second noun is a semiperipheral thing:
	if noun is radar and current action is useoning, continue the action;
	if action is pro-and-use, continue the action;
	blanket-reject second noun instead;

instead of doing something with a semiperipheral thing:
	if action is pro-and-use, continue the action;
	if current action is inserting into and noun is past sap, continue the action;
	if current action is stacking and noun is senile felines, continue the action; [add other exceptions here. This may be a horrid hack but it's the best I can do.]
	if current action is mussing and noun is opossum, continue the action;
	blanket-reject noun instead;

to blanket-reject (bj - a thing):
	repeat through table of periphery:
		if itm entry is bj:
			say "[reject entry][line break]";
			continue the action;
	repeat through table of cantuse:
		if use1 entry is bj:
			say "[babble entry][line break]";
			continue the action;
	say "While [the noun] doesn't need any detailed futzing, I don't have a detailed message for why. I need to fix that. Sorry."

table of periphery [xxper]
itm	reject [thus table is ordered west to east, north to south]
calcific lac	"There's nothing you need to do TO the calcific lac. You [if lac-score is 2]did enough[else if lac-score is 1]could maybe deal with the [kayak-boat][else]can't imagine the boat and kayak are useless, though[end if]." [start lac often focal 0 0]
Elided Ile	"You don't need to do anything to Elided Ile [if kayak is moot]now you've been[else]except maybe get[end if] there."
smirk rims	"The smirk rims are only important if you let them be. In other words, they're not." [start Sneer Greens 1 0]
Ebola Lobe	"The Ebola Lobe is impassable. You'd need some Nix-O-Toxin to get through, and there isn't any here." [start Flu Gulf 2 0]
mush sum	"The mush sum is too murky and unstable to deal with. And to break the fourth wall, it's just there to provide a north border."
e-pipe	"You don't need or want to tinker with the e-pipe. In fact, it's kind of nice to have a boundary as impassable as the e-pipe, so you don't have to wonder if there's anything beyond the Trapeze Part." [start Trapeze Part 3 0]
tube but	"The tube doesn't lead anywhere you want to go. You don't need to muck with it." [start Evaded Ave 4 0]
Line Nil	"There's nothing you need behind the Line Nil security system. In fact, it's probably protecting you." [start Yell Alley 5 0]
gash sag	"You don't want to mess with the gash sag. Destroying the butene tub is damage enough." [start Pro Corp 6 0]
Sci Pics	"The Sci Pics are just there to [if Gorge Grog is moot]rehash what happened[else]spell out what happens[end if] if you go pouring random explosive liquids down the butene tub."
mist sim	"You don't have anything that would dispel the mist sim." [start Yack Cay 0 1]
storm rots	"Yuck. You don't want or need to touch the storm rots, or do anything with them. There's probably worse behind them."
opossum	"The opossum is just there to (optionally) be nice to, in a special, unusual way." [start Le Babel 1 1]
voodoo v	"You don't want or need to mess with the voodoo v."
past sap	"[if liar grail is moot]With the liar grail gone, you don't want to have to deal with the past sap again[else]The past sap might be useful, but you [how-take-sap][end if]." [start Cold Loc 2 1]
pool gloop	"Fortunately, you don't need to do anything special to or with the pool gloop." [start Apse Spa 3 1]
spa taps	"The spa taps can't do much. You're not a customer, anyway."
state tats	"You don't need to do anything to or with the state tats, now that you're wearing them." [start traded art 4 1]
E Divide	"There's no way to dispel the E-Divide, but Ms. Ism isn't the main enemy here, any more." [start Red Roses Order 5 1]
Gal Flag	"The Gal Flag seems like a distraction. You need some way to disarm Ms. Ism!"
Oh Who	"[fonen-of of Oh Who]." [start Seer Trees 2 2]
x-it stix	"No way you're getting through the X-It Stix."
KAOS Oak	"The [kaoscaps] is immune to ordinary manipulation. You'll need a powerful contraption indeed to dispel it!" [start Fun Enuf 3 2]
pip	"The pip is just there as a guide to see if you can EYE anything. You don't need to do anything with it."
Name ME Man	"[fonen-of of Name ME Man]." [start Yawn Way 4 2]
x y pyx	"The x/y pyx is a map, nothing more, nothing less. You can only [if player does not have x y pyx]take and [end if]examine it."
DIFF ID	"You don't have the skill to tinker with the DIFF-ID. You [if Red Roses Order is visited]already found[else]just need to find[end if] a way to identify yourself." [start Emo Dome 5 2]
ivy villa	"[ivy-no]." [start uneven u 0 3]
den ivy vined	"[ivy-no]."
trap mart rampart	"It's too sturdy to climb or blow up and too wide to go around. But maybe that will just help you focus on where you need to go." [start Ooze Zoo 2 3]
bad dab	"The bad dab's message seems important, but it's not good for much except examining." [start Worn Row 3 3]
redness ender	"You don't want to do anything crazy with the Redness Ender. You don't want to go near it. It's dangerous looking. You can picture it ambushing someone who doesn't expect it."
Buff-U-B	"The Buff-U-B would be useful if you were in the sort of adventure where you needed to worry about strength and constitution and dexterity and so forth, instead of one where you need to guess a few verbs and see what items to mash together."
sto lots	"You don't want to tinker with the STO LOTS more than you have to. It makes carrying stuff easier, and that's good enough."
decal placed	"The decal placed is just there to advertise the food. It's not critical to the story." [start deli tiled 6 3]
snooty toons	"The snooty toons are just there for ambience. They're not critical to the story."
go fog	"The go fog is very dense. It pushes you back even as you look at it. As if to say, go away, and also, get going with what you want and need to do." [start Lair Trial 0 4]
be web	"The be web is--well, it's itself, and maybe there's a message here but you'll figure it out once you're finished adventuring. It's not important enough now." [start Motto Bottom 1 4]
stewy wets	"The stewy wets are unchangeable." [Frush Surf 2 4]
senile felines	"You don't have to do anything standard with the senile felines. In fact, you should think of them as cats." [Moo Room 3 4]
late petal	"You don't need to do anything with the late petal. Perhaps you could help the felines, uh, cats reach it?"
cassettes sac	"The cassettes sac is too messy to do anything with. You need to find a way to clean it up." [start Dopy Pod 4 4]
pill lip	"The pill lip is just there to prevent the demo med from getting dirty on the ground."
birch crib	"The birch crib is private property." [start Drawl Ward 5 4]
girt rig	"The girt rig is too sturdy to move. But there's nothing behind it." [start Scrap Arcs 6 4]
leet steel	"You want to focus on the Knife Fink and not the leet steel." [start Dirge Grid x x]
nogo gon	"The No-Go Gon is there to prevent people from getting in. It would probably prevent you from getting out, too, if there weren't other things to deal with."
Par Wrap	"It's not the Verses Rev's clothes you need to worry about."
part strap	"You want to focus on the Verses Rev and not the part strap."
saner arenas	"It's good the saner arenas are there, but you don't need to mess with them."
XILE helix	"The XILE helix is there as a memorial. You don't want to alter it in any way."
Tru Hurt	"[rediv-instead of tru hurt]."
Waster Fretsaw	"[rediv-instead of waster fretsaw]."
[zzper]

to say fonen-of of (pb - a phonebook): say "[pb] is just there to list all the people you may be helping. Like most phone books (well, of places other than Cleveland,) it's not terribly exciting or useful for adventuring. You leave it"

to say ivy-no: say "You remember how the Flee Elf deemed you not good enough for RAW LEVEL WAR at the start. That means you're definitely not good enough for the (cough) Ivies.[paragraph break]That's you the character, not you the game-player"

to say rediv-instead of (th - a thing):
	say "While the [th] is worrisome, it's clearly not as dangerous as the Redivider"

chapter lateruses

definition: a thing ( called th) is preclued:
	repeat through table of lateruses:
		if there is a to-get entry and to-get entry is th and in-limbo entry is true, yes;
	no;

[It'd be programatically more elegant to divide the table below in two, but I also want some game-order to all this, so one table it is.]

table of lateruses [xxlat]
to-get	in-limbo	combo-rule	remind-msg
--	false	can-chef rule	"You wanted to mix two foods together, but [if Ian is not moot and chef-Ian-clue is true]Ian was in the way[else]you did so on the wrong place[end if]."
--	false	need-cup rule	"You didn't have anything to take [if sap-with-hands is true]the past sap with in Cold Loc[end if][if sap-with-hands is true and sod-with-hands is true] or [end if][if sod-with-hands is true]the dose sod in Apse Spa[end if]."
--	false	puff-known rule	"You need to find where to puff up."
--	false	pull-known rule	"You need to find where to pull up."
--	false	rah-gas-clue rule	"[if sage gas is moot]You used the sage gas on the tame mat. Maybe the sharp rahs, whiich you used with the gas earlier, can counter it[else]You need an intermediary for the sharp rahs and sage gas[end if]."
--	false	sap-uncut rule	"You need (and might already have) something to cut the past sap with [hn-in of Cold Loc]."
--	false	worn-clued rule	"There might be a good time to switch back to Worn Row."
Bond Nob	false	--	"You didn't have the right stuff to give the Bond Nob from the Puce Cup last time."
cassettes sac	false	--	"You [if player has cave vac]may now have[else]need[end if] something more powerful than the Dirt Rid to clean the cassettes sac."
el doodle	false	--	"The Code Doc couldn't quite read El Doodle as-is. You [if sharp rahs are off-stage]haven't found a way to clean it up yet[else]cleaned it in the edits tide, though, which should help[end if]."
gate tag	false	--	"You [if Ned is moot]got[else]need to find a way to get[end if] rid of Ned, so you can use Ye Key on the etage gate in peace."
gnu dung	false	--	"You [if player has poo coop]need[else]may have[end if] a sanitary container to pick up the gnu dung to push it south."
kayo yak	false	--	"You [if Frush Surf is unvisited]may find a good time to say YAK OKAY once you find a yak[else]figured YAK OKAY might be worth telling the yak at the right moment, but it hasn't found an outlet for its aggression[end if]."
liar grail	false	--	"You didn't have the right stuff to pour in the Liar Grail from the Puce Cup last time."
poo coop	false	--	"You tried pushing the gnu dung south before, but with the poo coop, it'd be much easier to fill the turf rut."
sage gas	false	--	"You [if maps-explained is false]need to[else]now can[end if] make sense of the spa maps to get by Go-By Bog in the Spa Apse."
Spa Maps	false	--	"You [if tent net is not moot]need to do something so the Code Doc is willing[else]can now ask the Code Doc[end if] to decipher the Spa Maps the spa maps deciphered."
test set	false	--	"You [if emitted is false]need to find[else]now know[end if] how to aim the yard ray."
UFO tofu	false	--	"You [if cross orc is in Toll Lot]need to get rid of the cross orc to[else]can now[end if] use the radar on the crag arc."
yahoo hay	false	--	"There's still some yahoo hay left in Moo Room. The coarser, more practical stuff."
yard ray	false	--	"You know to EMIT NOONTIME with the yard ray, but you don't have the ammunition."
[zzlat]

this is the rah-gas-clue rule:
	if tame mat is not moot and rah-gas-tried is true, the rule succeeds;
	the rule fails;

this is the worn-clued rule:
	if psi wisp is not moot and worn-tried is true, the rule succeeds;
	the rule fails.

this is the can-chef rule:
	if chef-Ian-clue is true and Ian is not moot, the rule succeeds;
	if chef-gen-clue is true, the rule succeeds;
	the rule fails;

this is the pull-known rule:
	if pulled-up is true, the rule fails;
	if pullup-clue is true, the rule succeeds;
	the rule fails;

this is the puff-known rule:
	if puffed-up is true, the rule fails;
	if puffup-clue is true, the rule succeeds;
	the rule fails;

this is the sap-uncut rule:
	if sap-takeable is true, the rule fails;
	if sap-with-hands is true, the rule succeeds;
	the rule fails;

this is the need-cup rule:
	if puce-ever is true, the rule fails;
	if sap-with-hands is true or sod-with-hands is true, the rule succeeds;
	the rule fails;

to say get-rej of (th - a thing): get-reject th;

to get-reject (th - a thing):
	repeat through table of lateruses:
		if there is a to-get entry and to-get entry is th:
			now in-limbo entry is true;
			continue the action;
	say "NONCRITICAL bug: I should've rejected getting [the th], but I didn't. This loophole will probably just cause oddities in [b]THINK[r], but I'd like to know how it happened."

to later-wipe (th - a thing):
	let changed-limbo be false;
	let need-change-limbo be false;
	repeat through table of lateruses:
		if there is a to-get entry and to-get entry is th:
			now need-change-limbo is true;
			if debug-state is true and in-limbo entry is true, say "DEBUG: Removed [to-get entry] from table of lateruses.";
			now in-limbo entry is false;
			now changed-limbo is true;
		if in-limbo entry is true and there is a combo-rule entry:
			consider the combo-rule entry;
			if the rule succeeded:
				now changed-limbo is true;
	if need-change-limbo is true and changed-limbo is false, say "NONCRITICAL bug: I tried to erase something from an internal 'do it later' table, but it was never in there. This doesn't affect the game, but I'd like to know about it."

volume rooms

part Dim Mid region

book Fun Enuf

to say if-not-LLP: if LLP-hunting, say ", other than poke around for last lousy points,"

Fun Enuf is a room in Dim Mid. "[if elite tile is in Fun Enuf]Elite tile has replaced the old tile lit. Probably all that's left to do[if-not-LLP] is to read it, or just go back south through the Tix Exit[else]Some tile lit is carved out here, describing what leads west and east[xit-ave][end if]. [if Diktat Kid is moot][Dirge Grid] is back north, not that you need to revisit[else if KAOS Oak is moot]Also, the North-Tron has carved a passage north where the [kaoscaps] was. It's too big to, uh, repaper[else if flee elf is in Fun Enuf]An oak blocks the way north. It's a wide oak[else]The [kaoscaps] blocks your way north[end if]."

to say xit-ave:
	say ". The [if player has x-ite tix]Tix Exit to the south is waiting for you to enter[else if tix exit is in Fun Enuf]Tix Exit to the south prevents passage back home through Evac Ave[else]Evac Ave is south, if you want to chicken out[end if]"

chapter KAOS Oak

instead of doing something with KAOS Oak when flee elf is in Fun Enuf: say "The Flee Elf directs your attention to the cap. 'First things first. The oak can wait for later. Much later.'" instead;

The KAOS Oak is peripheral scenery in Fun Enuf. "[if flee elf is in Fun Enuf]It's forbiddingly wide[else]It's incredibly sturdy and very wide. You'll need a wild, powerful contraption to deal with it[end if]."

printed name of KAOS Oak is "[kaoscaps]".

after examining the KAOS Oak:
	if KAOS Oak is not xed, say "One look and you find yourself mumbling 'Elp! A Maple!' before remembering the truth. You whisper 'Missed it by THAT much,' then take a second to get smart. Now that's (ch/k)aos! ";
	if grammarg is false, say "The [kaoscaps] changes [one of][or]again [stopping]as you look at it. ";
	say "[one of][paragraph break][i][bracket]NOTE: [r][b]GRAMMAR G[r][i] can turn off this random capitalization nonsense.[close bracket][r][or][stopping]";
	continue the action;

chapter grammarging

grammarg is a truth state that varies.

grammarging is an action out of world.

understand the command "grammar g" as something new.

understand "grammar g" as grammarging when player is in Fun Enuf.

ever-gram is a truth state that varies.

carry out grammarging:
	if KAOS Oak is moot, say "Ordering around something that's not here? That's pretty chaotic!" instead;
	say "'Grammar, G!' you moan at the [kaoscaps]. ";
	now grammarg is whether or not grammarg is false;
	if ever-gram is false:
		say "While strictly speaking, grammar only pertains to sentence structure, the (now) [kaoscaps] being, well, its chaotic self results in a good deal of rumbling. The [kaoscaps] switches back to [if grammarg is true]relative normalcy[else]its old weird shifting self[end if]. It doesn't seem any more or less vulnerable, but you're just glad to have even a small amount of control over things.";
		now ever-gram is true;
	else:
		say "Now the [kaoscaps] is [if grammarg is true]less[else]more[end if] chaotic.";
	the rule succeeds;

chapter Flee Elf

The Flee Elf is a neuter person in Fun Enuf. "A Flee Elf stands here, guarding Evac Ave to the south.". description is "Quite a pert rep. You'd expect to see the Flee Elf wearing a gateman nametag, but maybe that's in some other, even more insanely brilliant, wonderful and creative adventure."

understand "pert/rep" and "pert rep" as Flee Elf.
does the player mean doing something with rep popper: it is likely.

chapter Evac Ave

Evac Ave is scenery in Fun Enuf. "Evac Ave leads back to where you came, and your ordinary life--it goes on for a while, and you can't see the end."

check entering Evac Ave: try going south instead; [??]

elf-warn is a number that varies.

the Tix Exit is scenery. "It's nothing particularly fancy, though it says TIX IF FIX-IT. I'm going to go out on a limb here and say it'll accept [if player has X-ITE TIX]your X-ITE TIX[else]X-ITE TIX, if you can find them[end if]."

check entering tix exit: try going south instead;

check going south in Fun Enuf:
	if player has X-ITE TIX, try useoning X-ITE TIX with Tix Exit instead;
	if Tix Exit is in Fun Enuf, say "The Tix Exit blocks your way to where Evac Ave was. You try to look for a way to bust through, but a voice booms 'EL BARRABLE!'[paragraph break]I guess you're stuck questing, here." instead;
	if elf-warn < 3, increment elf-warn;
	say "[if elf-warn is 1]The Flee Elf encourages you to give taking the cap a shot--well, not quite TAKING it, but if you do take it, you'll be ready to go[else if elf-warn is 2]'Oy! Oy! Yo-yo!' The Flee Elf encourages you to find the right way to take--er, get--er, pick up the cap[else]The Flee Elf mentions there are really only 26 simple ways to pick up the cap, if you think about it, and why not just brute force? You're not busy with anything else[end if].";
	if elf-warn < 3, the rule succeeds;
	say "[line break]Do you still wish to go through Evac Ave and turn your back on adventure?";
	if the player yes-consents:
		say "'Tireder, it ...' you grumble.[paragraph break]The Flee Elf cries 'Fool! Aloof!' as you walk south past Evac Ave through the Elim-Mile. You don't have to walk all the way, though. You're given a vehicle: EL CYCLE. It's not a very good one, certainly no PEDAL-ADEP[']. It's long and exhausting, and once back in the 'real' world, you crash out and forget your brief time in Fun Enuf. You have persistent nightmares of some weird elf yelling 'Dud, Bub, Dud!' at you, but at least they replaced the really awful ones from high school. You even take up bicycling and lose (and keep off) those five extra pounds.[paragraph break]That's a step up, but you still go through life feeling you missed something, somewhere, somehow.";
		end the story saying "NOWT WON";

xite-warn is a truth state that varies.

check going in Fun Enuf:
	if noun is west or noun is east:
		if Flee Elf is in Fun Enuf, say "'Keen! Eek!' the Flee Elf stops you. 'You need to figure out the right way to take the Cap, for a place like Grebeberg or Yelpley.'" instead;
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

check going east in Fun Enuf: if Diktat Kid is moot and east-LLP is 0, say "There's nothing more to do in Yelpley, not even a last lousy point, but you explore anyway...";

check going west in Fun Enuf: if Diktat Kid is moot and west-LLP is 0, say "There's nothing more to do in Grebeberg, not even a last lousy point, but you explore anyway...";

to decide which number is roving-LLP: [Not location dependent: DIAL AID, STATS, REFER, POOP, PEEP]
	decide on west-LLP + east-LLP;

to decide which number is fixed-LLP:
	let temp be 0;
	if aid-LLP-yet is false, increment temp;
	if refer-yet is false, increment temp;
	if stats-yet is false, increment temp;
	if peeped-yet is false, increment temp;
	if poop-boob-yet is false, increment temp;
	decide on temp;

to decide which number is west-LLP:
	let temp be 0;
	if senile felines are in Moo Room, increment temp;
	if slam-mam is false, increment temp;
	if opossum is not moot, increment temp;
	if bees-seen is false, increment temp;
	decide on temp;

to decide which number is east-LLP:
	let temp be 0;
	if DWELT LEWD is off-stage, increment temp;
	if balm-LLP-yet is false, increment temp;
	decide on temp;

check going north in Fun Enuf:
	if Diktat Kid is moot, say "No need to revisit the scene of your victory. On to ... NU FUN!" instead;
	if flee elf is in Fun Enuf, say "The flee elf sees you looking north but says 'First things first! Get the cap the right way, here.'" instead;
	unless epicer recipe is xed or KAOS Oak is moot, say "You don't have a way through the [kaoscaps], [if epicer recipe is off-stage]or anything that would show you one[else]but maybe there's something you could read right now to get an idea[end if]." instead;
	if epicer recipe is not moot and epicer recipe is nox, say "You need to get there. But you have no clue what to build, or how[if number of carried ingredients > 2]--though some of your inventory looks useful for that[end if][if player has epicer recipe]. Hmm, maybe Xing the epicer recipe will help that[end if]." instead;
	if KAOS Oak is not moot, say "You can't go north with the [kaoscaps] in the way. You need to build the North-Tron to destroy the oak[if tron-got is 4]. In fact, you probably can just use any of the parts you have on each other to build it, now[else]. You currently have [tron-got] piece[plur of tron-got][end if]." instead;
	if player does not have yard ray, say "You don't have a weapon to take down the Diktat Kid." instead;
	if murdered rum is not moot, say "You have the yard ray, but it isn't, well, charged." instead;
	if emitted is false, say "You don't know how to work the yard ray[if yard ray is xed]. EMIT ********--hmm, what could those eight letters be?[else]. Maybe examine it for instructions.[end if]" instead;
	if grid-side-items < 2, say "As you go north, you hear three voices. 'Prep?! Erp!' you mutter.[paragraph break]Perhaps the yard ray would work okay at first, but ... you get the feeling you may need some other stuff to take out EVERYBODY." instead;
	say "You think you have enough. You hope you won't need a redi-aider. Here goes!"

to decide which number is grid-side-items:
	let temp be 2;
	if ME gem is off-stage, decrement temp;
	if taboo bat is off-stage, decrement temp;
	decide on temp;

chapter Pact Cap

The Pact Cap is a wearable thing in Fun Enuf. "The pact cap the Flee Elf wants you to take (but not quite) sits here.". description is "It doesn't feel that heavy on your head, and you can't see it, because there are no mirrors. It didn't look THAT stupid back when the Flee Elf had you pack it. So that's something. You think[cap-beep-stuff]."

procedural rule while wearing the pact cap: ignore the can't wear what's not held rule;

check wearing pact cap: say "[if player has pact cap]You already are[else]The flee elf explains you can't wear the pact cap until you take it right[end if]." instead;

to say insert-cap-lots: if player has sto lots, say ", as the sto-lots is good enough"

after examining pact cap:
	say "[if cap-ever-pace is false]You also remember the Flee Elf saying it could be something else and might need to be, down the line[else if cap-pace is false]You know the pact cap can go to pace mode, but you haven't figured where[else]The pact cap is currently in pace mode[end if].";
	continue the action;

to say cap-beep-stuff:
	if cap-pace is true, say ".[paragraph break]It's currently set as a pace cap";
	say ". You can toggle the action-perception the Flee Elf told you about with [b]LO VOL[r][if cap-vol is false] (current setting)[end if] or [b]LOVE VOL[r][if cap-vol is true] (current setting)[end if]"

cap-dum is a truth state that varies.

to say cap-dum-now: now cap-dum is true.

check examining Pact Cap:
	if player is in Red Roses Order and mirror rim is in Red Roses Order, say "[cap-dum-now]Oh dear. Through the mirror, the pact cap does look sort of stupid on you right now. But you have deeper issues than sartorial elegance. Plus it's been so serviceable, who cares about looks?" instead;
	if pact cap is in Fun Enuf, say "It's no stetson, and it's not as helpful as a ref-titfer, mate tam or math tam, but it is less messy than a tahini hat, and it looks serviceable enough. It appears to have [b]LO VOL[r] and [b]LOVE VOL[r] settings. Perhaps the Flee Elf will tell you what they are for, once you've successfully taken it." instead;
	if cap-dum is true, say "You definitely feel more self-conscious about your pact cap now you saw it in the mirror rim, but what can you do?" instead;

check taking off the pact cap: say "No, you...uh, made a pact. It's not that uncomfortable, anyway." instead;

cap-pace is a truth state that varies. cap-pace is false.

cap-ever-pace is a truth state that varies. cap-ever-pace is false.

check taking pact cap when flee elf is quicknear: say "The Flee Elf shakes its head. 'Too direct. Don't [b]TAKE[r] or [b]GET[r] it, precisely. You could get, e. g. take a kat, maybe. Try a different ... possess-op.'" instead;

section pack cap

packing is an action applying to nothing.

understand the command "pack cap" as something new.
understand the command "pack" as something new.

understand "pack cap" as packing.
understand "pack" as packing.

carry out packing:
	if the player has the pact cap, say "You already did." instead;
	say "'Rec [']er!' shouts the Flee Elf. 'Hat! Ah!'[paragraph break]The Flee Elf hands you a Set O Notes and explains you need to find a way to destroy the [kaoscaps] to the north. Also, the Flee Elf points out the [b]LOVE VOL[r] and [b]LO VOL[r] settings on the pact cap: [b]LO VOL[r] means the cap is quiet and won't make a weird noise if you look at things that need a weird action. [b]LOVE VOL[r] means you will.[paragraph break]The Flee Elf also shows you [if eye-charges > 0]the lit[else][end if]a pip on the cap, which tells whether you may be able to [b]EYE[r] items to determine approximately how far along they are in your quest--if you make enough good guesses. You ask what this means. The Flee Elf says 'like [if tried-elf is true]if[else]when[end if] you tried to made me something else[if eye-charges > 0]. You've done so much, you already got a charge[end if],' and points you to the Tix Exit, which reads 79, presumably the last thing you'll need to operate.[paragraph break]'It's best I...' and with that, the Flee Elf becomes a FLED elf, pointing at the tile lit (slightly altered). You notice a TIX EXIT to the south, but you don't have any tickets.";
	wfak;
	say "[line break]You put the cap on. It fits okay. It can stay all quest. Not very stylish, but it sure beats wearing a bib.";
	get-cap;
	score-inc; [Dim Mid/pack cap]
	verify-done rev-pack-cap rule;
	the rule succeeds;

to get-cap:
	moot flee elf;
	now Tix Exit is in Fun Enuf;
	now player has Set O Notes;
	now player wears the cap;

chapter pip

instead of doing something with pip when flee elf is not moot:
	say "The flee elf mentions you'll learn more about the pip once you take the pact cap the right way."

ever-pip is a truth state that varies.

the pip is part of the cap. the pip is peripheral. description is "[pip-charges]."

eye-charges is a number that varies.

to say pip-charges:
	say "The pip on the pact cap is currently ";
	if eye-charges is 0:
		say "dark[if ever-pip is true], but maybe more good guesses could recharge it[end if]";
	else:
		say "lit[if eye-charges > 1], and not just lit, but it separates into [eye-charges in words] parts if you stare too hard[end if]";

chapter pace cap

paceing is an action out of world.

understand the command "pace cap" as something new.
understand the command "pacy cap" as something new.
understand the command "pacy" as something new.
understand the command "pace" as something new.

understand "pace cap" and "pacy cap" and "pace" and "pacy" as paceing.

understand "pace cap" as pact cap when cap-ever-pace is true.

pace-prev is a truth state that varies.

carry out paceing:
	if kayo yak is moot, say "You had enough high-speed fun for one game. If you want to zip around the map, though, GT is always an option." instead;
	if pact cap is in Fun Enuf:
		now pace-prev is true;
		say "That'll work later, but you need something a little different to actually TAKE the pact cap." instead;
	if cap-pace is true, say "It's already a pace cap." instead;
	if being-chased is true and mrlp is Yelpley, say "[chase-pass][walk-law]. [if kayo yak is moot]The Psi Wisp isn't nearly as fast as the Kayo Yak, so maybe you just need to find where to go and what to do[else]Maybe that'll work against someone, or something, faster[end if]." instead;
	if mrlp is Grebeberg, now cap-pace is whether or not cap-pace is false;
	if cap-ever-pace is false:
		reg-inc Dim Mid; [pace cap]
		now cap-ever-pace is true;
		now pace-prev is false;
		say "[if mrlp is not Grebeberg][walk-law].[else]You suddenly feel [pace-of]![end if]";
	else:
		say "[if mrlp is not Grebeberg][walk-law]. Like Grebeberg to the west?[else]You suddenly feel [pace-of].[end if]";
	follow the notify score changes rule;
	the rule succeeds;

to say walk-law:
	say "As you flip the cap, a voice booms 'WALK: LAW.' You decide to be, um, civic. Perhaps you need to change it in a slower area"

to say pace-of:
	say "[if cap-pace is true]full of deep speed[else]slower[end if]"

check going to Fun Enuf:
	if cap-pace is true, say "From the east, a voice booms 'WALK: LAW.' You decide to be, um, civic. You adjust your pace cap back to a pact cap.";
	now cap-pace is false;

[helpdocs below]

chapter Darer Ad

the Darer Ad is a helpdoc. The player carries the Darer Ad. importancy of the Darer Ad is 1.

description of Darer Ad is "Gig, gig, gig![paragraph break]No LOL on? SEE, REFER-EES! Do! Nod!"

after examining the Darer Ad:
	if Darer Ad is not xed and Set O Notes is xed:
		say "Well! That was a bit silly. The Set-O-Notes might have been a bit cryptic, but it was more than just advertisements.";
	else if Set O Notes is not xed:
		say "Hmph. You need something with a bit more concrete advice. [if player has Set O Notes]Like the Set-O-Notes[else]Maybe you'll find it quickly enough[end if].";
	else:
		say "Wow! This is pretty useless compared to the Set O Notes you got later.";
	continue the action;

chapter Set O Notes

the Set O Notes is a helpdoc. description is "[b]OPPO[r] is printed at the top. There's vague advice about making a North-Tron to reach and defeat the Diktat Kid, but first you'll have to defeat [b]Ms. Ism[r], as well as the [b]Yuge Guy[r].[paragraph break]There's mention of a guh-thug in various places, and you'll have to do something special when you see one. [thug-report].[paragraph break]Also scribbled, in the center, is [b][Fun Enuf][r] with [b]TRI-GIRT[r] below that. There are other landmarks scribbled in, which [if number of visited rooms < 20]will help you identify new places and scenic barriers and such[else]have been helpful so far[end if].[paragraph break]The Set O Notes also points out you'll need to find items and use them together, but since you're on a quest, you already sort of knew that. Oh, there are some weird notes you can READ, too, but they seem a bit esoteric.". importancy of the Set O Notes is 2.

understand "tri-girt" and "tri girt" and "trigirt" as set o notes.
understand "oppo" as set o notes.

to say thug-report:
	let GG be number of moot guhthugs;
	let GG2 be number of seenees guhthugs;
	if GG is 4:
		say "You've gotten all of them, so yay";
		continue the action;
	else if GG is 0:
		if GG2 is 0:
			say "[if GG2 is 0]You haven't seen any yet, but apparently you'll know them when you see them";
		else:
			say "[list of seenees guhthugs] may fit this description. Maybe you can get past [if GG2 is 1]him[else]them[end if]";
	else:
		say "[if number of seenees guhthugs is 0]Maybe you will figure how to tackle [list of seenees guhthugs][else]You got rid of [list of moot guhthugs], but maybe someone else is around[end if]";

definition: a guhthug (called th) is seenees:
	if location of th is visited, yes;
	if th is moot, yes;
	no;

after examining Set O Notes:
	if Set O Notes is not xed, say "[if epicer recipe is xed]Well, maybe you should've read this before the epicer recipe, but at least you got around to reading both[else if Darer Ad is xed]A bit cryptic, but at least more useful than the Darer Ad. Maybe you'll get something even more detailed than the Set-O-Notes later[else]Not 100% clear, but you couldn't really expect line-by-line instructions[end if].";
	if player is in Worn Row, say "[if Set O Notes is not xed][paragraph break][end if][trigirt].";
	continue the action;

to say trigirt:
	if row-prog > 1:
		say "The tri-girt makes perfect sense now that you've changed Worn Row to Word Row and Work Row";
	else if row-prog is 0:
		say "Hmm. You wonder what Tri-Girt could mean, here. Maybe Worn Row is not quite as static as it seems";
	else:
		say "You've made [location of player] Row, but the 'tri' makes you think there might be something else"

after looking in Fun Enuf when player was in Dirge Grid:
	say "You're filled with a desire for new adventure, now you beat the Diktat Kid.";
	continue the action;

chapter tile lit

the tile lit is scenery in Fun Enuf. "It's a rough compass, with GREBEBERG (LA RURAL) west by it, YELPLEY (TOWN, WOT) east, Evac Ave. south and Dirge Grid north. [if flee elf is in dirge grid]Evac Ave. and Dirge Grid are faded a bit now, though[else if kaos oak is moot]Dirge Grid is no longer faded[else]Dirge Grid is faded a bit, though[end if].[paragraph break]It also mentions you can toggle [b]SHUTTUHS[r] to block off areas you're done with, if you want guidance without spoilers[shut-known]." [ic]

shuttuhs-known is a truth state that varies.

to say shut-known: now shuttuhs-known is true.

check taking tile lit: say "It's sort of embedded into the ground. It looks nice there, anyway, and it's useful for information." instead;

chapter elite tile

the elite tile is scenery. "Done? Nod![line break]Nif-T-Fin![line break]Trape! Depart![paragraph break]Wow! Are you off to somewhere even cooler?".

check taking elite tile: say "It's a memento, not a souvenir." instead;

after going to Fun Enuf when Diktat Kid is moot:
	say "You hear chants of 'Hew, Eh' then a thud to the east! Perhaps Yawn Way is not so boring any more. Then you look down and notice the tile lit has changed slightly. It's more shiny now. Elite tile, if you will. And it says something different.";
	moot tile lit;
	move elite tile to Fun Enuf;
	continue the action;

book Dirge Grid

Dirge Grid is a room in Dim Mid. "The only way back is south[if Diktat Kid is in Dirge Grid], but you can't really run away from the Diktat Kid. A Tru Hurt is pointed at you, and that redivider looks extra imposing, but if you deal with the Kid, that won't matter[else], and you might as well go that way, now you've vanquished the Diktat Kid. No need for further spot ops[paragraph break]Saner Arenas surround the XILE helix that stands where the redivider used to be[end if]."

check going to Dirge Grid: if test set is not moot, say "[if player does not have yard ray]You don't have an adequate weapon[else]You need to get some practice with the Yard Ray before going north[end if]." instead;

printed name of Dirge Grid is "[if Diktat Kid is moot]Top Spot[else]Dirge Grid[end if]"

understand "top/spot" and "top spot" as Dirge Grid when Diktat Kid is moot.

for writing a paragraph about a person when player is in Dirge Grid:
	now all people in Dirge Grid are mentioned;
	if Dirge Grid is unvisited:
		say "You are greeted by someone who must be the Diktat Kid, who reminds you of a bully from high school. 'You did some weird things to get this far--but I've done some PRACTICAL things to make sure that's it! Knife Fink! Verses Rev!'[paragraph break]'We hew! Due: FEUD!'[paragraph break]Then the Diktat Kid gets all fancy. 'ENGAGE LE JEU QUE JE LE GAGNE!'[wfak]";
		say "They both appear. And they are armed! The Knife Fink, with leet steel, and the Verses Rev, with a part strap.";
		if grid-side-items is 0:
			say "Looking at your items, there's no way you have enough to take care of the Diktat Kid and the two henchmen. You back off.";
			move player to Fun Enuf, without printing a room description;
			continue the action;
		if grid-side-items is 1:
			say "You feel like you aren't quite prepared enough to tackle the Diktat Kid's henchmen. You back off.";
			move player to Fun Enuf, without printing a room description;
			continue the action;
		say "[one of]You sense a slight hesitation from your adversaries and unwisely boom 'Step, puppets!'[paragraph break]Uh oh. You'd better be able to back up your words[or]Thankfully, the Diktat Kid hasn't attacked you directly, so you have time to ... do something. You're pretty sure you have the firepower to win out[stopping], here.";
	else:
		if grid-side-items is 0:
			say "You're still overwhelmed by all three opponents! You run back to [Fun Enuf].";
			move player to Fun Enuf, without printing a room description;
			continue the action;
		if grid-side-items is 1:
			say "You feel you could do some damage, but not quite near enough. You run back to [Fun Enuf].";
			move player to Fun Enuf, without printing a room description;
			continue the action;
		say "[if Knife Fink is moot and Verses Rev is moot]The Diktat Kid continues to rage at you. Two henchmen gone, but it's not over![else if Knife Fink is moot]The Diktat Kid continues to yell at the Verses Rev to do something.[else if Verses Rev is moot]The Diktat Kid continues to yell at the Knife Fink to do something.[else]The Diktat Kid yells and wonders why the Verses Rev and Knife Fink haven't disposed of you, yet.[end if]";

check going in Dirge Grid:
	if Diktat Kid is in Dirge Grid, say "While the No-Go Gon is probably more for keeping people out, it would probably keep you back in even with [if henchmen-left is 0]the waster fretsaw and Tru-Hurt[else]enemies who might catch you[end if]. You've got no choice but to finish things off, here." instead;
	if noun is not south and noun is not outside, say "The saner arenas are nice, but they're not interesting enough to be stop-spots yet. With the Diktat Kid gone, it's probably best you get back home." instead;

check going south in Dirge Grid: if Diktat Kid is in Dirge Grid, say "'Mom! SOS! LOL! SOS! Mom!' the Diktat Kid mocks you.[paragraph break]You can't chicken out. You must be close!" instead;

advance-kid is a truth state that varies.

kid-moves is a number that varies.

every turn when player is in Dirge Grid:
	if advance-kid is true, increment kid-moves;
	if kid-moves is 7:
		now kid-moves is 0;
		say "'Deport! Roped!' a mechanical voice calls. You realize, even if you haven't [if henchmen-left is 2]struck a blow yet[else]completed things[end if] here, you haven't been wiped out. You need to keep thinking what to do.";

chapter no go gon

the nogo gon is peripheral scenery in Dirge Grid. "It is a huge regular glowing polygon that stretches out a way, though it's broken where the KAOS Oak was. With Diktat Kid to defeat, you don't have time to see how big it is."

printed name of nogo gon is "No-Go Gon". understand "no/go gon" and "no go" and "no" and "go" as nogo gon when player is in Dirge Grid and nogo gon is in Dirge Grid.

to say rand-pal:
	let Q be a random number between 10 and 39;
	let Q2 be (Q * 10) + (Q / 10);
	let Q3 be Q * 10 + Q / 10;
	say "[Q2]";
	if debug-state is true, say " ([Q]) ([Q3])"

chapter saner arenas

saner arenas are peripheral plural-named scenery. "They're a sign that Grebeberg and Yelpley will return to where they were."

chapter XILE helix

the XILE helix is peripheral scenery. "The XILE helix is a reminder of the evil the Diktat Kid wrought on Grebeberg and Yelpley. It even features the name of a sidekick you didn't need to dispatch: [next-rand-txt of table of rejected kid sidekicks]."

check entering XILE helix: say "You deserve a more heroic exit than that." instead;

chapter Diktat Kid

The Diktat Kid is a person in Dirge Grid. description is "The Diktat Kid [if henchmen-left is 0]is yelling at you, now[else if henchmen-left is 1]alternates between yelling at the departed [hl of false] and the remaining [hl of true][else]is barking out orders needlessly to the Knife Fink and Verses Rev[end if]. Even though it doesn't do any good, you feel spine nips worrying the Kid has a gun snug."

to say hl of (ts - a truth state):
	say "[if ts is whether or not Verses Rev is moot]Knife Fink[else]Verses Rev[end if]"

definition: a person (called p) is henchy:
	if p is Verses Rev or p is Knife Fink, yes;
	no;

to decide which number is henchmen-left:
	let count be 0;
	if Knife Fink is in Dirge Grid, increment count;
	if Verses Rev is in Dirge Grid, increment count;
	decide on count;

every turn when Diktat Kid is quicknear:
	say "The Diktat Kid whines '[next-rand-txt of table of diktat taunts]'[paragraph break]";

chapter Knife Fink

the Knife Fink is a neuter person in Dirge Grid. "A Knife Fink wields some leet steel here.". description is "A rough customer, to be sure. But the Fink's dazed look suggests greed more than hate, obligation more than violence."

the Knife Fink carries the leet steel.

the leet steel is peripheral. description is "The Knife Fink is waving it around with intent. It looks more like fancy cutlery than an effective weapon, though. But you don't want the Knife Fink to get close enough for stab-ats."

chapter Verses Rev

the Verses Rev is a neuter person in Dirge Grid. "A Verses Rev wields a part strap here.". description of Verses Rev is "Too much gravitas to be a Rot-Cert Rector, despite the unshowy par wrap and lack of Scold Locs. The hate and brimstone the Rev (obviously no Rev Love Evolver) intones at you is a different matter."

after examining Verses Rev for the first time:
	say "The Verses Rev, being against just about everything, is also a Versus Rev. In general, but more importantly right now, against YOU.";
	continue the action;

understand "versus" and "versus rev" as verses rev.

the Verses Rev wears the Par Wrap.

the Par Wrap is peripheral. description is "The Par Wrap is nothing special, but the Verses Rev is the sort of person who's stridently versus Certain Immoral Things, so they'd want to make sure any game they were in mentioned they were clothed.[paragraph break]I decided to respect that, but still, I'm hoping you lay a most righteous, if largely metaphorical, smackdown on the the Rev.[paragraph break]Also, VERY REV is stitched into it, because of course.".

the Verses Rev carries the part strap.

the part strap is peripheral. description is "It's more for overzealous religious flagellation to be daunting. A more practical weapon just might defeat it."

chapter x-ite tix

the x-ite tix are a plural-named thing. description is "A duo. Loud. Just the right number. If you had XI, that'd be too many to keep track of.[paragraph break]They promise passage to an EVEN MORE EXCITING AND EXPANSIVE ADVENTURE THAN THE ONE YOU'VE JUST FINISHED.[paragraph break]The words 'WOW' and 'YAY' are dotted all around, none overlapping the main 'TIX: I FIX IT' message."

understand "xite" and "x ite" and "xite tix" and "x ite tix" as x-ite tix.

chapter redivider

the redivider is scenery in Dirge Grid. "[if Diktat Kid is moot]It's broken down now. You don't understand how it works, but perhaps it could be repurposed as something more useful. Like a rotavator. The folks in Grebeberg could use a few extra agricultural tools[else]Just looking at the redivider makes you very mad at friends who said something mean two years ago, as if people who lived life better would've stayed madder and found even better friends. It's hard to pull yourself away, but you do[end if]."

after examining the redivider:
	say "It sure is scary! You're just lucky the game's not so topical it has a Nuge Gun mounted on it.";
	continue the action;

chapter tru hurt

the Tru Hurt is semiperipheral scenery in Dirge Grid. "The Tru Hurt is here, and it's aimed at you!"

chapter waster fretsaw

the waster fretsaw is semiperipheral scenery in Dirge Grid. "The less thought of, the better. Without the Diktat Kid to operate it, it'll be less harmful."

chapter emiting

emitted is a truth state that varies.

emiting is an action applying to one topic.

understand the command "emit" as something new.

understand "emit [text]" as emiting when player has yard ray.

noontime-found is a truth state that varies.

to clue-noon: say ", though once it is, you know to EMIT NOONTIME"

emit-guesses is a number that varies.

carry out emiting:
	if player does not have yard ray, say "You have nothing that emits, yet." instead;
	if yard ray is nox:
		now yard ray is xed;
		say "Looking at the yard ray for the first time, you notice it wants you to EMIT something...";
	if the topic understood matches "noontime" or the topic understood matches "noon time":
		get-reject yard ray;
		now noontime-found is true; [awkward to write this code in twice but the alternative is worse]
	else if the player's command matches the regular expression "time":
		repeat through table of good emit guesses:
			if the topic understood matches guess-topic entry:
				if guessed-yet entry is false:
					now guessed-yet entry is true;
					increment emit-guesses;
					say "[guess-result entry][line break]";
					say "[line break]Hmm, you've had some good tries. The right thing to emit will come to light soon enough.";
					the rule succeeds;
				else:
					say "You already tried that. There must be something else relatively simple that works." instead;
		let XX be indexed text;
		let XX be the player's command;
		replace the text " " in XX with "";
		let guesschar be number of characters in XX - 8;
		say "Not that sort of time. But it must be SOME time. A positive time[if yard ray is xed and guesschar is not 4]. A time with four letters in, not [guesschar in words][else if yard ray is not xed]. The yard ray may have a clue[end if]." instead;
	if murdered rum is not moot, say "The Yard Ray isn't charged enough to emit anything[clue-noon]." instead;
	if player is in location of Yuge Guy, say "No...the Yuge Guy needs to be defeated by other means." instead;
	if Diktat Kid is moot, say "You already got rid of the Diktat Kid." instead;
	if emitted is true, say "You already figured how to use the Yard Ray. Now you need to figure whom, or what, to use it on." instead;
	if the topic understood matches "noontime" or the topic understood matches "noon time":
		say "FOOM! Oof! The yard ray emits so much light, you immediately have to switch it off. Well, that was a good start. Now you want to make sure you can aim it at something that can be destroyed.";
		now emitted is true;
		later-wipe yard ray;
		reg-inc Dim Mid; [EMIT NOONTIME]
		consider the cap-beep rules for the yard ray;
		verify-done rev-emit-noontime rule;
		the rule succeeds;
	say "No, that's not quite it[clue-noon].";
	the rule succeeds;

to say clue-noon: if noontime-found is true, say ", but NOONTIME, which you guessed before, seems right for what to emit"

to say also-4: say ". Also, given what's on the Yard Ray, it's four letters"

table of good emit guesses
guess-topic (a topic)	guessed-yet	guess-result
"dudtime" or "dud time"	false	"A heel turn this late in the game? Nah[also-4]."
"onotime" or "ono time" or "sos time" or "sostime"	false	"Something positive and brighter[also-4]."
"yaytime" or "yay time"	false	"That's positive and bright, but it's better saved for after you've conquered the Dirge Grid north of [hn of Fun Enuf][also-4]."
"dadtime" or "dad time"	false	"I'm sorry you haven't uncovered enough groan-inducing jokes in the course of this game. I tried my best, honest I did[also-4]."
"pooptime" or "poop time"	false	"A hollow voice booms 'Loo? Fool!'[paragraph break]You want to get your opponent on the run, not get them the runs."
"time"	true	"You can emit time without a fancy yard ray. It must be some sort of time. Something positive and cheery, you'd guess." [guessed-yet is true here because it is semi-trivial to figure out]

part Grebeberg region

book Seer Trees

Seer Trees is west of Fun Enuf. It is in Grebeberg. "[trees-stix], but the other three directions lead to further rustic adventure[if stark rats are in Seer Trees], or will once you clear those stark rats[end if][seer-see].".

after looking in Seer Trees when player has trap art:
	say "You look at the trap art, then the rats, and back and forth again. You don't have the skill to design anything from the trap art on your own, but something somewhere must work.";
	continue the action;

to say trees-stix:
	if x-it stix are in Seer Trees:
		say "X-It Stix block the way east";
	else:
		say "East leads back to [Fun Enuf][if Yawn Way is visited] and Yelpley[end if]";

understand "tree" and "seer tree" as seer trees.

to say seer-see:
	if Cold Loc is visited, say ". Cold Loc is north";
	if Ooze Zoo is visited, say ". Ooze Zoo is south";
	if Dumb Mud is visited, say ". Dumb Mud is west";

check going in Seer Trees:
	if noun is not east and stark rats are in Seer Trees, say "The stark rats block you from going anywhere. At least they are not banging stop pots." instead;

chapter stark rats

the stark rats are a plural-named thing in Seer Trees. "Stark rats scuttle about, impeding passage every way except back east.". description is "They are too fast and numerous to run by without getting bitten. You'll need to USE something powerful to get rid of them."

check taking stark rats: say "Perhaps you could USE something that would catch them all, instead." instead;

check dropping party trap in Seer Trees: try useoning party trap with stark rats instead;
check dropping trap art in Seer Trees: say "The rats wouldn't be smart enough to be scared of a DIAGRAM of a trap. Maybe an actual trap could do more than scare them, though." instead;

Include (-
	has transparent animate
-) when defining stark rats.

understand "rat" and "stark rat" as stark rats.

chapter gift fig

the gift fig is a solid ingredient. description is "It looks edible, but it's too small to eat on its own."

chapter Oh Who

Oh Who is a peripheral phonebook. booktable of Oh Who is table of random palindrome firstlast names. description is "You read several [one of][or]more [stopping]names and numbers of Grebeberg residents from Oh Who, even though you have no phone to call them with:[line break][name-num of 5 and Oh Who][variable letter spacing][run paragraph on]". "Oh Who rests here, safe from the stark rats you got rid of, but not particularly useful."

book Cold Loc

Cold Loc is north of Seer Trees. It is in Grebeberg. "It's kind of dewed, here, but at least it's not the Snow-Ons. A rift fir blocks a steep drop west, but it's clear to the north, south and east. [if sap-takeable is true]The past sap you cut from it is lumped on the ground[else]Some past sap clings to it[end if]."

check going west in Cold Loc: say "[chase-pass]The rift fir blocks the way to much more dangerous places, maybe Red Locs Colder or the Splat Alps. Perhaps ski oiks or even site yetis await[if being-chased is true]. All told, it'd be safer for the more sure-footed yak than you[end if]." instead;

chapter rift fir

A rift fir is scenery in Cold Loc. "It sure is a rife fir. You're not getting past it, but you don't need to. It might even be protecting you from ski oiks in the treacherous Splat Alps or Red Locs Colder."

chapter past sap

the past sap is semiperipheral scenery in Cold Loc. "[if liar grail is moot]There's still a chunk remaining, but you probably don't need any more now that you got rid of the liar grail[else if sap-ever-in-cup is true]While you took some of it, there's still enough remaining if you need more[else if sap-takeable is true]A good chunk of it is lumped on the ground[else]It's stuck to the rift fir, but with the right tool, maybe you could pry it off[end if]."

sap-ever-in-cup is a truth state that varies.

sap-with-hands is a truth state that varies.

instead of taking the past sap:
	if liar grail is moot, say "You probably don't need any more past sap, now that you used it to dispose of the Liar Grail." instead;
	if player has puce cup:
		say "The puce cup is handier than your hands to take the sap, so you use it instead[if sap-takeable is false]. Unfortunately...[else].[end if]";
		try useoning past sap with puce cup instead;
	if sap-takeable is false:
		now sap-with-hands is true;
		say "The sap would get sticky on your fingers. You need some way to carry it." instead;
	say "You need to cut the sticky sap from the rift fir. Maybe you have something that will work." instead;

instead of sawing past sap, try useoning past sap with wash saw instead;

instead of useoning past sap with an ingredient, say "The past sap isn't edible by itself or with food."

to say how-take-sap:
	say "might [if puce-ever is true]want to USE the cup to hold it[else if player has puce cup]want to USE it on the puce cup[else]need something to carry it in. It's sticky[end if]"

sap-takeable is a truth state that varies.

chapter King Nik

King Nik is a male person in Cold Loc. "[one of]A man sits here, shaking his head. On seeing you, he gets up. 'I'm King Nik, and I came to Grebeberg for advice. Got any?'[or]King Nik paces around hopelessly, looking lost.[stopping]". description is "He doesn't look very regal. Maybe he needs something that can help him gain, or learn, gravitas.".

chapter Spur Ups

the Spur Ups are a plural-named beepy thing. description is "King Nik told you it was much more important they were UP than spurs. [if puffed-up is true]One burned out a bit once you puffed up to get to the Emo Dome, but the other may be useful. [end if]You can READ them if you want. You remember how King Nik told you the SPUR UPS could help you feel, or be, UP twice[if puffed-up is true], and you already managed to PUFF UP in the Emo Dome[end if]. Nothing too complex. The question is, how[if puffed-up is true] else[end if]?"

after useoning with:
	if noun is spur ups or second noun is spur ups, beep-if-vol spur ups;
	continue the action;

understand "up" and "spur up" and "spurs" as spur ups when player has spur ups.

after examining Spur Ups when player is in Yawn Way and puffed-up is false:
	say "The Spur Ups make the way east feel less intimidating. Maybe you could use them to do something UP enough to be able to hack the Emo Dome.";
	continue the action;

instead of wearing spur ups, say "They would be too pointy for comfort. There are no boots-too-b attached to and no West-Sew tailors to make them.";

book Flu Gulf

Flu Gulf is north of Cold Loc. It is in Grebeberg. "North and east, it's, oh, too H2O. The passage is clear back south, but [if scorn rocs are in Flu Gulf]scorn rocs['] gaze blocks you going west[else]west past the scorn rocs seems a bit treacherous[end if]. No way you're getting through the mush sum to the north, and the Ebola Lobe to the east is likely to get through you."

chapter mush sum

the mush sum is peripheral scenery in Flu Gulf. "It looks deceptive and swampy. Perhaps it is so deceptive, it is actually gosh-sog. Or not."

chapter Ebola Lobe

the Ebola Lobe is peripheral scenery in Flu Gulf. "It doesn't look that awful, but the Set-O-Notes pretty clearly declaims it as Somewhere Not To Go."

chapter gulf lug

the Gulf Lug is a person in Flu Gulf. "The Gulf Lug stands here, bent partially over with abdominal pain.". description is "The Gulf Lug looks slightly ill. Probably with Ulf's Flu. Maybe you could help fix that!".

chapter cash sac

the cash sac is a thing. description is "It's labeled Mt. ATM and full of currency--currency which you don't know whether you can spend anywhere. Perhaps it was once Cassini's, but there's no way to tell."

after examining cash sac for the first time: say "[whose-sac].";

chapter scorn rocs

The scorn rocs are plural-named scenery in Flu Gulf. "While they're motionless, their stare drives you back--and you know something simple like closing your eyes won't fool them. They're fiercely proud and shiny, white and clean."

check useoning a book with scorn rocs: say "They've got the staring bit down, but they won't process anything." instead; [?? move to gen-book-reject]

instead of talktoing scorn rocs: say "They remain silent, but 'Gog a['] Magog' goes through your head. Fear prevents you going west. You suspect that shortening 'and' to 'a' to fit in is the least of their evil indiscretions."

Include (-
	has transparent animate
-) when defining scorn rocs.

understand "gog magog" and "gog a/and magog" and "gog/magog" as scorn rocs.

understand "roc" and "scorn roc" as scorn rocs.

check going in Flu Gulf:
	if noun is east, say "You'd need some Nix-O-Toxin to survive the Ebola Lobe. There is none here in the game." instead;
	if noun is north, say "The mush sum would pull you down." instead;
	if noun is west:
		if scorn rocs are in Flu Gulf, say "The scorn rocs remain motionless, the stone NOTS you feel from their stern gaze freeze you as you even think of trying to go west. They're not mere starer-ats.[paragraph break]Maybe if they were less imperious, less shiny, less aesthetically perfect, they'd be less intimidating[if being-chased is true].[paragraph break]As you think of a way past them, you lose track of the Kayo Yak[end if]." instead;
		if being-chased is true:
			if Yuge Guy is moot, say "[chase-pass]With the Yuge Guy defeated, you don't feel a need to go back to [Sneer Greens]." instead;
			if Sneer Greens is unvisited, say "The invective from the west gives you pause. Between that and being chased by the Kayo Yak, you are dazed just long enough..." instead;
			say "The Kayo Yak, with a burst of energy, runs in front of you before you can make it [if Sneer Greens are unvisited]west[else]to [Sneer Greens][end if]. Weird! It's like the Yak was scared enough of [if Sneer Greens is visited]the Yuge Guy and the ME Totem[else]whatever's west[end if] to try and protect you. A well-meaning gesture, but perhaps the yak would rather tackle something less fearsome and horrid." instead;

book Sneer Greens

Sneer Greens is west of Flu Gulf. It is in Grebeberg. "[if Yuge Guy is in Sneer Greens]Despite the impressive view, the place has gone to pot[else]Nicer and quieter with the Yuge Guy gone. Still, it's... not completely silent, but safe enough[end if].[paragraph break]You can only go back east. Smirk rims block every way back except east[if me totem is in Sneer Greens], and a ME Totem towers above you[end if]."

check going nowhere in Sneer Greens: say "The smirk rims push you back, but you really don't need to do anything [if Yuge Guy is moot]more here[else]with them, just the Yuge Guy[end if]." instead;

Sneer Greens is above Flu Gulf.

printed name of Sneer Greens is "[if Yuge Guy is in Sneer Greens]Sneer Greens[else]Et Tu Butte[end if]"

understand "et tu butte" and "et/tu/butte" and "et tu" and "et/tu butte" as Sneer Greens when Yuge Guy is moot.

after looking in Sneer Greens for the first time:
	say "'Believe Me. Adore Me. Believe!' O gee, ego, you think to yourself.";
	continue the action;

every turn when Yuge Guy is quicknear:
	say "The Yuge Guy booms '[next-rand-txt of table of yuge battle cries]'[paragraph break]";

check going east in Sneer Greens: if Yuge Guy is in Sneer Greens, say "'[next-rand-txt of table of yuge baits]' the Yuge Guy booms, as you run away[one of]. He probably has a few of those trolls[or][stopping]."

chapter Yuge Guy

Yuge Guy is a proper-named person in Sneer Greens. description is "Bilgy. Glib. He cries 'GAWK, WAG!' as you look at him.". "[one of]'BELIEVE ME! LOVE ME! BELIEVE!' yells someone. Wow--he's a lot bigger than you.[paragraph break]'I am Yuge Guy!' he drones on. After your initial shock, you see that while he is bigger than you, it's more horizontally than vertically, and he looks like the ME Totem, too.[or]The Yuge Guy continues carrying on about how the world stinks, except for him.[stopping]"

chapter ME Totem

the ME Totem is scenery in Sneer Greens. description is "It's a more favorable version of the Yuge Guy: taller, thinner, better looking. It's overdone, but you can see how people would be fooled by it. It looks like it may be broadcasting to ... well, lots of places. It is hard to look away, as the ME Totem fills your head with circular arguments and 'would I lie about this' babble. But you know you need to."

chapter smirk rims

the smirk rims are peripheral scenery in Sneer Greens. description is "They look at you as if to say, '[if Diktat Kid is moot]Why haven't you gotten on with your life, now you beat the Diktat Kid[else][cant-beat][end if]?'[paragraph break]You're a bit worried there may be smack-cams behind them, too, waiting for you to do something stupid."

to say cant-beat: say "What makes you think you can beat the [if Yuge Guy is in Sneer Greens]Yuge Guy[else]Diktat Kid[end if]"

chapter murdered rum

some murdered rum is a drinkable thing. description is "It looks viscous, like oil. Perhaps it was only murk rum long ago, before it sat in the belly of the ME Totem for so long. It's ... well, you wouldn't want to get in contact with it. A lot more powerful than regular alcohol."

book Dumb Mud

Dumb Mud is west of Seer Trees. It is in Grebeberg. "Mud! Um...[paragraph break]A turf rut to the south is [if poo coop is moot]filled in enough[else]too deep[end if] to cross. The way west is [if gnu dung is moot]free[else]blocked by gnu dung[end if]. [if lie veil is in Dumb Mud]A lie veil (nowhere near small enough to wear) blocks your way[else]With the lie veil removed, you can go[end if] north. [mud-go] back east.".

understand "dum mud" and "dum" as dumb mud.

to say mud-go:
	let DS be 0;
	if gnu dung is moot, increment DS;
	if lie veil is moot, increment DS;
	if turf rut is moot, increment DS;
	say "[if DS is 0]So the only current exit is[else if DS is 1 or DS is 2]You can also go[else]And there's always[end if]"

check wearing the lie veil:
	ignore the can't wear what's not held rule;
	say "No way. You're on the side of good, here." instead;

check going west in Dumb Mud:
	if Diktat Kid is moot, say "[one of]You are informed that the Known Wonk and Code Doc have teamed up to design a system of Smarty-Trams to revitalize the economies of Grebeberg and Yelpley. Everything's still in the planning state, but construction has already started to the west[or]The Smarty-Trams construction and planning to the west is not to be disturbed. You've helped enough[stopping]." instead;
	if gnu dung is in Dumb Mud, say "Not through the gnu dung you aren't[if being-chased is true]...perhaps there's a way behind it, and you may need it, to get away from the kayo yak[end if]." instead;

check going south in Dumb Mud:
	if Diktat Kid is moot, say "With the Diktat Kid gone, plans are underway to take the essence of Mont Nom and the Ark of Okra and put them into a big chain of bland fast-food restaurants called Monopo-Nom. Well, you couldn't fix everything." instead;
	if poo coop is not moot, say "The turf rut is too deep. You need a way to fill it in." instead;
	if being-chased is true:
		say "The slog uphill is too much for you, but the kayo yak traverses it easily and bumps you before you can make it up all the way.";
		reset-chase instead;
	if Mont Nom is unvisited, say "With the turf rut filled in, the way across remains stable, and it even smells okay! Bonus! You climb up to...";

check going north in Dumb Mud:
	if lie veil is in Dumb Mud:
		if player has exam axe, say "The lie veil doesn't seem as intimidating as before. Maybe it's you, or something you have." instead;
		say "[one of]As you're about to touch the lie veil, you shake your head. No. You don't really want or need to explore north. Surely there's some better place to be? Perhaps you're not 100% prepared for the lie veil's 'thought-provoking' paradoxes, and it's doing you a favor pushing you back? Plus what if it hides a hidden booby trap? You try to walk further north, but somehow you wind up walking back south.[paragraph break]Once you're away from the Lie Veil, you forget its weird arguments. There's got to be a way, or weapon, to cut brutally through its sophistry[or]The Lie Veil still rejects and confuses you. You need something decisive and brutal to cut through it[stopping][if score < 30 and player does not have exam axe]. But finding the right weapon or implement may have to wait a bit[end if]." instead;
	if being-chased is true, say "[chase-pass]It's just too weird and chaotic ahead to the north. Maybe without the yak chasing you..." instead;

chapter gnu dung

the gnu dung is scenery in Dumb Mud. description is "You're not an expert in this sort of biology, but given what you've seen so far, it's probably from a gnu. It's too icky and wide to cross, but it's not too deep."

instead of doing something with gnu dung:
	if current action is pushing, say "Hm. Moving the gnu dung could work, with the right implement." instead;
	if current action is pushing to:
		if second noun is south:
			get-reject gnu dung;
			get-reject poo coop;
		say "[if second noun is south]Filling the rut seems like a very good idea, but not using your bare hands[else]Moving the gnu dung there wouldn't help, but maybe some place else[end if]." instead;
	if action is pro-and-use, continue the action;
	say "Eewee! (You probably want to USE something to pick up the gnu dung.)"

chapter turf rut

The turf rut is scenery in Dumb Mud. "[if poo coop is moot]Since you filled it in, you can walk across it [turf-s]to the south. It even smells okay[else]It's deep enough to prevent you going south. Maybe you could fill it in with something. Anything[end if]."

to say turf-s: say "[if Mont Nom is visited]again [end if]"

check taking turf rut: say "You'd need a nab-rut turban to do that. There's no nab-rut turban in this game[if poo coop is moot]. Besides, you already [rut-made-go] across[end if]." instead;

to say rut-made-go:
	say "[if Mont Nom is visited]made it[else]can go[end if]"

understand "turd rut" as turf rut when poo coop is moot.

chapter lie veil

The lie veil is scenery in Dumb Mud. "It covers the way north. It looks flimsy, yet at the same time, you are scared it might have some secret trap that would zap you to unconsciousness and, worse, make you feel silly for not noticing it in the first place."

instead of wearing veil: say "I don't want to know what would happen if you could, and probably, neither would you."

Include (-
	has transparent animate
-) when defining lie veil.

instead of talktoing lie veil, say "It's already messing with your mind. Probably a good thing it can't talk.";

book Le Babel

Le Babel is north of Dumb Mud. It is in Grebeberg. "Here space and time seem horribly warped. You can listen for apocryphal mumblings ... if you dare. A voodoo v blocks passage--and sight--everywhere except back south."

check going nowhere in Le Babel: say "You would surely get lost going anywhere other than back south, your last words perhaps being 'Haboob! Ah!'" instead;

chapter voodoo v

the voodoo v is peripheral scenery in Le Babel. "Maybe you could walk across it without getting hurt, but you doubt it. It's there, and it's immovable. Things probably will get weirder beyond it."

chapter opossum

the opossum is a llpish semiperipheral thing in Le Babel. "An opossum crouches here, looking scared. Maybe you can help it be less frozen by fear.". description is "Cute little thing, lovely fur, but it could use a friendly gesture."

instead of taking opossum: say "The opossum bounds away. Perhaps you can be less grabby." instead;

understand "oppossum" and "possum" as opossum.

section mussing

opmussing is an action applying to nothing.

mussing is an action applying to one thing.

understand the command "muss" as something new.

understand "ruff fur" as opmussing when opossum is quicknear.

check opmussing: try mussing opossum instead.

understand "muss [something]" as mussing.

carry out mussing:
	if noun is not opossum, say "You don't need to muss [the noun]." instead;
	say "You reach over and give the opossum a loving scratch. It perks up! Suddenly, it looks around and runs off, in search of home, wherever that is.";
	abide by the LLP rule; [MUSS OPOSSUM]
	moot opossum;
	the rule succeeds.

chapter Bros' Orb

the Bros' Orb is a thing in Le Babel. "[one of]An orb hovers in the air. You know it must be a Bros['] Orb[or]The Bros['] Orb still hovers in the air[stopping]. [if player has stir writs]You look at the stir writs in your hand, and you feel confident you can just take the orb now[else]You would love to take the orb, but you're not sure if you're worthy.". description is "Looking into the Bros['] Orb, you think, 'Do orbs brood?' There is a brief vision of star frats, lacking star brats or prats and even meriting star GRATS for community service. Maybe they don't do it perfectly, but it gets done. You start to understand social, subjective knowledge you assumed only jerks know. About how to be likable to others. Of course some go overboard, but any good thing can be abused that way. You realize you are cheating yourself if you don't learn the basics, here.[paragraph break]Oh yes. There's also a huge area marked off 'Sis' just to show it's not about guys.[paragraph break][if player has stir writs]You are awed but not overpowered[else]It all seems a bit too much to process up close, though[end if].".

after examining the Bros' Orb when player is in Red Roses Order:
	say "The Bros['] Orb is pulsing violently. It needs to let its energy out--but on whom? On what?";
	continue the action;

understand "bro/bros" and "bro/bros orb" as Bros' Orb.

check taking Bros' Orb:
	if player has Bros' Orb, say "You already have it." instead;
	if player does not have stir writs, say "A voice in your head says 'WANT? NAW!'[paragraph break]You aren't sure you can handle the potentially corrupting power of the Bros['] Orb[if player has sage gas]. The sage gas helps you to understand how things could go wrong, but still, you're a bit worried[end if]. Maybe if you had some more balance to your thinking." instead;
	say "You wonder if you should take the Bros['] Orb. If you deserve to. But you reread the stir writs and whisper to yourself, 'Nag, ol['] slogan,' and feel balanced enough to take the Bros['] Orb and accept the responsibility for doing so.[paragraph break]And even to recognize that you don't always deserve points for doing the right thing[if useon-writs is true], or knowing what to use on what[end if]. The stir writs helped with that. Just having the Bros['] Orb will be enough. It will be useful somewhere.";

report taking Bros' Orb:
	moot stir writs;
	say "Taking the Bros['] Orb requires two hands. You watch the stir writs flutter off beyond the Voodoo V. Oh, well. You carry the stir writs['] messages in your mind and heart and stuff anyway, now, and you'll continue to do so even when this adventure is done.";
	the rule succeeds;

useon-writs is a truth state that varies.

check useoning Bros' Orb with stir writs:
	try useoning stir writs with Bros' Orb instead; [ugh! I know. I just have to do this hack once, though. ??]

check useoning stir writs with Bros' Orb:
	now useon-writs is true;
	say "You don't need to wave the stir writs around or anything to take the orb, but you focus on the stir writs to make sure.[paragraph break]";
	try taking Bros' Orb instead;

book Mont Nom

Mont Nom is south of Dumb Mud. It is in Grebeberg. "An ark of okra blocks passage every way except back north to Dumb Mud."

Mont Nom is above Dumb Mud.

check useoning with in Mont Nom:
	if noun is drinkable or second noun is drinkable, say "In Mont Nom, drinking [if martini tram is off-stage]comes[else]would have come[end if] after eating." instead;

after looking in Mont Nom:
	if number of carried ingredients is 1:
		say "Your [random carried ingredient] smells a bit nicer, here.";
	else if number of carried ingredients > 1:
		say "The smells from your [list of carried ingredients] mix[one of] unexpectedly pleasantly[or] pleasantly, again,[stopping] here.";
	continue the action:

check going nowhere in Mont Nom: say "The Ark of Okra blocks progess any way except back down north." instead;

chapter ark of okra

The ark of okra is scenery in Mont Nom. "You always found okra, or the idea, icky, but the ark is beautiful enough, you sort of wonder how it'd taste--well, if it hadn't been sitting out for goodness knows how long. Here you can see DO OFT FOOD inscribed on it. Maybe if you LISTEN you'll hear an equally weird and vaguely useful message[if martini tram is off-stage]. You bet something cool is behind it. Maybe a tahini hat. You really want to make a sup opus here[end if]."

after examining ark of okra:
	if martini tram is moot:
		say "The ark of okra is cracked from where the martini tram rolled through, but you don't see any secret passage behind it.";
	else:
		if chef-yet is true, say "It appears slightly cracked now you combined [the list of ingredients in devreserved].";
	continue the action;

check taking ark of okra: say "It's bigger than you are." instead;

check entering ark of okra: say "[if martini tram is off-stage]There's no way in[else]The crack you made in the ark of okra doesn't lead anywhere[end if]." instead;

chapter martini tram

the martini tram is a tronpart. "That martini tram that rolled all the way from Mont Nom still rests here.". description is "[if player has epicer recipe and epicer recipe is xed]The martini tram looks like it'll provide a handy base for the future North-Tron the epicer recipe described[else]You're not sure what it is for, but it seems sturdy[end if].".

check taking martini tram: say "It'd be awkward to push around. Besides, it [if epicer recipe is xed]seems like it needs to be here, to build the north-tron[else]doesn't have anywhere better to go[end if]." instead;

chapter Ian

Ian is a proper-named guhthug in Mont Nom. "[one of]'I'm Ian. I guess I can't make you leave, but you seem ill-equipped to deal with the sophisticated blend of tastes served up by Mont Nom.'[or]Ian continues to look down his nose at you.[stopping]". description is "Ian smirks back at you. You turn away. He seems just a bit too suave.".

chapter nailing

nailing is an action applying to one thing.

understand the command "nail" as something new.

understand "nail [something]" as nailing when player is in Mont Nom and Ian is in Mont Nom.

carry out nailing:
	if Ian is moot, say "There's nobody named Elian to nail later in the game, so this isn't an action you need to take any more." instead;
	if noun is not Ian, say "You'll know what or whom to nail, and [if noun is a person]noun[else]that[end if]'s not it." instead;
	say "You wait and hide. After a while, you catch Ian picking his nose absent-mindedly. You call him on it! In the presence of food, no less! Ian mumbles he was doing so ironically, but you point out he was still doing it.[paragraph break]Ian hurries away in shame across the Turf Rut. He takes one look at the, um, bridge and realizes that if he hadn't DONE anything gross, he wouldn't have to CROSS anything gross.";
	moot Ian;
	score-inc; [Grebeberg/nail ian]
	consider the cap-beep rules for Ian;
	the rule succeeds;

book Ooze Zoo

Ooze Zoo is south of Seer Trees. It is in Grebeberg. "[if sleep eels are in Ooze Zoo]Sleep eels block passage south, but you can still go back north[else]With the sleep eels gone, you can go north, or south to [s-dray][end if]. [one of]A rampart (branded TrapMart, which seems wrong until you think about it for a second)[or]The TrapMart Rampart[stopping] blocks your way west and east."

check going south in Ooze Zoo: if sleep eels are in Ooze Zoo, say "There are too many eels. It would be inhumane to step on one. Maybe you can give them somewhere else to sleep, or something to sleep on." instead;

check going nowhere in Ooze Zoo: say "[chase-pass]The TrapMart Rampart restricts you to traveling north or south." instead;

chapter trapmart rampart

[the programmatic name has a space, but the printed name doesn't, because it's easier to write 'understand' that way]

the trap mart rampart is semiperipheral scenery in Ooze Zoo. "It's sturdy and too high to climb."

printed name of trap mart rampart is "TrapMart Rampart".

understand "trapmart rampart" and "trapmart" as trap mart rampart.

chapter sleep eels

the sleep eels are plural-named people in Ooze Zoo. "The sleep eels look slightly uncomfortable where they are. Maybe you can give them better sleeping quarters.". description is "The sleep eels squirm. Maybe there's a humane way to move them out."

understand "sleep eel" and "eel" as sleep eels.

check taking sleep eels: say "There are too many, and they'd slip through your fingers." instead;

to say s-dray:
	say "[if Frush Surf is visited]the Frush Surf[else]a coastal place[end if]"

book Frush Surf

Frush Surf is south of Ooze Zoo. "The land curves here. Stewy wets thrash to the south and west, but you can go north or east.". It is in Grebeberg.

check going in Frush Surf:
	if noun is south or noun is west, say "[chase-pass]You barely step in, and the water's a bit hot. You're worried you might run into some scorch crocs or worse, lava (naval.)" instead;

check going north in Frush Surf when being-chased is true: mug-the-player;

chapter Stamp Mats

the stamp mats are a thing in Frush Surf. "Stamp mats lie here.". description is "The stamp mats are thin and appear to be engraved in a sort of bas-relief pattern. They feel sharp enough, you could use them to cut most any material."

understand "stamps" as stamp mats.

report taking stamp mats:
	say "The stamp mats are thin enough and thus not too heavy. They line the Sto-Lots nicely, and they don't even slip to the bottom where they'll be hard to find.";
	the rule succeeds;

after taking stamp mats:
	shuffle-before Frush Surf and Trial Lair;
	continue the action;

chapter Kayo Yak

a chaser has a truth state called chased-yet.

The Kayo Yak is a beepy chaser in Frush Surf. chase-room of Kayo Yak is Frush Surf. "[one of]A tough looking animal paces around here! It rushes after a few imaginary targets. It looks like a yak. That would make it ... a kayo yak. [or][stopping][if player is in Lair Trial]The kayo yak has slowed down temporarily. It seems to be looking back and forth between you and the Ergot Ogre[else if being-chased is true]The kayo yak has an aggressive look in its eyes! It's snorting, and you're the only thing worth chasing[else if kayo yak was not in location of player]The kayo yak [yak-smell][else]The kayo yak, having sniffed at you, is just pacing around now[end if].". description is "[if being-chased is true]The Kayo Yak is really rumbling around, here[else]The Kayo Yak looks alert, ready for more than just standing around[end if].". stix-room of Kayo Yak is Seer Trees.

to say yak-smell: say "[if player wears stinky knits]bounds up to you and gives a sniff. It seems interested in your stinky knits, but not enough to really do anything[else if player wears brag garb and troll ort is not moot]walks up, takes a whiff of your brag garb, and backs up, howling. Hmm, the brag garb's scent is a bit too much for you, too[else if player wears brag garb]smells the troll ort on you[one of][or] again[stopping] and makes a weird noise[else]plods up to you and gives a cursory sniff but seems to find nothing too repellent or attractive. You feel almost blown off by this[end if]";

chapter stewy wets

the stewy wets are peripheral scenery in Frush Surf. "The stewy wets look too treacherous to enter."

chapter yakokaying

yakokaying is an action applying to nothing.

understand the command "yakokay" as something new.
understand the command "yak okay" as something new.
understand the command "yak on okay" as something new.
understand the command "yak off okay" as something new.

understand "yakokay" as yakokaying.
understand "yak okay" as yakokaying.
understand "yak on okay" as yakokaying.
understand "yak off okay" as yakokaying.

kayo-known is a truth state that varies.

carry out yakokaying:
	if ergot ogre is moot, say "[if yak is in location of player]The yak has served you well. It deserves a rest.[else]You relive past glories. Why not?[end if]" instead;
	if yak is in location of player and ergot ogre is in location of player:
		say "The kayo yak surges at the ergot ogre and knocks it over with a few ... smart rams! The ergot won't spread to the yak's horns, so that's good. The ogre dusts itself off and walks away, damp, mad. The yak, for its part, looks relaxed--almost like a tao goat--and seems to be begging for something. You toss it the brag garb, which it has no end of fun mauling further as it runs off in the distance where you can't follow.[paragraph break]You run back to Ooze Zoo to collect what you dropped, then back to the Lair Trial. But it isn't really a Lair Trial any more with the ergot ogre gone. Just plain old stride dirts.";
		score-inc; [Grebeberg/YAK OKAY]
		banish-ogre;
		moot brag garb;
		consider the cap-beep rules for the kayo yak;
		the rule succeeds;
	now kayo-known is true;
	if yak is in location of player:
		if player is in Moo Room:
			say "[get-rej of kayo yak]The kayo yak storms around the barn in circles! But it does not find anything worth really destroying[if yahoo hay is in Moo Room], not even the yahoo hay[end if]. You're exhausted watching it--perhaps the aggression from your KAYO YAK would be useful elsewhere." instead;
		if player is in Flu Gulf and scorn rocs are in Flu Gulf:
			say "[get-rej of kayo yak]The yak charges briefly at the scorn rocs but pulls up quickly. Maybe YAK OKAY could help the yak tackle something less fearsome." instead;
		if being-chased is true, now chase-mulligan is true;
		say "[get-rej of kayo yak]The yak paws the ground aggressively and runs in a circle before settling back. It seemed agitated, there, like it wanted to do more.[paragraph break]'YAK OKAY' seemed to make sense, though. You file it away for some other time and place." instead;
	say "[get-rej of kayo yak]There's no yak around to say okay to, but that could be handy somewhere." instead;
	the rule succeeds;

to banish-ogre:
	now cap-pace is false;
	moot kayo yak;
	later-wipe kayo yak;
	moot ergot ogre;
	moot troll ort;
	recover-items;
	now being-chased is false;
	now chase-mulligan is false;

chapter blocking east

check going east in Frush Surf when being-chased is true:
	if Moo Room is chase-blocked, continue the action;
	if poo coop is in Moo Room:
		say "That seems like a dead end, but who knows, maybe you [if Moo Room is visited]missed[else]might find[end if] something valuable there.";
		continue the action;
	say "[chase-pass]That seems like a dead end. The yak would have you cornered. But hey, why not.";

book Moo Room

Moo Room is east of Frush Surf. It is in Grebeberg. "You can't see any cows, but you occasionally hear them[if bees-seen is false] and, also, an ominous buzzing it'd be nice to locate[end if]. You can't see any farm as you'd expect to, but that's probably the private property of one Mr. A. [if yahoo hay is in Moo Room]Yahoo hay is piled all around. [end if]The only way back is west."

chapter poo coop

the poo coop is in Moo Room. "A poo coop sits here. Thankfully, it looks empty[if kayo yak is in Moo Room] and small enough to take before the kayo yak charges you[one of][or]. Hint, hint[stopping][end if].". description is "While it's 1/4 too small to be a pooch coop, the coop is 1) [if gnu dung is moot]full of gnu dung[else]empty[end if] and 2) somehow bigger on the inside than the outside. [if gnu dung is moot]It would be nice to get rid of the gnu dung[else]Maybe it can clean up a something dirty or worse[end if]."

understand "poos scoop" and "poos/scoop" as poo coop.
understand "gnu dung" and "gnu/dung" as poo coop when player has poo coop and gnu dung is moot.

chapter senile felines

the senile felines are plural-named llpish semiperipheral things in Moo Room. "Senile felines swat at a late petal just a bit too high to reach. It might be fun to help them, but they probably can't help you. CATS!". description is "They are just lazing around, swatting at the late petal but never reaching it. You guess it must be fun for them[think-cats]."

to say think-cats:
	if the player's command does not include "cats", say ".[paragraph break]Maybe it'd be fun to think of them as CATS"

instead of taking senile felines, say "It's hard enough to take ONE cat at a time, much less many."

understand "cats" as senile felines.

check taking the senile felines: say "Sure, that'd help them swat the petal and 'win' whatever game they're playing, but maybe they want to feel like they did it themselves. As CATS." instead;

the late petal is peripheral scenery in Moo Room. "It's just out of reach of the cats. Felines. Same thing--or is it?"

instead of taking late petal, say "That'd be cheating, to actually give the cats the petal."

chapter yahoo hay

the yahoo hay is scenery in Moo Room. "The yahoo hay, unlike normal hay, makes you feel inexplicably cheery. Like it can be used to build even cooler stuff.[paragraph break][if SOME DEMOS is moot]It's mostly the coarser, unbendable stuff that's remaining, now you built the straw arts. Maybe you could make something practical[else if enact cane is moot]The remains from building the moor broom look suitable for stuffing or bending. Nothing practical, but maybe something fun[else]Half the hay appears to coarser, stronger and more practical to build something useful with. The other half looks more suitable for stuffing, or bending into all kinds of things. NOTE: you don't have to refer to either half in a command[end if]."

chapter straw arts

the straw arts are a plural-named thing. description is "Whatever they are, you made them, and you hope it expresses something or other."

chapter moor broom

the moor broom is a thing. description is "It's made of that enact cane and the yahoo hay, and just looking at it, you feel almost excited about cleaning. It's more practical than a pomp mop, for sure."

book Swamp Maws

Swamp Maws is west of Dumb Mud. It is in Grebeberg. "A made dam blocks your way west. You can go north, south and east here."

check going in Swamp Maws (this is the check yak speed rule):
	if being-chased is true and cap-pace is false:
		say "You have to pause to catch your breath. As you do, the kayo yak bumps you! If only you could've found a way to go a bit faster...[paragraph break]";
		reset-chase;
		the rule succeeds;

understand "swamp maw" and "maw" as swamp maws.

chapter hinting dr d again

revisit-clue is a truth state that varies.

after looking in Swamp Maws (this is the uneven u revisit hint rule) :
	if exam axe is not off-stage and revisited-u is false and balsa slab is off-stage:
		now revisit-clue is true;
		say "[one of]'Oh, wow! A Dr. Award! For all my hard work! Great news for Uneven U!' you hear Dr. D, the Code Doc, boom from the south. Maybe the Known Wonk really did help the Code Doc! You should check it out![or]You realize you haven't been south to congratulate Dr. D yet.[stopping]";
	continue the action;

revisited-u is a truth state that varies.

after going south when exam axe is not off-stage:
	if player is in Uneven U, now revisited-u is true;
	continue the action;

chapter made dam

the made dam is scenery in Swamp Maws. description is "It looks hastily put together, and you're not sure if it's actually protecting any great torrent of water. It also looks heterogeneous--if there were a way to find if part of the dam were particularly odd or valuable, you could maybe scrape away, there."

chapter eroded ore

some Eroded Ore is a thing. description is "You're no expert metallurgist, but it's dim and porous and probably not as potent as it could be."

chapter Ore Zero

Some Ore Zero is a tronpart. description is "It gleams dully. Hopefully it's not radioactive. Well, it hasn't killed you yet."

book Uneven U

Uneven U is south of Swamp Maws. It is in Grebeberg. "This looks vaguely like a university campus, with an all-ivy villa blocking the way west and a den, ivy-vined, blocking the way east. You can go north and south easily, though. [if tent net is moot]It feels nice and cozy now you helped the Code Doc add some furnishings[else]But it feels terribly unfinished, even with the ivy ambiance. It needs just a bit more cover. Cover that might still let in a bit of light[end if][if-porch]."

printed name of Uneven U is "[if balsa slab is off-stage]Uneven[else]Unitin['][end if] U".

understand "unitin/u" and "unitin u" as uneven u when balsa slab is not off-stage.

understand "cribs" and "birch cribs" as birch crib.

check entering birch crib: try going west instead;

check going in Uneven U: if noun is east or noun is west, say "It would be rude to traipse around [Uneven U]." instead;

check going nowhere in Uneven U: say "You see no way into the [if noun is west]all-ivy villa[else]den, ivy-vined[end if], and you see no reason to enter, either. You're not here for education!" instead;

section all ivy villa

does the player mean doing something with ivy villa: it is likely.

the thing called all ivy villa is semiperipheral scenery in Uneven U. "[ivy-desc]."

check entering ivy villa: try going west instead;

to say ivy-desc: say "It's impressive looking[if tent net is not moot] and much more finished than the rest of Uneven U[end if], but you see no way to enter it"

section den ivy vined

the den ivy vined is semiperipheral scenery in Uneven U. "[ivy-desc].". printed name of den ivy vined is "den, ivy-vined".

check entering den ivy vined: try going east instead;

chapter code doc

Code Doc is a neuter person in Uneven U. "[if uneven u is unvisited]Someone is pacing back and forth here, muttering 'Ada. Perl, rep! Gig: PHP! SAS!' They look up as you walk in. 'Oh. Sorry. Hi. I'm the Code Doc. I can help you with, like, technical stuff, if you need.'[else]The Code Doc paces back and forth here.[end if]". description is "The Code Doc hand-waves and mumbling about whom to hire to increase [Uneven U]'s prestige. [if wash saw is moot]You've had a good working relationship with the Code Doc, but you both need to move on to even bigger things[else]Busy, but not too busy to help or work with someone else[end if]."

understand "dr/d" and "dr d" as code doc.

chapter Spa Maps

the Spa Maps are a plural-named thing. indefinite article of Spa Maps is "some". description is "[if sage gas is not off-stage]The maps seem old hat now you've gotten the sage gas[else if maps-explained is false]You can't quite make sense out of them. There's Gobs-Bog and Go-By Bog, and one is a lot safer than the other, but you're not sure which[else]The spa maps clearly demark Go-By Bog and Gobs Bog and even Goblin-Nil Bog, which probably contains a troll or two. And no hospitality[end if]."

does the player mean useoning Spa Maps with go by bog: it is very likely.

after examining spa maps for the first time:
	say "[line break]They were, unsurprisingly, written by Pam. Good thing they're not spa mini-maps. They'd be IMPOSSIBLE to read.";
	continue the action;

understand "spa map" and "map" as spa maps when player has spa maps.

check examining spa maps:
	if player is not in Apse Spa, say "It doesn't look like the maps apply to the terrain here[if Apse Spa is unvisited] or anywhere you've been[else], but they seem somewhat familiar[end if]." instead;
	try useoning spa maps with go by bog instead;

maps-explained is a truth state that varies.

chapter porch crop

the porch crop is scenery. "[if wash saw is moot]It's been cleared up since you used the wash saw on it[else]It really sprawls. Maybe there is a way to trim it to help the Code Doc[end if]."

to say if-porch: if porch crop is in Uneven U, say ". [if wash saw is moot]The porch crop is still trimmed back[else]Some porch crop has sprouted up, but there's just too much of it. It could use a trimming[end if]";

chapter balsa slab

The Balsa Slab is a thing. description is "It appears grooved, as if someone has labeled places to cut it to make it into something useful. It's not rad eco-cedar, but it's still pretty nice."

book Lair Trial

Lair Trial is south of Uneven U. It is in Grebeberg. "Thick go-fog bounds this passage to the south and west[if ergot ogre is moot], and with the trial over, you're free to go either way[end if]."

printed name of Lair Trial is "[if ergot ogre is in Lair Trial]Lair Trial[else]Stride Dirts[end if]".

understand "stride dirts" and "stride/dirts" as Lair Trial when ergot ogre is moot.

check going nowhere in Lair Trial: say "[chase-pass][if ogre is in Lair Trial]You can't sneak around the ergot ogre. You need to get rid of it[else]There's nothing in the fog[end if]." instead;

chapter ergot ogre

the ergot ogre is a neuter person in Lair Trial. "An ergot ogre blocks the way east.". description is "It looks vicious, like a grue (eurg.) You don't want it touching you, due to disease and possible dismemberment. You need to get the ogre out of the way, somehow.".

check going east in Lair Trial: if ergot ogre is in Lair Trial, say "Not with the ergot ogre guarding the way." instead;

chapter go fog

the go fog is peripheral scenery in Trial Lair. understand "gofog" and "go-fog" as go fog. "The go fog is very opaque. It would be too easy to get lost in."

book Motto Bottom

Motto Bottom is east of Lair Trial. It is in Grebeberg. "A be-web blocks passage every way except back west. There's also a tips pit you don't want to fall into."

understand "motto botto" and "botto" as Motto Bottom when Motto Bottom is visited.

check going nowhere in Motto Bottom: say "The Be-Web is full of wisdom on just existing happily and doing small meaningful everyday nice things for their own sake, but you're in an adventure right now. That's useful for after this whole mess, but right now, you can really only go back west." instead;

chapter tips pit

the tips pit is peripheral scenetry in Motto Bottom. understand "tips pit" and "tip pit" and "tipspit" as tips pit. "The tips pit is--man, it's deep. Well, physically, at least. Maybe there's some life advice down at the bottom, but to get there you'd probably have to fall, and you wouldn't have much life left."

chapter be web

the be web is peripheral scenery in Motto Bottom. understand "beweb" as be web. "The be-web spans everywhere except back west. Perhaps if you were a lot cleverer, or sillier, you could find meaning in it, but as-is, it's just there to nudge you back east."

chapter tame mat

The tame mat is a thing in Motto Bottom. "A tame mat lies here. It's supposed to be profound and universal, but you're half embarrassed to look at what it says.". description is "'MAIN, I AM!' it reads. That's sort of lame. There must be some way to improve it, make it cleverer or (philosophically) weightier."

check taking tame mat: say "As you try to take the tame mat, you feel stuck-cuts. It seems rooted to the spot. Maybe it would budge if you augmented it somehow." instead;

chapter guru rug

The guru rug is a thing. "A guru rug lies here. You're not sure how impressed you should be by it.". description is "Hmm, it feels a bit looser than the tame mat, but still not loose enough to take. It looks like you could slip the right thing in or under. Its simplicity leads you to believe it holds even greater secrets within, if you used a bit of wisdom."

check taking guru rug: say "'Egad! Adage!' you think to yourself. You're not up to any great philosophy. Maybe something less heavy than the guru rug.[paragraph break]However, you would like to take its lessons with you in some form." instead;

chapter stir writs

The stir writs are a plural-named thing. description is "E.g. adage. They balance emotional and intellectual considerations well, making you feel you can do things you'd put off before, both simple or complex, and maybe you don't need permission to do or deserve big things.[paragraph break]They're probably safer for your help and give a more permanent boost than Stim-Its or a Vig-IV, too."

check useoning stir writs with Bros' Orb: try taking Bros' Orb instead;

book Yack Cay

Yack Cay is north of Swamp Maws. It is in Grebeberg. "An edits tide blocks your way west, and storm rots block your way east. [if mist sim is moot]You can go north or south here with ease[else]Mist sim hovers to the north, but there's no blocking back south[end if][if mist sim is moot]. The Known Wonk's Tru-Yurt is here[is-yurt-messy][end if]."

check entering tru yurt: say "A rebuke from the Known Wonk stops you: 'Ye so nosey!' Nip in? Not on!" instead;

to say is-yurt-messy: if moor broom is not moot, say ". It looks messy[if wonk is moot], and from the inside, you hear the Known Wonk whining about it[end if]"

printed name of Yack Cay is "[if Known Wonk is moot]Roomy Moor[else]Yack Cay[end if]".

understand "roomy/moor" and "roomy moor" as Yack Cay when Known Wonk is moot.

check going north in Yack Cay when mist sim is in Yack Cay: say "The Known Wonk pushes you back. 'You don't know how weird it is to the north, especially beyond that mist sim! It's potentially WORSE than normal mist! But I know a thing or two about adventuring... well, adventuring theory. And I can tell you, boy oh boy, there are risks.'[paragraph break]The Known Wonk lists a few. You don't know if the Known Wonk believes all this. But you can't refute it, and you do have a nagging worry." instead;

check going west in Yack Cay: say "The edits tide [if el doodle is moot]was more useful to help reconfigure El Doodle[else]is probably better for something edit-able[end if]. Besides, there might be scuba bucs waiting beyond." instead;

check going east in Yack Cay: say "You don't want or need to have anything to do with the storm rots." instead;

check entering edits tide: try going west instead;

chapter Known Wonk

The Known Wonk is a neuter person in Yack Cay. "The Known Wonk stands by a Tru Yurt, babbling about ... well, lots of smart sounding things.". description is "Not particularly disheveled, but then, not terribly charismatic. The Known Wonk seems lost in more esoteric matters than helping you figure how to save Grebeberg and Yelpley."

chapter mist sim

the mist sim is semiperipheral scenery in Yack Cay. "It's blocking your way north, and it doesn't look dangerous, but you never know. You're new here, after all."

check entering mist sim: try going north instead;

chapter storm rots

the storm rots are plural-named peripheral scenery in Yack Cay. "Euugh. You don't want to go anywhere near them."

chapter Exam Axe

The Exam Axe is a thing. description is "Just looking at the exam axe, you feel as though you've been right about stuff. Maybe not right or morally superior, but you're able to see through obvious nonsense. You know it will help you with some max-exam, somewhere."

chapter Tru Yurt

The Tru Yurt is scenery in Yack Cay. "[if moor broom is moot]It's much cleaner now you took the moor broom to it[else][peek-eep]. You didn't see much, but it looks really messy, and stuff like cleaning can't be the Known Wonk's forte[end if]."

to say peek-eep:
	say "'Peek? Eep!' [if mist sim is moot]you hear from the Tru Yurt[else]the Known Wonk exclaims, shocked at your nosiness[end if]"

check taking tru yurt: say "It's the Known Wonk's. You don't need a home base, anyway." instead;

check entering yurt: say "No, that's where the Known Wonk lives. [if exam axe is off-stage]Maybe you could clean it up, by using the right item[else]You already helped clean it up, and that's enough[end if]." instead;

chapter Edits Tide

The Edits Tide is scenery in Yack Cay. "Just looking into the tide, you remember things that confused you in the past and relatively easy ways you found to work around them. A voice from the edits tide seems to say [if spa maps are off-stage]that you could use its proofreading skills[else]it has labored enough for you[end if]."

chapter sharp rahs

the sharp rahs are a plural-named thing. "The sharp rahs get you enthused, but they're not enough by themselves. Perhaps they are a bit overdone, with stuff like ZEST SEZ. They need balance some way.". description is "Reading the rahs leaves you feeling more motivated for a bit, but not long, because you used all your mental energy getting motivated. Perhaps they need to be balanced with something more cerebral." [??rahs on mat]

book Lac Oft Focal

Lac Oft Focal is north of Yack Cay. It is in Grebeberg. "A calcific lac borders on all sides except south back to the [Yack Cay].[paragraph break][if dork rod is moot]The Tao Boat that helped you get at peace with things is here[else]A Tao Boat rests on the shore, here, with no clear entry[end if]. [if elope pole is moot]That kayak you took to Elided Ile is here, too[else]There's a kayak, too. [one of]And wait! If you look into the distance, you see something! Elided Ile! Just as the Known Wonk said it had to be somewhere! The Wonk's calculations and predictions were all right[or]You see Elided Ile in the distance. Maybe some day, you will get there[stopping][end if]."

printed name of Lac Oft Focal is "[if lac-score is 2]Lac Old Local[else]Lac Oft Focal[end if]".

understand "old local" and "old/local" and "lac old/local" and "lac old local" as Lac Oft Focal when lac-score is 2.

check going nowhere in Lac Oft Focal: say "You can't make it across the calcific lac by yourself[if lac-score is 2], and you don't need to any more[end if]. You can't really expect a bunch of sprats['] tarps to appear." instead;

to decide which number is lac-score:
	let temp be 0;
	if elope pole is moot, increment temp;
	if dork rod is moot, increment temp;
	decide on temp;

to say kayak-boat:
	say "[if kayak is in Lac Oft Focal]kayak[else]Tao Boat[end if]"

chapter Elided Ile

Elided Ile is peripheral scenery in Lac Oft Focal. "Elided Ile is so far away, you can't see much. [if kayak is moot]But you remember it and the good times you had there. That's enough.[else]Maybe one day you'll get there![end if]"

chapter calcific lac

the calcific lac is peripheral scenery in Lac Oft Focal. "You C A lac. It's a very CALM lac (of course it is) but far too wide to cross without transportation."

chapter kayak

The kayak is scenery in Lac Oft Focal. "It's, well, just a kayak. It doesn't have anything to steer it with, though. Maybe you have something, or you could find something."

check taking kayak: say "You got strong in My Gym, but not that strong! [if elope pole is moot]Besides, you already took it somewhere[else]Maybe you could USE the right item to take it somewhere[end if]." instead;

check entering kayak: say "[if elope pole is moot]Your elope pole is gone. There's no way to steer it[else]You need to find a way to steer it. Maybe there's no paddle, but something long and straight[end if]." instead;

instead of doing something with kayak when elope pole is moot:
	if action is procedural, continue the action;
	say "The kayak has served its purpose."

instead of useoning with kayak when elope pole is moot:
	say "The kayak has served its purpose."

chapter tao boat

The Tao Boat is scenery in Lac Oft Focal. "It rocks gently on the waves, with no clear entry, just fine without anyone riding on it. You [unless dork rod is moot]wonder what it's like inside, if you're worthy[else]look back on your time inside with fondness. It has put you at peace with the job you have ahead[end if]. Just looking at it gives more inner peace than you'd get from any of the medicine or alcohol you've come across in the game[unless dork rod is moot], but perhaps you need to show it a certification of appropriate humility to enter. Perhaps an item that seems useless elsewhere[end if]."

check entering tao boat: say "You see no clear entry. Perhaps you need to make some gesture, or show the boat an emblem of your worth or self-acceptance." instead;

check taking tao boat: say "The tao boat is much too big." instead;

chapter dork rod

The dork rod is a thing. description is "Wand? Naw. It's kind of neat and quirky, but it's not shiny enough to be the famed Dorada Rod. Which would be worth more at a pawn shop, but the dork rod reminds you of embarrassing things you did in the past, and yet...you're not quite so embarrassed about them! You know how to deal a bit better, now. You even feel less embarrassed you were shunted off into this quest instead of something more action-packed. At peace with yourself, even."

chapter enact cane

The Enact Cane is a thing. description is "Just holding it makes you feel snazzier and more authoritative and with-it. It's slightly mussed at one end, as if maybe you could attach something there to make it actually useful. It looks like it was recycled from something else. If you READ it, you might be able to see."

chapter taboo bat

The taboo bat is a thing. description is "You feel rebellious just holding this thing. One look, and visions of chances taken and authority bucked in your youth, sensible or not, swirl at you for a bit. It--well, it almost feels foamish, but it's decorated so that if I described it in full, this game would still probably be PG, but I don't want to risk it. Sorry about that!"

chapter you buoy

the you buoy is a thing. description is "It's really plain, now you look at it. Also, as you look it over, it rattles a bit. It feels too sturdy to break open by yourself, though."

chapter ME gem

the ME gem is a thing. description is "You feel a strong urge to keep this and not share it, because of all the crazy things you did to get it, but you know that's not quite right. You wonder of its origin--perhaps it was chipped off from Le We Jewel, or it was originally engraved in the Ring O['] Zognir. Or was it the Ring of Ufognir?[paragraph break]Also, it looks nothing at all like the emerald in Zork I, which was also in a buoy, so stop thinking that.[paragraph break]It doesn't feel destructive, so it's not a gem of omega, or anything."

book Apse Spa

Apse Spa is east of Cold Loc. It is in Grebeberg. "The Apse Spa is covered with dose sod, which you don't need for yourself--you're not sick--but it looks beautiful. Pool gloop and Go-By Bog block pretty much every way except back west. You [if sage gas is off-stage]could traverse it, if you knew what you were doing[else]already went through it, though[end if]. There are also spa taps here you shouldn't mess with, since you're not a paying customer."

check entering go by bog:
	if spa maps are moot, say "You don't want or need to revisit the bog." instead;
	if maps-explained is true, try useoning spa maps with go by bog instead;
	if word number 1 in the player's command is "go" and word number 2 in the player's command is "bog":
		say "In the true palindrome spirit, you take one step in the bog, then reverse direction before it gets dangerous. You suspect there are plenty of sap-spas and no E-Z Ooze if you misstep, so you probably need some sort of guide to navigate safely." instead;
	say "The bog is dangerous without guidance." instead;

check going in Apse Spa:
	if noun is not west, try entering bog instead;

chapter dose sod

the dose sod is scenery in Apse Spa. "It looks ucky, but given you're in an Apse Spa, it may have health benefits for those that need them."

rule for deciding whether all includes the dose sod when taking: it does;

sod-with-hands is a truth state that varies.

check taking dose sod:
	now sod-with-hands is true;
	say "The sod is pretty slimy. Any curative properties would be canceled out by your germs carrying it. You need something to hold it in. Or 'in which to hold it,' if ending a sentence with a preposition hacks you off." instead;

chapter go-by bog

Go By Bog is scenery in Apse Spa. description is "[if sage gas is off-stage]It's too hazy. You'd get lost navigating it without a lot of help[else]You got the sage gas. You don't want to risk any more[end if]."

printed name of Go By Bog is "Go-By Bog".

chapter pool gloop

The pool gloop is peripheral scenery in Apse Spa. "The pool gloop is probably to help people convalesce, or it's advertised as such, but you're not sick, and you already followed one silly ad to get here."

chapter spa taps

some spa taps are plural-named peripheral scenery in Apse Spa. "They probably keep the spa feeling relaxing, somehow. You resist the urge to twiddle them. Or maybe get rid of one to create a path tap that might lead somewhere."

understand "tap" and "spa tap" as spa taps when player is in Apse Spa.

check taking spa taps: say "They're useless, altogether or if you take just one. You don't need a path tap in this game."

chapter sage gas

some sage gas is a thing. description is "It's pretty translucent--you're just glad you've been able to bottle it up in the Sto Lots, somehow. You're not sure what it could make wiser, but it probably isn't wise to experiment on a person.".

part Yelpley region

book Yawn Way

Yawn Way is east of Fun Enuf. It is in Yelpley. "[yawn-desc]."

understand "palapa" as Yawn Way when elite tile is in fun enuf.

to say yawn-desc:
	if elite tile is in fun enuf:
		say "A palapa has replaced boring old Yawn Way. It's relaxing now without being boring[if day away ad is in Yawn Way][one of]. And wait! There's a day-away ad, trumpeting all the business that'll return to Yelpley now you defeated the Diktat Kid[or]. You can still read the day-away ad, if you want[stopping][end if]. You can still go in all four directions";
	else:
		say "Not much to do here, and it's quiet enough it could be Yawling-Nil Way, but you can go [yawn-stix] north to [if Art Xtra is visited]Art Xtra[else]an art store[end if], south to [if My Gym is visited]My Gym[else]a gym[end if], or east to [if Emo Dome is visited]Emo Dome[else]a dome[end if]"

printed name of Yawn Way is "[if elite tile is in fun enuf]A Palala[else]Yawn Way[end if]".

to say yawn-stix:
	say "[if stix are in Yawn Way]all but west, where the X-It Stix block you:[else]in all four directions, here: back west to [Fun Enuf],[end if]"

after looking in Yawn Way for the first time:
	say "Whew! You were worried you'd develop a city tic, looking around, but thankfully not.";
	continue the action;

after looking in Yawn Way:
	if Diktat Kid is moot and day away ad is off-stage:
		say "Oh! There's something new [if Name ME Man is in Yawn Way]next to Name ME Man[else]where Name ME Man was[end if]. It's ... a day-away ad! Of businesses that will repopulate Yelpley with the Diktat Kid gone!";
		move day away ad to Yawn Way;
	continue the action;

chapter day away ad

the day away ad is scenery. printed name of day away ad is "Day-Away Ad". "The Day-Away Ad describes businesses soon to open in the new improved Yelpley, including [next-rand-txt of table of businesses] and [next-rand-txt of table of businesses]."

chapter X/Y Pyx

an X Y Pyx is a peripheral thing in Yawn Way. printed name of x y pyx is "X/Y Pyx". description of X Y Pyx is "[map-so-far]". "[one of]An X/Y pyx lies here. Closer inspection reveals that's just a fancy name for a map[or]The X/Y pyx still lies here[stopping]. It wouldn't be too cumbersome to take.". indefinite article of X Y Pyx is "an".

check examining pyx when player is in Dirge Grid: say "You're sort of off the map, here, and you'll continue to be until you [unless Diktat Kid is moot]defeat the Diktat Kid and [end if]return south." instead;

does the player mean useoning pyx with: it is unlikely.
does the player mean useoning with pyx: it is unlikely.

understand "map" and "xy" and "xy pyx" as pyx when Yawn Way is visited.

report taking pyx when screenread is true:
	say "Taken, with the caveat that it's not readable in screenread mode.";

screenwarn is a truth state that varies.

report screening when player has pyx and screenread is true and screenwarn is false:
	now screenwarn is true;
	say "[i][bracket]NOTE: this makes the X/Y Pyx you're carrying useless, since it relies on text images that play poorly with a screen reader. The [b]THINK[r] command, however, can show you where you want or need to go.[close bracket][r]";

does the player mean doing something with pyx when player has doodle or player has spa maps: it is unlikely.

check examining pyx when screenread is true:
	say "The large text map has a lot of special characters and doesn't play well with screen readers, so you can't examine it productively. Sorry. SCREEN or SCR toggles screen reader mode." instead;

to say pyx-x:
	say "[b]X X[r], [b]XX[r], [b]M[r] or [b]MAP[r]"

pyx-warn-yet is a truth state that varies.

after examining pyx:
	if pyx is not xed:
		say "Notes for the future[if screenread is true], if you turn screen reading off[end if]: [pyx-x] will examine the pyx, to save keystrokes.";
		if player does not have pyx:
			say "[line break]Also, you take the pyx for future reference, because it's lightweight enough.";
			now player has pyx;
	if screenread is false and pyx-warn-yet is false:
		say "[if pyx is not xed][line break]If your current room above looks slightly misaligned and you are playing in a web browser, you may wish to type [b]FF[r] to force/fix fonts.";
		now pyx-warn-yet is false;
	continue the action;

to decide whether eithervisit of (rm - a room) and (di - a direction):
	if the room di of rm is nowhere, no;
	if rm is visited, yes;
	if the room di of rm is visited, yes;
	no;

understand the command "m" as something new.
understand the command "mm" as something new.
understand the command "ma" as something new.
understand the command "map" as something new.
understand the command "xx" as something new.

understand "m" as xpyxing.
understand "mm" as xpyxing.
understand "ma" as xpyxing.
understand "map" as xpyxing.
understand "xx" as xpyxing.

xpyxing is an action applying to nothing.

carry out xpyxing:
	if Yawn Way is unvisited, say "You haven't found the map yet, so this map command doesn't work." instead;
	if pyx is in Yawn Way and player is not in Yawn Way, say "The Pyx is in Yawn Way, so you can't reference it right now." instead;
	if pyx is in DropOrd, say "You dropped the pyx when the [chase-person] started chasing you, but you remember it well enough...";
	try examining the pyx instead;

definition: a room (called rm) is wayout:
	if eithervisit of rm and north, no;
	if eithervisit of rm and west, no;
	if eithervisit of rm and south, no;
	if eithervisit of rm and east, no;
	yes;

definition: a room (called rm) is ungoable:
	unless Diktat Kid is moot, no;
	if rm is westpost or rm is eastpost, yes;
	if rm is eastcond and balm-LLP-yet is true, yes;
	if rm is westcond and felines are moot and bees-seen is true, yes;
	no;

to say fcs: if fixed-force is false, say "[first custom style]"

to say redstar: say "[fcs]*[fixed letter spacing]"

to say star-ast of (myr - a room) and (nu - a number):
	if nu is 2 and player is in myr:
		say "[redstar][redstar]";
	else if nu is 3 and loc-num of location of player - loc-num of myr is 10:
		say "[redstar][redstar]";
	else:
		say "  "

to say star-vert of (myr - a room) and (nu - a number):
	if room south of myr is nothing:
		if nu is 2 and player is in myr:
			say "[redstar]";
		else if nu is 3 and loc-num of location of player - loc-num of myr is 10:
			say "[redstar]";
		else:
			say " ";
	else if myr is unvisited and room south of myr is unvisited:
		say " ";
	else:
		say "|"

to write-top-bottom-edge:
	let temp be 0;
	let loc-rem be remainder after dividing loc-num of location of player by 10;
	say "[fixed letter spacing]";
	while temp < 7:
		if temp is loc-rem:
			say "[fcs]*****[fixed letter spacing]";
			break;
		increment temp;
		say "        ";

to say map-so-far:
	let lastnum be -1;
	let pyx-row be 0;
	let thru-once be false;
	let times-thru be 0;
	if loc-num of location of player < 10:
		write-top-bottom-edge;
		say "[line break]";
	say "[fixed letter spacing]";
	while pyx-row < 28 or times-thru < 2:
		increment pyx-row;
		choose row pyx-row in table of pyxloc;
		if times-thru > 1:
			say "[star-ast of rmname entry and times-thru][star-vert of rmname entry and times-thru][star-ast of rmname entry and times-thru][if remainder after dividing pyx-row by 7 > 0]   [else][end if]";
		else if loc-num of rmname entry <= lastnum:
			say "[if times-thru is 0]BAD##[else][rmname entry][end if]";
		else:
			say "[if player is in rmname entry][fcs][else][fixed letter spacing][end if][if rmname entry is ungoable]XXXXX[else if rmname entry is unvisited]?????[run paragraph on][else if times-thru is 0][uptxt entry][else][downtxt entry][end if][if player is in rmname entry][fixed letter spacing][end if]";
			say "[if times-thru is 0 and eithervisit of rmname entry and east]===[else if remainder after dividing pyx-row by 7 > 0]   [end if]";
		if the remainder after dividing pyx-row by 7 is 0:
			increment times-thru;
			say "[if pyx-row is 35 and times-thru > 1][run paragraph on][else][line break][end if]";
			if times-thru < 4:
				now pyx-row is pyx-row - 7;
			else:
				now times-thru is 0;
	if loc-num of location of player >= 40:
		say "[line break]";
		write-top-bottom-edge;
	say "[variable letter spacing]";

Table of User Styles (continued)
style name	justification	obliquity	indentation	first-line indentation	boldness	fixed width	relative size	glulx color
special-style-1	left-justified	no-obliquity	0	0	--	fixed-width-font	0	g-red

Table of Common Color Values (continued)
glulx color value	assigned number
g-red	16711680		[== $ff0000]

[this is organized from left to right, up to down. It doesn't have to be, but it's easier to visualize the map this way.]
table of pyxloc [xxpyx]
rmname	uptxt	downtxt
Lac Oft Focal	"L O[if lac-score is 2]LD[else]FT[end if]"	"[if lac-score is 2]L[else]F[end if]OCAL"
Sneer Greens	"[if Yuge Guy is moot]ET TU[else]SNEER[end if]"	"[if Yuge Guy is moot]BUTTE[else]GREEN[end if]"
Flu Gulf	" FLU "	"GULF "
Trapeze Part	"TRAPE"	"PART "
Evaded Ave	"EVADE"	"D [if Dave is moot]AVE[else]...[end if]"
Yell Alley	"YELL "	"ALLEY"
Pro Corp	"[if bald-lab]BALD[else] PRO[end if] "	"[if bald-lab]LAB [else]CORP[end if] "
Yack Cay	"[if Known Wonk is moot]ROOMY[else]YACK [end if]"	"[if Known Wonk is moot]MOOR[else] CAY[end if] "
Le Babel	" LE  "	"BABEL"
Cold Loc	"COLD "	" LOC "
Apse Spa	"APSE "	" SPA "
Art Xtra	"[if el doodle is moot]TRADE[else] ART [end if]"	"[if el doodle is moot] ART [else]XTRA [end if]"
Red Roses Order	" RED "	"ROSES"
Gross Org	"GROSS"	" ORG "
Swamp Maws	"SWAMP"	"MAWS "
Dumb Mud	"DUMB "	" MUD "
Seer Trees	"SEER "	"TREES"
Fun Enuf	" [if Diktat Kid is moot]NU [else]FUN[end if] "	"[if Diktat Kid is moot] FUN[else]ENUF[end if] "
Yawn Way	"YAWN "	" WAY "
Emo Dome	"[if Diktat Kid is moot]DOME[else] EMO[end if] "	"[if Diktat Kid is moot] MOD[else]DOME[end if] "
Toll Lot	"TOLL "	" LOT "
Uneven U	"UN[if balsa slab is off-stage]EVE[else]ITI[end if]"	" N U "
Mont Nom	"MONT "	" NOM "
Ooze Zoo	"OOZE "	" ZOO "
Worn Row	"WOR[if Worn Row is wordy]D[else if Worn Row is worky]K[else]N[end if] "	" ROW "
My Gym	" MY  "	" GYM "
Swept Pews	"SWEPT"	"PEWS "
Deft Fed	"[if yob attaboy is moot]BON [else]DEFT[end if] "	"[if yob attaboy is moot]SNOB[else] FED[end if] "
Lair Trial	"[if ergot ogre is moot]STRID[else]LAIR [end if]"	"[if ergot ogre is moot]DIRTS[else]TRIAL[end if]"
Motto Bottom	"MOTTO"	"BOTTO"
Frush Surf	"FRUSH"	"SURF "
Moo Room	" MOO "	"ROOM "
Dopy Pod	"DOPY "	" POD "
Drawl Ward	"DRAWL"	"WARD "
Scrap Arcs	"SCRAP"	"ARCS "

chapter ffing

ffing is an action out of world.

understand the command "ff" as something new.
understand the command "fff" as something new.

understand "ff" as ffing.
understand "fff" as ffing.

fixed-force is a truth state that varies.

carry out ffing:
	now fixed-force is whether or not fixed-force is false;
	say "Forcing fixed font for the map in web browsers is now [on-off of fixed-force][if screenread is true], though this doesn't immediately apply with screen reader mode on[end if].";
	the rule succeeds;

chapter Name ME Man

to decide whether phonebook-near:
	if player is in Yawn Way, yes;
	if player is in Seer Trees and Oh Who is in Seer Trees, yes;
	no;

instead of taking a phonebook, say "That would weigh you down too pointlessly[if player has sto lots], even with your Sto['] Lots[end if]."

does the player mean doing something with Name ME Man when player is in Yawn Way:
	if the player's command includes "man", it is likely;
	if the player's command includes "me", it is unlikely;
	if current action is taking, it is very unlikely;
	it is likely;

does the player mean useoning with Name ME Man: it is unlikely.

Name ME Man is a peripheral phonebook in Yawn Way. description is "[one of]It's really just a phone book. You read several[or]You read several more[stopping] names and numbers of Yelpley residents from Name ME Man, even though you have no phone to call them with:[line break][name-num of 5 and Name ME Man][variable letter spacing][run paragraph on]". "[one of]There's also something called Name ME Man, which, with a cursory glance, seems to be just a glorified phone book. Yawn[or]Name ME Man waits for your perusal, if you have a great need to procrastinate[if Name ME Man is xed] some more[end if][stopping].". booktable of Name ME Man is table of random palindrome lastfirst names.

understand "nm/mm/nmm/phone/book" and "phone book" as Name ME Man.

to say name-num of (n - a number) and (ph - a phonebook):
	let numrow be number of rows in booktable of ph;
	say "[fixed letter spacing]EL TITLE         MUNICI-NUM[line break]";
[	if debug-state is true, say "Curseed [curseed of ph] initseed [initseed of ph].";]
	repeat with x running from 1 to n:
		increment curseed of ph;
		choose row curseed of ph in booktable of ph;
		say "[randtxt entry]: ";
		let A be number of characters in "[randtxt entry]";
		if A < 16:
			repeat with AA running from A to 15:
				say " ";
		say "[phone-number of curseed of ph + initseed of ph][line break]";
		if curseed of ph is numrow:
			say "[variable letter spacing]That's the end!";
			now curseed of ph is 0;
			continue the action;

after examining Oh Who for the first time:
	if debug-state is true, say "DEBUG Seed = [initseed of Oh Who].";
	continue the action;

after examining Name ME Man for the first time:
	if debug-state is true, say "DEBUG Seed = [initseed of Name ME Man].";
	say "(If you want, you can abbreviate Name ME Man as [b]NM[r] or [b]MM[r] or even [b]NMM[r].)[paragraph break]";
	continue the action;

nevev is a truth state that varies.

after examining a phonebook:
	if nevev is false:
		if initseed of Oh Who + initseed of Name ME Man is 8:
			now nevev is true;
			say "[line break]Perusing the names, you mumble 'Never even. Never even.'";
	continue the action;

prime-constant is a number that varies. prime-constant is 7993.

to say phone-number of (x - a number): [this takes the multiplicative inverse of x mod 7993 and adds 2000 to get abcd, then converts to abc-dcba.]
	let x2 be 1;
	let x1 be x;
	[say "([x] [x2])";]
	while x1 > 1:
		let Y be (prime-constant / x1) + 1;
		now x1 is the remainder after dividing x1 * y by prime-constant;
		now x2 is the remainder after dividing x2 * y by prime-constant;
		[say "([y] [x] [x2])";]
	now x2 is x2 + 2000; [phone # can't start with 1]
	say "[x2 / 10]-[remainder after dividing x2 by 10][remainder after dividing x2 / 10 by 10][remainder after dividing x2 / 100 by 10][x2 / 1000]"

chapter puffuping

puffuping is an action applying to nothing.

understand the command "puffup" as something new.
understand the command "puff up" as something new.

understand "puffup" as puffuping.
understand "puff up" as puffuping.

puffed-up is a truth state that varies.
puffup-clue is a truth state that varies.

to say stop-emo-dome: if Emo Dome is visited, say " to stop in the Emo Dome"

carry out puffuping:
	if puffed-up is true, say "You already did, [if spur ups are moot]and with the spur ups gone, you can't, any more[else]but maybe you can do something else UP[stop-emo-dome][end if]." instead;
	let puff-put be whether or not word number 1 in the player's command is "puff";
	if player does not have spur ups:
		now puffup-clue is true;
		say "You don't possess anything that would help you feel more up." instead;
	if player is not in Yawn Way:
		now puffup-clue is true;
		say "Maybe not here. There's nothing angst-inducing nearby.";
	say "As you hold the Spur-Ups, you think about how great you are and can and will be and how you won't let anything small get in the way of where you want to go. Surprisingly, you feel a charge from them. It works! But as it does, one of the Spur-Ups corrodes to near-black.[paragraph break]Hardened! Rah![paragraph break]You feel more confident, more able to deal with sadness now.[paragraph break]Plus you have an idea for a motivational gizmo that could make you millions. A Round Tuitt? So yesterday! The Gratz-Targ has to work! It's all so intuitive, you don't bother to write it down, but after a few minutes daydreaming what you will do with too much money, you forget the idea. Eh, well. There's still Yelpley and Grebeberg to save.";
	now puffed-up is true;
	score-inc; [Yelpley/puff up]
	the rule succeeds;

book My Gym

My Gym is south of Yawn Way. It is in Yelpley. "[if Dave is moot]Now Dave's gone and you looted the sto(le) lots, there's not much to do here. [end if]You can go back out north to Yawn Way. There's also a way west[if Worn Row is visited] to [Worn Row][else if Dave is in My Gym], though you'll probably have to get rid of Dave to explore it[end if]. Or you can LISTEN to soak up 'energetic' beats. A large BUFF-U-B machine lies in the corner, useless for your goals in this game."

chapter Dave

Dave is a proper-named guhthug in My Gym. initial appearance is "[one of]A fellow walks over to you and booms 'DAVE!' You freeze, and after a few seconds, he continues 'HUGE! GUH!'[or]Dave paces slowly here, keeping an eye on you, guarding the passage west.[stopping]". description is "Dave is big and strong--quite a musc(ilic)-sum, but maybe too beefy to be fully mobile. Maybe you can take advantage of that."

instead of doing something with Dave:
	if action is pro-and-use, continue the action;
	if current action is evadeing, continue the action;
	say "Looks like you'll need to do something special with, or to, Dave. Nothing destructive. But psych him out, somehow."

check going west in My Gym when Dave is in My Gym: say "Dave says, 'I can't let you do that, Hal. Ah!' Whether or not your name actually is Hal, you reason there must be a succinct, clever way to sneak around him." instead;

the stole lots is a thing in My Gym. "A container labeled STOLE LOTS is behind Dave.". description is "It looks like it'd be handy for carrying a lot of items around. Maybe it has something in it, but right now it looks closed.[paragraph break]You'd love to see what's inside, but Dave is guarding it.".

understand "container" as stole lots.

chapter wash saw

The wash saw is a thing. "A small wash saw [if Dave is moot]lies here[else]is behind Dave[end if].". description of wash saw is "How handy! It can squirt out cleaning fluid or whatever. Useful if something's stuck.".

check taking stole lots when Dave is quicknear: say "It's behind Dave, who booms 'BAR GRAB!' He's really in the way, here." instead;

section sawing

sawing is an action applying to one thing.

understand the command "saw" as something new.

understand "cut [something]" as sawing when player has wash saw.
understand "saw [something]" as sawing when player has wash saw.
understand "saw [something]" as cutting when player does not have wash saw.

check sawing:
	try useoning wash saw with noun instead;

instead of cutting: say "You don't have a cutting item. And while CUT or a few synonyms can be used as a verb, they're not necessary to solve the game."

chapter sto lots

the sto lots is a peripheral thing. description is "It helps you carry everything you have.".

understand "stole lots" and "stole" as sto lots when stole lots is moot.

chapter evadeing

evadeing is an action applying to one thing.

understand the command "evade" as something new.

understand "evade [something]" as evadeing.

does the player mean evadeing Dave: it is very likely.

carry out evadeing:
	if noun is Dave:
		if Dave is moot, say "You don't need to evade Dave again.";
		say "You evade Dave! Deked! Deked![paragraph break]After spinning fruitlessly around for a while and putting up with your 'E.g. dodge' and 'El Ole' taunts, Dave trudges off, exhausted, emitting a huge 'GUH!'[paragraph break]Whew! Consulting the Set O Notes[if Set O Notes is xed] again[end if], you notice there may be at least one more guh thug, but nothing too violent. That's good. You'd hate to have to TRUCK CURT, MASH SAM, RAM OMAR, SIT ON OTIS or even DISS SID. And it would be awkward to tell SAL ALAS.";
		wfak;
		say "Suspicious there are no actual weight machines, you find a passage to a hidden spate of Sperses-Reps machines with the motto 'Scepsis?! Pecs!' They help you bulk up a bit, so item weight will not be a factor. But you don't want to waste too much time bulking up. You go back out and have a look at the Stole-Lots. You consider making it a STORE-lots, but then the 'rots' is not so good, so then you also check if the E and an L rub out quickly. They do, making it a Sto(['])-Lots. Bam! Logistical and moral problems: SOLVED![paragraph break]Also, you notice a wash saw in the (now) Sto Lots. They both seem worth taking along, so you do.";
		moot Dave;
		now player has sto lots;
		moot stole lots;
		now player has wash saw;
		score-inc; [Yelpley/evade dave]
		consider the cap-beep rules for Dave;
		verify-done rev-evade-Dave rule;
	else:
		say "There's only one person you need to evade in this game.";
	the rule succeeds.

chapter Buff-U-B

the Buff-U-B is peripheral scenery in My Gym. printed name is "Buff-U-B". "The Buff-U-B is a complex machine that can, presumably, bulk up any of your muscle groups, not just the stomach ones like (presumably) an Ab Mamba."

understand "large/machine" and "large machine" as buff-u-b when the player is in My Gym.

understand "buff" and "buff u" and "buff u b" and "u b" and "b" as buff-u-b.

book Worn Row

Worn Row is west of My Gym. It is in Yelpley. "[if Worn Row is worky][what-machines][else if Worn Row is wordy][else]It's pretty empty here, [worn-scen][end if][wrow].[paragraph break][dab-notes]The only way out is back east."

to say wrow: if row-prog is 2, say ". You could also summon [if Worn Row is worky]Word[else]Work[end if] Row back if you wanted";

to say worn-scen:
	say "[if redness ender is in Worn Row]not counting a big lumpy Redness Ender that makes Worn Row feel even more worn[else]and with the redness ender gone, you might as well just change things back to Work Row or Word Row"

to say what-machines: say "[if test set is off-stage]A cold and sterile, but safe, place[else if test set is moot]Since you destroyed the test set, it's pretty empty here[else]It's more spacious here with the re*er machines destroyed[end if][if ever-workrow is true and Worn Row is wordy]. You could also summon Word Row back if you wanted[end if]"

to say dab-notes:
	if row-prog >= 3, continue the action;
	say "[if row-prog is 2]The bad dab splashed on the floor looks even more smudged than when you first saw it[else if row-prog is 1]The bad dab splashed on the floor looks smudged now you changed Worn Row[else]A bad dab is splashed on the floor, too, and it looks readable[end if]. "

printed name of Worn Row is "[if Worn Row is wordy]Word[else if Worn Row is worky]Work[else]Worn[end if] Row"

Worn Row can be worny, wordy or worky. Worn Row is worny.

understand "work row" and "work" as Worn Row when ever-workrow is true.
understand "word row" and "word" as Worn Row when ever-wordrow is true.

to decide whether in-work:
	if player is in Worn Row and Worn Row is worky, yes;
	no;

to decide whether in-word:
	if player is in Worn Row and Worn Row is wordy, yes;
	no;

chapter redness ender

the redness ender is semiperipheral scenery in Worn Row. description is "It also seems to double as a redness SENDER, as when you get close to look at it, an ominous red to-dot appears on your. You back off, and the to-dot vanishes.".

chapter tract cart

tract-trace is a truth state that varies.

to say tract-status:
	if relate taler is in Worn Row:
		say "[one of]A relate taler is now beside the tract cart. It looks like it has a better and more literary selection than the tract cart did, though you doubt you have time to read them all. Still, you inspired them all. Yay[or]The relate taler sits next to the tract cart that was useful for so long[stopping]";
	else:
		say "A tract cart is here, [if number of necessary books in Worn Row is 1]almost empty[else if number of necessary books in Worn Row is 0]holding no books[else]holding a few books[end if]"

definition: a book (called bo) is sober:
	if bo is DWELT LEWD, no;
	yes;

for printing a locale paragraph about a book (called bk):
	if bk is not mentioned:
		say "The tract cart contains [list of sober books in Worn Row][if DWELT LEWD is in Worn Row], with DWELT LEWD off to the side[end if][if number of sober books in Worn Row is 4]. They don't seem glued to the cart or anything[end if].";
		now all books are mentioned;

chapter Rob

Rob is a proper-named guhthug in Worn Row. "[one of]'Oh, hi! I'm Rob, it's pretty uninteresting here, so you'd sort of fit in, but I'm trying to make it better. So, bug off, okay?'[or]Rob is still here giving you the side-eye.[stopping]". description is "Rob sniffs and rolls his eyes as if he is too good for Worn Row."

every turn when player is in Worn Row and Rob is in Worn Row:
	say "Rob mumbles '[next-rand-txt of table of Rob droning]' before looking over to see if you're impressed.";

chapter bad dab

the bad dab is peripheral scenery in Worn Row. description is "[if Rob is in Worn Row]WORN ROW is written, somewhat dubiously[else if row-prog > 2]WOR* ROW is here, reminding you [Worn Row] can be switched around at will[else if row-prog > 0]WOR+ ROW is still here, a bit blotchier than when you opened [Worn Row]. Maybe there's still something more Worn Row could be[else]The bad dab spells out WOR- ROW. Maybe there's more here than just Worn Row[end if]."

understand "wor" and "wor row" as the bad dab when bad dab is quicknear.

check rubbing: #changed from instead rule
	if noun is bad dab, say "No. It looks like a clue." instead;
	say "[no-burt]." instead;

to say no-burt: say "There's no one named Burt or Babbur or Liwilbur anything like that in this game, so you don't have to rub anyone or anything. Plus, it might be a burdened rub anyway."

after examining bad dab:
	consider the cap-beep rules for the bad dab;
	continue the action;

chapter test set

The test set is a thing. "A test set lies here, looking convoluted and -- well, open to abuse.". description is "A mangled tin unit. You're not sure what it's good for, but now that you worked through all the machines, maybe you just need it to, well, try stuff before your final confrontation.".

does the player mean doing something with the test set: it is very likely.

check taking the test set: say "It's too unwieldy. But it has to be useful for something." instead;

understand "tin/unit" and "tin unit" as test set.

chapter boreing

boreing is an action applying to one thing.

understand the command "bore" as something new.

understand "bore [something]" as boreing.

does the player mean boreing Rob: it is very likely.

carry out boreing:
	if noun is not a person, say "You should try to bore people, not things." instead;
	if noun is not Rob, say "Wrong thing or person to bore." instead;
	say "You pull out your 'greatest' conversational hits from years gone by: stuff you now can't believe you thought would impress others. Stuff they subsequently castigated you for. Stuff you have trouble admitting is still kind of important to you, but you still don't know how to express it right. It's cathartic for you but not so fun for Rob.[paragraph break]Rob grabs his head and shakes it until he is unable to repress a huge 'GUH!' similar to Dave. He paces around, grinding out the 'N' in the bad dab, leaving it as WOR- ROW, before wandering off, perhaps to Ybor, mumbling how he is too hard core even for Dre Nerd and Nerd Ren.[paragraph break]As he leaves, you hear him yell 'SUDO X-ODUS!' before loud-whispering plans to submit your dismal social performance to Pizzazz-IP, Mock.com and/or Mock-OK.com.";
	boot-Rob;
	score-inc; [Yelpley/bore rob]
	consider the cap-beep rules for Rob;
	verify-done rev-bore-Rob rule;
	the rule succeeds.

to boot-Rob:
	moot Rob;
	move bad dab to Worn Row;

chapter workables

a workable is a kind of thing. a workable has a number called useleft. useleft of a workable is usually 3.

a workable has text called verb-abbrev.

check entering a workable: say "[if noun is workedout]It's not dangerous now it's broken, but it's not useful, either[else]You can't fit in the [noun], but things you carry can[end if]." instead;

understand "machine" and "machines" as a workable.

does the player mean doing something with a workedout workable: it is very unlikely.

check examining a workable:
	if noun is workedout, say "The [noun] is broken now, but you got good use out of it." instead;

after examining a workable: say "[if useleft of noun is 3]Oh, the word [printed name of item described in upper case] is printed on the front[else]Since you had success using [the item described], you feel more comfortable using it again[end if]."

the reifier is a workable. useleft is 3. understand "rei" as reifier. description is "The most esoteric of the three machines, but if you put something in it, maybe it could become something much better.". verb-abbrev is "REI".

the reviver is a workable. useleft is 3. understand "rev" as reviver. description of reviver is "It reads FIX IF OLD, LO! Sounds like beaten-up items could go here.". verb-abbrev is "REV".

the rotator is a workable. useleft is 3. understand "rot" as rotator. understand "ro" as rotator. description of rotator is "It is circular, like a washing machine. It can probably shake up items you can't. Maybe split them open to find neat things[if stinky knits are not moot]. Or, maybe, it could make something smell a bit nicer[end if].". verb-abbrev is "ROT".

rule for supplying a missing second noun when useoning:
	if noun is a workable:
		say "You need to USE something on the [noun]. Or you can just [b][verb-abbrev of noun][r] something, for shorthand.";
		reject the player's command;
	continue the action;

rule for printing a locale paragraph about a workable (called th):
	if th is not mentioned, say "The reifier, reviver and rotator sit here. [if number of workedout workables is 1]The [random workedout workable] is broken, though[else if number of workedout workables is 2]However, only the [random not workedout workable] is still usable[else]They all seem in pretty good shape[end if].";
	now reifier is mentioned;
	now reviver is mentioned;
	now rotator is mentioned;

to decide whether say-unless-speed:
	if deep-speeding is false or say-despite-speeding is true, yes;
	no;

to wear-down (w - a workable):
	decrement useleft of w;
	if w is workedout:
		if revving-over is false and deep-speeding is false:
			say "[line break]You watch as [the w] sputters and dies. [if number of workedout workables is 2]Oh dear. That's the second one down[else]Well, you got a lot of good use out of it, and hopefully you won't need any more[end if].";
		else if say-unless-speed:
			say "(BOOM! You took out the [w] in the process.)[line break]";
	if useleft of w is 1 and revving-over is false and deep-speeding is false, say "[line break]The [w] wheezes an emphatic 'FOOF.' Hopefully, you won't need to use it too much more.[line break]";
	if machuses is 0:
		hint-bump-worn;
		if deep-speeding is false and revving-over is false:
			say "[line break]With [the list of workables] all destroyed, Work Row shakes a bit more. The machines fall out from a wall, revealing something behind ... a test set. It's big and huge and you can't move it, but who knows what it'll be useful for later?";
		else:
			if say-unless-speed, say "(And that's all 3 machines in Word Row down. They are replaced with a test set.)[line break]";
		move test set to Worn Row;
		now all workables are in devreserved; [ic]
		[?? trivial coding stuff: how to moot all workables]
	else if can-implement-rr:
		if deep-speeding is false and revving-over is false:
			say "[line break]You've had enough experience twiddling the Work Row machines. You can now, if you wish, use a shortcut to try all the machines with [b]RR[r].";
			now rr-available is true;

to decide whether can-implement-rr:
	if rr-available is false and machuses <= 6, yes;
	no;

definition: a workable (called w) is workedout:
	if useleft of w is 0, yes;
	no;

to decide which number is machuses:
	let retval be 0;
	repeat with Q running through workables:
		increase retval by useleft of Q;
	decide on retval;

check switching on a workable, say "You need to USE something with [the noun]." instead;

check taking a workable, say "Too heavy. But you can USE something on it." instead;

the r-shortcut rules are an object-based rulebook.

an r-shortcut rule for a thing (called x):
	if x is moot, say "Alas, the [x] is destroyed." instead;
	if psi wisp is in Worn Row, say "[chase-pass]Not with the psi wisp around!" instead;
	if x is in TempMet:
		say "You need to bring back Work Row first. Do so?";
		if the player yes-consents:
			try workrowing;
		else:
			the rule succeeds;
	if wr-short-note is false, say "NOTE: you guessed one verb abbreviation to use on the [x], but for future reference, the other two are [if x is reifier][b]REV[r] and [b]ROT[r][else if x is reviver][b]REI[r] and [b]ROT[r][else][b]REI[r] and [b]REV[r][end if].";
	now wr-short-note is true;

section reiing

reiing is an action applying to one thing.

understand the command "rei" as something new.
understand the command "reify" as something new.

understand "rei [something]" as reiing when player is in Worn Row and reifier is not off-stage and ever-workrow is true.
understand "reify [something]" as reiing when player is in Worn Row and reifier is not off-stage and ever-workrow is true.

carry out reiing:
	follow the r-shortcut rules for the reifier;
	try useoning noun with reifier instead;

section reving

reving is an action applying to one thing.

understand the command "rev" as something new.
understand the command "revive" as something new.

understand "rev [something]" as reving when player is in Worn Row and reviver is not off-stage and ever-workrow is true.
understand "revive [something]" as reving when player is in Worn Row and reviver is not off-stage and ever-workrow is true.

carry out reving:
	follow the r-shortcut rules for the reviver;
	try useoning noun with reviver instead;

section roting

roting is an action applying to one thing.

understand the command "rot" as something new.
understand the command "rotate" as something new.

understand "rot [something]" as roting when player is in Worn Row and rotator is not off-stage and ever-workrow is true.
understand "rotate [something]" as roting when player is in Worn Row and rotator is not off-stage and ever-workrow is true.

carry out roting:
	follow the r-shortcut rules for the rotator;
	try useoning noun with rotator instead;

chapter books

to decide what number is books-in-cart:
	decide on number of sober books in Worn Row;

the tract cart is scenery. "'GREED-E? ERG!' is emblazoned on it, as a warning you should take only one book at a time. [if number of sober books in Worn Row is 0]You've looted it completely[else]It carries [books-in-cart] book[plur of books-in-cart]: [list of sober books in Worn Row][end if][hint-trace][one of]. It's not actually rideable, though. It just holds stuff[or][stopping]."

check taking the tract cart, say "It's not small enough to fit in your sto-lots, and it's not mobile, either." instead;

to say hint-trace:
	say "[if tract-trace is false]. But it also seems a bit too big for just carrying a few books. Maybe it holds a deeper secret[end if]"

check examining tract cart:
	if Diktat Kid is moot, say "The tract cart was useful, but the relate taler is more interesting." instead;
	unless any-books-left, say "It's empty now[hint-trace]. Maybe some day, someone will write a book like [next-rand-txt of table of altbooks]. Maybe it could be you! But you don't have the time to read right now, really." instead;

a book is a kind of thing. a book is usually proper-named.

does the player mean useoning a book with a NPCish person: it is very likely.

check examining a book:
	if description of noun is empty, say "It [if player carries the item described]is[else]looks[end if] really heavy and incomprehensible to you."

to decide which book is rand-book:
	let Q be a random carried book;
	decide on Q;

understand "book/books" as a book. [?? doesn't work long term]

does the player mean doing something with a carried book: it is likely.

rule for supplying a missing second noun when giving:
	if number of npcish people in location of player > 0:
		now noun is a random npcish person in location of player.

after examining a book:
	if noun is not DWELT LEWD, say "The author is [auth-name of noun].";
	continue the action;

to say auth-name of (mybk - a book):
	define-author mybk;
	choose row auth-row of mybk in table of random authors;
	say "[randtxt entry]";

a book can be in-row or hidden. a book is usually in-row.

a book can be necessary. a book is usually necessary.

a book can be return-after-chase. a book is usually not return-after-chase.

a book has a number called auth-row. auth-row of a book is usually 0.

auth-ind is a number that varies.

check examining a book (this is the assign a book to a random table rule):
	define-author noun;

to define-author (bk - a book):
	if auth-row of bk is 0:
		increment auth-ind;
		now auth-row of bk is auth-ind;

section relate taler

the relate taler is peripheral scenery. description is "With the tract cart gone, the relate taler has more artsy books left. One is [next-rand-txt of table of altbooks]."

chapter pity tip

the pity tip is a thing. description of pity tip is "[if DWELT LEWD is off-stage]'You can do something neat and completely unnecessary with the cart! There are only so many possibilities, of course.'[paragraph break]NOTE: document is[else]You figured what the tip about the tract cart was, but the tip is still[end if] good for free snack cans at Seedy Dee's."

after examining the pity tip for the first time:
	say "It doesn't seem like a very good tip, but if you got another, maybe they'd be spite tips that were actively wrong or misleading.";
	continue the action;

chapter books in bookcase

TI is a book. printed name of TI is "[i]TO IDIOT[r] (TI)". understand "to idiot" and "idiot" as ti. description is "It's full of hot takes and 'clever' put-downs based on assuming the recipient isn't as smart as they think they are. You remember laughing at this sort of thing when you were really bored or grouchy, and you sort of regret it now. Still, it keeps some people busy.". [Door Frood]

NULL ILLUN is a book. printed name of NULL ILLUN is "[i]NULL ILLUN[r] (NI)". understand "ni" as NULL ILLUN. description is "Surprisingly wise advice about how to achieve happiness and shake annoyances you can't dispel with just logic. It discusses how to flex your SCEPSIS-PECS so you don't just know a lot of stuff you aren't sure what to do with. It even advertises a not-yet-published companion book on emotional intelligence: SLANGISH SIGNALS.". [Known Wonk]

EPOCH COPE is a book. printed name of EPOCH COPE is "[i]EPOCH: COPE[r] (EC)". understand "ec" as EPOCH COPE. description is "All sorts of present-day political and social musings for shahs and other leaders, with the catch phrase '[']S civics!' It's surprisingly accessible, though you don't have time to read it.". [King Nik]

YOB ATTABOY is a book. printed name of YOB ATTABOY is "[i]YOB ATTABOY[r] (YA)". understand "ya" as YOB ATTABOY. description is "All about picking yourself up by your bootstraps and not feeling sorry for yourself or being too jealous of what others know or can do--SHED EH'S is repeated in big bold letters.". [Sniffins]

ti-to is a truth state that varies

after doing something with ti when ti-to is false:
	now ti-to is true;
	say "NOTE: referring to 'To Idiot' as 'to' gives the parser more problems than I was able to squash, so if you want to abbreviate it, you may wish to refer to it as TI.";
	continue the action;

section reading

reading is an action applying to one thing.

understand the command "read" as something new.

understand "read [something]" as reading.

definition: a thing (called th) is need-read:
	if th is off-stage or th is moot, no;
	if location of th is unvisited, no;
	repeat through table of readables:
		if th is read-cand entry:
			if read-yet entry is false, yes;
			if read-yet entry is true, no;
	no;

read-warn is a truth state that varies.

carry out reading:
	unless noun is Set O Notes and noun is nox:
		repeat through table of readables:
			if noun is read-cand entry, say "[read-msg entry][line break]" instead;
	if noun is a book:
		say "[if noun is DWELT LEWD]You read [one of]a bit[or]on[stopping], despite your better instincts...[else]Whoah! You don't have time to read all that text, right now. You're busy with much more active things. Still, you flip through for a general overview.[end if]";
	else if noun is a helpdoc:
		say "It's only a page long.";
	if read-warn is false, say "[bracket]Note: unless you're specifically informed otherwise, READ is functionally equivalent to X/EXAMINE, for books or non-books.[close bracket][paragraph break]";
	now read-warn is true;
	try examining the noun instead;
	the rule succeeds;

table of readables
read-cand	read-yet	read-msg
Spur Ups	false	"Hmm, that's interesting. Each has P, U and an asterisk in a triangle[if puffed-up is true], even the charred one."
Set O Notes	false	"You scrunch your eyes to read the random miscellany at the edges of the Set O Notes. Apparently, there can only be one questor, to avoid a partner-entrap. The Flee Elf also wrote in 'REP US SUPER' to motivate you.[paragraph break]Um, yeah. The Set O Notes's main page seems a lot more useful, describing your enemies and some of the scenery and all, but hey, it didn't hurt to read closer."
enact cane	false	"You squint carefully. KLENS'N ELK is written. But how would you restore the Enact Cane into something that could actually clean stuff? And who has something that needs cleaning?"
moor broom	false	"The moor broom still has the KLENS'N ELK written on it that the enact cane did."

section show-warning

the block showing rule is not listed in any rulebook.

show-warn is a truth state that varies.

instead of showing to:
	if show-warn is false, say "Note: SHOW x TO y is the equivalent of GIVE x TO y, which maps to USE x ON y.";
	now show-warn is true;
	try useoning noun with second noun;

chapter SOME DEMOS

there is a book called SOME DEMOS. printed name of SOME DEMOS is "SOME DEMOS (SD)". understand "sd" as SOME DEMOS. It is hidden. description is "It's a sort of life hacker book with a particular emphasis on having fun with making weird art out of common or even unsophisticated materials--hey, whatever makes you feel cool or neat--and not worrying too much about the quality of the result. Less concrete info than the books you've been schlepping out to others, but it's a fun read. Who knows? It might help you.".

does the player mean doing something with SOME DEMOS: it is unlikely.

gap-yet is a truth state that varies.

after examining a book:
	if gap-yet is false, say "You look for a page gap, and you're surprised there isn't one.";
	now gap-yet is true;
	continue the action;

chapter DWELT LEWD

DWELT LEWD is a proper-named not necessary hidden book. printed name of DWELT LEWD is "DWELT LEWD (DL)". understand "dl" as DWELT LEWD.

dwelt-first is a list of text variable. dwelt-first is { "Nell, Edna", "Leon", "Nedra", "Anita", "Rolf", "Nora", "Alice", "Carol", "Leo", "Jane", "Reed", "Dena" }.
dwelt-last is a list of text variable. dwelt-last is { "Ned", "Dee", "Rena", "Joel", "Lora", "Cecil", "Aaron", "Flora", "Tina", "Arden", "Noel", "and Ellen" }

lewd-chap is a number that varies. lewd-chap is 0.
lewd-read is a truth state that varies.

check examining DWELT LEWD: if lewd-chap is 1 and lewd-read is true, say "Another round? Sicko.[paragraph break]";

description of DWELT LEWD is "[lewd-details][run paragraph on]".

to say lewd-details:
	let lelt be number of entries in dwelt-first;
	if lelt is not number of entries in dwelt-last, say "(BUG mismatched text array sizes) "; [should never happen, but just in case]
	increment lewd-chap;
	say "[one of]It's by Liberty Trebil and Bernie Weinreb. [or][stopping]You read chapter [lewd-chap]: Dennis";
	repeat with X running from 1 to lewd-chap - 1:
		say ", [entry X of dwelt-first]";
	let temp be lewd-chap;
	let min be lelt + 2 - lewd-chap;
	repeat with X running from min to lelt:
		say "[if X is not lelt],[end if] [entry X of dwelt-last]";
	say " Sinned.";
	if lewd-chap is number of entries in dwelt-first + 1 and lewd-read is false:
		say "[line break]Whew! You've finished DWELT LEWD. Apparently there is 'related' material, including [next-rand-txt of table of trashy art]. [one of]Who thinks this junk up? (Hey, don't look that way at me! I just wrote the abstract code for the 'book' as a purely intellectual exercise.)[or]You feel guilty having looked for more desipte knowing better.[stopping]";
		decrement lewd-chap;
		now lewd-read is true;

to say lewd-true: now lewd-read is true; [this is for the tables code to signify we want to go back to reading DL]

check taking DWELT LEWD: say "No, you'd be embarrassed to be seen with it. It can't be useful anywhere. You hope not, anyway." instead;

chapter book verbs

books-carried-yet is a truth state that varies.

a thing has a number called take-order. the take-order of a thing is usually 1.

a thing has a number called eyespoil. eyespoil of a thing is usually 0.

take-order of DWELT LEWD is 2.

The book-sort rule is listed before the generate action rule in the turn sequence rules.

This is the book-sort rule:
	let L be the multiple object list;
	if the number of entries in L is greater than 1:
		sort L in take-order order;
		alter the multiple object list to L.

check taking a book:
	if number of entries in multiple object list > 1:
		let total-books be 0;
		repeat with J running through multiple object list:
			if J is a book, increment total-books;
		let firstbook be the noun;
		alter the multiple object list to { };
		add noun to multiple object list;
		if total-books > 1, say "(the only book you can take, as taking more than one big book at once would be awkward) ";
	if player has noun, continue the action;
	if books-carried-yet is false:
		say "Oof! a bit heavy and bulky, but after working out in My Gym, you can just about juggle it.";
		now books-carried-yet is true;
	else:
		if number of lugged books > 0:
			let myb be a random lugged book;
			say "[one of][noun] jams as you try to take it out. You hear a buzzing, and your eyes run across 'GREED-E? ERG' on the tract cart, and you flash back to that time you checked out too many library books and got a small fine when you couldn't finish them all.[paragraph break]Besides, nothing says 'adventure' less than schlepping around multiple books. Well, except maybe sitting in front of a computer playing some silly game. Or, far worse, programming one.[paragraph break][or][stopping]You put [myb] back in the tract cart before taking [noun].";
			now myb is in Worn Row;
		else:
			say "It's a bit unwieldy, but you manage to pick up [noun].";
	consider the book-took rule;
	now player has noun instead;

this is the book-took rule:
	if debug-state is true, say "DEBUG: Moot book list = [number of moot books] [list of moot books].";
	if number of moot books > 1 and SOME DEMOS is off-stage:
		say "As you pick up [noun], something else falls out. It's a smaller pamphlet, called SOME DEMOS. Might as well take it, too.";
		now player has SOME DEMOS;
		now SOME DEMOS is in-row;
		the rule succeeds;
	continue the action;

to decide what number is row-prog:
	if redness ender is moot, decide on 3;
	let ret be 0;
	if ever-workrow is true, increment ret;
	if ever-wordrow is true, increment ret;
	decide on ret;

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
understand the command "work row" as something new.

understand "work" and "work row" and "workrow" as workrowing when player is in Worn Row.

ever-workrow is a truth state that varies.

this is the wornrow-change rule:
	if Diktat Kid is moot, say "You're stuck with Word Row, which is really more pleasant than the alternatives." instead;
	if Rob is in Worn Row, say "That'll work when Rob is gone." instead;
	if Psi Wisp is in Worn Row, say "[chase-pass]Right idea, wrong room to change to." instead;
	continue the action;

carry out workrowing:
	if Worn Row is worky, say "You're already in Work Row." instead;
	abide by the wornrow-change rule;
	notify-row-change;
	if ever-workrow is false:
		say "[Worn Row] shakes, and with a [i]MAL[r] 'Blam' and clicks and whirs, you watch as the [if ever-wordrow is true]tract cart[else]redness ender[end if] retreats into the wall, maybe for later. After more whirring, three machines pop out of another wall. One looks particularly odd, another is spinning like a washer or dryer, and the third--well, it looks like one of those cryogenic things to store frozen bodies for resurrection. A quick glance shows they labeled ROTATOR, REIFIER and REVIVER, in that order.";
		score-inc; [Yelpley/work row]
		verify-done rev-work-row rule;
	else:
		say "[line break][if test set is off-stage]The reifier, reviver and rotator reappear[else if test set is in Worn Row]The test set re-appears[else]Work row is still barren, though,, now you destroyed everything here[end if].";
	work-row-open;
	check-dab;
	the rule succeeds;

to work-row-open:
	clear-worn-row;
	now ever-workrow is true;
	now Worn Row is worky;
	if test set is off-stage, now all workables are in Worn Row;
	now all books in Worn Row are in TempMet;
	if redness ender is in Worn Row, now redness ender is in TempMet;
	if tract cart is in Worn Row, now tract cart is in TempMet;

to check-dab:
	if bad dab is in Worn Row:
		if row-prog > 2:
			say "[line break]The WOR* ROW text of the bad dab fades out of sight.";
		if row-prog > 1:
			say "[line break]The [one of]plus in WOR+ ROW bleeds into an asterisk[or]asterisk in WOR* ROW pulses a bit[stopping]. Odd.";
		else:
			say "The bad dab saying WOR- ROW morphs slightly into, well, WOR+ ROW. Maybe there's something else beside [Worn Row]."

chapter wordrowing

wordrowing is an action applying to nothing.

understand the command "wordrow" as something new.
understand the command "word row" as something new.

understand "word" and "word row" and "wordrow" as wordrowing when player is in Worn Row.

ever-wordrow is a truth state that varies.

definition: a book (called bo) is tractable:
	if bo is hidden, no;
	if bo is moot, no;
	if player carries bo, no;
	yes;

carry out wordrowing:
	if Worn Row is wordy, say "You're already in Word Row." instead;
	abide by the wornrow-change rule;
	notify-row-change;
	if ever-wordrow is false:
		hint-bump-worn;
		score-inc; [Yelpley/word row]
		verify-done rev-word-row rule;
		say "A tract cart appears, full of odd books. A pity tip also flutters down. You take the tip.";
	word-row-open;
	check-dab;
	the rule succeeds;

to notify-row-change:
	if Worn Row is wordy:
		say "You hear a whirring behind the wall as the tract cart sinks into it.";
	else if Worn Row is worky:
		say "[if test set is moot]Even though there's nothing to remove from Work Row any more, you still hear whirring[else if test set is in Worn Row]The wall whirs as the test set spins back in[else]The machines spin back into the wall with an efficient whirr[end if].";
	else:
		say "[if psi wisp is moot]The wall opens and retracts, even without any redness ender to hide.[else]The redness ender retracts. Who knows if you'll see it again?[end if]"

to word-row-open:
	clear-worn-row;
	now ever-wordrow is true;
	now all tractable books are in Worn Row;
	move tract cart to Worn Row;
	if pity tip is off-stage, now player has pity tip;
	now Worn Row is wordy;

chapter wornrowing

wornrowing is an action applying to nothing.

understand the command "wornrow" as something new.
understand the command "worn row" as something new.

understand "wornrow" and "worn" and "worn row" as wornrowing when player is in Worn Row.

worn-tried is a truth state that varies.

carry out wornrowing:
	if Diktat Kid is moot, say "No need to go that far back." instead;
	if psi wisp is moot, say "Now that the redness ender and Psi Wisp destroyed each other, Worn Row really holds nothing else for you." instead;
	unless ever-wordrow is true or ever-workrow is true, say "It is Worn Row. But maybe it can become something else." instead;
	if psi wisp is not in Worn Row:
		now worn-tried is true;
		say "[if ever-wordrow is false or ever-workrow is false]The bad dab seems to indicate there's more here than [Worn Row], and there's no reason you can't go back to Worn Row, but y[else]Y[end if]ou don't want to face the redness ender alone back in Worn Row. You're not very red, but it seemed like it might just shoot any old thing. That could be handy, if you were under attack." instead;
	clear-worn-row;
	say "A buzz and a whirr makes the Psi Wisp pause. The [if Worn Row is worky]machines snap[else]tract cart snaps[end if] back into a wall, and the redness ender pops out of another. It locks on the Psi Wisp, which is very red indeed. Zap! Zot! The Psi Wisp becomes even redder before exploding. As its last act, the Psi Wisp channels that energy back into the redness ender, which also explodes. Some of the debris drops onto the bad dab, wiping it out. And somehow, the walls whir some more and drop all the items you left near Pro Corp at your feet. You take them all. That saved a trip back, you think, until you remember Pro Corp held a couple things worth picking up anyway.";
	win-wisp-chase;
	check-dab;
	score-inc; [Yelpley/WORN ROW]
	the rule succeeds;

to win-wisp-chase:
	now being-chased is false;
	now chase-mulligan is false;
	verify-done rev-work-row rule;
	clear-worn-row;
	now Worn Row is worny;
	moot psi wisp;
	moot redness ender;
	moot bad dab;
	recover-items;

chapter mytraceing

mytraceing is an action applying to one thing.

understand the command "trace" as something new.

understand "trace [something]" as mytraceing.

carry out mytraceing:
	if noun is not tract cart, say "That's not something to trace." instead;
	if DWELT LEWD is not off-stage, say "Nothing new turns up." instead;
	say "Yes, something about the tract cart seems off. There's a bit more space than the books would need...while fiddling with the cart, a new book pops out. It's called DWELT LEWD. You can imagine why it was hidden. Nothing's forcing you to read it, and it's probably not critical, but there it is[if player has pity tip]. You glance at the pity tip--it looks like it still has some advice beyond looking into the tract cart[end if].";
	abide by the LLP rule; [TRACE CART]
	now DWELT LEWD is in Worn Row;
	now DWELT LEWD is in-row;
	now tract-trace is true;
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

chapter trap art

some trap art is a singular-named thing in Art Xtra. "Some trap art sits here. It's free. You might as well take it.". description is "The trap art depicts a bunch of nasty, dirty animals being trapped. It's not a real trap, but it seems like a realistic depiction.". the indefinite article of trap art is "some".

after taking trap art:
	shuffle-before Art Xtra and Yack Cay;
	continue the action;

chapter el doodle

after taking El Doodle:
	shuffle-before Art Xtra and Red Roses Order;
	if straw arts is not moot, say "The Revolt Lover lets you know that there's some other art, more powerful stuff, but ... they need to know that you have an artsy side, too, and you won't just be the new tyrant replacing the old tyrant, here.";
	continue the action;

El Doodle is a thing. description is "A jumble of raw creativity, it looks like it could be a map--or something--but it sure could use some paring down."

understand "map" as doodle when doodle is quicknear.

after looking in Art Xtra when El Doodle is off-stage:
	if stark rats are moot:
		say "You tell the Revolt Lover about how you got rid of the stark rats. The Revolt Lover, impressed, mentions there's something else for you. 'Someone left it here a while back. It's indecipherable. I can't use it, but maybe you can figure it out.' It's labeled El Doodle. You take it.";
		now player has El Doodle;
	continue the action;

chapter party trap

the party trap is a thing. description is "It looks roughly like the notes from the trap art, and when you read it you note it's more powerful than a MICE-DECIM. You just hope it works right when you USE it. That would be cool. I mean, if you used it on things that deserved it.".

report taking party trap:
	say "'Enjoy! if you can find some use for it, that'd be awesome!'";
	the rule succeeds;

section traping

traping is an action applying to one thing.

understand "trap [something]" as traping when player has party trap or player has trap art.

does the player mean traping the stark rats: it is very likely.

carry out traping:
	if player has trap art, try useoning trap art with noun instead;
	try useoning party trap with noun instead;

chapter Revolt Lover

the Revolt Lover is a neuter person in Art Xtra. "[if Art Xtra is unvisited]'Hi! I'm the Revolt Lover. Business is slow here, but I still have a few freebies, especially for someone with a cool cap like yours. If you're able to use them, I'd be willing to trade for more.'[else]The Revolt Lover [one of]smiles[or]nods[or]winks[at random] at you[lover-wisp].[end if]". description is "Artsy looking, but not pretentiously hipster-ish.".

to say lover-wisp: if being-chased is true, say ", apparently oblivious to the Psi Wisp chasing you"

chapter state tats

the state tats are a plural-named thing. description is "They say OMG MO['] and are bordered by roses, or..."

chapter soot tattoos

the soot tattoos are a plural-named thing. description is "They're blank now, but maybe if something cut them into the right shape, they could help your image, somehow. Maybe you could imprint something on them, to give them shape and texture."

understand "soot" and "soot tattoo" as soot tattoos.

instead of wearing soot tattoos, say "Right idea, but you need a way to press them onto your skin.";

does the player mean useoning soot tattoos with ME gem: it is very unlikely.
does the player mean useoning ME gem with: it is likely.
does the player mean useoning with ME gem: it is likely.

book Emo Dome

Emo Dome is east of Yawn Way. It is in Yelpley. "You can go any direction here, and you sort of want to, because it's stuffy in here, even if it smells nice. [can-go-rro]."

after looking in Emo Dome when pulled-up is false:
	say "You remember the Spur Ups and how they got you here. You just need to do, or be, up in one more way to be able to STAY here. You just sense it! Something similar to PUFF UP, but more permanent[if pullup-clue is true]! Something you may already have done[end if]!";
	the rule succeeds;

printed name of Emo Dome is "[if Diktat Kid is moot]Dome, Mod[else]Emo Dome[end if]"

understand "dome mod" and "mod" as Emo Dome when Diktat Kid is moot.

to say can-go-rro:
	if Red Roses Order is unvisited:
		say "Something labeling itself DIFF ID guards the way north";
	else:
		say "[if not-a-baton is off-stage]You feel you may still have unfinished business behind the DIFF ID to the north[else]The DIFF ID guards the Red Roses Order, which no longer holds adventure[end if]"

emo-dir-adj is a truth state that varies.

instead of doing something in Emo Dome when pulled-up is false:
	if current action is puffuping, say "That was then. The old tricks won't work. You need something new! Maybe very similar, but new." instead;
	if current action is pulluping, continue the action;
	if current action is thinking or requesting the score or aiding or sosing:
		say "You take a second to catch your breath.";
		continue the action;
	if current action is going:
		if noun is not west and noun is not east:
			say "You're scared whatever's [if noun is north or noun is south][noun][else]that way[end if] would be even worse. You keep running [emo-dir] instead. You managed to PUFF UP to face your fears, but that only goes so far.";
			now emo-dir-adj is true;
			try going emo-dir instead;
		if emo-dir-adj is false, say "You run [if noun is emo-dir][noun] with extra speed[else if noun is opposite of emo-dir]further [emo-dir] instead[end if].[paragraph break]";
		now emo-dir-adj is false;
		continue the action;
	if current action is taking or current action is dropping:
		say "Possessions! What do they matter? Why does anything matter? In your current state, you can't be bothered to take the cup. Or even litter.[paragraph break]";
	say "You keep running [emo-dir], instead. Your Spur Ups let you PUFF UP, but now you're just running around too fast. You're not stable enough. You need to calm down, but it's hard to reconcile that with UP. You feel like you need something similar, yet different, to stay and face your fears here.";
	try going emo-dir instead;

emo-dir is a direction that varies. emo-dir is west.

check going to Emo Dome:
	if Spur Ups are off-stage, say "It's too whiny to the east! You're just too, well, down to deal with it, yet. You back out[if NULL ILLUN is xed or NULL ILLUN is carried]. Even [i]NULL ILLUN[r] didn't help. Maybe you need something more gut-level[end if]." instead;
	if puffed-up is false, say "The Spur Ups make you feel a bit less down, but not up enough to enter the Emo Dome. Having a talisman isn't enough. You'll need an action that can help you be UP." instead;
	if pulled-up is false:
		now emo-dir is noun;

check going south in Emo Dome when Diktat Kid is moot:
	say "The Swept Pews are closed for reconstruction. You've done all you could there." instead;

check going north in Emo Dome:
	say "[chase-pass]";
	if state tats are off-stage, say "The Red Roses Order is, like, double-intensity. Just the name leaves you pondering you probably aren't ready for it yet until you're, like, totally ready. Still, you try to pass by the DIFF-ID but hear a warn-raw voice: 'Dim ID! Go jog!'[paragraph break]You think, hang? Nah. Maybe you [if player has soot tattoos and player has gate tag]can hustle up an ID--a DIY ID, if you will--from your current possessions, though[else if player has soot tattoos or player has gate tag]could find something to help you get by[end if]." instead;
	if Bros' Orb is in Le Babel, say "The DIFF ID is silent, but you don't feel prepared enough to enter the Red Roses Order, yet. You don't need someone else, but you need something that makes you feel someone else is, well, there." instead;
	if Diktat Kid is moot, say "The Red Roses Order is being replaced by something more ... civic. The Teem-Civic Meet, to be precise. They're formulating something called Vogue-U-Gov, which will take more time than you can spend here, even with so many dynamos. Perhaps there should be a 'SLO POLS' sign." instead;
	if balsa slab is moot, say "With Ms. Ism defeated, the Teem-Civic Meet is going in full swing. They're throwing interesting ideas around, but you don't have anything to add. Lots of folks all 'Yep, ey?'[paragraph break]You've done all you could in the Red Roses Order." instead;
	say "You make sure your state tats are visible for scanning. They are accepted with a 'YA MAY!'.[paragraph break][if Ms Ism is in Red Roses Order]You step into what may be your final challenge in Yelpley...[else]Maybe there is something you can do with the sword rows.[end if]";

chapter DIFF ID

[?? if you have the tattoos and tried going north, we should check those cases]

the DIFF ID is semiperipheral scenery in Emo Dome. "You can't really look directly into it too much, but it seems like one of those scanners that could pop up a force field, or make a really annoying noise, if you tried to cross it. REBUFF-UBER is written on it, just to discourage anyone with any ideas of running through."

id-knows-tats is a truth state that varies.

after examining DIFF ID when player has state tats:
	now id-knows-tats is true;
	say "[one of]You see a red line across your state tats. The DIFF ID buzzes[or]The DIFF ID buzzes yet again as it crosses your state tats[stopping].";
	continue the action;

instead of talktoing DIFF ID: say "No response. Looks like you may need something to show it."

understand "rebuff/uber" and "rebuff uber" as DIFF ID.

chapter pulluping

pulled-up is a truth state that varies.

pulluping is an action applying to nothing.

understand the command "pull up" as something new.
understand the command "pullup" as something new.

understand "pull up" as pulluping.
understand "pullup" as pulluping.

pullup-clue is a truth state that varies.

carry out pulluping:
	if pulled-up is true, say "You already did." instead;
	if Spur Ups are off-stage:
		now pullup-clue is true;
		say "Maybe you can be or do that sort of up, later." instead;
	if player is in Emo Dome:
		say "You pull out your Spur Ups for a bit of extra confidence, and you manage to stop yourself. The whining isn't too bad. Yeah, you can hack it here. You ball your fists nice and tight ... so tight, the Spur Ups crumble and blow away. Well, they did their job.";
		now pulled-up is true;
		now pullup-clue is false;
		moot spur ups;
		score-inc; [Yelpley/pull up]
		the rule succeeds;
	now pullup-clue is true;
	say "This isn't the place, but maybe you could pull up [if Emo Dome is visited]in the Emo Dome[else]somewhere else[end if] where [if Toll Lot is visited]you felt[else]you'd feel compelled[end if] to run. First, you need to find a way to get confidence." instead;

chapter puce cup

The Puce Cup is a thing in Emo Dome. "Someone has left a puce cup here.". description is "It's, well, puce, and it seems sturdy enough. It's currently [if puce cup is empty]empty[else if puce cup is sappy]full of [sap-sirup] from the rift fir [hn-in of Cold Loc][else]full of Dose Sod from the Apse Spa[end if]."

understand "dose/sod" and "dose sod" as Puce Cup when puce cup is soddy and player is not in Apse Spa.

to say sir-sap: say "[if player is in Cold Loc]sirup[else]sap[end if]".

to say sir-sap-long: say "[if player is in Cold Loc]purist sirup[else]past sap[end if]".

to say sap-sirup: say "[if location of player is Cold Loc]Past Sap[else]Purist Sirup[end if]"

report taking puce cup:
	say "Emo swag! Awesome!";
	the rule succeeds;

the puce cup can be empty, sappy or soddy. the puce cup is empty.

puce-ever is a truth state that varies.

understand "purist sirup" and "purist/sirup" as puce cup when puce cup is sappy and player is not in Cold Loc.

understand "dose sod" and "dose/sod" as puce cup when puce cup is soddy and player is not in Apse Spa.

after going from Cold Loc when puce cup is sappy:
	say "The past sap in the puce cup thaws into purist sirup.";
	continue the action;

after going to Cold Loc when puce cup is sappy:
	say "The purist sirup in the puce cup hardens [one of][or]back [stopping]into past sap.";
	continue the action;

section cup points

cup-nerf is a truth state that varies.

to no-extra-cup-points:
	if cup-nerf is true, continue the action;
	repeat through table of goodacts:
		if there is a use1 entry:
			if use1 entry is puce cup and there is a use2 entry:
				if use2 entry is dose sod or use2 entry is past sap, now sco entry is false;
	now cup-nerf is true;

book Toll Lot

Toll Lot is east of Emo Dome. It is in Yelpley. "[if cross orc is in Toll Lot]While it's easy enough to go back west to the Emo Dome, that cross orc doesn't seem to want to let you go north or south[else]You can go north or south with the cross orc gone or, well, back west, too[end if]. A crag arc rises to the east[if UFO tofu is off-stage]--maybe it is hiding something[end if]."

[??snuff funs]

after looking in Toll Lot when pulled-up is false:
	say "Oh no! You still feel emo, since that cross orc won't let you go anywhere. Probably just have to go back west. 'No fair! No fair!', you think, clutching your Spur Ups. Why couldn't it be enough to puff up? What else can you DO?";
	continue the action;

check going in Toll Lot:
	if Diktat Kid is moot:
		if noun is south, say "There's a party at the Bon Snob, and it's so exclusive, even you aren't invited!" instead;
		if noun is north and balm-LLP-yet is true, say "You already did a little extra in the Bald Lab. You figure it's best to keep away--you guess people probably thought Ms. Ism ruined it, and why fill them in on the truth?" instead;
	if cross orc is in Toll Lot:
		if noun is north or noun is south, say "The cross orc stops you from going [noun]. 'GIVE VIG!' it booms." instead;

chapter cross orc

The cross orc is a neuter person in Toll Lot. "A cross orc paces quickly back and forth between the north and south exits, just to reinforce that you'd better not try to go that way with it around.". description is "It paces quickly, rubbing its fingers together, mumbling to itself about the fabled moola loom and loot stool, or a possible bank nab or bar grab to afford a nice place on Fee Reef."

chapter crag arc

the crag arc is scenery in Toll Lot. "It soars high and is too dangerous to climb[if UFO tofu is off-stage]. It's intricate enough, it may be hiding something you can find--with the right tools[end if]."

chapter UFO tofu

some UFO tofu is a liquid ingredient. description is "It's a disturbingly squishy, yet impenetrable, block, with OF UFO scratched into one side, in case you forget where it came from.[paragraph break]Since it didn't fall apart when the UFOs dropped it on you, I guess it has enough preservatives it won't go bad too soon. I mean, more bad than tofu itself is.[paragraph break][if player is in Mont Nom]And yet, here on Mont Nom, it looks a lot better than when it dropped on you[else]It'd take a special place indeed to make this schlop more edible[end if]."

book Gross Org

Gross Org is north of Toll Lot. It is in Yelpley. description is "It's kind of musty in this north-south passage, [if etage gate is in Gross Org]though an etage gate blocks your way north[else]which bears no reminder of the etage gate that blocked the way north[end if]."

printed name of Gross Org is "[if stinky knits are not in Gross Org]Den, Evened[else]Gross Org[end if]".

take-after-deny is a truth state that varies.
check taking when player is in Gross Org and Ned is in Gross Org:
	now take-after-deny is true;
	say "Not with Ned around, you won't." instead;

the etage gate is scenery in Gross Org. "It is locked and too strong to force out of the way, but at least it's not a set-a-gates. It's engraved with...hmm, roses, or..."

understand "roses" and "roses or" as etage gate when etage gate is quicknear.
understand "roses" and "roses or" as gate tag when gate tag is quicknear.
understand "roses" and "roses or" as DIFF ID when DIFF ID is quicknear.
understand "roses" and "roses or" as state tats when state tats are quicknear.

instead of unlocking etage gate with Ye Key:
	if player has Ye Key, try useoning Ye Key with etage gate instead;
	try going north;

does the player mean unlocking etage gate with Ye Key: it is likely.

[instead of unlocking etage gate:
	try going north;]

chapter Ned

check going north in Gross Org: if etage gate is in Gross Org, say "The etage gate blocks you[if Ned is in Gross Org], and Ned would probably pull you back, too[end if]." instead;

understand "evened" and "den evened" as Gross Org when stinky knits are not in Gross Org.

Ned is a proper-named guhthug in Gross Org. "'Ned's Den!' someone booms. You're guessing their name must be Ned.". description is "Ned is sort of wildly flailing about, looking for a verbal or physical altercation, but that's not really your thing.".

chapter stinky knits

the stinky knits are a plural-named thing in Gross Org. description is "The inside of the stinky knits is tagged PE-YOO? YEP.". "Stinky knits, unwearable enough even without DAFT FAD printed on the front, lie here[if Ned is moot]. With Ned gone, you can probably just take them[end if].".

understand "daft/fad" and "daft fad" and "knit" and "stinky knit" as stinky knits.

check wearing the stinky knits: say "Wear a ...? Ew. That's physically possible, but no. No way. Not in their current state[if knits are not carried by the player]. You could take them, though[end if]." instead;

chapter Brag Garb

the brag garb is a thing. description is "You don't know fashion that well, but it's labeled STIFF FITS and is emblazoned with a BMOC Comb. It's more comfortable than the stinky knits, too. It smells of [if troll ort is moot]the troll ort you rubbed on it[else]something marketed as, but not really, attractive to humans--or other animals[end if]."

chapter Gate Tag

the Gate Tag is a thing. description is "It--well, it's perforated and jagged enough along the edges to cut out an outline of whatever it is. The pattern is roses, or..."

chapter denying

denying is an action applying to one thing.

understand the command "deny" as something new.

understand "deny [something]" as denying.

does the player mean denying Ned: it is likely.

carry out denying:
	if noun is Ned:
		say "Ned wants to get in an argument or fight, so you get in an argument over whether it's really necessary, and then you say, that wasn't so great, see? He slinks off, defeated.";
		if take-after-deny is true:
			say "Without Ned, it seems perfectly safe, if slightly unappealing, to take the stinky knits. So you do.";
			now player has stinky knits;
		moot Ned;
		score-inc; [Yelpley/deny Ned]
		consider the cap-beep rules for Ned;
	the rule succeeds;

book Deft Fed

Deft Fed is south of Toll Lot. It is in Yelpley. description is "There's not much decor in this [unless yob attaboy is moot]deli, tiled, except for a decal placed[else]fancy eatery, except for some snooty toons[end if]. You can exit to the north."

printed name of Deft Fed is "[if yob attaboy is moot]Bon Snob[else]Deft Fed[end if]".

understand "bon/snob" and "bon snob" as Deft Fed when Yob Attaboy is moot.

Sniffins-reintro is a truth state that varies.

after looking in Deft Fed when Sniffins-reintro is false and yob attaboy is moot:
	now Sniffins-reintro is true;
	say "Oh! Hi! Now that I'm a bit classier, I've given myself a new name that gives me ironic distance from my station in life. You can call me Smuggums, if you like.";
	continue the action;

chapter Sniffins

Sniffins is a neuter person in Deft Fed. "[if Deft Fed is unvisited]You hear a sniff, and the proprietor introduces themselves as Sniffins, apologizing for how lame the ambience and decor are, but there's just no INSPIRATION to do better[else][snismu] sniffs here[end if].". description is "[if yob attaboy is moot]Sniffins/Smuggums looks down at you despite your help--what a posh sop[else]Sniffins is despondent and pleading for any sort of help[end if]."

to say snismu: say "Sniffins[if Sniffins-reintro is true]/Smuggums[end if]"

understand "smuggums" as Sniffins when Sniffins-reintro is true.

chapter Dirt Rid

the Dirt Rid is a thing. description is "The Dirt Rid looks old and decrepit. Sniffins probably wore it out converting the Bon Snob, but it's yours now."

chapter cave vac

the cave vac is a thing. description is "It looks a lot more powerful than the Dirt Rid."

chapter Gorge Grog

some Gorge Grog is in Deft Fed. "Some Gorge Grog is here. It looks out of place in the Bon Snob, but Sniffins probably won't give it to you for free.". description is "Unsurprisingly, it is a product of Grog-Org. It's considerably more than four pruof. Err, foor proof."

check taking Gorge Grog when player does not have Gorge Grog: say "Sniffins chides you. 'It's worthless to us, but if there's anything tackier than bad alcohol, it's people who want to steal it!'[paragraph break]Maybe you could trade something for it." instead;

chapter Nat's Tan

Nat's Tan is a beepy thing in Deft Fed. "A container of something called Nat's Tan is here.". description is "Ugh! Given that it marks itself as Le Gel turning you orange with that Ol['] Glo, you're not sure you'd want that. Maybe there are some people or things much neater than you that would hate it even more. The NAT'S is disproportionately big compared to the 'tan' text.".

check taking nat's when nat's is in Deft Fed:
	say "Ugh! It feels too gross to take. Maybe you need to prepare yourself to feel less squeamish about taking it.";
	beep-if-vol Nat's Tan;
	the rule succeeds;

understand "nats/nat" and "nats/nat tan" as nat's tan.

chapter placed decal

the decal placed is peripheral scenery in Deft Fed. description is "It's an advertisement for LE FALAFEL and stir grits and, to wash them down, pop."

chapter snooty toons

The snooty toons are peripheral scenery. "They certainly add ambience to the place. You're not sure whether you should feel obliged to laugh at them or not good enough to laugh at them. But they're not really hurting you, you guess. And they advertise the food here under text labeled UNE MENU. One item: [next-rand-txt of table of snooty toon ads]."

chapter standing

standing is an action applying to one thing.

understand the command "stand" as something new.

understand "stand [something]" as standing.

carry out standing:
	if player has Nat's Tan, say "You already did. And you still do. Barely. Best not do anything to upset that." instead;
	if noun is Nat's Tan:
		if the player's command does not include "nats":
			say "[the player's command]: I'm going to be super pedantic and make you say it palindromically, but yes, that's the basic idea." instead;
		say "It's tough, but you manage to stand the icky Nat's Tan enough to pick it up--it's for the good of your adventure. Maybe you can dump it on someone or something who finds it even ickier than you do.";
		score-inc; [Yelpley/stand nat's]
		now player has Nat's Tan;
		now Nat's Tan is ordinary;
	the rule succeeds.

book Evaded Ave

Evaded Ave is north of Art Xtra. It is in Yelpley. "It's a bit sleazy in here. Passages lead east and west, [if tube but is in Evaded Ave]and north there's a tube, but ... [tbut][else]but the way north is blocked[end if]. You can go back south to [Art Xtra], too."

understand "evade" and "evade ave" as evaded ave.

dumb-Dave-joke-yet is a truth state that varies.

after looking in Evaded Ave:
	if Dave is moot and dumb-Dave-joke-yet is false and Door Frood is not moot:
		now dumb-Dave-joke-yet is true;
		say "You look around spacily for a minute, wondering if Dave fled here. Whew! He's somewhere else.";
		continue the action;

the Door Frood is a neuter person in Evaded Ave. "[one of]Someone waving their fists and shouting at who-knows-what pauses as you walk by. 'I'm the Door Frood. Not, like, a physical door, but a doorperson.' They say you MIGHT deserve to visit west or east, but -- a clever gift would be appreciated[or]The Door Frood continues to pace back and forth here, making sure you don't sneak off any way but back south[stopping].". description is "Probably not angry enough to actually do anything besides block others from doing what they want."

after examining the Door Frood for the first time:
	say "Seeing the Door Frood, you think to yourself: 'Hoopy? Pooh!'";
	continue the action;

check going in Evaded Ave:
	if Door Frood is in Evaded Ave:
		if noun is west or noun is east, say "The Door Frood blocks you. 'Look, I'd like something cleverer to do than stop you from going where you want, but I don't HAVE anything. Yet.'[paragraph break]Maybe if you gave the Frood something to stay occupied, they'd ignore you." instead;
		if noun is north, say "The Door Frood would enjoy laughing at you for running into a wall, but you might not join in." instead;

chapter bunk nub

the bunk nub is a thing in Evaded Ave. "A small bunk nub lies [if Door Frood is in Evaded Ave]behind the Door Frood[else]around for the taking[end if].". description is "It's small, so an actual person couldn't sleep on it. Perhaps it was once part of a larger debt bed. It reads, ironically, NOO COCOON. It looks very old and beaten-up and uncomfortable, though of course you're too big to test that for yourself."

understand "noo/cocoon" and "noo cocoon" as bunk nub.

check taking bunk nub: if Door Frood is in Evaded Ave, say "The Door Frood blocks you. 'Hey! That's mine. It's worthless to me, but it's the principle, here. But maybe if you got me something interesting...'" instead;

the stock cots are a plural-named thing. description is "The stock cots are cut cleverly from the remains of the bunk nub. They'll make a great place to sleep for any number of small animals."

understand "cot" as stock cots.

chapter tube but

the tube but is peripheral scenery. "It's dark enough to make you think, 'Grue! Urg!' [if tube-try is true]You don't see where it leads. It bends out of sight, but then, you probably don't want to see the Door Frood again[else]You already know it's a dead end. Not worth a re-try[end if]."

check entering tube but: try going north instead;

tube-try is a truth state that varies.

to say tbut: say "[if tube-try is false]you can't see where it goes[else]you already tried to follow the Door Frood, and nothing good happened[end if]"

check going north in Evaded Ave:
	if tube but is in Evaded Ave:
		say "[if tube-try is true]The rood-y door behind the tube seemed extra fortified. Plus[else]You try to follow the Door Frood and enter the tube, but ... you hit your head on a rood-y door (which you maybe should've expected) in the passage as the tube turns. You hear the Door Frood say 'TUBE REBUT' and laugh. At you or [i]TO IDIOT[r], you don't know. Eh, well[end if], you really don't want to see the Door Frood again.";
		now tube-try is true instead;
	say "The Door Frood chuckles a bit. Why would you run into a wall?" instead;

book Trapeze Part

Trapeze Part is west of Evaded Ave. It is in Yelpley. "[if epicer recipe is off-stage]There's a ten level net on the floor, here. It could protect you from a long fall. You're convinced there must be something at the far end, but it's probably not safe to use the trapeze to get over until, well, you've done safety checks[else]The ten level net still sits here, and it'd be handy if there was anything else on the other side of it, but there isn't[end if]. A large e-pipe blocks you from going anywhere except back east."

check going nowhere in Trapeze Part: say "The e-pipe is not only shaped like an e, but it's positioned so you're pretty much forced to go back e. Err, east." instead;

chapter e pipe

the e-pipe is peripheral scenery in Trapeze Part. "The e-pipe is cylindrical and too slippery to climb, and the middle prong of the e is far shorter than the other two."

understand "pipe" and "e pipe" as e-pipe.

chapter ten level net

the ten level net is beepy scenery in Trapeze Part. "[if epicer recipe is off-stage]It doesn't quite look sturdy enough. Maybe you could do something to fix it. For all its seeming complexity, it's really just a net, and you probably don't need any crazy tool to make sure it's safe[else]It was sturdy enough to help you get the epicer recipe, and that's enough[end if]."

rule for deciding whether all includes level net when taking: it does;

check taking the level net: say "But then you couldn't get across it without serious risk!" instead;

chapter tent net

the tent net is a thing. description is "It's tagged as a 'Tent o['] Dot Net,' which seems to be overdoing the trendy-to-techies angle, but at least it's not advertised as a Net, Torn, Rotten.[paragraph break]Though it can't make a structure on its own, it could probably let just the right amount of light in a home that needs a roof."

does the player mean taking the tent net when the player is in Trapeze Part: it is unlikely.

chapter epicer recipe

the epicer recipe is a helpdoc. description is "[one of]You've seen recipes before, but this is a big interesting one, written by E-Z Amaze corp! It's got instructions, not just for building some tike kit, but a north-tron, which can blast through anything ... including the [kaoscaps]! But first there's a list of parts[or]You focus on the parts to build the north-tron[stopping].[paragraph break][tronpartlist][run paragraph on]". importancy of the epicer recipe is 3.

after examining epicer recipe:
	if tron-got is 4, say "Well, You've got everything[hint-tron].";
	continue the action;

to say tronpartlist:
	repeat with tp running through tronparts:
		say "--[tp][if player has tp or tp is in Fun Enuf] (got it!)[else][line break][end if]"

chapter tending

tending is an action applying to one thing.

understand the command "tend" as something new.

understand "tend [something]" as tending.

carry out tending:
	if noun is not level net, say "That doesn't need tending." instead;
	if player has epicer recipe, say "You already did what you needed with the net." instead;
	say "You adjust the ten level net. You're not sure how to make it work, but what with the palindromes you've seen thus far, you keep it symmetrical, until it looks sturdy. You climb and swing from the trapeze to the other side--falling into the ten level net about a hundred or so times--but the hundred and first, BAM! You notice an epic-er recipe under some superfluous steno-nets.[paragraph break]A quick glance indicates it has much more detailed information than the set o['] notes. Yay! There's also something labeled an elope pole, which you suspect may help you get away if and when you need to. Part of the net falls off, too. It'd make a nice tent: a tent net. You gather up a nice haul: pole, net, recipe.";
	get-tended-stuff;
	score-inc; [Yelpley/TEND NET]
	verify-done rev-tend-net rule;
	the rule succeeds.

to get-tended-stuff:
	now player has elope pole;
	now player has tent net;
	now player has epicer recipe;
	now level net is ordinary;

chapter elope pole

The elope pole is a thing. description is "You wonder what wild places the elope pole could make you visit. It's not long enough to vault over anything, though.[paragraph break]While the elope pole looks like it could pull apart, you wouldn't want to do so until you saw somewhere to go and had a way to get there. Then you could USE it."

book Yell Alley

Yell Alley is east of Evaded Ave. It is in Yelpley. "[if Line Nil is in Yell Alley]Line Nil security blocks every way except back[else]The only way back is[end if] west[if bomb mob is not moot]. The way east is blocked by a [alley-e-block] where the yelling is from[end if][if navy van is not moot]. Maybe if you got rid of the navy van, you could find out[end if]."

to say alley-e-block:
	say "[if navy van is in Yell Alley]navy van... you're not sure[else]bomb mob... so that's[end if]"

check going nowhere in Yell Alley: say "[if navy van is in Yell Alley]It probably gets even seedier behind the navy van[else if bomb mob is in Yell Alley]It probably gets even seedier behind the bomb mob. Best just to go back west[else]Trust me. The Line Nil is protecting you from the perils of No-Trekker-Ton and Dart-strad. You don't want to visit No-Trekker-Ton or Dart-strad[end if]." instead;

chapter navy van

the navy van is scenery in Yell Alley. "There seems to be no way to enter it. It is labeled SEEDY DEE'S and has a small eye you could USE something on to scan it."

after examining the navy van for the first time, say "You worry a second too late it may be a no-gawk wagon. But nothing happens. Whew!"

understand "seedy/dee/dees" and "seedy dee/dees" as navy van.

section eye

the eye is part of the navy van. description is "It looks electronic and (unsurprisingly) symmetrically spherical. Perhaps you could USE something on it."

instead of putting something on the eye: try useoning noun with eye;
instead of putting something on the navy van: try useoning noun with navy van;

chapter snack cans

the snack cans are a plural-named solid ingredient. description is "They're labeled DEE FEED. You're not sure what's in them, but whatever it is--well, it seems almost as artificial as a nachoh can. You're not hungry enough. Yet.".

understand "snack can" and "can" as snack cans.

understand "dee feed" and "dee/feed" as snack cans.

chapter Mayo Yam

the Mayo Yam is a liquid ingredient in Yell Alley. "A gross looking -- something -- is here. It's a mayo yam! It's a bit on the slimy side, and it's probably worse inside.". description is "Fortunately, the mayo yam's skin is sturdy enough to avoid being burst and making a mess. But you can still smell the mayo inside it, and it's all globby on the outside. It doesn't look, well, muy yum."

chapter rep popper

the rep popper is a thing in Yell Alley. "A rep popper lies here. You're wary of getting too close to it. You're not sure how good your rep is, but that thing looks [if dork rod is moot]less fearsome than it used to[else]like it could embarrass you quickly[end if].". description is "The rep popper is a combination of a funny flower, joy buzzer, and several old stupid gags. You're not sure how it's supposed to work, and it's not something you carry around to show off how cool it is."

check taking rep popper:
	if player has dork rod, say "The dork rod vibrates as you get near the rep popper. You feel as though you could just about take the popper without worrying how dumb it was, if it didn't interact with the rod. How to get rid of it?" instead;
	if dork rod is not moot, say "No way! You're not sure how much rep you have, but taking that rep popper would drop it a notch or more, and the prospect seems too horrible. You need to find inner peace, somehow, somewhere." instead;
	now player has rep popper;
	say "[if player has taboo bat]With the taboo bat in your possession, you just don't care about stuff like rep, so you have no problem taking the rep popper[else]Now you've visited the Tao Boat with the dork rod, you aren't worried about your rep any more. You take the rep popper cautiously. Whew! No crazy explosion[end if]." instead;

[??Yuge Guy rep popper used what's wrong with you? I make boring people feel less boring vs you describing how you figured things out and only 26 possibilities really and also some trial and error]

report taking rep popper: say "Taken. As a shortcut, you can POP something instead of USE POPPER ON.";

section poping

poping is an action applying to one thing.

understand the command "pop" as something new.

understand "pop [something]" as poping when rep popper is quicknear.

instead of useoning:
	if noun is rep popper or second noun is rep popper:
		if player does not have rep popper, say "You need to get the rep popper before you can do anything with it." instead;
	continue the action;

carry out poping:
	if player does not have rep popper, say "You need to get the rep popper before you can do anything with it." instead;
	if noun is rep popper, say "That wouldn't gain you anything. You worked hard to get the rep popper." instead;
	try useoning noun with rep popper instead;

chapter bomb mob

the bomb mob are plural-named people. description is "They're ignoring you, and that's probably for the best.". "You're lucky the bomb mob is not looking your way, or you'd be in trouble. They seem to be guarding some TNT."

understand "poor troop" and "poor/troop" as bomb mob when DNA hand is moot.

TNT-test is a truth state that varies. [needs to be hear and not behind a "not for release" block]

instead of doing something with TNT when bomb mob has TNT:
	if TNT-test is true, continue the action;
	if current action is useoning, continue the action;
	if action is procedural, continue the action;
	say "[if player has epicer recipe]You need a sneaky way to get the TNT[else]You aren't sure what you'd want with the TNT, yet. Not worth risking the bomb mob[end if]." instead;

chapter TNT

the TNT is a tronpart. description is "From what you remember, TNT's molecular structure isn't symmetrical, but you don't suspect anyone's going to call you on this. Anyway, it's stacked together in one of those spiffy hexagons of cylinders with a stick in the middle, the kind that always explode in cartoons, so it has to be legit!". the bomb mob carries the TNT.

check taking TNT when bomb mob is quicknear: say "The bomb mob would say a bit more than 'Yank? Nay!' You'd be seen too easily." instead;

chapter Line Nil

Line Nil is peripheral scenery in Yell Alley. "It's a thin looking red line you're pretty sure you don't want to step over. Maybe somewhere there's a number keypad to disarm it, with a palindrome code of course, but not in this game."

book Red Roses Order

Red Roses Order is north of Emo Dome. It is in Yelpley. "[if Ms Ism is in Red Roses Order]The only visible way back is south, with a Mirror Rim blocking the other directions and seeming very threatening and oppressive indeed, but you can't chicken out[else]Sword rows have been revealed once the Mirror Rim dispersed. The E-Divide flickers and guards the way north where Ms. Ism left. You can go back south[end if]."

Red Roses Order is above Emo Dome.

chapter Mirror Rim

the Mirror Rim is scenery in Red Roses Order. "Looking in the Mirror Rim, you see ... well, you don't look terribly heroic. No wonder you were rejected for Raw Level War! In fact, you look kind of grouchy and upset. But it's not just that. You see and recall flaws you've forgotten, and you're pretty sure they're magnified beyond what they should be. But you feel half-obliged to keep looking at the Mirror Rim for an 'objective' amplification of all your tiny faults.[paragraph break]Oh, and the Pact Cap looks even sillier on you than you imagined it would. At least Ms. Ism has to see you wearing it!"

chapter sword rows

The sword rows are plural-named scenery. ."[if not-a-baton is moot]It doesn't look like you broke them, but you probably don't need them any more[else]The sword rows look automatic. Put something they can cut in, and get something out[end if]."

chapter not-a-baton

The not-a-baton is a thing. description is "It is wood and round and long. It's too long to be a baton, but it's the right shape to be something powerful. It just sort of feels lifeless right now."

understand "not/baton" and "not a/baton" and "not a baton" as not-a-baton.
[understand "not a baton" as not-a-baton]

chapter Ms Ism

Ms Ism is a proper-named female person in Red Roses Order. printed name of Ms Ism is "Ms. Ism". "[one of]Before you have time to gloat '[']N I'm In,' you see Ms. Ism standing[or]Ms. Ism stands[stopping] here in defiance, holding the Gal Flag high and waving it.". description is "She obviously didn't get to her position of power by being some over-educated pantsuited fool who made a small mistake with an e-mail server once.[paragraph break]As she waves that Gal Flag, you should probably be grateful she doesn't have a girl rig, too. You need a way to neutralize the Gal Flag!"

Ms Ism carries the Gal Flag. description of Gal Flag is "It's fluttering even without a breeze, and it reflects throughout the mirror rim to make you feel more than a little overwhelmed. On it are several images of Ms. Ism doing all kinds of superhuman things.". the Gal Flag is peripheral.

understand "la gal" and "la/gal" as Ms Ism.

check going south in Red Roses Order:
	if Ms Ism is in Red Roses Order, say "No way! You are locked in mortal combat! Plus, there's really only one thing to do, here." instead;
	if balsa slab is moot:
		say "You hear a crash behind you as the sword rows spin and wheeze from the exertion, then fall over. There's something ... no, some PEOPLE ... behind the wall. They introduce themselves as the Droll Lord and Madam. They thank you profusely: they were close to becoming the Dull Lud and Dame Mad back there![paragraph break]The crash behind the sword rows must've reverberated. As people stream in, Madam and the Droll Lord outline their plans for a more peaceful Yelpley, despite their differences. They discuss ways to avoid letting a Diktat Kid, Yuge Guy or Ms. Ism gain power again. 'We'd like you to stay, but we hear you have your own life to lead.' And they're right. You're not up to GOVERNING.[paragraph break]As you leave, you notice them scratching out the last bit calling this building the Red Roses Order, replacing it with TEEM-CIVIC MEET.[paragraph break]It's slightly forced, but it's the best there is, better than GRO-CIVIC ORG or EVA[']-CIVIC AVE and gets the point across. Hey, politics is the art of the possible, of the best realistic option.[paragraph break]You rub your State Tats off. You won't be needing them.";
		moot-tats-and-rows;
	else:
		say "You look back at the sword rows. Perhaps they will be useful."

to moot-tats-and-rows:
	moot state tats;
	moot sword rows;

check going in Red Roses Order:
	if noun is south, continue the action;
	if noun is north and Ms Ism is moot, say "Whether or not the E-Divide could damage you, you don't need to follow Ms. Ism. You need to take down the Diktat Kid!" instead;
	say "[if Ms Ism is moot]There are no secret passages [noun][else]There are more effective ways to shatter the mirror rim than running into it[end if]." instead;

chapter yard ray

the yard ray is a beepy thing. description is "It looks pretty lethal[if resale laser is not off-stage]--more powerful than the resale laser[end if].[paragraph break][yard-inst].[paragraph break]It's currently [if murdered rum is moot]loaded with energy from the murdered rum[else]out of of fuel[end if]."

to say yard-inst:
	if emitted is true:
		say "You figured you need to EMIT NOONTIME with it, so the instructions are useless";
	else:
		say "There are also instructions: EMIT [if screenread is true]8 question marks, presumably a word to fill out[else]????????[no line break][end if]"

does the player mean useoning with the Set O Notes: it is unlikely.

chapter E-Divide

the E Divide is peripheral scenery in Red Roses Order. "Ms. Ism crossed it, but you don't need to follow her. It would probably be dangerous. Besides, she probably caught a sub-level bus to go far, far away.". printed name of E Divide is "E-Divide". understand "e-divide" as e divide.

book Swept Pews

Swept Pews is south of Emo Dome. It is in Yelpley. "There is a wide passage back north to the Emo Dome in this tidy little area lacking a rat-ladened altar. It's unnamed but probably St. Emmet's. It's narrower south[if liar grail is moot], but with the liar grail and wordy drow gone, it should be no problem to go that way, either[end if]."

for printing a locale paragraph about a thing (called th) in Swept Pews:
	if th is the player:
		now the player is mentioned;
		continue the action;
	if th is wordy drow or th is liar grail:
		if th is not mentioned:
			say "A wordy drow is pinned to a liar grail here. Together, they block the way south.[paragraph break]";
			now wordy drow is mentioned;
			now liar grail is mentioned;
			now the player is mentioned;
	if th is troll ort:
		say "[initial appearance of troll ort][paragraph break]";
		now troll ort is mentioned;

understand "pew" and "swept pew" as swept pews.

check going south in Swept Pews: if Liar Grail in Swept Pews, say "'No yon! No yon!' moans the wordy drow, as the liar grail glows and fills your head with confusing arguments about how you don't need to go south, and even if you did, well, there's nobody interesting there, and even if there was, they'd have taken all the GOOD items, anyway." instead;

chapter liar grail

The Liar Grail is a thing in Swept Pews. description is "It's all sorts of shades of gray and carved inside with the phrase Y'R DRY, which is kind of odd, because it's a lot drier than you. But real live liars often accuse others of their deficiencies.[paragraph break]It's empty, but looking at it, you feel fogged by ambiguities and half-truths explicitly meant to sucker you because you sort of wanted to believe them, or you'd feel dumb not believing them if they were actually true, whether or not they sounded intuitive. Or maybe you'd even feel dumb admitting you believed such silly lies for so long.[paragraph break]Perhaps there is some way to make the liar grail's arguments so extreme they can be laughed off.". "A liar grail stands in your way to the south. It shouldn't be intimidating, given its lack of size, but it is."

check taking liar grail: say "A small voice cries 'Da cad! Da cad!' You probably don't want the liar grail corrupting you." instead;

every turn when player is in Swept Pews and wordy drow is in Swept Pews and wordy drow was in Swept Pews:
	say "A rum, rum murmur from the wordy drow: '[next-rand-txt of table of wordy drow laments]'[line break]";

chapter wordy drow

The wordy drow is a neuter person in Swept Pews. description is "Seemingly attached to the Liar Grail, looking sad and helpless--perhaps you can help release it from its self-pity and preaching.". "[one of]A[or]The[stopping] wordy drow moans admonishments and regrets here[one of]: '[if screenread is true]4 asterisks[else]****[end if]! WHY?!' it cries[or][stopping]. It blocks the way south." [yhwh but of course that is unspeakable in some mythologies]

chapter troll ort

the troll ort is an edible thing in Swept Pews. "A troll ort lies on the floor here. It's too dusty to eat, even without the five-second rule, but who knows where it might be useful.". description is "It doesn't look particularly edible to you. It appears crusted over. From what you know of trolls and such, neither they nor their food smell very good, so maybe it's best that the smell is covered, for now.[paragraph break]Weirdly, it has PINT-A-CATNIP carved on it."

report taking troll ort:
	say "It just LOOKS musty. You suspect the dust covers up some of its odor, and this may be a good thing, but at least it doesn't feel icky when you pick it up.";
	the rule succeeds

book Drawl Ward

[unicode 9524 ?? on some interpreters]
Drawl Ward is south of Swept Pews. It is in Yelpley. "This passage is a T (well, a _l_), walled off to the south by a birch crib. It looks homier to the west and a bit barren to the east, but you can always go back north through the Swept Pews."

check going in Drawl Ward:
	if Bond Nob is in Drawl Ward:
		if noun is west or noun is east, say "You hear the Bond Nob groaning and think it wouldn't be nice to pass by. They'll let you by once you help them with whatever sickness they have." instead;
	if noun is south, say "The birch crib is a private home, but you don't need to go there." instead;

rig-yet is a truth state that varies.

after looking in Drawl Ward:
	if rig-yet is false and player has radar:
		now rig-yet is true;
		say "You're just itching for the chance to try your snazzy new radar on something, anything. That girt rig looks like just the thing! However, when you do, nothing happens.";
	continue the action;

chapter Bond Nob

the Bond Nob is a neuter person in Drawl Ward. "[one of]'Hi! I'm the Bond Nob. I ain't feeling so good, but I wondered if maybe I could get some medicine.'[or]The Bond Nob continues to moan colloquially about the sickness, the pain.[stopping]". description is "The Bond Nob looks pretty ill. Nothing life-threatening, but too sick to go fetch even the dinkiest over-the-counter medication."

chapter Elan Ale

the Elan Ale is a drinkable thing. description is "It's labeled as CLASS Alc, unsurprisingly, unlike Red Ice Cider or Zoo Booz, clashs-alc people use to get drunk and rowdy. It's about the size of a pint nip."

chapter birch crib

the birch crib is peripheral scenery in Drawl Ward. "It's a crib in the slang sense, not the baby sense. It looks like a nice place to be, but you couldn't afford it[if player has cash sac], even with the cash sac[end if]. Plus there's no way in, and it's probably somebody's.[paragraph break]Stuff like YA SAY? and YO BOY and HOUSES U?! OH?! are scribbled in there so the Drawl Ward [if Bond Nob is in Drawl Ward]is still[else]would still be[end if] drawl-y with or without the Bond Nob."

instead of taking birch crib, say "It's a whole big house! Anyway, you couldn't do anything with a regular crib."

book Scrap Arcs

Scrap Arcs is east of Drawl Ward. It is in Yelpley. "A girt rig blocks passage every way except back west. Some slate metals are lying around here[if stamp mats are moot]--you've probably already used what you need[else], and if you needed to use a bit, nobody would notice[end if]."

understand "arc" and "scrap arc" as scrap arcs.

chapter girt rig

the girt rig is semiperipheral scenery in Scrap Arcs. description is "It is too sturdy and large to climb or break down or even walk around. I guess it has to be, to deal with all the scrap safely."

chapter slate metals

the slate metals are scenery in Scrap Arcs. "You could probably carve something out of them, with the right implement(s). Maybe not steel fleets--they seems a bit flimsy, which is probably why they wound up here. But something useful for a humbler and less violent task."

check taking slate metals:
	say "[if stamp mats are moot]You already made something from the slate metals[else]Youmight be able to use part of them to make something, but you couldn't carry ALL the metals, even with your Sto-Lots[end if]." instead;

understand "slate metal" and "metal" as slate metals.

chapter Ye Key

Ye Key is a thing. description is "Engraved YE KEY, it clearly looks important. It's carved with...well, roses, or ... you're not sure. Maybe it does not lead to Ye Fey or Ye Ley, but you haven't seen too many locked places, and its label also is a relief there aren't a whole bunch to chase down. You've been running around enough so far."

book Dopy Pod

Dopy Pod is west of Drawl Ward. It is in Yelpley. printed name of Dopy Pod is "[if cassettes sac is moot]Dope[else]Dopy[end if] Pod". "[if cassettes sac is moot]There's not much left here, but it was neat to get the radar. [else]It's kind of stuffy here. No Cav-HVAC or even a naff fan. There doesn't seem like there's much useful in here, but who knows? [end if]The only exit is back east."

understand "dope pod" and "dope" as Dopy Pod when cassettes sac is moot.

check going nowhere in Dopy Pod: say "Maybe there's a do-prefer pod somewhere, but it's off-limits to you." instead;

chapter cassettes sac

the cassettes sac is a semiperipheral thing in Dopy Pod. "A rather large cassettes sac sits here. It's too dirty to pick up.". description is "Phew! It's too dirty to look at too closely."

report taking cassettes sac: say "[whose-sac].";

to say whose-sac: say "You wonder who owned it before. Perhaps it was [one of]Cassini[or]Cassaza[in random order]'s Sac, though that doesn't really matter"

understand "casette/casete/cassette/cassetes sac" and "casette/casete/cassette/cassetes" as cassettes sac. [1 is technically not an anagram but it's a plausible misspelling, so we should allow it.]

after taking demo med:
	consider the bump-pod rule;
	continue the action;

chapter radar

to decide which number is radar-used:
	let temp be 0;
	if eroded ore is not off-stage, increment temp;
	if UFO tofu is not off-stage, increment temp;
	decide on temp;

the radar is a thing. description is "You're not sure of the deeper science, but it seems simple enough to USE it ON something (or just RAD something) when the time comes[if radar-used is 1] again, though it does seem slightly damaged[end if]."

The roto motor is a thing. description is "It's quite tiny and seems unaffected by how you caused the radar to go on the fritz. What could it animate, you wonder?"

chapter rading

rading is an action applying to one thing.

understand the command "rad" as something new.
understand the command "rdr" as something new.
understand the command "scan" as something new.

understand "rad [something]" as rading when radar is not off-stage.
understand "scan [something]" as rading when radar is not off-stage.
understand "rdr [something]" as rading when radar is not off-stage.

carry out rading:
	if radar is moot, say "The radar did all it could. Its usefulness [if player has roto motor]lives on in the Roto Motor[else if player has mr arm]lives on in Mr. Arm[else]netted you some swell TNT[end if].";
	try useoning radar with noun;
	the rule succeeds.

chapter Demo Med

a Demo Med is an edible thing in Dopy Pod. "The demo med that must not have worked for the Bond Nob sits here, on a pill lip.". description is "It appears to have a brand name that's scratched out: D--PE-S--. You can't tell if the second-last letter is Y or I."

understand "dispepsid" and "dyspepsyd" as demo med.

the pill lip is peripheral scenery in Dopy Pod. "A Demo Med rests on the Pill Lip."

report taking demo med:
	say "The pill lip retracts with no trace as you take the demo med.";
	moot pill lip;
	the rule succeeds;

book Pro Corp

Pro Corp is north of Gross Org. It is in Yelpley. description is "This obscure lab is lit by an unseen blu-bulb. [if butene tub is in Pro Corp]A butene tub rests here. At least, that's what it says it is[else]Pro Corp is devoid of equipment now you blew up the butene tub[end if]. The only way out is back south. [if butene tub is moot]The Sci Pics you ignored while destroying[else]Sci Pics that seem to warn what NOT to do with[end if] the butene tub cover the walls."

printed name of Pro Corp is "[if bald-lab]Bald Lab[else]Pro Corp[end if]".

understand "bald/lab" and "bald lab" as Pro Corp when bald-lab.

check going south in Pro Corp when being-chased is true:
	mug-the-player;

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

after taking when player is in Pro Corp (this is the notify Bald Lab rule):
	if bald-lab, say "Thanks to your actions, Pro Corp is now a Bald Lab.";
	continue the action;

to decide whether bald-lab:
	if butene tub is moot and DNA band is not in Pro Corp and gold log is not in Pro Corp, yes;
	no;

chapter LLP hint

after looking in Pro Corp when bald-lab and balm-LLP-yet is false:
	say "You feel a bit itchy. Maybe it's the chemical reactions in here. Maybe something in here could help fix that, despite it being a Bald Lab. Not necessary to, but ... a small nice thing.";
	continue the action;

chapter Sci Pics

the Sci Pics are plural-named peripheral scenery in Pro Corp. "They detail what happen[if Gorge Grog is moot]ed when you poured[else] if you pour[end if] a potentially explosive liquid down the butene tub. How many are there? You count: XI pix, of course."

chapter butene tub

the butene tub is scenery in Pro Corp. "It smells pretty nice, so it's probably not a butyl-y tub. But it's been marked condemned, dangerously close to falling apart. It looks sturdy enough, but who knows what sort of reactions could occur with the flammable butene if the tub collapsed from a big chemical bang and fell to the dangerously sparky area below with special instruments and such? You can't just pour any old thing down![paragraph break]What sort of adventurer could ignore a warning like that? Especially in a game that's meant to be polite on the Zarfian cruelty scale, thus eliminating all risk and/or need to type UNDO if you mess up!"

check entering butene tub: say "[if psi wisp is in Pro Corp][chase-pass]That's no way to hide from the psi wisp[else]You're clean enough, really[end if]." instead;

chapter gash sag

the gash sag is peripheral scenery. "It has covered up your destruction of the butene tub, but at least you got that resale laser first."

chapter resale laser

The resale laser is a tronpart. description is "It has a big red 1 sketched on it in LCD. Perhaps it only has one use left, and you need to make it count. I mean, things are bad in Yelpley and Grebeberg, but not bad enough that any fool can get their hands on something that can kill repeatedly and quickly."

chapter gold log

the gold log is a thing in Pro Corp. description is "Maybe if it were shaped a bit differently, it would be a golf log you could use to putt up, but as-is, it's not too useful.[paragraph break]It feels hollow, though. Lighter than it should. You remember how it rattled when you picked it up."

report taking gold log:
	say "It feels light. Not a ton. It rattles as you pick it up.";
	the rule succeeds;

chapter DNA band and hand and what's after

The DNA band is a thing in Pro Corp. "A DNA band sits here, nice and tidy and helical.". description is "The DNA band seems like it could come to life, but you'd need some weird science to do so.".

instead of wearing DNA band, say "You can't wear it. It's helical, not a headband."

The DNA hand is a thing. description is "It's motionless, but it looks lifelike enough, despite being recessed. The right item could bring it to life!"

Mr Arm is a proper-named thing. description is "Wow! It's really evolved from a DNA band! The BANG NAB written on it indicates it's more than a measly banana nab. It's sturdy. If it had eyes, it'd be looking for something to steal and run--umm, that's not quite right--off with. You're not sure why it hasn't run off with anything in your inventory. Is all this stuff you piled up worthless? Perhaps Mr. Arm is just grateful and wants to steal something for you.[paragraph break][one of]Mr. Arm seems about to point somewhere. If you examine him again, you can see where.[or]Mr. Arm [arm-dir][stopping]"

printed name of Mr Arm is "Mr. Arm".

understand "bang/nab" and "bang nab" as Mr Arm.

to say arm-dir:
	if location of player is Yell Alley:
		say "is [if navy van is in Yell Alley]shaking a fist at the navy van[else]waving around frantically[end if]![no line break]";
		continue the action;
	say "points ";
	let Horz be (remainder after dividing loc-num of location of player by 10) - (remainder after dividing loc-num of Yell Alley by 10);
	let Vert be (loc-num of location of player / 10) - (loc-num of Yell Alley / 10);
	if Vert is 0:
		say "[if Horz > 0]west[else]east";
	else if Horz is 0:
		say "north";
	else if Vert + Horz is 0:
		say "northeast";
	else if Vert is Horz:
		say "northwest";
	else if Horz > 0:
		say "[if Vert > Horz]north[else]west[end if]-northwestish";
	else:
		say "[if Vert + Horz > 0]north[else]east[end if]-northeastish";
	say ".[no line break]"

volume dialogue

section talk texts

[xxtalk]
[organized alphabetically, why not ... this doesn't need to be here, strictly, but I'd rather define talk text AFTER defining people]

to say maps-if-solved: say "[if spa maps are preclued]the spa maps now[else]something[end if]"

talk-text of the player is "'Me! Hi! Hem.'"

talk-text of Bomb Mob is "You don't need a gang nag. Maybe you, or something you find or found, can sneak around them to get the TNT, though.".
talk-text of Code Doc is "After some desultory chatter, the Code Doc mentions how[one of], to avoid Uneven U becoming Y-Me'd Academy,[stopping] [next-rand-txt of table of university primary targets] or [next-rand-txt of table of university secondary targets] would be a strong addition to Uneven U as a co-doc. [if maps-explained is true]You might not have much to talk about, now you've had help with the Spa Maps[else if spa maps are preclued]You need some way to help the Code Doc, so you can get help with the Spa Maps[else]Perhaps USEing [maps-if-solved] on the Code Doc might be more helpful to you[end if].".
talk-text of Cross Orc is "'Yap?! Pay!'".
talk-text of Dave is "Dave's here, man. And Dave's not chatty, man. He just seems to want to block you from doing anything.".
talk-text of Diktat Kid is "Now's not the time for talk. Okay, the Diktat Kid might be bragging, but you won't get a word in. Maybe a stiff 'It's...'".
talk-text of Ergot Ogre is "'Guh! Ug!'[paragraph break]Diplomacy won't get you by, here, and you don't have the guts to boom 'Erg, OFF, ogre!' You need something, or someone, stronger or quicker than you. Or both.".
talk-text of Flee Elf is "[one of]'That cap. It's for you. Find the right way to take it, and I'll leave you on your way. Ask me again for hints.'[or]'Well, there are only twenty-six ways to take the Pact Cap--um, okay, twenty-five, if you think about it. And don't overthink. Once you do, I'm on my way.'[stopping]".
talk-text of Gulf Lug is "'Ill, I...' Then general disappointment how Eruct-Cure and Burp Rub will only cure the SYMPTOMS.".
talk-text of Ian is "Ian sniffs. 'Why should I talk to someone not classy enough to BELONG here on Mont Nom?' He turns his head for a moment, as if doing something he's ashamed of.".
talk-text of Kayo Yak is "It looks up a bit but then ignores you. Well, it is a yak, not a yack, after all. Maybe there's an order it can respond to.".
talk-text of King Nik is "'I am not a very good king! I've tried to understand social and economic forces and big picture issues and stuff. But it gets all muddled. I'm no [next-rand-txt of table of King Nik ancestors]. I'm worried my kingdom will soon become Skint Nik's. Maybe you could help me?'".
talk-text of Knife Fink is "The Knife Fink stops and looks over your possessions for a moment.".
talk-text of Known Wonk is "'Say, as...' There is some awkward small talk. The Known Wonk's mind is elsewhere, but maybe you can help with practical matters.".
talk-text of Ms Ism is "She is just full of isms as she waves her Gal Flag about. Obscurantism, denialism, revisionism, escapism, whataboutism, you name it! She also upbraids the Mainstream Media for not paying attention to [next-rand-txt of table of Ms Ism pals].".
talk-text of Revolt Lover is "'[if straw arts are moot]Your art has helped me push forward with my magnum opus: WONDERED NOW! Thank you!'[else]Did you find any Stray Arts? I can always use them.'[end if]".
talk-text of Bond Nob is "'I ain't much for talking now I'm sick... no way I can visit [next-rand-txt of table of Bond Nob bars] or [next-rand-txt of table of Bond Nob bars] or any other cool bar with my pals...'".
talk-text of Ned is "Ned's not in the mood for regular talk. He seems to want an argument or fight, but you don't.".
talk-text of Psi Wisp is "It has nothing to say. It just pulses.".
talk-text of Door Frood is "The Door Frood launches into how mostly everyone is really stupid and at fault, and those who aren't can't really do anything except snark about it. And sad thing is, the Door Frood is out of new creative snark! For the moment.".
talk-text of Rob is "Rob yawns. He doesn't find you very interesting. Maybe there's a way to take advantage of that.".
talk-text of sleep eels is "Maybe they are sending some sort of electric message you could detect with the right instrument, but they're not talking. You're more struck, though, by how uncomfortable they look while sleeping--wriggling about.".
talk-text of Sniffins is "[if YOB ATTABOY is not moot]'Tony? Not! People call my food lower class than even N-E-Mart Ramen! If only I had some success manual!'[else]'Oh. It's YOU again. If you were REALLY smart, you'd have taken the advice in that book you gave me. Too late now! Guess you'll never do anything with your life.'[end if]".
talk-text of Verses Rev is "The Verses Rev booms 'Erupt! Pure!' then piously intones how weirdos not in line with the Diktat Kid's values need to be eradicated.".
talk-text of Wordy Drow is "It moans and points at the Liar Grail. They're forced together, somehow, but maybe you can change that. But you'll have to do more than shout 'Ye go, bogey!'".
talk-text of Yuge Guy is "'I'm ... ' / 'TMI!'"
[zztalk]

volume gotoing

printed name of Fun Enuf is "[if Diktat Kid is moot]NU FUN[else]Fun Enuf[end if]".

chapter gotoing

to decide which number is gtdist of (r1 - a room) and (r2 - a room):
	if r1 is fun enuf, decide on room-dist of r2;
	if r2 is fun enuf, decide on room-dist of r1;
	if map region of r1 is not map region of r2, decide on room-dist of r1 + room-dist of r2;
	if room-dist of r1 > room-dist of r2, decide on gtdist of r2 and r1;
	let temp be 0;
	let r2t be r2;
	while room-dist of r2t > room-dist of r1:
		increment temp;
		now r2t is in-room of r2t;
	let r1t be r1;
	while r1t is not r2t:
		increment temp;
		now r1t is in-room of r1t;
		now r2t is in-room of r2t;
		if temp > 15, decide on 15;
	decide on temp;

gotoing is an action applying to one visible thing.

understand the command "gi" as something new.
understand the command "gr" as something new.
understand the command "gt" as something new.
understand the command "goto" as something new.
understand the command "go to" as something new.

understand "go to [any room]" as gotoing.
understand "goto [any room]" as gotoing.
understand "gt [any room]" as gotoing.
understand "gr [any room]" as gotoing.
understand "go [any room]" as gotoing.

to decide whether goto-available:
	if Diktat Kid is quicknear, no;
	if Ms Ism is quicknear, no;
	yes. [obviously we don't want this to be trivial once the game's complete, but we want the code in place.]

gone-to is a truth state that varies.

to decide which direction is first-move of (r1 - a room) and (r2 - a room):
	let D1 be the best route from r1 to r2;
	if D1 is not up and D1 is not down, decide on D1;
	repeat with D2 running through maindir:
		if the room D1 of r1 is the room D2 of r1, decide on D2;
	decide on up; [??this should never happen. But I'd like a bail statement if it does.]

carry out gotoing:
	if noun is location of player, say "Already there! Er, here." instead;
	if being-chased is true:
		if first-move of location of the player and noun is the opposite of last-chase-direction:
			say "Before you can double back, [the chase-person] catches you and sends you spinning!";
			reset-chase instead;
		if mrlp is not map region of noun:
			say "You run into some x-it stix that block your way to [Fun Enuf].";
			if mrlp is Yelpley, move player to Yawn Way instead;
			if mrlp is Grebeberg, move player to Seer Trees instead;
			say "UH OH bad bug ... should be moved somewhere.";
			the rule succeeds;
		if shuttuhs is true and noun is shutted, say "[chase-pass][noun] is shuttered right now." instead;
		move the player to noun;
		the rule succeeds;
	unless goto-available, say "You're at a (critical) point in the game where goto isn't available." instead;
	if Diktat Kid is moot:
		if noun is Deft Fed, say "You can't crash the party. You weren't invited. It's REALLY exclusive." instead;
		if noun is westpost, say "The Smarty Trams project is underway there, now you've dealt with the Diktat Kid." instead;
		if noun is eastpost, say "That area is now undergoing civic restoration, with the Diktat Kid gone." instead;
		if noun is ungoable, say "You're pretty sure you've figured out all the secrets there or beyond." instead;
	consider the avail-rule of noun;
	if the rule failed:
		if noun is Emo Dome and Emo Dome is visited, say "You'd run away from the Emo Dome too quickly. You need a plan of attack to deal with it." instead;
		say "[noun] isn't available yet, so you can't go there." instead;
	if noun is unvisited, say "You can reach [noun], but you haven't visited there, yet. So I'm going to be a stickler and say you have to get there first." instead; [?? look for first in chain-back you have visited]
	consider the unavail-rule of noun;
	if the rule succeeded, say "[noun] is no longer worth going to. You don't want to go back. Onward!" instead;
	if cap-pace is true and map region of location of noun is not Grebeberg:
		now cap-pace is false;
		say "Your pace cap slows down as you [if noun is Fun Enuf]enter[else]cross[end if] [Fun Enuf]...";
	now gone-to is true;
	let my-dist be gtdist of noun and location of player;
	if my-dist is 1:
		say "You walk over one room...";
	else if my-dist < 4:
		say "'Go, jog,' you exhort yourself, for the moderate journey...";
	else:
		say "'Run, ur...' you push yourself, for the long journey...";
	move player to noun;
	the rule succeeds;

	[?? kick player to Toll Lot if they get LLP after ...]
	[?? change map text of rooms]

[??gt a person]

a room can be eastpost, eastcond, westpost, westcond or unblockable. a room is usually unblockable.

Yack Cay is westpost. Swamp Maws is westpost. Lac Oft Focal is westpost. Trial Lair is westpost. Uneven U is westpost. Trial Lair is westpost. Motto Bottom is westpost. Mont Nom is westpost. Moo Room is westcond. Frush Surf is westcond.

Red Roses Order is eastpost. Swept Pews is eastpost. Drawl Ward is eastpost. Dopy Pod is eastpost. Scrap Arcs is eastpost. Deft Fed is eastpost.
Gross Org is eastcond. Pro Corp is eastcond.

section gotothinging

gotothinging is an action applying to one visible thing.

does the player mean gotothinging a moot thing: it is very unlikely.
does the player mean gotothinging a thing in an unvisited room: it is very unlikely.
does the player mean gotothinging an off-stage thing: it is very unlikely.
does the player mean gotothinging a thing carried by the player: it is unlikely.
does the player mean gotothinging Tru Hurt when player has X-Ite Tix: it is unlikely.

understand "go to [any thing]" as gotothinging.
understand "goto [any thing]" as gotothinging.
understand "gt [any thing]" as gotothinging.
understand "gi [any thing]" as gotothinging.
understand "go [any thing]" as gotothinging.

carry out gotothinging:
	let Q be location of noun;
	let odd-mulligan be false;
	if Q is TempMet:
		if noun is tract cart or noun is a workable or noun is a book:
			say "Right now [the noun] is in a different configuration of [Worn Row][if player is in Worn Row]. Just say which configuration you want in order to see [the noun] again[end if].";
			now odd-mulligan is true;
	if odd-mulligan is false and Q is in Odd Do:
		if Q is eels:
			say "You remember where the eels were.";
			try gotoing Ooze Zoo;
		say "Unfortunately, [the noun] [if noun is plural-named]are[else]is[end if] [if Q is devreserved]out of this game[else]in an in-between state[end if] right now." instead;
	if noun is off-stage, say "Unfortunately, you accessed something that wasn't introduced to the game world yet." instead;
	try gotoing Q instead;

section available rules

[we could get cute here and define availability by what item is moot, but that can go haywire once there's an exception. For instance, it's tricky to do stuff with the Spur Ups and the Psi Wisp, and Dirge Grid is tricky as well.]

a room has a rule called avail-rule. avail-rule of a room is usually the trivially true rule.

avail-rule of DevReserved is the trivially false rule.
avail-rule of TempMet is the trivially false rule.
avail-rule of DropOrd is the trivially false rule.

avail-rule of Fun Enuf is trivially true rule. [described elsewhere]

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
	if puffed-up is true, the rule succeeds;
	the rule fails;

avail-rule of Deft Fed is orc-block rule.
avail-rule of Gross Org is orc-block rule.

this is the orc-block rule: [similar to pre-radar-on-arc but with no text]
	if cross orc is moot, the rule succeeds;
	the rule fails;

avail-rule of Pro Corp is gate-gone rule.

this is the gate-gone rule:
	if etage gate is moot, the rule succeeds;
	the rule fails;

avail-rule of Swamp Maws is dung-gone rule.
avail-rule of Yack Cay is dung-gone rule.
avail-rule of Uneven U is dung-gone rule.
avail-rule of Trial Lair is dung-gone rule.

this is the dung-gone rule:
	if gnu dung is moot, the rule succeeds;
	the rule fails;

avail-rule of Lac Oft Focal is wonk-book rule.

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
	if soot tattoos are moot and Bros' Orb is not in Le Babel, the rule succeeds;
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

a room can be chase-blocked. a room is usually not chase-blocked.

check going to a chase-blocked room when being-chased is true: say "[chase-pass]No, you've already been there[xtra-txt of room noun of location of player]." instead;

to say xtra-txt of (rm - a room):
	if exit-count of rm < 2:
		say ", but it was a dead end with nothing to do";
		continue the action;
	else if all-visited-beyond of rm:
		say ", and everywhere beyond, with nothing to do";
	else:
		say ", and though there are rooms beyond you didn't explore, maybe you should stick with places you know for now"

to decide whether all-visited-beyond of (rm - a room):
	if rm is unvisited, no;
	if exit-count of rm is 1, yes;
	repeat with Q running through maindir:
		say "trying [Q] of [rm].";
		if Q is in-dir of rm, next;
		if the room Q of rm is nowhere, next;
		unless all-visited-beyond of the room Q of rm, no;
	yes;

after going when being-chased is true:
	if x-it stix are in location of player, say "As you run further [noun], you notice X-it Stix X out the way [if Fun Enuf is room east of location of player]east[else]west[end if]. It's probably bad for the [chase-person] to get loose in [if player is in Yawn Way]Grebeberg[else]Yelpley[end if].";
	continue the action;

x-it stix are semiperipheral scenery. "They look like the metal grating shops pull out over their doors and windows at closing time.[paragraph break]They are in an X, and while they don't allow an Xit, they do x out one way to go, which may help you figure how you need to get away from the [chase-person].[paragraph break]Of course, any wordplay adventurer worth their salt (like you--you're pretty far along, here) knows the difference between EXIT and X-IT. These things are X-ing out an option, here!";

understand "xit stix" and "x it stix" and "x/it stix" and "x it" as x-it stix.

being-chased is a truth state that varies.
init-turn is a truth state that varies.
chase-mulligan is a truth state that varies.

chase-person is a person that varies.

last-chase-direction is a direction that varies.

ever-chased is a truth state that varies.
ever-chased-wisp is a truth state that varies.
ever-chased-yak is a truth state that varies.

to start-chase (guy - a person):
	now chased-yet of guy is true;
	move x-it stix to stix-room of guy;
	now chase-person is guy;
	now last-chase-direction is southwest;
	now init-turn is false;
	if guy is yak, now ever-chased-yak is true;
	if guy is wisp, now ever-chased-wisp is true;
	if ever-chased is false:
		now ever-chased is true;
		say "(NOTE: [no-time-note].)[paragraph break]";
	now being-chased is true;

definition: a thing (called th) is keepable:
	if th is pyx and player has pyx, yes;
	if th is worn, yes;
	no;

to mug-the-player:
	say "You drop all your possessions (except [the list of keepable things]) as you flee[one of][or] again[stopping]! That will make you a bit faster, but it looks like you'll need your own wit and quick actions to escape, here[one of].[wfak][or].[stopping]";
	now all not keepable things carried by the player are in DropOrd;

to say no-time-note:
	say "When you are in a chase[if being-chased is true], like right now[end if], commands like [b]X/EXAMINE[r], [b]L/LOOK[r], [b]I/INVENTORY[r], [b]THINK[r] and even [b]AID[r] (if you must) will take no time"

cap-during-yak is a truth state that varies.

yak-lair is a truth state that varies.

every turn when being-chased is true:
	if action is procedural:
		if debug-state is true, say "DEBUG TEXT: [current action].";
		now chase-mulligan is false;
		continue the action;
	if init-turn is false:
		say "You'd better get a move on. The [chase-person] looks pretty agitated.";
		now init-turn is true;
		now chase-mulligan is false;
		continue the action;
	if chase-mulligan is true:
		now chase-mulligan is false;
		continue the action;
	if chase-person is in location of player:
		say "You've been caught! Stung! Nuts! [if chase-person is kayo yak]A quick butt, nothing violent, but just to show you who's boss leaves[else]Sting-nits, a lot, leave[end if] you dazed and confused, you [if player is in Ooze Zoo or player is in Gross Org]run around in circles a bit[else]stagger back to[end if]...";
		reset-chase instead;
	else:
		say "The [chase-person] [if chase-person is kayo yak]charges[else]pulses[end if] close behind.";
		if chase-person is kayo yak and cap-pace is true and cap-during-yak is false:
			now cap-during-yak is true;
			say "[line break]Wow! You outran the yak comfortably. The pace/pact cap seems to have helped, and even better, you don't feel particularly exhausted.";
		move chase-person to location of player;
		if location of player is Lair Trial:
			now yak-lair is true;
			say "[line break]The Kayo Yak slows down temporarily and makes a weird sound at the ergot ogre, as if it wants to attack, but it almost needs permission!"

to recover-items:
	now player has all things in DropOrd;

to reset-chase:
	let LP be location of player;
	wfak;
	move x-it stix to TempMet;
	recover-items;
	now being-chased is false;
	now chase-mulligan is false;
	if debug-state is true, say "RULE TRACKER: [LP] ([chase-block-rule of LP]).";
	consider chase-block-rule of LP;
	if the rule succeeded:
		if debug-state is true, say "Now [LP] is chase-blocked.";
		now LP is chase-blocked;
	if mrlp is Grebeberg, drop-player-at Ooze Zoo;
	if mrlp is Yelpley, drop-player-at Gross Org;
	unless player was in Frush Surf or player was in Pro Corp, say "Well, all your items you dropped are still here, so that's something. You take them back, staying where the [chase-person] won't quite find you.";
	move chase-person to chase-room of chase-person, without printing a room description;
	if LP is Lair Trial, say "The kayo yak didn't seem to want to attack you, but you just didn't know what to say. Maybe you can and should try again.";

after going when being-chased is true:
	now last-chase-direction is noun;
	continue the action;

check going when being-chased is true (this is the block reverse and flatten directions rule):
	if last-chase-direction is opposite of noun, say "The [chase-person] is blocking you from the [noun]. You try a gazelle-zag but don't have the moves." instead;
	if noun is up or noun is down:
		if the room noun of location of player is nowhere, continue the action;
		repeat with DR running through maindir:
			if the room DR of location of player is the room noun of location of player, try going DR instead;

check going to Fun Enuf when being-chased is true: say "[chase-pass]The X-It Stix block you." instead;

the Psi Wisp is a chaser in Pro Corp. chase-room of Psi Wisp is Pro Corp. description is "[one of]'I spy PSI,' you think to yourself.[paragraph break][or][stopping]The Psi Wisp is very red, and it pulses fervently. If it had feelings, you'd be pretty sure it didn't like you.". "[one of]A Psi Wisp pulses here before lurching alarmingly in your direction![or]The Psi Wisp [if player is in Pro Corp]pulses again! Back to the chase.[else]is still chasing you![end if][stopping]". stix-room of Psi Wisp is Yawn Way.

after looking when being-chased is false (this is the start-chase-in-case rule):
	if player is in Pro Corp and psi wisp is not moot:
		say "The Psi Wisp hovers and pulses and swirls aggressively in the air[one of][or], again[stopping]!";
		start-chase Psi Wisp;
		continue the action;
	if troll ort is moot and player is in Frush Surf and kayo yak is in Frush Surf:
		start-chase Kayo Yak;
		say "The Kayo Yak scuffs its hooves, ready to bound after you[one of][or] again[stopping]!";
		continue the action;
	continue the action;

to decide whether tried-yak:
	if ever-chased-yak is false, no;
	if kayo yak is moot, no;
	yes;

to decide whether tried-wisp:
	if ever-chased-wisp is false, no;
	if psi wisp is moot, no;
	yes;

chapter chase block rules

a room has a rule called chase-block-rule. chase-block-rule of a room is usually the trivially false rule.

section yak chase

chase-block-rule of Moo Room is the block-moo-room rule.
chase-block-rule of Flu Gulf is the block-flu-gulf rule.
chase-block-rule of Apse Spa is the block-room-generically rule.
chase-block-rule of Cold Loc is the block-cold-loc rule.
chase-block-rule of Lac Oft Focal is the block-room-generically rule.
chase-block-rule of Yack Cay is the block-yack-cay rule.

this is the block-room-generically rule:
	say "Hmm, you didn't seem to need to go that way. [location of player] was a dead end.";
	the rule succeeds;

this is the block-flu-gulf rule:
	say "With [if scorn rocs are in Flu Gulf]whatever's west of the scorn rocs[else if Sneer Greens are unvisited]something scary to the west[else if Yuge Guy is moot]the Yuge Guy gone[else]the Yuge Guy looming[end if], [Sneer Greens] doesn't seem like the place to be. The Yak couldn't do much there.";
	the rule succeeds;

this is the block-moo-room rule:
	if poo coop is had-or-done:
		say "You know the Moo Room is a dead end, and since you got the poo coop from here, it seems like you need the yak to chase you somewhere else.";
		the rule succeeds;
	the rule fails;

this is the block-cold-loc rule:
	if Flu Gulf is chase-blocked and Apse Spa is chase-blocked:
		say "Brr. It was cold there. There was nothing north or east, and besides, you'd freeze before the yak did. Maybe you need it to chase you somewhere else.";
		the rule succeeds;
	the rule fails;

this is the block-yack-cay rule:
	if mist sim is in Yack Cay:
		say "It's unlikely something is behind the mist sim, and you found nothing in Yack Cay.";
		the rule succeeds;
	if Lac Oft Focal is chase-blocked:
		say "There was nothing in [Lac Oft Focal] OR [Yack Cay] you saw that could slow the yak down more than you. Well, that's another place you can ignore next time.";
		the rule succeeds;
	the rule fails;

section wisp chase

chase-block-rule of Yell Alley is the block-room-generically rule.
chase-block-rule of Trapeze Part is the block-room-generically rule.
chase-block-rule of Evaded Ave is the block-evaded-ave rule.
chase-block-rule of Art Xtra is the block-art-xtra rule.
chase-block-rule of Scrap Arcs is the block-room-generically rule.
chase-block-rule of Dopy Pod is the block-room-generically rule.
chase-block-rule of Drawl Ward is the block-drawl-ward rule.
chase-block-rule of Swept Pews is the block-swept-pews rule.
chase-block-rule of Deft Fed is the block-deft-fed rule.

this is the block-deft-fed rule:
	say "You don't remember much of the wisp getting you, but you remember [snismu] yelling and generally carrying on. If there's any place that can get rid of the Psi Wisp, it's not [Deft Fed].";
	the rule succeeds;

this is the block-evaded-ave rule:
	if Yell Alley is chase-blocked and Trapeze Part is chase-blocked:
		say "Nothing to do west or east, and nothing here. The Psi Wisp might be a shock for the Door Frood ... but no way you'd outrace it through the tube. Somewhere else, then.";
		the rule succeeds;
	the rule fails;

this is the block-art-xtra rule:
	if Evaded Ave is chase-blocked:
		say "There's nothing behind Art Xtra. The Revolt Lover would like to help you but can't. This can't be the way.";
		the rule succeeds;
	the rule fails;

this is the block-drawl-ward rule:
		say "Yyyuuuppp. Nothing to do here. You searched both west and east. Time to find somewhere else.";
		the rule succeeds;
	the rule fails;

this is the block-swept-pews rule:
		say "You cringe as you think of all the chaos you brought to the Swept Pews. There's nothing you see that could help you dispose of the Psi Wisp, which (un)fortunately isn't demoniac enough to be affected by such a holy place. Maybe you need something more physical or scientific.";
		the rule succeeds;
	the rule fails;

volume accelerator commands

to decide whether in-warp-command:
	if in-ms-warp is true, yes;
	if in-guy-warp is true, yes;
	if in-tool-warp is true, yes;
	if in-tip-it is true, yes;
	if deep-speeding is true, yes;
	if revving-over is true, yes;
	no;

chapter deepspeeding

to decide whether redact-postrule:
	if deep-speeding is true, yes;
	if deep-speeding is false and revving-over is true, yes;
	no;

deepspeeding is an action out of world.

deep-speeding is a truth state that varies.

say-despite-speeding is a truth state that varies.

understand the command "deepspeed" as something new.
understand the command "deep speed" as something new.

understand "deep speed" as deepspeeding.
understand "deepspeed" as deepspeeding.

to say recxcheck of (speedy - a truth state) :
	if player has epicer recipe and epicer recipe is nox:
		say "[if speedy is true] (examining the epicer recipe first) [else]You examine the epicer recipe first. You haven't, yet.[paragraph break][end if]";
		now epicer recipe is xed;

i-sped is a truth state that varies.

carry out deepspeeding:
	let gsi be grid-side-items;
	abide by the rev-check rule;
	now deep-speeding is true;
	say "DEEP SPEEDing to near the end[recxcheck of true]...";
	try revovering;
	now deep-speeding is false;
	now all rooms in Yelpley are visited;
	now all rooms in Grebeberg are visited;
	now i-sped is true;
	if gsi < 3, say "You may wish to check your inventory. You will have what you need to beat the Diktat Kid. I hope you enjoy the final confrontation, but if you want to get to the end right away, [b]TIP IT[r] three times.";
	if score is not min-win - 4, say "[line break]Uh oh. There is a bug in the scoring. You can still win the game, but you should have [min-win] points and only have [score].";
	the rule succeeds;

section smitimsing - not for release

[ * this wins the Dirge Grid if you have cleared the KAOS Oak ]

smitimsing is an action out of world.

understand the command "smitims" as something new.

understand "smitims" as smitimsing.

carry out smitimsing:
	unless KAOS Oak is moot, say "Remove the [kaoscaps] first. [b]DEEP SPEED[r] may be handy." instead;
	if Dirge Grid is visited, say "Too late for [b]SMITIMS[r]." instead;
	if player is not in Fun Enuf, move the player to Fun Enuf, without printing a room description;
	try going north;
	if the player is not in Dirge Grid, say "Oops. Something went wrong. Check your inventory. Make sure the redivider is loaded, and you know how to use it. Remember, you can always [b]DEEP SPEED[r]." instead;
	if a random chance of 1 in 2 succeeds:
		try useoning ME gem with Knife Fink;
		try useoning taboo bat with Verses Rev;
	else:
		try useoning taboo bat with Verses Rev;
		try useoning ME gem with Knife Fink;
	try useoning yard ray with redivider;
	try going south;
	follow the notify score changes rule;
	the rule succeeds;

section sdsing - not for release

[ * say-despite-speeding flag toggle for full verbosity with DEEP SPEED ]

sdsing is an action out of world.

understand the command "sds" as something new.

understand "sds" as sdsing.

carry out sdsing:
	now say-despite-speeding is whether or not say-despite-speeding is false;
	say "Say-despite-speeding now [on-off of say-despite-speeding].";
	the rule succeeds;

section wrw - not for release

[ * wrw is short for WARP RAW. It is superseded by TIP IT for the most part. ]

understand the command "wrw" as something new.

understand "wrw" as wrw1ing.

understand "wrw [number]" as wrwing.

wrw1ing is an action out of world.

wrwing is an action applying to one number.

rev-max is a number that varies. rev-max is 73.

carry out wrw1ing: try wrwing 1 instead;

carry out wrwing:
	now rev-skips is number understood;
	if rev-skips > rev-max:
		say "[rev-max] is the maximum possible number. Rounding down.";
		now rev-skips is rev-max;
	if rev-skips < 1, say "I need a number between 1 and [rev-max] inclusive." instead;
	try revovering;
	now rev-skips is 0;
	the rule succeeds;

chapter toolslooting

toolslooting is an action out of world.

understand the command "toolsloot" as something new.
understand the command "tools loot" as something new.

understand "toolsloot" as toolslooting.
understand "tools loot" as toolslooting.

in-tool-warp is a truth state that varies.

carry out toolslooting:
	abide by the chase-warp-check rule;
	if KAOS Oak is moot, say "You already destroyed the [kaoscaps]." instead;
	if tron-got is 4, say "You already have all the North-Tron pieces the epicer recipe says you need." instead;
	now in-tool-warp is true;
	try revovering;
	now in-tool-warp is false;
	drop-player-at Fun Enuf;
	say "You're ready to put the North-Tron together[if main-score < 73]. You may have other things to do before visiting the Diktat Kid, but you're ready to destroy the [kaoscaps] now[end if].";
	the rule succeeds;

to decide which number is main-score:
	decide on cur-score of Grebeberg + cur-score of Yelpley + cur-score of Dim Mid;

chapter smhmsing

smhmsing is an action out of world.

understand the command "smhms" as something new.
understand the command "smh ms" as something new.

understand "smhms" as smhmsing.
understand "smh ms" as smhmsing.

in-ms-warp is a truth state that varies.

carry out smhmsing:
	abide by the chase-warp-check rule;
	if Ms Ism is moot, say "You already beat Ms. Ism." instead;
	unless Bros' Orb is in Le Babel or soot tattoos are off-stage, say "You already have what you need to defeat Ms. Ism." instead;
	now in-ms-warp is true;
	try revovering;
	now in-ms-warp is false;
	drop-player-at Emo Dome;
	say "Ms. Ism awaits north.";
	the rule succeeds;

chapter guyuging

guyuging is an action out of world.

understand the command "guyug" as something new.
understand the command "guy ug" as something new.

understand "guyug" as guyuging.
understand "guy ug" as guyuging.

in-guy-warp is a truth state that varies.

carry out guyuging:
	abide by the chase-warp-check rule;
	if Yuge Guy is moot, say "You already beat the Yuge Guy." instead;
	if player has rep popper or rep popper is moot, say "You already have what you need to defeat the Yuge Guy." instead;
	now in-guy-warp is true;
	try revovering;
	now in-guy-warp is false;
	if dork rod is not moot, say "Oops. Something that really shouldn't have happened, happened. You don't need to undo, but you may need to get the rep popper manually." instead;
	now player has rep popper;
	drop-player-at Flu Gulf;
	say "The Yuge Guy awaits west.";
	the rule succeeds;

chapter tipiting

tipiting is an action out of world.

understand the command "tipit" as something new.
understand the command "tip it" as something new.

understand "tipit" as tipiting.
understand "tip it" as tipiting.

in-tip-it is a truth state that varies.

carry out tipiting:
	now in-tip-it is true;
	now rev-skips is 1;
	try revovering;
	now in-tip-it is false;
	now rev-skips is 0;
	the rule succeeds;

chapter revovering

this is the chase-warp-check rule:
	if being-chased is true, say "Sorry, I can't do this during a chase." instead;

revovering is an action out of world.

understand the command "rev over" as something new.

understand "rev over" as revovering.

global-delay is a number that varies.

score-cheat is a number that varies.

revving-over is a truth state that varies.

rev-skips is a number that varies.

this is the rev-check rule:
	if being-chased is true, say "Oops, that's too much for me to do at once! Either escape or get caught by [the chase-person] first, then we can proceed." instead; [?? I am almost ready to delete this]
	if in-tip-it is false:
		if i-sped is true, say "You already sped up to just before the Dirge Grid fight[if x-ite tix are off-stage]. [b]TIP IT[r] is the only command left[end if]." instead;
		if player is in Dirge Grid, say "You're already at the Dirge Grid!" instead;
		if Dirge Grid is visited, say "Too late! You've already been to the Dirge Grid." instead;
	if cant-tip-further:
		if in-tip-it is true, say "You just need to use the X-ITE TIX, now." instead;
		if player is in Dirge Grid, say "You need to fight through the Dirge Grid or use [b]TIP IT[r]." instead;
		if player is in Fun Enuf, say "You've already gone as far as [b]REV OVER[r] or Dirge Grid will take you[if x-ite tix are off-stage]. [b]TIP IT[r] can take care of the rest[end if]." instead; [i can cut this down, because some of this is probably redundant, but I'd rather be too sure]
		say "You're pretty near the endgame. Would you like me to drop you off at [Fun Enuf]?";
		if the player yes-consents, move player to Fun Enuf instead;
		say "OK, but you don't have much else to do[if cur-score of Odd Do is max-score of Odd Do]--you got all the LLPs[else] except search for LLPs[end if]." instead;
	continue the action;

to decide whether cant-tip-further:
	if in-tip-it is false and emitted is true and player has ME gem and player has taboo bat and KAOS Oak is moot and test set is moot, yes;
	if in-tip-it is true and X-ITE TIX are not off-stage, yes;
	no;

definition: a thing (called th) is speedtakeable:
	if th is a person, no;
	if th is scenery, no;
	if th is eye, no;
	if th is tame mat, no;
	if th is a workable, no;
	if th is test set, no;
	if th is bomb mob, no;
	if th is stark rats, no;
	if th is liar grail, no;
	if th is cassettes sac, no;
	yes;

definition: a thing (called th) is swipeable:
	if th is Gorge Grog, yes;
	if th is TNT, yes;
	if th is bunk nub, yes;
	no;

to decide whether need-rev-check:
	if in-ms-warp is true, no;
	if in-guy-warp is true, no;
	if in-tool-warp is true, no;
	if in-tip-it is true, no;
	if deep-speeding is true, no;
	yes;

carry out revovering:
	abide by the rev-check rule;
	if in-ms-warp is true:
		say "Warping to before Ms. Ism...";
	else if in-guy-warp is true:
		say "Warping to before Yuge Guy...";
	else if in-tool-warp is true:
		say "Warping to before you destroy the KAOS Oak...";
	else if in-tip-it is true:
		say "Looking for the next thing to do...";
	else if deep-speeding is false:
		say "Attempting to [b]REV OVER[r][recxcheck of true]...";
	now global-delay is 0;
	let count be 0;
	let turns-to-add be 0;
	let bonus-turns be 0;
	let move-room be location of player;
	let spun-out-yet be false;
	now revving-over is true;
	now basic-hint-yet is true;
	repeat through table of goodacts:
		if in-ms-warp is true and ms-need entry is false, next;
		if in-guy-warp is true and guy-need entry is false, next;
		if in-tool-warp is true and tool-need entry is false, next;
		increment count;
		if debug-state is true, say "Row [count], score [score].";
		if rev-skips > 0 and global-delay is rev-skips:
			if spun-out-yet is false and debug-state is true, say "DEBUG: spun out at row [count].";
			now spun-out-yet is true;
			next;
		if in-tip-it is false and there is a use1 entry and use1 entry is ME gem:
			now i-sped is true;
			break;
		else:
			if there is a use1 entry and use1 entry is X-ITE TIX:
				break;
		[say "Rows so far [count - 1], current score [score].";]
		if there is no use1 entry:
			consider the preproc entry;
			if the rule succeeded:
				if there is a room-after entry:
					now move-room is room-after entry;
					visit-up-to move-room;
				increment global-delay;
				increment turns-to-add;
				if preproc entry is rev-worn-row rule or preproc entry is rev-yak-okay rule, increase bonus-turns by 5; [a hack to guess the right number of turns]
				if sco entry is true:
					if debug-state is true, say "(DEBUG: non-use point) (+1 [preproc entry])[line break]";
					increment the score;
					increment cur-score of reg-plus entry;
					now done entry is true;
			if need-rev-check and global-delay > 0 and the remainder after dividing global-delay by 5 is 0 and rev-skips is 0 and score < min-win - 4:
				say "Okay, do you want to try to do more?";
				if the player yes-consents:
					do nothing;
				else:
					break;
			next;
		let wr-flipped be false;
		if there is a getit entry and getit entry is not off-stage:
			if getit entry is not swipeable, next; [the Gorge Grog/TNT/bunk nub are already visible. Other items aren't.]
		if use1 entry is moot or use2 entry is moot, next;
		if there is a preproc entry:
			consider the preproc entry;
			if the rule failed, next;
		now done entry is true;
		increment global-delay;
		if there is a room-to-go entry: [to-go != room-after. In this case, to-go is more likely to be visited than room-after.]
			now move-room is room-to-go entry;
			visit-up-to move-room;
		let u1a be false;
		let u2a be false;
		let g1a be false;
		let demos-too be false;
		if the player does not have use1 entry and use1 entry is speedtakeable:
			if use1 entry is not off-stage and use1 entry is not in TempMet and use1 entry is not in devreserved, now location of use1 entry is visited; [this fixes a bug where you can "take" the stamp mats but REV OVER doesn't think you visited Frush Surf]
			now u1a is true;
			now player has use1 entry;
			if use1 entry is a book and number of tractable books is 1:
				now demos-too is true;
				now player has SOME DEMOS;
		if the player does not have use2 entry and use2 entry is speedtakeable:
			now u2a is true;
			now player has use2 entry;
		if use1 entry is a book:
			if Worn Row is worky, now wr-flipped is true;
			word-row-open;
		if say-unless-speed, say "You [if wr-flipped is true]toggle [Worn Row], then [end if][if u1a is true]acquire and [end if]use [the use1 entry] with [if u2a is true and u1a is true](also acquired) [else if u2a is true](acquired) [end if][the use2 entry][if there is a getit entry], acquiring [the getit entry][end if][if demos-too is true]--and scoring SOME DEMOS in the process[else if use1 entry is balsa slab]. Then you leave the Red Roses Order to people who can rebuild Yelpley[end if].";
		if use2 entry is a workable:
			if Worn Row is wordy, now wr-flipped is true;
			work-row-open;
			wear-down use2 entry;
		increment turns-to-add;
		if sco entry is true:
			if debug-state is true and deep-speeding is false, say "*(DEBUG: use point) (+1 above)[line break]";
			increment the score;
			increment cur-score of reg-plus entry;
		if there is a getit entry, now player has getit entry; [?? guru rug shouldn't be take-able but code is tricky]
		if d1 entry is true, moot use1 entry;
		if d2 entry is true, moot use2 entry;
		if there is a postproc entry, follow the postproc entry;
		if global-delay < rev-skips, say "rev-skips was too much by [rev-skips - global-delay].";
		if need-rev-check and the remainder after dividing global-delay by 5 is 0 and rev-skips is 0 and score < min-win - 4:
			say "Okay, do you want to try to do more?";
			if the player yes-consents:
				do nothing;
			else:
				break;
	if rev-skips > 0 and move-room is not location of player:
		skip upcoming rulebook break;
		say "(Moving you to [move-room])";
		move player to move-room, without printing a room description;
	now turns-to-add is turns-to-add * 4;
	increase turns-to-add by bonus-turns;
	if turns-to-add > 0:
		let delt be score - last notified score;
		skip upcoming rulebook break;
		if delt > 2 and score is 73, say "[line break]Thus ends your [if deep-speeding is true][b]DEEP SPEED[r] [else if revving-over is true][b]REV OVER[r] [else]accelerated [end if]journey, leaving you very close to saving Grebeberg and Yelpley[if deep-speeding is false and in-tip-it is false]. The final confrontation should be relatively quick and fun, but if you want, you can use [b]TIP IT[r] three times to run through[end if].";
		say "[line break][bracket][if delt > 0]I just gave you [delt] point[plur of delt] to go with your quick trip, and I also[else]I[end if] tacked on [turns-to-add] turns, as a guesstimate.[close bracket][paragraph break]";
		now score-cheat is score-cheat + score - last notified score;
		now last notified score is score;
		increase turn count by turns-to-add;
	else if in-tip-it is true:
		say "[if x-ite tix are off-stage]I didn't find anything to do. This is a bug in the warp code. Apologies, and I'd be interested how this happened[else]You've got the X-ITE TIX. The last step, you need to do yourself[end if].";
	else:
		say "Uh oh. There should've been a message saying you can't warp any more and only have the Dirge Grid left. It's likely there is a bug in the rev over/deep speed code. Continually using [b]TIP IT[r], however, should work. If you have a transcript, report the bug at my github site or email me.";
	follow the notify score changes rule;
	if test set is moot and player is not in Fun Enuf and Dirge Grid is not visited:
		say "(Also moving you to [Fun Enuf] for the endgame)[paragraph break]";
		move player to Fun Enuf, without printing a room description;
	now revving-over is false;
	the rule succeeds;

to say isco:
	abide by the delay-or-bail rule;
	increment the score;
	increment global-delay;

this is the delay-or-bail rule:
	if global-delay > 0 and remainder after dividing global-delay by 5 is 0:
		say "[b]REV OVER[r] more?";
		if the player yes-consents, continue the action;
		stop the action;

volume metarooms

[there is a little bit of cute code here. Odd Do's score = weird stuff, but it's also where DevReserved, the collect-all room for used objects, goes. TempMet is for items that temporarily disappear.]

part Odd Do region

[don't give the player any accidental access to these meta-rooms]

DevReserved is a privately-named room in Odd Do. "Bug." [for items you're done with]

TempMet is a privately-named room in Odd Do. "Bug." [for items in work/word row]

DropOrd is a privately-named room in Odd Do. "Bug." [for items dropped during the chase]

section debug helps - not for release

[ * this is just reassigning convenient abbreviated names to the meta-rooms ]

understand "zr/zero/devreserved/ll/lll/dev" as DevReserved. [DevReserved is my default for other games. So why not.]

understand "tm/tempmet/temp/met" and "temp met" as TempMet.

understand "dod/ord" and "drop ord" as DropOrd.

volume bonus points and odd verbs

chapter eyeing

eyeing is an action applying to one thing.

understand the command "eye" as something new.
understand the command "ecce" as something new.

understand "eye [something]" as eyeing.
understand "ecce [something]" as eyeing.

to decide which number is rowcount of (th - a thing):
	let res be 0;
	if th is ergot ogre or th is kayo yak, decide on rowcount of pact cap + 1;
	repeat through table of goodacts:
		increment res;
		if there is no use1 entry:
			if preproc entry is rev-evade-Dave rule and th is Dave, decide on res;
			if preproc entry is rev-create-tron rule:
				if th is a tronpart or th is epicer recipe, decide on res;
			if preproc entry is rev-bore-Rob rule and th is Rob, decide on res;
			if preproc entry is rev-word-row rule and th is bad dab and ever-wordrow is false, decide on res;
			if preproc entry is rev-work-row rule and th is bad dab and ever-workrow is false, decide on res;
			if preproc entry is rev-tend-net rule and th is level net, decide on res;
			if preproc entry is rev-puff-up rule and th is spur ups and puffed-up is false, decide on res;
			if preproc entry is rev-pull-up rule and th is spur ups and pulled-up is false, decide on res;
			if preproc entry is rev-stand-nats rule and th is nat's and Nat's Tan is had-or-done, decide on res;
			if preproc entry is rev-deny-Ned rule and th is Ned, decide on res;
			if preproc entry is rev-worn-row rule and th is Psi Wisp, decide on res;
			if preproc entry is rev-pace-cap rule and th is pact cap:
				if kayo yak is not moot, decide on res;
			if preproc entry is rev-yak-okay rule:
				if th is yak or th is ogre, decide on res;
			if preproc entry is rev-nail-Ian rule and th is Ian, decide on res;
			if preproc entry is rev-first-food-combo rule and th is an ingredient and number of moot ingredients < 2, decide on res;
			if preproc entry is rev-second-food-combo rule and th is an ingredient, decide on res;
			if preproc entry is rev-get-bros orb rule:
				if th is bros' orb or th is stir writs, decide on res;
			if preproc entry is rev-emit-noontime rule and th is yard ray and emitted is false, decide on res;
			next;
		if there is a use3 entry and use3 entry is moot, next;
		if use1 entry is th:
			if nextable of use1 entry and use2 entry, next;
			if there is a use2 entry and use2 entry is not moot:
				if there is no use3 entry or use3 entry is off-stage, decide on res;
		if use2 entry is th:
			if nextable of use1 entry and use2 entry, next;
			if there is a use1 entry and use1 entry is not moot:
				if there is no use3 entry or use3 entry is off-stage, decide on res;
	decide on -1;

to decide whether nextable of (u1 - a thing) and (u2 - a thing):
	if u2 is puce cup and u1 is past sap:
		if puce cup is sappy or liar grail is moot, yes;
	if u2 is puce cup and u1 is dose sod:
		if puce cup is soddy, yes;
	if u1 is wash saw and u2 is past sap and sap-takeable is true, yes;
	if u1 is radar and u2 is crag arc and UFO tofu is not off-stage, yes;
	if u1 is spa maps and u2 is code doc and maps-explained is true, yes;
	no;

carry out eyeing:
	if player does not have pact cap, say "You need the pact cap to [b]EYE[r] things." instead;
	if eyespoil of noun > 0, say "You already got a number of [eyespoil of noun] for [the noun]." instead;
	if noun is the player, say "You are always important. Always! Are you?" instead;
	if noun is the pyx, say "It probbly doesn't solve any puzzles, but I bet it'll help you get around easier." instead;
	if noun is a helpdoc and noun is not epicer recipe, say "The [noun] is just for reading." instead;
	if eye-charges is 0, say "You don't feel able to see into anything right now[if ever-pip is true]. Maybe you should look into more[end if]." instead;
	let n1 be noun;
	repeat through table of shiftables:
		if use1 entry is n1:
			now n1 is use3 entry;
			say "Your eye wanders from [the use1 entry] to [the use3 entry]...";
	let Q be rowcount of n1;
	if Q is -1, say "You see nothing special. Well, that's one less thing you need to manipulate." instead;
	say "On eyeing [the n1], you notice the pact cap registers the number [Q][one of]. You can recall this information later with [b]THINK[r][stopping].";
	now eyespoil of n1 is Q;
	decrement eye-charges;
	if eye-charges is 0, say "[line break]The pip in the pact cap winks out. You may need more good guesses to bring it back.";
	the rule succeeds.

chapter meming

definition: a thing (called th) is memorable:
	if th is off-stage, no;
	if th is moot, no;
	if th is x-it stix, no;
	if location of th is unvisited, no;
	if th is in location of player, no;
	if th is carried or th is worn, no;
	if th is scorn rocs, yes;
	if th is KAOS Oak, yes;
	if th is a phonebook, no;
	if th is scenery, no;
	yes;

definition: a thing (called th) is thingmemorable:
	if th is a person, no;
	if th is memorable, yes;
	no;

meming is an action applying to nothing.

understand the command "mem" as something new.

understand "mem" as meming.

carry out meming:
	if number of things in TempMet > 0, say "Stuff temporarily out of play: [list of things in TempMet].";
	if number of things in dropord > 0, say "Stuff you'll find in [drop-room] after this chase: [list of things in dropord].";
	let Q be number of memorable people;
	let count be 0;
	if Q > 0:
		say "Memorable people:";
		repeat with QQ running through memorable people:
			say "[if count > 0], [end if][QQ] ([location of QQ])";
			increment count;
		say ".";
	else:
		say "I can't find any memorable people outside of here.";
	now Q is number of thingmemorable things;
	let count be 0;
	if Q > 0:
		say "Memorable things:";
		repeat with QQ running through thingmemorable things:
			say "[if count > 0], [end if][QQ] ([location of QQ])";
			increment count;
		say ".";
	else:
		say "I can't find any memorable things outside of here.";
	the rule succeeds;

chapter sosing

sosing is an action out of world.

aidllping is an action out of world.

understand the command "sos" as something new.

understand "sos" as aidllping.

carry out aidllping:
	try sosing;
	if aid-LLP-yet is false:
		now aid-LLP-yet is true;
		say "Your 'correct' way of asking for aid nets a last lousy point. You didn't even need to throw in a 'Plea! [']Elp!' to make sure![paragraph break]Yay![paragraph break]";
		abide by the LLP rule; [DIAL AID]
		consider the LLP or normal score changes rule;

in-sos is a truth state that varies.

definition: a thing (called th) is in-play:
	if th is off-stage, no;
	if map region of location of th is Odd Do, no;
	yes;

definition: a thing (called th) is in-known:
	if th is off-stage, no;
	if map region of location of th is Odd Do, no;
	if location of th is unvisited, no;
	yes;

to decide whether (u1 - a thing) and (u2 - a thing) are mixable:
	if u1 is in-known and u2 is in-known, yes;
	if u1 is in-known and player is in Worn Row and ever-workrow is true and u2 is a workable, yes;
	no;

carry out sosing:
	if hint-yet is false and word number 1 in the player's command is "hint":
		say "There are more harmonious ways to ask for a hint, if you want a bonus point. But it's not critical.";
		now hint-yet is true;
	if being-chased is true:
		if chase-person is kayo yak:
			if cap-pace is false, say "[one of]You're not quite fast enough to outrun the yak on your own. An item you have can help.[or]The pact cap.[or]The pact cap can become a PACE cap.[stopping]" instead;
			if player is in trial lair, say "[one of]The kayo yak can take out the ergot ogre.[or]You just need to give the right command to the kayo yak.[or]YAK ???? will do it.[or]YAK OKAY (no comma.)[stopping]" instead;
			say "[one of]The kayo yak will keep chasing you. Maybe you can find someone else for it to knock over.[or]Someone guarding something?[or]The ergot ogre.[or]You'll need to do one more thing once you get to the Trial Lair.[stopping]" instead;
		if player is in Worn Row, say "[one of]You have the Psi Wisp in the right place, but you can't do anything here in [Worn Row], yet.[or]You have to change it.[or]WORN ROW. The redness ender will take care of the psi wisp.[stopping]" instead;
		say "[one of]The psi wisp is certainly red. Maybe there's something that could neutralize it.[or]Do you remember a room at the start?[or]It sort of isn't there any more.[or]Go to Word/Work Row, first.[stopping]" instead;
	let take-clues be 0;
	repeat through table of just take it:
		if to-take entry is in where-is entry and where-is entry is visited:
			if there is no take-check entry:
				increment take-clues;
				say "[if take-clues is 1]Y[else]Also, y[end if]ou can just take [the to-take entry] [hn-in of where-is entry].";
			else:
				process the take-check entry;
				if the rule succeeded:
					increment take-clues;
					say "[if take-clues is 1]Y[else]Also, y[end if]ou can just take [the to-take entry] [hn-in of where-is entry].";
	if take-clues > 0:
		say "NOTE: This poke to take something may be a distraction from more rigorous and immediate puzzles, but I'd rather first point you to something you overlooked but may be able to use before spoiling a puzzle.";
		if debug-state is true:
			say "Falling through to see what hints I would've gotten, for debug purposes. This should not be in the release version.[paragraph break]";
		else:
			the rule succeeds;
	now in-sos is true;
	let count be 0;
	repeat through table of goodacts:
		if there is a room-to-go entry and room-to-go entry is not location of player, next;
		if there is a use1 entry:
			if use1 entry and use2 entry are mixable:
				if there is a preproc entry:
					if debug-state is true, say "Checking [preproc entry].";
					consider the preproc entry;
					if the rule failed, next;
					if the rule succeeded:
						if debug-state is true, say "[preproc entry] succeeded!";
						now in-sos is false;
						the rule succeeds;
				say "[if debug-state is true](DEFAULT-1) [end if][if use2 entry is a workable and Worn Row is not worky]Change to WORK ROW, then [end if]USE [printed name of use1 entry in upper case] ON [printed name of use2 entry in upper case].";
				now in-sos is false;
				the rule succeeds;
		else if there is a preproc entry:
			consider the preproc entry;
			if the rule succeeded:
				now in-sos is false;
				the rule succeeds;
	say "I can't find anything specific to do here right now. So let's look more generally.";
	repeat through table of goodacts:
		if there is a room-to-go entry and room-to-go entry is unvisited, next;
		if there is a use1 entry:
			if use1 entry and use2 entry are mixable:
				if there is a preproc entry:
					consider the preproc entry;
					if the rule failed, next;
					if the rule succeeded:
						if debug-state is true, say "[preproc entry] succeeded!";
						now in-sos is false;
						the rule succeeds;
				say "[if debug-state is true](DEFAULT-2) [end if][if use2 entry is a workable and Worn Row is not worky]Change to WORK ROW, then [end if]USE [printed name of use1 entry in upper case] ON [printed name of use2 entry in upper case].";
				now in-sos is false;
				the rule succeeds;
		else if there is a preproc entry:
			consider the preproc entry;
			if the rule succeeded:
				if debug-state is true:
					say "[preproc entry] succeeded!";
					now in-sos is false;
					the rule succeeds;
	repeat through table of goodacts:
		if there is a room-to-go entry and room-to-go entry is unvisited:
			let oiq be in-dir of room-to-go entry;
			say "GENERAL HINT: the room [opposite of oiq] of [in-room of room-to-go entry] is available, but you haven't visited there yet.";
			now in-sos is false;
			the rule succeeds;
	say "Uh oh, I couldn't find a hint.";
	now in-sos is false;
	the rule succeeds;

report sosing: now in-sos is false;

to say vague-dir of (rm - a room):
	let r2 be rm;
	let away be 0;
	let idr be north;
	while r2 is unvisited:
		increment away;
		let idr be in-dir of r2;
		let r2 be the room idr of r2;
		if away is 10:
			say "a room at ([the remainder after dividing loc-num of rm by 10], [loc-num of rm / 10]) from the northeast of the map";
			let idr be in-dir of r2;
			continue the action;
	let oid be opposite of idr;
	say "a room [oid] of [hn of r2][if away > 1], and then some[end if]";

section hint rules just take it table [xxoga]

table of just take it [xxjti]
to-take	where-is	take-check
trap art	Art Xtra	a rule
mayo yam	Yell Alley	--
poo coop	Moo Room	--
puce cup	Emo Dome	cup-take rule
troll ort	Swept Pews	--
demo med	Dopy Pod	--
stamp mats	Frush Surf	--
stinky knits	Gross Org	knits-take rule
gold log	Pro Corp	corp-take rule
DNA band	Pro Corp	corp-take rule
Bros' Orb	Le Babel	orb-take rule
rep popper	Yell Alley	popper-take rule

this is the corp-take rule:
	if psi wisp is moot, the rule succeeds;
	the rule fails;

this is the popper-take rule:
	if dork rod is moot, the rule succeeds;
	the rule fails;

this is the cup-take rule:
	if pulled-up is true, the rule succeeds;
	the rule fails;

this is the knits-take rule:
	if Ned is moot, the rule succeeds;
	the rule fails;

this is the orb-take rule:
	if player has stir writs, the rule succeeds;
	the rule fails;

section hint rules [xxhr]

to say once-work: say "[if Worn Row is not worky], once you change to Work Row[end if]"

to say once-word: say "[if Worn Row is not wordy], once you change to Word Row[end if]"

this is the pre-ore-on-reviver rule:
	if in-sos is true:
		if eroded ore is moot or eroded ore is off-stage, the rule fails;
		say "[one of]The eroded ore could use an upgrade[or]One of the three machines can fix the eroded ore[or]USE ERODED ORE ON REVIVER[once-work][stopping].";
	the rule succeeds;

this is the pre-band-on-reifier rule:
	if in-sos is true:
		if DNA band is in Pro Corp or DNA band is off-stage, the rule fails;
		say "[one of]The DNA band isn't much by itself[or]You should use machines to augment the DNA band[or]There's a question as to which Work Row machine would help the DNA band become something real and living[or]USE DNA BAND ON REIFIER[once-work][stopping].";
	the rule succeeds;

this is the pre-not-a-baton-on-reifier rule:
	if in-sos is true:
		if not-a-baton is moot or not-a-baton is off-stage, the rule fails;
		say "[one of]The not-a-baton isn't useful as-is[or]One more time with a machine should fix the not-a-baton[or]You may or may not have knocked out a lot of machines so far, so there may be only one left that works on the not-a-baton[or]The not-a-baton needs to be defined by what it is, not what it isn't[or]USE REIFIER ON NOT-A-BATON[once-work][stopping].";
	the rule succeeds;

this is the pre-knits-on-rotator rule:
	if in-sos is true:
		unless stinky knits are carried by the player, the rule fails;
		say "[one of]Phew! Those stinky knits could use a washing[or]There's no washing machine in the game, but there's something close enough, the knits might get clean[or]USE STINKY KNITS ON ROTATOR[once-work][stopping].";
	the rule succeeds;

this is the pre-log-on-rotator rule:
	if in-sos is true:
		if gold log is moot or gold log is in Pro Corp, the rule fails;
		say "[one of]The gold log would be valuable in a treasure hunt, but not here.[or]There's something inside the gold log. It's hollow. What sort of machine would shake it out?[or]USE GOLD LOG ON ROTATOR[once-work].[stopping]";
	the rule succeeds;

this is the pre-buoy-on-rotator rule:
	if in-sos is true:
		if you buoy is moot or you buoy is off-stage, the rule fails;
		say "[one of]The you buoy would be valuable in a treasure hunt, but not here.[or]There's something inside the you buoy. It's hollow. What sort of machine would shake it out?[or]USE YOU BUOY ON ROTATOR[once-work].[stopping]";
	the rule succeeds;

this is the pre-med-on-lug rule:
	if in-sos is true:
		if demo med is moot, the rule fails;
		if player has demo med:
			say "[one of]The demo med could help someone[or]The demo med's brand is DYSPEPSYD. Think of someone who might have stomach troubles[or]USE DEMO MED ON GULF LUG[hn-in-blank of Flu Gulf][stopping].";
		else:
			say "You don't have what you need to help the Gulf Lug, yet. You need to get beyond Drawl Ward.";
		the rule succeeds;
	the rule succeeds;

this is the pre-sac-on-orc rule:
	if in-sos is true:
		if cash sac is moot, the rule fails;
		if player has cash sac:
			say "[one of]You have what you need to bribe the cross orc[or]USE CASH SAC ON CROSS ORC [hn-in of Toll Lot][stopping].";
		else:
			say "[one of]To pay the orc, you need someone to get you valuables. Preferably, money[or]To get cash for the orc, you may need to help someone who can offer money in exchange for help[or][if Flu Gulf is visited]If you help the Gulf Lug, you can get past the cross orc[else]You haven't found anyone with money yet, but once you get some, you can use it on the cross orc[end if][stopping].";
	the rule succeeds;

this is the pre-rid-on-reviver rule:
	if in-sos is true:
		if Dirt Rid is moot or Dirt Rid is off-stage, the rule fails;
		say "[one of]The Dirt Rid could use an upgrade[or]The Dirt Rid's already real enough, and spinning it might cause its parts to get even more discombobulated[or]USE DIRT RID ON REVIVER[once-work][stopping].";
	the rule succeeds;

this is the pre-mats-on-metals rule:
	if in-sos is true:
		unless Ye Key is off-stage, the rule fails;
		if player is in Scrap Arcs:
			say "[one of]You have everything you need here[or]Maybe you can cut something out of the slate metals[or]USE STAMP MATS ON SLATE METALS[stopping].";
		else:
			say "[one of]The stamp mats must be good for something[or]They could maybe create a pattern on the right sort of material--material nobody else would use[or]Scrap Arcs has spare stuff[or]USE STAMP MATS ON SLATE METALS[stopping].";
	the rule succeeds;

this is the pre-attaboy-on-Sniffins rule:
	if in-sos is true:
		if yob attaboy is moot, the rule fails;
		if player has yob attaboy:
			say "[one of]Sniffins needs help. Maybe you have something[or]USE YOB ATTABOY ON SNIFFINS[stopping].";
		else:
			say "[one of]Sniffins could use support[or]Maybe give Sniffins something to read[or]Maybe a book in Word Row would improve Sniffins's social standing[or]GET YOB ATTABOY[once-word][stopping].";
	the rule succeeds;

this is the pre-art-on-reifier rule:
	if in-sos is false, the rule succeeds;
	if trap art is moot or player does not have trap art, the rule fails;
	if ever-wordrow is false:
		say "You need to change [Worn Row].";
	else if Art Xtra is unvisited:
		say "Look north of Yawn Way. You haven't been there yet.";
	else:
		say "[one of]You can use the trap art on one of the machines [hn-in of Worn Row][or]Use the trap art on the reifier[stopping][once-work].";
	the rule succeeds;

this is the pre-trap-on-rats rule:
	if in-sos is false, the rule succeeds;
	if stark rats are moot, the rule fails;
	if Seer Trees is unvisited:
		say "You should visit west of Fun Enuf.";
	else if player has trap art:
		say "[one of]The trap art is not enough to catch the stark rats, but it's a good plan[or][if Worn Row is unvisited]You haven't found the place to change the trap art, yet[else if Worn Row is not worky]You need to change [Worn Row] to something else[else][one of]You need to use the trap art on one of the machines[or]USE TRAP ART ON REIFIER in Word Row[stopping][end if][stopping].";
	else if player has party trap:
		say "[one of]You have the item you need to catch the stark rats[or]Many verbs work to catch the rats[or]DROP TRAP, TRAP RATS, or USE PARTY TRAP ON STARK RATS[stopping].";
	else:
		say "[one of]The stark rats [hn-in of Seer Trees] are tough to catch[or]You need an item that will catch the stark rats[or]The trap art [hn-in of Art Xtra] will get you started[stopping].";
	the rule succeeds;

this is the pre-ti-on-frood rule:
	if in-sos is false, the rule succeeds;
	if Door Frood is moot, the rule fails;
	if Evaded Ave is unvisited, the rule fails;
	if Worn Row is unvisited:
		say "[one of]The Door Frood requires something from a location you haven't been yet[or][if My Gym is visited]You need to go west of My Gym[else]You need to go south and west of Yawn Way[end if][stopping].";
	else if ever-wordrow is false:
		say "You need something from [Worn Row], but not in a configuration you've discovered yet. Go there.";
	else if player has TI:
		say "[one of]You have what the Door Frood wants[or]USE TI ON DOOR FROOD[stopping].";
	else if Worn Row is worky:
		say "You need something from Word Row, but currently it's [Worn Row].";
	else:
		say "[one of]You need a book from [Worn Row], but there is more than one[or]The Door Frood likes to look down on people[or][TI] is the book the Door Frood would like[or]Once you get [i]TO IDIOT[r] from Word Row, USE TI ON DOOR FROOD[stopping].";
	the rule succeeds;

this is the pre-tip-on-eye rule:
	if in-sos is false, the rule succeeds;
	if pity tip is moot, the rule fails;
	if Evaded Ave is unvisited, the rule fails;
	if Worn Row is unvisited:
		say "[one of]The Door Frood requires something from a location you haven't been yet[or][if My Gym is visited]You need to go west of My Gym[else]You need to go south and west of Yawn Way[end if][stopping].";
	else if ever-wordrow is false:
		say "You need something from [Worn Row], but not in a configuration you've discovered yet. Go there.";
	else if Yell Alley is unvisited:
		say "You need to visit east of [hn of Evaded Ave].";
	else:
		say "[one of]The eye on the van needs to scan something. You have an item that clues this[or]The van is named Seedy Dee's[or]The pity tip offers a free sample at Seedy Dee's[or]USE PITY TIP ON VAN (or eye)[stopping].";
	the rule succeeds;

chapter aiding

aiding is an action out of world.

understand the command "dial aid" as something new.
understand the command "aid" as something new.
understand the command "hint" as something new.

understand "aid" as sosing.
understand "dial aid" as aidllping.
understand "hint" as sosing.

aid-LLP-yet is a truth state that varies.

more-later is a truth state that varies.
hint-yet is a truth state that varies.

carry out aiding:
	if being-chased is true:
		if chase-person is kayo yak:
			if cap-pace is false, say "[one of]You're not quite fast enough to outrun the yak on your own. An item you have can help.[or]The pact cap.[or]The pact cap can become a PACE cap.[stopping]" instead;
			if player is in trial lair, say "[one of]The kayo yak can take out the ergot ogre.[or]You just need to give the right command to the kayo yak.[or]YAK ???? [or]YAK OKAY (no comma)[stopping]." instead;
			say "[one of]The kayo yak will keep chasing you. Maybe you can find someone else for it to knock over.[or]Someone guarding something?[or]The ergot ogre.[or]You'll need to do one more thing once you get to the Trial Lair.[stopping]" instead;
		if player is in Worn Row, say "[one of]You have the Psi Wisp in the right place, but you can't do anything here in [Worn Row], yet.[or]You have to change it.[or]WORN ROW. The redness ender will take care of the psi wisp.[stopping]" instead;
		say "[one of]The psi wisp is certainly red. Maybe there's something that could neutralize it.[or]Do you remember a room at the start?[or]It sort of isn't there any more.[or]Go to Word/Work row, first.[stopping]" instead;
	abide by the hint-rule of location of player;
	consider the finished-rule of location of player;
	let all-done-here be whether or not the rule succeeded;
	say "You're done here, for [if all-done-here is true]good[else]now[end if][if row-prog > 1 and row-prog-warn is false][but-row][end if]. Would you like to be pointed to somewhere else relevant?"; [?? test case: remove Yuge Guy check in Sneer Greens but have him around. I should see an error] [?? what about going north in Emo Dome]
	unless the player yes-consents, say "Okay." instead;
	now search-hint-room is true;
	repeat with Q running through L:
		if debug-verbose is true, say "Checking [Q] in order.[run paragraph on][line break]";
		consider the avail-rule of Q;
		unless the rule succeeded, next;
		consider the hint-rule of Q;
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
				consider the hint-rule of Q;
			break;
	if search-hint-room is true:
		now search-hint-room is false;
		say "I'm out of ideas for rooms you've visited. Maybe look around the map a bit more.";
	the rule succeeds;

row-prog-warn is a truth state that varies.

to say but-row:
	now row-prog-warn is true;
	say ", but I may note something in [if Worn Row is wordy]Work[else if Worn Row is worky]Word[else]Worn/Work[end if] Row if you switch back there"

report aiding: consider the LLP or normal score changes rule;

to describe-nearby (ro - a room):
	repeat with dir running through maindir:
		let DR be the room dir of ro;
		if DR is visited:
			say "Try looking [opposite of dir] [hn-of of DR]. You haven't, yet[one of]. [b]NOTE: for future reference, AID first looks for rooms you can, but haven't, visited, if you request it in a room that's cleared for now. This is meant as a final buffer against hints you don't want, but it may point you away from a nearby puzzle[r][or][stopping].";
			continue the action;
	if player is in Fun Enuf and ro is Art Xtra:
		say "Try exploring Yelpley to the east.";
		continue the action;
	say "There's a room you haven't visited with something to do, but it's pretty far away.";
	if in-beta is true, say "(BETA TESTER NOTE) [ro] isn't being flagged correctly."

search-hint-room is a truth state that varies.

this is the trivially false rule: the rule fails;

this is the trivially true rule: the rule succeeds;

a room has a rule called hint-rule. hint-rule of a room is usually dunno-hint rule.

a room has a rule called finished-rule. finished-rule of a room is usually the trivially true rule.

this is the dunno-hint rule: [I should never have to use this in the final release.]
	say "I haven't determined hints for [location of player], yet.";
	the rule succeeds;

section shuffling and room clue order

to hint-bump-worn:
	shuffle-before Worn Row and Dirge Grid;

[this is the list of how I do things in the walkthrough.]

L is a list of rooms variable. L is { Fun Enuf, Art Xtra, My Gym, Worn Row, Evaded Ave, Yell Alley, Trapeze Part, Seer Trees, Cold Loc, Yawn Way, Ooze Zoo, Frush Surf, Emo Dome, Swept Pews, Apse Spa, Drawl Ward, Dopy Pod, Scrap Arcs, Flu Gulf, Toll Lot, Deft Fed, Gross Org, Pro Corp, Moo Room, Dumb Mud, Swamp Maws, Yack Cay, Lac Oft Focal, Uneven U, Trial Lair, Motto Bottom, Mont Nom, Le Babel, Sneer Greens, Red Roses Order, Dirge Grid }

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

section bulk hint-rule definitions

hint-rule of Apse Spa is apse-spa-hint rule.
hint-rule of Art Xtra is art-xtra-hint rule.
hint-rule of Cold Loc is cold-loc-hint rule.
hint-rule of Deft Fed is deft-fed-hint rule.
hint-rule of Dirge Grid is dirge-grid-hint rule.
hint-rule of Dopy Pod is dopy-pod-hint rule.
hint-rule of Drawl Ward is drawl-ward-hint rule.
hint-rule of Dumb Mud is dumb-mud-hint rule.
hint-rule of Emo Dome is emo-dome-hint rule.
hint-rule of Evaded Ave is evaded-ave-hint rule.
hint-rule of Flu Gulf is flu-gulf-hint rule.
hint-rule of Frush Surf is frush-surf-hint rule.
hint-rule of Fun Enuf is fun-enuf-hint rule.
hint-rule of Gross Org is gross-org-hint rule.
hint-rule of Lac Oft Focal is lac-oft-focal-hint rule.
hint-rule of Lair Trial is lair-trial-hint rule.
hint-rule of Le Babel is le-babel-hint rule.
hint-rule of Mont Nom is mont-nom-hint rule.
hint-rule of Moo Room is moo-room-hint rule.
hint-rule of Motto Bottom is motto-bottom-hint rule.
hint-rule of My Gym is my-gym-hint rule.
hint-rule of Ooze Zoo is ooze-zoo-hint rule.
hint-rule of Pro Corp is pro-corp-hint rule.
hint-rule of Red Roses Order is red-roses-order-hint rule.
hint-rule of Scrap Arcs is scrap-arcs-hint rule.
hint-rule of Seer Trees is seer-trees-hint rule.
hint-rule of Sneer Greens is sneer-greens-hint rule.
hint-rule of Swamp Maws is swamp-maws-hint rule.
hint-rule of Swept Pews is swept-pews-hint rule.
hint-rule of Toll Lot is toll-lot-hint rule.
hint-rule of Trapeze Part is trapeze-part-hint rule.
hint-rule of Uneven U is uneven-u-hint rule.
hint-rule of Worn Row is worn-row-hint rule.
hint-rule of Yack Cay is yack-cay-hint rule.
hint-rule of Yawn Way is yawn-way-hint rule.
hint-rule of Yell Alley is yell-alley-hint rule.

section hint-rule-check - not for release

[ * this is something that checks to make sure all rooms have a nontrivial hint rule. Perhaps it should be schlepped to Finished Code. ]

when play begins:
	repeat with Q running through rooms:
		if map region of Q is Odd Do, next;
		if finished-rule of Q is trivially true rule, say "finished-rule of [q] needs change from default.";
		if hint-rule of Q is dunno-hint rule, say "hint-rule of [q] needs change from default.";

section finished-rule definitions

[these need to be undefined from the trivially true rule]

finished-rule of Apse Spa is apse-spa-complete rule.
finished-rule of Art Xtra is art-xtra-complete rule.
finished-rule of Cold Loc is cold-loc-complete rule.
finished-rule of Deft Fed is deft-fed-complete rule.
finished-rule of Dirge Grid is deft-fed-complete rule.
finished-rule of Dopy Pod is dopy-pod-complete rule.
finished-rule of Drawl Ward is drawl-ward-complete rule.
finished-rule of Dumb Mud is dumb-mud-complete rule.
finished-rule of Emo Dome is emo-dome-complete rule.
finished-rule of Evaded Ave is evaded-ave-complete rule.
finished-rule of Flu Gulf is flu-gulf-complete rule.
finished-rule of Frush Surf is frush-surf-complete rule.
finished-rule of Fun Enuf is trivially false rule.
finished-rule of Gross Org is gross-org-complete rule.
finished-rule of Lac Oft Focal is lac-oft-focal-complete rule.
finished-rule of Lair Trial is lair-trial-complete rule.
finished-rule of Le Babel is le-babel-complete rule.
finished-rule of Mont Nom is mont-nom-complete rule.
finished-rule of Moo Room is moo-room-complete rule.
finished-rule of Motto Bottom is motto-bottom-complete rule.
finished-rule of My Gym is my-gym-complete rule.
finished-rule of Ooze Zoo is ooze-zoo-complete rule.
finished-rule of Pro Corp is pro-corp-complete rule.
finished-rule of Red Roses Order is red-roses-order-complete rule.
finished-rule of Scrap Arcs is scrap-arcs-complete rule.
finished-rule of Seer Trees is seer-trees-complete rule.
finished-rule of Sneer Greens is sneer-greens-complete rule.
finished-rule of Swamp Maws is swamp-maws-complete rule.
finished-rule of Swept Pews is swept-pews-complete rule.
finished-rule of Toll Lot is toll-lot-complete rule.
finished-rule of Trapeze Part is trapeze-part-complete rule.
finished-rule of Uneven U is uneven-u-complete rule.
finished-rule of Worn Row is worn-row-complete rule.
finished-rule of Yack Cay is yack-cay-complete rule.
finished-rule of Yawn Way is yawn-way-complete rule.
finished-rule of Yell Alley is yell-alley-complete rule.

section Apse Spa rule

this is the apse-spa-hint rule:
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

this is the art-xtra-hint rule:
	if trap art is not in Art Xtra and stark rats are not moot, continue the action;
	if soot tattoos are not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if trap art is in Art Xtra, say "The trap art will be useful, with a change." instead;
	if el doodle is in Art Xtra, say "El doodle will be useful, with a change." instead;
	if straw arts is off-stage, say "You need to make some art for the Revolt Lover." instead;
	if player has straw arts, say "USE STRAW ARTS ON REVOLT LOVER." instead;
	say "Eep! There's a lot to do here, and I messed things up." instead;

this is the art-xtra-complete rule:
	if soot tattoos are moot, the rule succeeds;
	the rule fails;

section Cold Loc rule

this is the cold-loc-hint rule:
	if King Nik is moot and puce cup is sappy, continue the action;
	if King Nik is moot and puffed-up is false, continue the action;
	if liar grail is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if King Nik is in Cold Loc:
		if ever-wordrow is false, say "Work Row can still be changed into something else." instead;
		if player does not have Epoch Cope, say "[one of]You need a[if number of lugged books > 0]nother[end if] book to help King Nik[or]Epoch Cope (EC) from Word Row will help King Nik[stopping]." instead;
		say "USE EPOCH COPE ON KING NIK." instead;
	if wash saw is off-stage, say "Get the wash saw from My Gym." instead;
	if sap-takeable is false, say "USE WASH SAW ON PAST SAP." instead;
	if player does not have puce cup, say "You need the puce cup from the Emo Dome." instead;
	say "USE PUCE CUP ON PAST SAP." instead;

this is the cold-loc-complete rule:
	if King Nik is moot:
		if puce cup is sappy or liar grail is moot, the rule succeeds;
	the rule fails;

section Deft Fed rule

this is the deft-fed-hint rule:
	if Elan Ale is moot, continue the action;
	if Bond Nob is not moot and yob attaboy is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if yob attaboy is not moot, say "USE YOB ATTABOY ON SNIFFINS." instead;
	say "USE ELAN ALE ON SNIFFINS." instead;

this is the deft-fed-complete rule:
	if Elan Ale is moot and Nat's Tan is had-or-done, the rule succeeds;
	the rule fails;

section Dirge Grid rule

this is the dirge-grid-hint rule:
	if player has the X-ITE TIX, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Verses Rev is in Dirge Grid, say "[one of]You need to dispose of the Verses Rev[or]USE TABOO BAT ON VERSES REV[stopping]." instead;
	if Knife Fink is in Dirge Grid, say "[one of]You need to dispose of the Knife Fink[or]USE ME GEM ON KNIFE FINK[stopping]." instead;
	say "[one of]You need to dispose of the Diktat Kid, but you can't attack the Kid directly[or]USE YARD RAY ON REDIVIDER[stopping]." instead;

this is the dirge-grid-complete rule:
	if player has X-ITE TIX, continue the action;
	the rule fails;

section Dopy Pod rule

this is the dopy-pod-hint rule:
	if cassettes sac is moot and pill lip is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if demo med is in Dopy Pod, say "Take the demo med." instead;
	if cave vac is off-stage, say "You need to come back once you have something that can clean the Dopy Pod." instead;
	if Dirt Rid is off-stage, say "You need to come back once you have converted the cave vac to something more powerful." instead;
	say "USE CAVE VAC ON CASSETTES SAC." instead;

this is the dopy-pod-complete rule:
	if cassettes sac is moot and pill lip is moot, the rule succeeds;
	the rule fails;

section Drawl Ward rule

this is the drawl-ward-hint rule:
	if Bond Nob is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if puce cup is not soddy, say "[one of]You have the puce cup, but it needs to be filled with something other than the past sap/purist sirup that got you by the Liar Grail.[or]You need something healing.[or]If you navigated the Apse Spa, you'll see what's there.[or]Once you have the dose sod from the Apse Spa, USE PUCE CUP ON [psu].[stopping]" instead;
	say "USE PUCE CUP ON [psu]." instead;

to say psu:
	let X be the printed name of Bond Nob;
	say "[X in upper case]";

this is the drawl-ward-complete rule:
	if Bond Nob is moot, the rule succeeds;
	the rule fails;

section Dumb Mud rule

this is the dumb-mud-hint rule:
	if lie veil is moot and turf rut is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Moo Room is unvisited, say "There's a part of southeast Grebeberg you haven't explored yet[if Ooze Zoo is visited and sleep eels are in Ooze Zoo]. You need to get past the sleep eels[end if]." instead;
	if gnu dung is in Dumb Mud, say "[one of]You need a way to get rid of the gnu dung so you can go west.[or][if player does not have poo coop]The poo coop in the Moo Room will help you[else]USE POO COOP ON GNU DUNG[end if].[stopping]" instead;
	if turf rut is in Dumb Mud, say "[one of]You need a way to fill up the turf rut.[or]You'd love to get rid of the poo coop.[or]USE POO COOP ON TURF RUT.[stopping]" instead;
	say "[one of]You need something to cut the lie veil[or][if player has exam axe]USE EXAM AXE ON LIE VEIL[else]You will need an item you don't have yet for the Lie Veil[end if][stopping]." instead;

this is the dumb-mud-complete rule:
	if lie veil is moot and turf rut is moot, the rule succeeds;
	the rule fails;

section Emo Dome rule

this is the emo-dome-hint rule:
	if player has Bros' Orb:
		if player has state tats, continue the action;
	else:
		if puce cup is not in Emo Dome and pulled-up is true, continue the action;
	if search-hint-room is true, the rule succeeds;
	if pulled-up is false, say "[one of]You managed to PUFF UP with the spur ups, but it looks like they have one more use[or]PULL UP[stopping]." instead;
	if puce cup is in Emo Dome, say "Take the puce cup." instead; [move Emo Dome just before Red Roses Order??]
	if player has state tats and player does not have Bros' Orb, say "You have ID, but you need an item that makes you feel brave enough. [if Le Babel is visited]The Bros['] Orb[else]It's in a place you haven't visitef yet[end if]." instead;
	if id-pieces is 0, say "You need to get past the DIFF-ID by combining two items to create identification. They are found elsewhere." instead;
	if id-pieces is 1, say "The [if player has gate tag]gate tag[else]soot tattoos[end if] will make up part of the state tats you need to pass the DIFF-ID." instead;
	if id-pieces is 2, say "USE SOOT TATTOOS ON GATE TAG." instead;

to decide which number is id-pieces:
	let temp be 0;
	if player has soot tattoos, increment temp;
	if player has gate tag, increment temp;
	decide on temp;

this is the emo-dome-complete rule:
	if state tats are not off-stage, the rule succeeds;
	the rule fails;

section Evaded Ave rule

this is the evaded-ave-hint rule:
	if Door Frood is moot and bunk nub is not in Evaded Ave, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Door Frood is in Evaded Ave:
		if My Gym is unvisited, say "Visit south of Yawn Way a bit." instead;
		if Worn Row is unvisited, say "See about west of My Gym." instead;
		if row-prog is 0, say "Worn Row can become something else. A couple other things, actually." instead;
		if row-prog is 1, say "You changed [Worn Row] from Worn Row, but it can become something else." instead;
		if player has TI, say "[one of]You have a book the Door Frood wants[or]USE TO IDIOT ON DOOR FROOD[stopping]." instead;
		say "[one of]Word Row has some interesting books. Maybe one would please the Door Frood.[or]You need something daring and obnoxious.[or]Get TI from Word Row.[stopping]" instead;
	say "You just need to take the bunk nub here." instead;

this is the evaded-ave-complete rule:
	if Door Frood is moot and bunk nub is not in Evaded Ave, the rule succeeds;
	the rule fails;

section Flu Gulf rule

this is the flu-gulf-hint rule:
	if scorn rocs are moot, continue the action;
	if Bond Nob is in Drawl Ward, continue the action;
	if search-hint-room is true, the rule succeeds;
	if gulf lug is not moot, say "The gulf lug needs medicine. [if Bond Nob is not moot]You haven't opened the location that has it[else if Dopy Pod is not visited]It's west of the Drawl Ward[else if player does not have demo med]It's the demo med[else]USE DEMO MED ON GULF LUG[end if]." instead;
	say "[one of]The scorn rocs can be repelled by something that would stain them.[or][if player has Nat's Tan]USE TAN ON ROCS[else]You need to get the Nat's Tan from [Deft Fed][end if].[stopping]" instead;

this is the flu-gulf-complete rule:
	if scorn rocs are moot, the rule succeeds;
	the rule fails;

section Frush Surf rule

this is the frush-surf-hint rule:
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

section Fun Enuf rule

this is the fun-enuf-hint rule:
	now more-later is true; [ we will always have more to do here ]
	if Dirge Grid is not mapped north of Fun Enuf and Flee Elf is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Flee Elf is in Fun Enuf, say "[one of]The Flee Elf wants you to take the cap. But not take. A synonym. To show you're in tune with this place.[or]PAC* CAP is the way to go.[or]PACK CAP.[stopping]" instead;
	if epicer recipe is off-stage, say "There's a useful list of items in Yelpley that may help you figure a way north." instead;
	if tron-got < 4, say "You'll need to come back later to break open the North-Tron." instead;
	if KAOS Oak is in fun enuf, say "USE any part of the North-Tron on another." instead;
	if grid-side-items < 3, say "You need three items to defeat the Diktat Kid north and have [grid-side-items in words]." instead;
	if player has X-ITE TIX, say "USE TIX ON TIX EXIT." instead;
	continue the action;

section Gross Org rule

this is the gross-org-hint rule:
	if etage gate is not in Gross Org, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Ned is not moot, say "DENY NED." instead;
	if stinky knits are in Gross Org, say "You need to take the stinky knits." instead;
	if player does not have Ye Key, say "You need to create a key for the Etage Gate." instead;
	say "USE YE KEY ON ETAGE GATE." instead;

this is the gross-org-complete rule:
	if stinky knits are not in Gross Org and etage gate is moot, the rule succeeds;
	the rule fails;

section Lac Oft Focal rule

this is the lac-oft-focal-hint rule:
	if dork rod is moot and elope pole is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player has dork rod, say "USE DORK ROD ON TAO BOAT." instead;
	if player has elope pole, say "USE ELOPE POLE ON KAYAK." instead;
	say "You need to find an item somewhere else to [if dork rod is moot]navigate the kayak[else if elope pole is moot]feel the peace needed to enter the Tao Boat[else]make use of the kayak and Tao Boat[end if]." instead;

this is the lac-oft-focal-complete rule:
	if dork rod is moot and elope pole is moot, the rule succeeds;
	the rule fails;

section Lair Trial rule

this is the lair-trial-hint rule:
	if ergot ogre is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if kayo yak is in Lair Trial, say "YAK OKAY." instead;
	say "[one of]You need to bring something that can knock the ogre off. You can't do it yourself.[or]Get the kayo yak to chase you.[stopping]" instead;

this is the lair-trial-complete rule:
	if ergot ogre is moot, the rule succeeds;
	the rule fails;

section Le Babel rule

this is the le-babel-hint rule:
	if Bros' Orb is not in Le Babel, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player does not have stir writs, say "You need something to help you take the Bros['] Orb. It's in [if Motto Bottom is unvisited]a place you haven't visited yet[else]Motto Bottom[end if]." instead;
	say "All you really have to do here is take the Bros['] Orb." instead;

this is the le-babel-complete rule:
	if Bros' Orb is not in Le Babel, the rule succeeds;
	the rule fails;

section Mont Nom rule

this is the mont-nom-hint rule:
	unless martini tram is off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Ian is in Mont Nom, say "NAIL IAN." instead;
	if number of solid ingredients carried by player > 0 and number of liquid ingredients carried by player > 0, say "[one of]You can make some food here.[or]USE [printed name of random solid ingredient carried by player in upper case] ON [printed name of random liquid ingredient carried by player in upper case].[stopping]" instead;
	say "You need to find some more food before using it here." instead;

this is the mont-nom-complete rule:
	if martini tram is not off-stage, the rule succeeds;
	the rule fails;

section Moo Room rule

this is the moo-room-hint rule:
	if yahoo hay is moot, continue the action;
	if art-free-warn is false:
		if poo coop is not in Moo Room and straw arts are not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if poo coop is in Moo Room, say "Take the poo coop." instead;
	if player has SOME DEMOS, say "USE SOME DEMOS ON YAHOO HAY." instead;
	if player has enact cane, say "USE ENACT CANE ON YAHOO HAY." instead;
	say "[one of]You need to use a book from Word Row to make art[or][if player has SOME DEMOS]USE SOME DEMOS ON YAHOO HAY[else]There's a book that doesn't fall from the tract cart until you've taken three others and successfully used two[end if][stopping]." instead;

this is the moo-room-complete rule:
	if yahoo hay is moot, the rule succeeds;
	the rule fails; [as a future note, getting rid of the yahoo hay requires the enact cane which you get from the tao boat. So just the one condition is sufficient.]

section Motto Bottom rule

this is the motto-bottom-hint rule:
	if stir writs are not had-or-done and sage gas is not had-or-done, continue the action;
	if search-hint-room is true, the rule succeeds;
	if sage gas is not had-or-done, say "You need to get something from Apse Spa." instead;
	if player has sage gas, say "USE SAGE GAS ON TAME MAT." instead;
	say "USE SHARP RAHS ON GURU RUG." instead;

this is the motto-bottom-complete rule:
	if stir writs is moot or player has stir writs, the rule succeeds;
	the rule fails;

section My Gym rule

this is the my-gym-hint rule:
	if Dave is not in My Gym, continue the action;
	if search-hint-room is true, the rule succeeds;
	if wash saw is in My Gym and Dave is not in My Gym, say "Take the wash saw." instead;
	say "[one of]Dave is in the way, but he doesn't quite fit in Yelpley.[or]How could you expose him, appropriate to the whole game?[or]You need to sneak by.[or]EVADE DAVE.[stopping]" instead;

this is the my-gym-complete rule:
	if wash saw is not in My Gym, the rule succeeds;
	the rule fails;

section Ooze Zoo rule

this is the ooze-zoo-hint rule:
	if sleep eels are moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if bunk nub is in Yell Alley, say "You need to get rid of the sleep eels without harming them. You don't have anything remotely sleep-sounding." instead;
	if player has bunk nub, say "The bunk nub isn't quite enough to give the sleep eels a good rest. Maybe you can improve it, like you did the trap art." instead;
	say "USE STOCK COTS ON SLEEP EELS." instead;

this is the ooze-zoo-complete rule:
	if sleep eels are moot, the rule succeeds;
	the rule fails.

section Pro Corp rule

this is the pro-corp-hint rule:
	if resale laser is not off-stage and DNA band is not in Pro Corp and gold log is not in Pro Corp, continue the action;
	if search-hint-room is true, the rule succeeds;
	if DNA band is in Pro Corp, say "Take the DNA band." instead;
	if gold log is in Pro Corp, say "Take the gold log." instead;
	if Gorge Grog is off-stage, say "[one of]You need a liquid to pour down the butene tub. A caustic one.[or]Bon Snob has a liquid to pour down the tub.[stopping]" instead;
	say "USE GORGE GROG ON BUTENE TUB." instead;

this is the pro-corp-complete rule:
	if resale laser is not off-stage and DNA band is not in Pro Corp and gold log is not in Pro Corp, the rule succeeds;
	the rule fails;

section Red Roses Order rule

this is the red-roses-order-hint rule:
	if taboo bat is not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Ms Ism is in Red Roses Order, say "USE BROS ORB ON MIRROR RIM." instead; [okperc]
	if balsa slab is not had-or-done, say "You need to get the balsa slab from south of Swamp Maws." instead;
	say "USE BALSA SLAB ON SWORD ROWS." instead;

this is the red-roses-order-complete rule:
	if not-a-baton is not off-stage, the rule succeeds;
	the rule fails;

section Scrap Arcs rule

this is the scrap-arcs-hint rule:
	if Ye Key is not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player does not have stamp mats, say "[one of]You need something from Grebeberg to cut the slate metals.[or][if Frush Surf is visited]Get the stamp mats from Frush Surf.[else]Look south of [trees-zoo].[end if][stopping]";
	say "USE STAMP MATS ON SLATE METALS." instead;

to say trees-zoo:
	say "[if Ooze Zoo is visited]Ooze Zoo[else]Seer Trees[end if]"

this is the scrap-arcs-complete rule:
	if Ye Key is not off-stage, the rule succeeds;
	the rule fails;

section Seer Trees rule

this is the seer-trees-hint rule:
	if stark rats are moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player has party trap, say "USE the party trap on the stark rats. Or DROP it, to save keystrokes." instead;
	if player has trap art, say "The trap art can be made into something bigger. ";
	if ever-workrow is true, say "[one of]One of the machines in Work Row works.[or]USE TRAP ART ON REIFIER.[stopping]" instead;
	if Worn Row is visited, say "Worn Row is more than it seems[if ever-wordrow is true]. Yes, even more than Word Row[end if]." instead;
	say "There's a room you haven't been to, [if My Gym is visited]past My Gym[else if Yawn Way is unvisited]east in Yelpley[else]south of Yawn Way[end if]. Have a look there." instead;

this is the seer-trees-complete rule:
	if stark rats are moot, the rule succeeds;
	the rule fails;

section Sneer Greens rule

this is the sneer-greens-hint rule:
	if Yuge Guy is moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player has rep popper, say "USE REP POPPER ON ME TOTEM." instead;
	if dork rod is moot, say "You can take the item you need to defeat the Yuge Guy." instead;
	if Yuge Guy is in Sneer Greens, say "[one of]You need something from elsewhere to defeat the Yuge Guy. AID again to see where[or]What you need to defeat the Yuge Guy is in Yell Alley[stopping]."

this is the sneer-greens-complete rule:
	if Yuge Guy is moot, the rule succeeds;
	the rule fails;

section Swamp Maws rule

this is the swamp-maws-hint rule:
	unless eroded ore is off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if player does not have radar, say "There's something important behind the made dam, but you don't have the tool to detect it, yet." instead;
	say "[one of]There's something behind the made dam. How can you detect it?[or]You have one detection instrument.[or]The radar.[or]USE RADAR ON MADE DAM.[stopping]" instead;

this is the swamp-maws-complete rule:
	if eroded ore is not off-stage, the rule succeeds;
	the rule fails;

section Swept Pews rule

this is the swept-pews-hint rule:
	if liar grail is moot and troll ort is not in Swept Pews, continue the action;
	if search-hint-room is true, the rule succeeds;
	if troll ort is in Swept Pews, say "Take the troll ort." instead;
	if player does not have puce cup, say "You need the puce cup to pour something in the liar grail." instead;
	if puce cup is not sappy, say "[one of]You need to pour something [if puce cup is not empty]else [end if]in the puce cup.[or][if Cold Loc is unvisited]You haven't looked north of Seer Trees[else]Cold Loc has something. The past sap.[end if][stopping]" instead;
	say "USE PUCE CUP ON LIAR GRAIL." instead;

this is the swept-pews-complete rule:
	if liar grail is moot and troll ort is not in Swept Pews, the rule succeeds;
	the rule fails;

section Toll Lot rule

this is the toll-lot-hint rule:
	if cross orc is moot and UFO tofu is not off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if cash sac is off-stage, say "[one of]You need to bribe the cross orc with something in Grebeberg.[or]If you help someone in Grebeberg, you will get paid, and you can give that to the cross orc.[or][if Flu Gulf is visited]The cash sac from the Gulf Lug in Flu Gulf works[else]Check north of Cold Loc for someone to help[end if].[stopping]" instead;
	if cross orc is in Toll Lot, say "USE CASH SAC ON CROSS ORC." instead;
	say "USE RADAR ON CRAG ARC." instead;

this is the toll-lot-complete rule:
	if cross orc is moot and UFO tofu is not off-stage, the rule succeeds;
	the rule fails;

section Trapeze Part rule

this is the trapeze-part-hint rule:
	unless epicer recipe is off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	say "[one of]The ten level net needs you to do something to it.[or]TEND NET.[stopping]" instead;

this is the trapeze-part-complete rule:
	if epicer recipe is not off-stage, the rule succeeds;
	the rule fails;

section Uneven U rule

this is the uneven-u-hint rule:
	if wash saw is moot, continue the action;
	if maps-explained is true and porch crop is off-stage, continue the action;
	if search-hint-room is true, the rule succeeds;
	if porch crop is in Uneven U, say "USE WASH SAW ON PORCH CROP." instead;
	if tent net is off-stage, say "To make the Code Doc happy, there's something [if Trapeze Part is visited]west of Evaded Ave[else] in Trapeze Part[end if] you can get." instead;
	if player has tent net, say "[one of]If you help the Code Doc, the Code Doc will help you[or]USE TENT NET ON CODE DOC[stopping]." instead;
	if el doodle is not had-or-done, say "There's something back in [Art Xtra] to pick up." instead;
	if spa maps are off-stage, say "You can change El Doodle into something the Code Doc can decipher." instead;
	say "USE SPA MAPS ON CODE DOC." instead;

this is the uneven-u-complete rule:
	if wash saw is moot, the rule succeeds;
	the rule fails;

section Worn Row rule

this is the worn-row-hint rule:
	if test set is moot, continue the action;
	if row-prog is 2:
		if Worn Row is wordy and any-books-left and number of lugged books is 0:
			do nothing;
		else:
			consider the got-machine-fodder rule;
			unless the rule succeeded, continue the action;
	if search-hint-room is true, the rule succeeds;
	if Psi Wisp is in Worn Row, say "WORN ROW will get rid of the Psi Wisp." instead;
	if Rob is in Worn Row, say "[one of]Boy, Rob sure likes to hear himself talk. He's too exciting for you. Like Dave, you can get rid of him with the right action[or]BORE ROB[stopping]." instead;
	if ever-wordrow is false, say "You can change this place to WORD ROW." instead;
	if ever-workrow is false, say "You can change this place to WORK ROW." instead;
	if Worn Row is worny, say "You can change Worn Row back to WORK ROW[if any-books-left] or WORD ROW[end if]." instead;
	if Worn Row is wordy:
		if any-books-left:
			repeat with bk running through bkorder:
				if bk is not moot, say "[if number of necessary books in Worn Row is 1]You should take [bk], since it's the only book left[else]While there's no fixed order for using the books, [bk] is a good choice next[end if]." instead;
		say "You don't have anything more to do in Word Row. Change it back to Work Row." instead;
	if rotator is in Worn Row, abide by the find-machine rule;
	if player does not have murdered rum, say "You will get something useful on defeating the Yuge Guy." instead;
	if emitted is false, say "Test the yard ray with EMIT NOONTIME." instead;
	if player has murdered rum, say "USE MURDERED RUM ON YARD RAY." instead;
	say "USE YARD RAY ON TEST SET." instead;

bkorder is a list of things variable. bkorder is { TI, Epoch Cope, NULL ILLUN, Yob Attaboy }.

to say book-hint:
	say "[if player carries cur-book]You are carrying a good book to use[else]There's no strict order, but I'd suggest going with [cur-book]"

to decide whether any-books-left:
	if number of necessary books in Worn Row > 0, yes;
	no;

to decide which book is cur-book:
	if Door Frood is not moot, decide on TI;
	if King Nik is not moot, decide on EPOCH COPE;
	if cross orc is not moot and gnu dung is moot, decide on NULL ILLUN;
	if YOB ATTABOY is not moot, decide on YOB ATTABOY;
	decide on NULL ILLUN;

postmachines is a list of things variable. postmachines is { brag garb, dork rod, ME gem, stock cots, cave vac, ore zero, party trap, DNA hand, taboo bat }.

premachines is a list of things variable. premachines is { bunk nub, DNA band, Dirt Rid, eroded ore, gold log, not-a-baton, stinky knits, trap art, you buoy }.

this is the got-machine-fodder rule:
	repeat with Q running through premachines:
		if player has Q, the rule succeeds;
	the rule fails;

this is the find-machine rule:
	repeat with Q running through premachines:
		if player has Q:
			repeat through table of goodacts:
				if there is a use1 entry and use1 entry is Q:
					say "USE [printed name of use1 entry in upper case] ON [printed name of use2 entry in upper case].";
					the rule succeeds;
	say "You don't have anything you could use on a machine at the moment." instead;

this is the worn-row-complete rule:
	if test set is moot, the rule succeeds;
	the rule fails;

section Yack Cay rule

this is the yack-cay-hint rule:
	unless player has el doodle or NULL ILLUN is not moot or moor broom is not moot, continue the action;
	if search-hint-room is true, the rule succeeds;
	if ever-wordrow is false, say "You may want to change Work Row to something else, first." instead;
	if player has el doodle, say "USE EL DOODLE ON EDITS TIDE." instead;
	if NULL ILLUN is not moot, say "[if player has Known Wonk]USE NULL ILLUN ON KNOWN WONK[else][one of]You need to give the Known Wonk a book[or]Get NULL ILLUN from back in Word Row[stopping][end if]." instead;
	if player does not have moor broom, say "The enact cane can be combined to better purpose." instead;
	say "USE MOOR BROOM ON TRU YURT." instead;

this is the yack-cay-complete rule:
	if moor broom is moot, the rule succeeds;
	the rule fails;

section Yawn Way rule

this is the yawn-way-hint rule:
	if puffed-up is true, continue the action; [this is a trivial rule, but in case I decide to add something, it may be a help.]
	if search-hint-room is true, the rule succeeds;
	if Seer Trees is unvisited, say "You need to visit west of Fun Enuf." instead;
	if stark rats are not moot, say "You need to deal with the stark rats to see more of Grebeberg to help you go east." instead;
	if player does not have Spur Ups, say "You may need to visit Cold Loc to receive an item to help you go east." instead;
	say "[one of]The spur ups can make you feel, if not go, UP. But how should you get more UP?[or]PUFF UP.[stopping]" instead;

this is the yawn-way-complete rule:
	if puffed-up is true, the rule succeeds; [this is a trivial rule, but in case I decide to add something, it may be a help.]
	the rule fails;

section Yell Alley rule

this is the yell-alley-hint rule:
	if mayo yam is had-or-done and pity tip is moot and psi wisp is not moot and mr arm is not moot, continue the action; [?? this is not complete! Mr Arm needs to be clued]
	if search-hint-room is true, the rule succeeds;
	if mayo yam is in Yell Alley, say "TAKE MAYO YAM." instead;
	if pity tip is not moot, say "USE PITY TIP ON EYE (or NAVY VAN)." instead;
	if DNA band is not had-or-done, say "You may need to look in [if Pro Corp is visited]the northeast room[else][Pro Corp][end if] to get started here.";
	if DNA hand is not had-or-done, say "You need to do something to the DNA band in Work Row." instead;
	if player does not have Mr Arm, say "You need to combine the DNA hand with [if roto motor is off-stage]an item you don't have yet[else]the roto motor[end if]." instead;
	say "USE MR ARM ON TNT." instead;

this is the yell-alley-complete rule:
	unless TNT is had-or-done, the rule fails;
	unless mayo yam is had-or-done, the rule fails;
	the rule succeeds;

chapter balmlabing

balm-LLP-yet is a truth state that varies.

balmlabing is an action applying to nothing.

understand the command "balmlab" as something new.
understand the command "balm lab" as something new.

understand "balm lab" as balmlabing when player is in Pro Corp and bald-lab.
understand "balmlab" as balmlabing when player is in Pro Corp and bald-lab.

carry out balmlabing:
	if balm-LLP-yet is true, say "No double dipping." instead;
	now balm-LLP-yet is true;
	abide by the LLP rule; [BALM LAB]
	say "Some EOL Aloe (O, La) squirts out of the butene tub. You rub it on yourself. You immediately quit running around in circles in your mind, and when a disturbing thought pops back up, you sort of say Lo, EOL, to ward it off. But then an enol cyclone blows you over, and when you wake up again, it's a Bald Lab." instead;

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

pooping is an action out of world.

understand the commands "boob" and "poop" and "pap" and "tit" as something new.

understand "boob" and "poop" and "pap" and "tit" as pooping.

poop-boob-yet is a truth state that varies.

carry out pooping:
	if poop-boob-yet is false:
		say "Oath tao!";
		now poop-boob-yet is true;
		say "[line break][bracket]Your score has just gone up by 727 points.[close bracket]";
		wfak;
		say "[line break]Well, for the moment.[line break]";
		wfak;
		repeat with Q running from 1 to 6:
			say "[line break][bracket][if Q is 1]Wait, no, y[else]Y[end if]our score has just gone down [if Q > 1]again [end if]by 121 points.[close bracket]";
			wfak;
		abide by the LLP rule; [POOP]
		now the last notified score is the score;
		say "[line break]NOTE: there are three other 'proper' ways to swear, but I don't want to encourage bad behavior too much, here. So this is the only bonus point you'll get!";
	else:
		say "Ah! Cussin['] is such a...[paragraph break]X2?[paragraph break]...X!";
	follow the notify score changes rule;
	the rule succeeds;

chapter slammammalsing

slam-mam is a truth state that varies.

slammammalsing is an action applying to nothing.

understand the command "slam mammals" as something new.

understand "slam mammals" as slammammalsing.

carry out slammammalsing:
	if slam-mam is true, say "You already did. Don't overdo it." instead;
	unless player is in Ooze Zoo, say "You have no sympathetic audience." instead;
	say "You babble some rubbish about the deer creed of a deer breed being deer greed. The sleep eels wake from their slumber [if bunk nub is moot]just out of sight [end if]briefly to squirm. They telepathically project their pleasure [if sleep eels are moot]from their stock cots [end if]before dozing off. They seem to have appreciated your sleep speels. You've ... done something, I guess? And hopefully without too much whataboutism?";
	now slam-mam is true;
	consider the cap-beep rules for the opossum;
	abide by the LLP rule; [SLAM MAMMALS]
	the rule succeeds;

chapter stacking

stacking is an action applying to one thing.

understand the command "stack" as something new.

understand "stack [something]" as stacking.

carry out stacking:
	if noun is not senile felines, say "Not worth stacking." instead;
	unless the player's command matches the text "cats" or LLP-quick is true,  say "Refer to the felines by a simpler synonym, and you've got it." instead;
	say "You stack the cats so there's a suitable pet-step to reach the late petal, but once you do, the top one bats it, and it falls out of sight. They walk away, disinterested. But they still seemed to have fun. Well, cats are like that.";
	moot senile felines;
	moot late petal;
	consider the cap-beep rules for the senile felines;
	abide by the LLP rule; [STACK CATS]
	the rule succeeds;

chapter statsing

stats-yet is a truth state that varies.

statsing is an action out of world.

understand the command "stats" as something new.

understand "stats" as statsing.

carry out statsing:
	let stats-now be stats-yet;
	now stats-yet is true;
	try requesting the score;
	if stats-now is false:
		say "Nice job! Have an extra style point for requesting the score 'correctly.'";
		abide by the LLP rule; [STATS]
	consider the LLP or normal score changes rule;
	the rule succeeds;

volume endgame stuff

part final questions

Table of Final Question Options (continued)
final question wording	only if victorious	topic	final response rule	final response activity
"see RANKS"	true	"RANK/RANKS"	--	rankseeing
"see responses to various commands (RAND 0 for list, RAND 1-[number of rows in table of all randoms] for specific table, RN 0 for next table[if post-alf is false], ORDR O to alphabetize[end if])"	true	"RAND [number]"	--	rling
"see [if LLP-hint-yet is false]hints for [end if]which LLP[if cur-score of Odd Do is not 10]s[end if] you MISSED"	true	"LLP/LLPS/MISSED"	what-missed rule	loafing
--	true	"RN"	--	rlning
--	true	"RAND"	--	rl0ing
--	true	"ORDR O"	--	ordring

rlning is an activity.

rule for rlning:
	increment last-table-tried;
	if last-table-tried > number of rows in table of all randoms:
		say "(Cycling back to the first table)[paragraph break]";
		now last-table-tried is 1;
	try randlisting last-table-tried instead;

rlming is an activity.

rule for rlming: say "You need to type in a number instead of a table name." instead;

rl0ing is an activity.

rule for rl0ing: try randlisting number understood instead;

rling is an activity.

rule for rling: try randlisting number understood instead;

randlisting is an action applying to one number.

last-table-tried is a number that varies.

carry out randlisting:
	let count be 0;
	if number understood is 0:
		repeat through table of all randoms:
			increment count;
			say "[count]. [desc entry][line break]";
		say "[line break]This doesn't include the tables of names for each phone book. Those are both really long, and you'll probably want to see the source code (Ailihphilia Tables.i7x) if you're really interested.";
		the rule succeeds;
	if number understood < 0 or number understood > number of rows in table of all randoms, say "Need 1-[number of rows in table of all randoms]." instead;
	now last-table-tried is number understood;
	choose row number understood in table of all randoms;
	let mytab be tabnam entry;
	now count is 0;
	say "All random text for [desc entry]:[line break]";
	repeat through mytab:
		increment count;
		say "[randtxt entry][line break]";

loafing is an activity.

ordring is an activity.

post-alf is a truth state that varies.

rule for ordring:
	if post-alf is true, say "Already sorted all tables in alphabetical order." instead;
	repeat through table of all randoms:
		sort tabnam entry in randtxt order;
	now post-alf is true;
	say "Sorted all tables in alphabetical order.";

rankseeing is an activity.

rule for rankseeing:
	say "Some ranks are fixed: for instance, you are an ebohphobe if you have no points, an elihphile once you destroy the [KAOS Oak], and a tsilihphilist once you beat the Diktat Kid. Last Lousy Points have no effect on your rank.";
	say "Here are the maximum points for each rank, in order: ";
	let count be 0;
	let tsrr be number of rows in table of silly ranks;
	repeat through table of silly ranks:
		increment count;
		if count is tsrr, say " and ";
		if pre-prio entry is not 0, say "(fixed) ";
		say "[the-rank entry] ([max-sco entry])";
		if count < tsrr - 1, say ", ";
	say ".";

chapter replace standard response to final question

the nonstandard respond to final question rule is listed instead of the standard respond to final question rule in for handling the final question.

This is the nonstandard respond to final question rule:
	repeat through the Table of Final Question Options:
		if the only if victorious entry is false or the story has ended finally:
			if there is a final response rule entry
				or the final response activity entry [activity] is not empty:
				if the player's command matches the topic entry:
					if there is a final response rule entry, abide by final response rule entry;
					otherwise carry out the final response activity entry activity;
					rule succeeds;
	if the player's command includes "rand":
		say "RAND requires a number after it.";
		the rule succeeds;
	issue miscellaneous library message number 8.

part amusing the player

to say gt: say "Ailihphilia";

rule for amusing a victorious player:
	say "Funny (I hope) things to try:[paragraph break]";
	repeat through table of amusements:
		say "[2da][amu entry][line break]";
	say "[line break]";

table of amusements
amu
"A general sweeping note: the mistakes file ([gt] mistakes.i7x) should have all the possible palindrome tries you can make and the text they give. It should be included in the release or at [bb]."
"Another sweeping note: the tables file ([gt] tables.i7x) in the same location(s) should have all the random texts."
"Attacking yourself, the ergot ogre, the pact cap, the made dam, or the eels."
"Asking for [b]PCP[r] in Evaded Ave or Yell Alley."
"Trying to [b]BUNT NUB[r] three times."
"[b]RM GNU[r] around the gnu, or RM MR around Mr. Arm."
"[b]SMELL[r] the gnu dung, butene tub or Yuge Guy."
"[b]XYZZY[r]."
"Some USE X ON Y: you can look in the table of specific use rejects (xx[i][r]rej in the story.ni file) for them all." [ the R is there so I can search the source]

part what you missed (LLP)

LLP-hint-yet is a truth state that varies.

this is the what-missed rule:
	let missed be 0;
	repeat through table of last lousy points:
		consider the dorule entry;
		if the rule failed:
			say "[if LLP-hint-yet is false][LLP-clue entry][else][LLP-spoil entry][end if]";
			increment missed;
	if missed is 0, say "You found all the points, but something in your final results isn't fully in tune with the game...yet. It can't be too hard to change!" instead;
	if LLP-hint-yet is false, say "[paragraph break]Type MISSED again to spoil the LLPs. While the X-Ite Tix allow you through the Tix Exit, there's no restriction on wandering around after.";
	now LLP-hint-yet is true;

chapter misses table

table of last lousy points [xxllp]
LLP-clue	LLP-spoil	mclu	finord	dorule	cluey
"Three ways to swear right, none over four letters"	"BOOB or POOP or PAP to swear 'right'"	false	1	pb-yet rule	"Swear 'right'"
"A five-letter way to think"	"[b]REFER[r] instead of [b]THINK[r]"	false	2	refer-yet rule	"[b]THINK[r], or recall, information differently"
"A different way to ask for AID"	"DIAL AID instead of AID"	false	3	aid-LLP-yet rule	"Ask for AID a bit more formally"
"A four-letter way to look"	"PEEP instead of looking"	false	4	peep-yet rule	"LOOK differently"
"A five-letter way to get your score"	"STATS to get the score"	false	5	stats-yet rule	"Get the SCORE differently"
"Another way to examine the tract cart"	"TRACE CART to find an 'extra' book"	false	6	cart-traced rule	"Find an extra book in [if ever-wordrow is true]the tract cart[else]a cart containing books[end if]"
"Discuss mammals with the eels[if eels are moot], even though they're gone--they'll still hear you[end if]"	"SLAM MAMMALS around the eels"	false	7	slam-yet rule	"Apologize for mammals to [if Ooze Zoo is unvisited]some non-mammals[else]the eels[end if]"
"Help the felines, err, cats"	"STACK CATS to help the senile felines"	false	8	cats-stacked rule	"Help the cats in [moo-room-vis]"
"Find the source of the buzzing in Moo Room (3/4 letters)"	"SEE BEES in Moo Room"	false	9	bees-seen rule	"Notice the source of the buzzing in [moo-room-vis]"
"Find something healing in the Bald Lab"	"BALM LAB in the Bald Lab"	false	10	balm-yet rule	"Get a semi-hidden item [if Pro Corp is unvisited]from the northeast room[else]from [Pro Corp][end if][if bald-lab] after looting it[end if]"
"Be nice to the opossum in Le Babel"	"MUSS OPOSSUM to make a friend"	false	11	muss-yet rule	"Be nice to [if Le Babel is unvisited]an opossum somewhere in the future[else]the opossum in Le Babel[end if]"
[zzllp]

to say moo-room-vis:
	say "[if Moo Room is visited]Moo Room[else]a barn-ish area you haven't seen yet[end if]"

this is the balm-yet rule:
	if balm-LLP-yet is true, the rule succeeds;
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

this is the aid-LLP-yet rule:
	if aid-LLP-yet is true, the rule succeeds;
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
	if refer-yet is true, the rule succeeds;
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
	now rr-available is true;
	say "(DEBUG ONLY NOTE: in-beta is true. The RR command may save time for the three machines.)[paragraph break]";

section llpqing

llpqing is an action out of world.

understand the command "llpq" as something new.

understand "llpq" as llpqing.

carry out llpqing:
	now LLP-quick is true;
	let orm be location of player;
	if cur-score of Odd Do is 11, say "You got all the LLPs." instead;
	say "Note: this command may have stray text.";
	say "=====DO-ANYWHERE LLPs[line break]";
	if aid-LLP-yet is false:
		say "DIAL AIDing/SOSing.";
		now aid-LLP-yet is true;
		consider the LLP rule;
		consider the LLP or normal score changes rule;
	if poop-boob-yet is false:
		say "Using a naughty, but not too naughty, four letter word...";
		try pooping;
	if stats-yet is false:
		say "STATSing...";
		try statsing;
	if refer-yet is false:
		say "REFERing...";
		try refering;
	if peeped-yet is false:
		say "PEEPing...";
		try peeping;
	say "=====SPECIFIC AREA LLPs[line break]";
	say "SLAMming mammals in Ooze Zoo...";
	if slam-mam is false:
		move player to Ooze Zoo;
		try slammammalsing;
		consider the LLP or normal score changes rule;
	say "TRACEing the cart...";
	if DWELT LEWD is off-stage:
		move player to Worn Row;
		now Worn Row is wordy;
		try mytraceing tract cart;
		consider the LLP or normal score changes rule;
	say "BALM LAB in Pro Corp/Bald Lab...";
	unless balm-LLP-yet is true:
		move player to Pro Corp;
		try balmlabing;
		consider the LLP or normal score changes rule;
	say "STACKing the cats...";
	unless senile felines are moot:
		move player to Moo Room;
		try stacking felines;
		consider the LLP or normal score changes rule;
	say "SEEing the bees...";
	if bees-seen is false:
		move player to Moo Room;
		try seebeesing;
		consider the LLP or normal score changes rule;
	say "MUSSing the opossum...";
	unless opossum is moot:
		move player to Le Babel;
		try opmussing;
		consider the LLP or normal score changes rule;
	now LLP-quick is false;
	if orm is not Le Babel, move player to orm;
	the rule succeeds;

chapter eaing

eaing is an action out of world.

understand the command "ea" as something new.

understand "ea" as eaing.

carry out eaing:
	let minuses be { pact cap };
	now minuses is { };
	let cluables be { pact cap };
	now cluables is { };
	repeat with X running through things:
		if X is the player, next;
		if X is not quicknear, next;
		now eyespoil of X is rowcount of X;
		if rowcount of X is -1:
			add X to minuses;
		else:
			add X to cluables;
	sort cluables in eyespoil order;
	if number of entries in minuses > 0, say "Un-eyeable: [minuses].";
	repeat with Y running through cluables:
		say "[Y]: [eyespoil of Y].";
	the rule succeeds;

chapter euing

[ * EU adds a charge to the pip ]

euing is an action out of world.

understand the command "eu" as something new.

understand "eu" as euing.

carry out euing:
	increment eye-charges;
	say "[eye-charges] eye charges now.";
	the rule succeeds;

chapter eming

[ * EM fakes a mistake ]

eming is an action out of world.

understand the command "em" as something new.

understand "em" as eming.

carry out eming:
	say "This simulates a good guess. You should get a pip charge after every 5 good guesses, real or fake.[mis of 0]";

section llplling - not for release

[ * LLP laundry list]

llplling is an action out of world.

understand the command "llpll" as something new.

understand "llpll" as llplling.

carry out llplling:
	repeat through table of last lousy points:
		consider the dorule entry;
		if the rule failed, say "[LLP-spoil entry]";
	the rule succeeds;

chapter llping

llping is an action out of world.

understand the command "LLP" as something new.

understand "LLP" as llping.

carry out llping:
	now LLP-reject is whether or not LLP-reject is false;
	say "LLP reject is now [on-off of LLP-reject].";
	the rule succeeds;

chapter endgame

endgameing is an action applying to nothing.

understand the command "endgame" as something new.

understand "endgame" as endgameing.

carry out endgameing:
	say "Giving you all the cool stuff to defeat the Diktat Kid. NOTE: Also moving the test set to [Fun Enuf]. It should be in work row, but it's easier this way.";
	move test set to Fun Enuf;
	now player carries all tronparts;
	now martini tram is in Fun Enuf;
	now player carries murdered rum;
	now player carries yard ray;
	now player carries epicer recipe;
	moot Set O Notes;
	moot Darer Ad;
	moot elf;
	now player has pact cap;
	now player has taboo bat;
	now player has ME gem;
	now Tix Exit is in Fun Enuf;
	if player is not in Fun Enuf, move player to Fun Enuf;
	now endgame-test is true;
	the rule succeeds;

chapter rring

rring is an action applying to one thing.

understand the command "rr" as something new.

understand "rr [something]" as rring when ever-wordrow is true.

rr-available is a truth state that varies.

to mach-try (a1 - a thing) and (a2 - a thing):
	if a2 is moot, continue the action;
	if a1 is moot, continue the action;
	try useoning a1 with a2;

one-mach-warn is a truth state that varies.

carry out rring:
	if player is not in Worn Row, say "You need to be in Work Row for this to work." instead;
	if Worn Row is not worky, say "You need to change back to Work Row to do this." instead;
	if number of moot workables is 3, say "The RR command is not valid now you destroyed all the machines." instead;
	if rr-available is false:
		say "You may have indirectly discovered a verb to plow through all three machines. Just so you know, in case you want to undo.[line break]";
		now rr-available is true;
	if number of moot workables is 2 and one-mach-warn is false:
		now one-mach-warn is true;
		say "NOTE: the RR command is really just the same as [b][verb-abbrev of random not workedout workable in Worn Row][r] now you destroyed two of the machines, but since RR saves a keystroke, why not?[paragraph break]";
	repeat through table of goodacts: [It would be simpler to use an if statement but things could get shuffled in the table of goodacts. This assures that we try all possible machines before an item vanishes permanently, but no more.]
		if there is a use1 entry:
			if use2 entry is reviver and use1 entry is noun:
				mach-try use1 entry and reifier;
				mach-try use1 entry and rotator;
				mach-try use1 entry and reviver;
				the rule succeeds;
			if use2 entry is reifier and use1 entry is noun:
				mach-try use1 entry and rotator;
				mach-try use1 entry and reviver;
				mach-try use1 entry and reifier;
				the rule succeeds;
	mach-try noun and reviver;
	mach-try noun and reifier;
	mach-try noun and rotator;
	the rule succeeds.

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
		repeat through table of goodacts:
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

include Ailihphilia Tests by Andrew Schultz. [must come first so blank-appear-okay is accepted]

Diktat Kid is blank-appear-okay.
Knife Fink is blank-appear-okay.
Verses Rev is blank-appear-okay.

the debug tweaks rule is listed first in the when play begins rulebook.

when play begins (this is the debug tweaks rule):
	say "This should not be present in a Beta or Release version of Ailihphilia.";
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

when play begins (this is the miscellaneous deep testing rule):
	if debug-state is true, try percing;

chapter tntting

tntting is an action out of world.

understand the command "tntt" as something new.

understand "tntt" as tntting.

carry out tntting:
	now TNT-test is whether or not TNT-test is false;
	say "TNT test is now [on-off of TNT-test]. Best not to run a walkthrough while it's on.";
	the rule succeeds;

chapter uuxing

the dud is a thing. description is "none necessary".

understand the command "uux" as something new.

understand "uux [any thing]" as uuxing.

carry out uuxing: try uuing dud on noun instead;

chapter uuying

understand the command "uuy" as something new.

understand "uuy [any thing]" as uuying.

carry out uuying: try uuing noun on dud instead;

chapter uuing

understand the command "uu" as something new.

understand "uu [any thing] on [any thing]" as uuing it on.

carry out uuing:
	let L1 be TempMet;
	let L2 be TempMet;
	let O1 be whether or not noun is off-stage;
	let O2 be whether or not second noun is off-stage;
	if noun is not off-stage and noun is not carried, now L1 is location of noun;
	if second noun is not off-stage and second noun is not carried, now L2 is location of second noun;
	if player does not carry noun, move noun to location of player;
	if player does not carry second noun, move second noun to location of player;
	try useoning noun with second noun;
	if O1 is true:
		now noun is off-stage;
	else:
		move noun to L1;
	if O2 is true:
		now second noun is off-stage;
	else:
		move second noun to L2;
	the rule succeeds.

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
		consider the hint-rule of Q;
		if the rule succeeded:
			consider the finished-rule of Q;
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

chapter raytesting

raytesting is an action applying to one number.

understand the command "raytest" as something new.

understand "raytest [number]" as raytesting.

carry out raytesting:
	if KAOS Oak is not moot, say "The North-Tron must be created before running this test." instead;
	let nu be the number understood;
	if nu < 1 or nu > 5, say "1-5 please." instead;
	now yard ray is off-stage;
	now emitted is false;
	now ME gem is off-stage;
	now taboo bat is off-stage;
	if nu is 1, try going north;
	now player has yard ray;
	if nu is 2, try going north;
	now emitted is true;
	if nu is 3, try going north;
	if nu is 4:
		now player has ME gem;
		try going north;
	if nu is 5:
		now player has taboo bat;
		try going north;
	say "If you are doing further testing, UNDO immediately now you've run this. Trust me. There was too much to tie up, here.";
	the rule succeeds;

chapter percing

percing is an action out of world.

understand the command "perc" as something new.

understand "perc" as percing.

carry out percing:
	let count be 0;
	repeat through table of periphery:
		if itm entry is integral:
			if itm entry is state tats, next;
			say "[itm entry] is in periphery table but is not peripheral.";
			increment count;
	repeat with pthi running through peripheral things:
		if pthi is not an itm listed in table of periphery:
			say "Need itm entry in table of periphery for [pthi].";
			increment count;
	say "[if count is 0]Yay! Periphery succeeds![else][count] periphery errors.[end if]";
	the rule succeeds;

chapter dirvering

dirvering is an action out of world.

understand the command "dirver" as something new.

understand "dirver" as dirvering.

definition: a room (called ro) is chaseable:
	if ro is in Odd Do, no;
	if ro is Dirge Grid, no;
	yes;

carry out dirvering:
	let list-none be false;
	let XDX be up;
	let XCX be 0;
	repeat with X running through chaseable rooms:
		now XCX is exit-count of X;
		now list-none is false;
		if exit-count of X is 1, now list-none is true;
		if list-none is true:
			now XDX is exit-dir of X;
			say "[XDX] is the expected direction from [x].";
		else:
			say "[XCX] ways out of [x].";
		repeat with Y running through chaseable rooms:
			if X is Y, next;
			let fmo be first-move of X and Y;
			if list-none is false:
				say "[X] to [Y] starts [fmo].";
			else:
				let Y2 be the room XDX of X;
				if fmo is not XDX:
					say "[X] to [Y] is incorrectly derived as starting [fmo] when it should be [XDX].";
	the rule succeeds;

chapter scvering

scvering is an action out of world.

understand the command "scver" as something new.

understand "scver" as scvering.

carry out scvering:
	let missings be 0;
	let rows be 0;
	repeat through table of goodacts:
		increment rows;
		if there is a done entry and done entry is false:
			increment missings;
			if there is a use1 entry:
				say "Row [rows]: didn't get [use1 entry] + [use2 entry] = [if there is a getit entry][getit entry][else](nothing)[end if].";
			else if there is a preproc entry:
				say "Row [rows]: didn't follow the [preproc entry].";
			else:
				say "Something odd happening with row [rows].";
	the rule succeeds;

chapter tccing

[ * this is turn count checking for end of game, but ensuring you have a non-palindrome ]

tcccing is an action out of world.

understand the command "tccc" as something new.

understand "tccc" as tccing.

carry out tcccing:
	try tccing;
	increment the turn count;

chapter tccing

[ * this is turn count checking for end of game, but ensuring you have a palindrome ]

tccing is an action out of world.

understand the command "tcc" as something new.

understand "tcc" as tccing.

carry out tccing:
	unless player is in Fun Enuf and Diktat Kid is moot, say "This is only valid at game's end." instead;
	if turn count < 100, say "No way you solved the game yet! Even with GT, you need at least 160 moves. I checked. It's too soon." instead;
	if turn count > 10000, say "Ulp! Can't help you!" instead;
	let oldt be turn count;
	if turn count < 1000:
		let y be turn count / 100;
		let z be the remainder after dividing turn count by 100;
		if z < y:
			now turn count is 101 * z;
		else:
			let x be the remainder after dividing turn count by 10;
			now turn count is turn count - x;
			now turn count is turn count + y;
	else:
		let z be turn count / 1001;
		let z2 be turn count / 1000;
		let z3 be the remainder after dividing turn count by 1000;
		if z3 < z2:
			now turn count is z2 * 1001;
		else:
			let w be the remainder after dividing z by 1001;
			now w is 110 * (w / 110);
			now turn count is (z * 1001) + w;
	[decrement turn count;] [for some reason you don't take a turn going through the tix exit]
	if turn count is oldt, say "No change in turn count." instead;
	say "Change from [oldt] to [turn count].";
	the rule succeeds;

chapter txing

txing is an action applying to one number.

understand the command "tx" as something new.

understand "tx [number]" as txing.

carry out txing:
	if player does not have x-ite tix, say "You need to have the X-Ite Tix for this to work." instead;
	if number understood < 100 or number understood > 10000, say "New turn count must be between 100 and 10000." instead;
	now turn count is number understood - 1;
	say "Forced game to [number understood] turns.";
	the rule succeeds.

chapter allshuting

allshuting is an action out of world.

understand the command "allshut" as something new.

understand "allshut" as allshuting.

carry out allshuting:
	say "YELPLEY: [list of shutted rooms in Yelpley].";
	say "GREBEBERG: [list of shutted rooms in Grebeberg].";
	the rule succeeds;

chapter full monty extension

include Full Monty Testing by Andrew Schultz.

table of monties (continued)
montopic (topic)	on-off	test-title (text)	test-action	topic-as-text (text)
"xlist"	false	"DIRING"	show-dirs rule	"showing directions"
"sos"	false	"SOSING"	sos-it rule	"sos new hint"
"mem"	false	"MEMING"	mem-it rule	"mem it all"
"eye"	false	"EYEING everything"	eye-it rule	"eye it all"

this is the sos-it rule: try sosing;

this is the show-dirs rule: say "Header = [location of player] ([mrlp])[dir-summary]."

this is the eye-it rule: try eaing;

this is the mem-it rule: try meming;

chapter noxing

noxing is an action applying to one thing.

understand the command "nox" as something new.

understand "nox [something]" as noxing.

carry out noxing:
	if the noun provides the property nox:
		say "[if the noun is nox]Already is[else]Changed[end if].";
		now the noun is nox;
	else:
		say "You can't nox/xed [noun].";
	the rule succeeds.

chapter worth a try

to decide whether the action is pro-and-use: [aip2]
	if useoning, yes;
	if uuing, yes;
	if uuxing, yes;
	if uuying, yes;
	if the action is procedural, yes;
	no;

chapter stuff we can comment out

[Include Room Description Verification by Andrew Schultz.

when play begins:
	now Seer Trees is check-immune;
	now Emo Dome is check-immune;
	consider the check-room-descriptions rule;]

[?? test to see about any person/place/scenery that is in table of rejects or useons but not both]