Version 1/171220 of Put It Up Mistakes by Andrew Schultz begins here.

volume Mistakes

[the rooms here are arranged alphabetically. When an item triggers the mistake, the room will be the one where you first find the item. If there are two places, we go with the first: for instance, (partial spoiler) the roto motor appears in the west of the two locations where it can turn up.]

[programmer's note: the utility aam.py adds or sorts the 'mis' numbers]

to decide whether (mt - a thing) is/are quicknear:
	if mt is in location of player, yes;
	if player carries mt, yes;
	no;

[todo: (programming exercise) write script that can automatically change when player is in x and (y) is in x to when (y) is quicknear)]

book Apse Spa

understand "spa caps" as a mistake ("But you already have your pace cap![mis of 1]") when player is in Apse Spa or spa maps are quicknear.

understand "spa naps" as a mistake ("No time to relax! There's adventuring to be had![mis of 2]") when player is in Apse Spa or spa maps are quicknear.

understand "spa raps" as a mistake ("The spa is a place of peace. Stop that noise, and get off mylawn![mis of 3]") when player is in Apse Spa or spa maps are quicknear.

understand "spa zaps" as a mistake ("You don't need a weapon.[mis of 4]") when player is in Apse Spa or spa maps are quicknear.

book Art Xtra

understand "art ecetra" as a mistake ("One silly misspelling does not beget another.[mis of 5]") when player is in Art Xtra.

book Birch Crib

understand "cods doc" as a mistake ("No way. It's nice to be around someone non-fishy, actually.[mis of 6]") when player is in Birch Crib.

book Calcific Lac

understand "calf lac" as a mistake ("There is [if moo room is unvisited]another room with that, sort of[else]already the Moo Room. Let's not overdo it[end if].[mis of 7]")

understand "calm lac" as a mistake ("It is calm enough.[mis of 8]")

chapter moor broom

understand "moor groom" as a mistake ("There is no romance, here. Besides, I can't do anything with 'bride.'[mis of 9]") when player has moor broom.

understand "moor vroom" as a mistake ("The moor broom is not equipped for transport. Some brooms are, but this isn't.[mis of 10]") when player has moor broom.

chapter tao boat

understand "tao goat" as a mistake ("The goat wouldn't remain placid for long once it was plunged into water.[mis of 11]") when player is in Calcific Lac.

understand "tao moat" as a mistake ("The lake is peaceful enough as-is.[mis of 12]") when player is in Calcific Lac.

understand "tao coat" as a mistake ("You don't need protection from the weather here.[mis of 13]") when player is in Calcific Lac.

chapter ME gem

understand "mega gem" as a mistake ("That'd be useful in Kingdom of Loathing, but not here.[mis of 14]") when ME gem is quicknear.

book Cold Loc

understand "rife fir" as a mistake ("It's already big enough.[mis of 15]") when player is in Cold Loc.

understand "riff fir" as a mistake ("It's rife enough to block passage west and to provide past sap.[mis of 16]") when player is in Cold Loc.

understand "cola loc" as a mistake ("You'd be better off with a warmer drink. Which isn't here.[mis of 17]") when player is in Cold Loc.

understand "colt loc" as a mistake ("No gandered nag appears. Or gun(ug).[mis of 18]") when player is in Cold Loc.

understand "purr up" as a mistake ("The Spur Ups make you feel you can be anyone, but not anything.[mis of 19]") when player has spur ups.

book Deft Fed

understand "defy fed" as a mistake ("Way to go! Keep that Hunger! Well, I hope it's that and not conspiracy theories about the Fed.[mis of 20]") when player is in Deft Fed and YOB ATTABOY is not moot

understand "defy fed" as a mistake ("No problem, you're not getting fed anyway.[mis of 21]") when player is in Deft Fed and yob attaboy is not moot.

chapter Bon Snob

understand "bon knob" as a mistake ("You don't need to help Sniffins with interior decorating, here.[mis of 22]") when player is in Deft Fed and YOB ATTABOY is moot.

book Dirge Grid

understand "dir grid" as a mistake ("With only one way out, you don't need directions.[mis of 23]") when player is in Dirge Grid.

book Dopy Pod

understand "pod op" as a mistake ("But what sort of op?[mis of 24]") when player is in Dopy Pod.

understand "do pod" as a mistake ("But what to do to it? How to change it?[mis of 25]") when player is in Dopy Pod.

book Drawl Ward

understand "bony nob" as a mistake ("The Bond Nob's body weight is not an important issue, here.[mis of 26]") when Bond Nob is quicknear.

understand "bone nob" as a mistake ("Out of your league.[mis of 27]") when Bond Nob is quicknear.

understand "bonk nob" as a mistake ("That'd let you get west ... until the nob woke up and called a few friends.[mis of 28]") when Bond Nob is quicknear.

understand "bong nob" as a mistake ("The Bond Nob probably knows someone but prefers alcohol.[mis of 29]") when Bond Nob is quicknear.

understand "drawn ward" as a mistake ("The room remains text-based.[mis of 30]") when player is in Drawl Ward.

book Dumb Mud

understand "dump mud" as a mistake ("It's already kind of dumped here[if poo coop is not moot]. Maybe you could dump the mud into the rut for passage south, but it might take too long, and you don't have a shovel. You'd need something else[end if].[mis of 31]") when player is in Dumb Mud.

understand "gnu bung" as a mistake ("There's no way to put the toothpaste back in the tube, as it were.[mis of 32]") when gnu dung is quicknear.

understand "gnu lung" as a mistake ("The gnu dung smells bad enough without dropping more internal organs into the mix.[mis of 33]") when gnu dung is quicknear.

understand "turd rut" as a mistake ("Hmm! Maybe you could fill the rut up with ... something ... to cross it.[mis of 34]") when player is in Dumb Mud and poo coop is not moot.

understand "turn rut" as a mistake ("It's too large to redirect[if poo coop is moot], and besides, you already have a way across[end if].[mis of 35]") when player is in Dumb Mud.

understand "turnon rut" and "turn on rut" as a mistake ("No innuendo here! The gnu dung[if gnu dung is not in Dumb Mud] with the poo coop[end if] is about as close as you'll get.[mis of 36]") when player is in Dumb Mud.

book Emo Dome

understand "emo home" as a mistake ("It's too wide open a space.[mis of 37]") when player is in Emo Dome.

understand "emo tome" as a mistake ("That would be out of place among all the stupid jokes, here.[mis of 38]") when player is in Emo Dome.

understand "puck cup" as a mistake ("There's no rink nir. Near.[mis of 39]") when puce cup is quicknear.

book Evaded Ave

understand "bung nub" as a mistake ("The bunk nub is in bad enough shape as-is.[mis of 40]") when bunk nub is quicknear.

understand "door brood" as a mistake ("Just one guardian is enough to deal with.[mis of 41]") when Door Frood is quicknear.

book Flu Gulf

understand "gull lug" as a mistake("You shouldn't try to take advantage of sick people. Help the Gulf Lug instead.[mis of 114]") when gulf lug is quicknear.

understand "gulp lug" as a mistake("Cannibalism is wrong. Besides, you'd probably catch whatever the Gulf Lug has.[mis of 115]") when gulf lug is quicknear.

chapter scorn rocs

understand "score rocs" as a mistake ("You don't have any witty way to score off them, or steal them, or whatever, and you don't need to.[mis of 42]") when scorn rocs are quicknear.

understand "rocs cor" as a mistake ("Your flattery doesn't move the rocs.[mis of 43]") when scorn rocs are quicknear.

book Frush Surf

book Fun Nuf

understand "evaded ave" as a mistake ("That'll appear later.[mis of 44]") when player is in Fun Nuf and Evaded Ave is unvisited.

understand "fun enuf" as a mistake ("Still ungrammatical![mis of 45]") when player is in Fun Nuf.

understand "funk nuf" as a mistake ("No cool music plays, but at least it doesn't smell worse.[mis of 46]") when player is in Fun Nuf.

understand "fun snuf" as a mistake ("You vow to take saving fantasy worlds much more seriously. No more frivolity![mis of 47]") when player is in Fun Nuf.

understand "fund nuf" as a mistake ("Nonsense! Adventure is its own reward![mis of 48]") when player is in Fun Nuf.

chapter cap abuse

understand "paca cap" and "pacb cap" and "pacc cap" and "pacd cap" and "pacf cap" and "pacg cap" and "pach cap" and "paci cap" and "pacj cap" and "pacl cap" and "pacm cap" and "pacn cap" and "pacp cap" and "pacq cap" and "pacr cap" and "pacs cap" and "pacu cap" and "pacv cap" and "pacw cap" and "pacx cap" and and "pacz cap" as a mistake ("'Hmm, try again,' grumps the Flee Elf.[mis of 49]") when Flee Elf is quicknear.

understand "paco cap" as a mistake ("The Flee Elf notes that's a pejorative term for policemen in Central America--not quite what you want.[mis of 50]") when Flee Elf is quicknear.

understand "pact cap" as a mistake ("It already is![mis of 51]") when Flee Elf is quicknear.

chapter flee elf abuse

understand "flea elf" and "flea" as a mistake("[fe0]The elf scratches for a bit, then looks embarrassed.[mis of 52]") when Flee Elf is quicknear.

understand "flex elf" and "flex" as a mistake("[fe1]The elf looks more flexible than you. It's the cap you want to concentrate on.[mis of 53]") when Flee Elf is quicknear.

understand "fleece elf" and "fleece" as a mistake("[fe2]There is much more fortune and glory in adventure! It's the cap you want to concentrate on.[mis of 54]") when Flee Elf is quicknear.

flea-elf is a truth state that varies.
flex-elf is a truth state that varies.
fleece-elf is a truth state that varies.

to say fe0:
	now flea-elf is true;

to say fe1:
	now flex-elf is true;

to say fe2:
	now fleece-elf is true;

book Gross Org

understand "dent Ned" as a mistake ("Less violence, more subtlety.[mis of 55]") when Ned is quicknear.

understand "stinko knits" as a mistake ("In this game, you don't need to get drunk. Nurd.[mis of 56]") when stinky knits are quicknear.

book Lair Trial

book Le Babel

book Mire Rim

chapter eroded ore

understand "eros ore" as a mistake ("I don't even want to know what you're trying to do, there.[mis of 57]") when eroded ore is quicknear.

book Mont Nom

[understand "truce curt" as a mistake ("You'll need something more violent, here.") when player is in Mont Nom and Curt is in Mont Nom.

understand "truco curt" as a mistake ("You don't have a deck of cards, and Curt wouldn't want to play.[mis of 58]") when player is in Mont Nom and Curt is in Mont Nom.]

book Motto Bottom

understand "tamp mat" as a mistake ("It's already pretty beaten down.[mis of 59]") when player is in Motto Bottom and tame mat is in Motto Bottom.

understand "gurn rug" as a mistake ("It's a guru rug. It's too good to be moved by such a cheap bailout.[mis of 60]") when guru rug is quicknear.

book Moo Room

understand "moo boom" as a mistake ("You hear something strafe farts far away.[mis of 61]") when player is in Moo Room.

understand "moo doom" as a mistake ("Die? I'd...[mis of 62]") when player is in Moo Room.

book My Gym

understand "evade dave" as a mistake ("Dave's not here, man![mis of 63]") when player is in My Gym and Dave is moot.

understand "wasp saw" as a mistake ("You don't need the wash saw to turn into something that might sting you[if Dave is not moot]. Dave's enough to deal with, right now[else if player has wash saw], especially since you are carrying it[else]. You should probably just take it, instead[end if].[mis of 64]") when wash saw is quicknear.

book Ooze Zoo

understand "eel flee" as a mistake ("Well, you could maybe get one eel to leave, but there are a lot.[mis of 65]") when sleep eels are quicknear.

understand "eel glee" as a mistake ("The eels squirm a bit. I bet they're having fun dreams! Too bad I can't describe them.[mis of 66]") when sleep eels are quicknear.

understand "sleet eels" as a mistake ("They are alive. Turning them to metal would be cruel.[mis of 67]") when sleep eels are quicknear.

understand "sleek eels" as a mistake ("The eels don't need dexterity. They need comfort. They are slippery enough.[mis of 68]") when sleep eels are quicknear.

book Pro Corp

understand "dna land" as a mistake ("Biochemistry has its own nuances with symmetry, but we're sticking with something a lot dumber, here.[mis of 69]") when DNA band is quicknear or DNA hand is quicknear.

understand "DNA hand" as a mistake ("Right idea, but you can't do it on your own. You need technology to help you.[mis of 70]") when DNA band is quicknear.

understand "DNA sand" as a mistake ("That will happen with the passage of time.[mis of 71]") when DNA band is quicknear or DNA hand is quicknear.

understand "dna wand" as a mistake ("No. You know TRUE MAGIC MUST COME FROM WITHIN.[mis of 72]") when DNA band is quicknear or DNA hand is quicknear.

understand "band nab" as a mistake ("The bang nab tries to grap itself. It fails.[mis of 73]") when bang nab is quicknear.

understand "balk lab" as a mistake ("There's not much to do or say here, for sure[if balm-got is false]![else]--well, maybe something that's not quite BALK.[end if][mis of 74]") when player is in Pro Corp.

understand "ball lab" as a mistake ("Nothing fun explodes out from the walls or ceiling.[mis of 75]") when player is in Pro Corp.

understand "golf log" as a mistake ("There is no Par Trap to navigate here, so you don't need to make a golf log.[mis of 76]") when gold log is quicknear.

book Red Roses Order

understand "gal slag" as a mistake ("You managed to annoy Madam enough that she lashes out and conks you with a mortal blow with the Gal Flag. Okay, not really, but name calling won't help.[mis of 77]") when Gal Flag is quicknear. [?? do fake death thing]

understand "sworn rows" as a mistake ("The sword rows are inanimate and neutral. Unless you get too close to them.[mis of 78]") when sword rows are quicknear.

chapter yard ray misuse

understand "yarn ray" as a mistake ("If you want more story, then sorry, this one's nearly at an end.[mis of 79]") when player has yard ray.

understand "yarg ray" and "yarr ray" as a mistake ("Becoming a pirate at the end? A clever heel turn![mis of 80]") when player has yard ray.

book Scrap Arcs

understand "scram arcs" as a mistake ("The arcs stay still, but you can just go back east if you want.[mis of 81]") when player is in Scrap Arcs.

book Seer Trees

understand "seer brees" as a mistake ("[one of]A man throws a football at you from 50 yards away, and it drills you right in the chest. Accurate![or]The man doesn't appear again. He probably has better things to do than schlep around in some text adventure. Perhaps he is off eating at a QB BBQ.[stopping][mis of 82]") when player is in Seer Trees.

understand "seer frees" as a mistake ("[if stark rats are in Seer Trees]It won't be THAT easy[else]You already feel free enough here[end if].[mis of 83]") when player is in Seer Trees.

chapter stark rats

understand "stare rats" as a mistake ("You try to win a blinking contest, and maybe you could with one, but not that many.[mis of 84]") when stark rats are quicknear.

understand "start rats" as a mistake ("You sort of need to stop them, instead.[mis of 85]") when stark rats are quicknear.

chapter gift fig

understand "gif fig" as a mistake ("No graphics, here![mis of 86]") when gift fig is quicknear.

understand "gi fig" as a mistake ("No violence, here![mis of 87]") when gift fig is quicknear.

book Sneer Greens

book Swamp Maws

understand "swami maws" and "swamy maws" as a mistake ("They can't quite be. The Known Wonk's knowledge is not universal enough.[mis of 88]") when player is in Swamp Maws.

understand "swam maws" as a mistake ("Perhaps someone has, but you don't need to.[mis of 89]") when player is in Swamp Maws.

book Swept Pews

understand "trod ort" as a mistake ("It looks run-down enough.[mis of 90]") when troll ort is in Swept Pews.

understand "liar frail" and "liar trail" as a mistake ("The grail remains in your way to the south. But it was worth a try.[mis of 91]") when liar grail is quicknear.

book Toll Lot

understand "told lot" as a mistake ("[if cross orc is in Toll Lot]The cross orc isn't open to verbal negotiation[else]You pretend you won an argument against the cross or and didn't just hand over money[end if].[mis of 92]") when player is in Toll Lot.

understand "crop orc" as a mistake ("That attack would boomerang, and not just because this is a palindrome-y game. The orc is lots, lots bigger than you.[paragraph break]Also, there is no farm nearby.[mis of 93]") when cross orc is quicknear.

understand "croc orc" as a mistake ("The orc is fearsome enough without becoming a total genetic monstrosity.[mis of 94]") when cross orc is quicknear.

understand "crow orc" as a mistake ("The orc remains silent (yay) and flightless (boo).[mis of 95]") when cross orc is quicknear.

understand "cray arc" as a mistake ("The arc doesn't need to change shape or become more volatile.[mis of 96]") when player is in Toll Lot.

understand "crap arc" as a mistake ("You might cause a mudslide, or worse.[mis of 97]") when player is in Toll Lot or player is in Scrap Arcs.

understand "crass arc" as a mistake ("[if cross orc is in Toll Lot]The cross orc and crag arc don't fuse together. Rats[else]You spend a few seconds feeling deeply offended by the crag arc[end if].[mis of 98]") when player is in Toll Lot or player is in Scrap Arcs.

understand "cram arc" as a mistake ("You can't stuff anything in it.[mis of 99]") when player is in Scrap Arcs.

understand "crab arc" as a mistake ("That's just what you need, a giant crab coming after you[if cross orc is in Toll Lot], along with the cross orc[end if].[mis of 100]") when player is in Toll Lot.

book Trapeze Part

book Worn Row

understand "worm row" as a mistake ("[if Worn Row is worny]Ugh! You don't need to make this place worse[else]You already upgraded Worn Row. No need to downgrade it[end if].[mis of 101]") when player is in Worn Row.

understand "bork Rob" as a mistake ("Maybe there is a more nonviolent way to get him to give up.[mis of 102]") when Rob is quicknear.

understand "borg Rob" as a mistake ("He is already assimilated.[mis of 103]") when Rob is quicknear.

understand "track cart" as a mistake ("Right idea, but the cart isn't going anywhere.[mis of 104]") when player is in Worn Row and Worn Row is worky.

chapter dork rod

understand "dorm rod" and "dorm" as a mistake ("You reveal no frat. Arf![mis of 105]") when dork rod is quicknear.

chapter ERA FARE

understand "era ware" as a mistake("The book is neither software nor for sale.[mis of 106]") when ERA FARE is quicknear.

understand "era hare" as a mistake("You always wanted to learn how to pull a rabbit out of a big book, but this isn't hollow enough.[mis of 107]") when ERA FARE is quicknear.

understand "era rare" as a mistake("Every time seems odd if you look at it right, yes.[mis of 108]") when ERA FARE is quicknear.

understand "era mare" as a mistake("Quit horsing around with the book.[mis of 109]") when ERA FARE is quicknear.

understand "era care" as a mistake("You try to inject some sympathy into the book's dry writing, but you're worried you'll overdo it.[mis of 110]") when ERA FARE is quicknear.

book Yawn Way

understand "yawp way" and "yawl way" as a mistake ("It's still quiet here.[mis of 111]") when player is in Yawn Way.

book Yell Alley

understand "pcp" as a mistake ("While searching for a bost, you're apprehended by a crank narc! I'm very disappointed in you. Not the whole drugs bit, but that this game didn't alter reality enough for you.[etg][mis of 112]") when player is in Yell Alley or player is in Evaded Ave.

understand "nacelle can" as a mistake ("You don't need a huge engine.[mis of 113]") when player has snack cans.

volume checking off mistakes from the player

mist-found is a number that varies.

mis-yet is a truth state that varies.

cur-LLP-hint-row is a number that varies. cur-LLP-hint-row is 0.

checkoffs is a list of truth states variable. checkoffs is { false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }.

hint-every-x is a number that varies. hint-every-x is 5.

to say mis of (n - a number):
	let Q be entry N in checkoffs;
	if Q is false:
		now entry N in checkoffs is true;
		increment mist-found;
		if mist-found is 1:
			say "[paragraph break](NOTE: this was a specific reject for a good try. For the most part, you don't need to riff on anything after the pact cap, but enough good guesses will tell you how to get secret points.)";
			continue the action;
		if the remainder after dividing mist-found by hint-every-x is 0:
			while cur-LLP-hint-row < number of rows in table of last lousy points:
				increment cur-LLP-hint-row;
				choose row cur-LLP-hint-row in table of last lousy points;
				consider the dorule entry;
				if the rule failed:
					say "[paragraph break]A voice from behind the fourth wall whispers: [cluey entry]";
					now mclu entry is true;
					if mis-yet is false:
						now mis-yet is true;
						say "[paragraph break]NOTE: THINK[if refer-bonus is true]/REFER[end if] will show you the LLPs clued so far that you haven't figured, yet.[run paragraph on][line break]";
					continue the action;

volume prospective

Put It Up Mistakes ends here.

---- DOCUMENTATION ----
