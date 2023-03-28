Version 1/171220 of Ailihphilia Mistakes by Andrew Schultz begins here.

volume Mistakes

[the rooms here are arranged alphabetically. When an item triggers the mistake, the room will be the one where you first find the item. If there are two places, we go with the first: for instance, (partial spoiler) the roto motor appears in the west of the two locations where it can turn up.]

[programmer's note: the utility aam.py adds or sorts the 'mis' numbers. This was probably a bad idea, but I did it anyway, because it seemed organizational at the time. Now it just throws way too many changes into git. Mist.py makes sure each mistake is in the appropriate rbr-* or reg-* test file.]

chapter stuff that would stomp on mistakes if it appeared later

[put this in here so it doesn't wipe out "pace recap" etc. in the mistakes below]

section something-new that must be declared before mistakes

understand the command "pace" as something new.
understand the command "ta" as something new.
understand the command "verb" as something new.

chapter quickdefs

[todo: (programming exercise) write script that can automatically change when player is in x and (y) is in x to when (y) is quicknear)]

definition: a thing (called mt) is quicknear:
	if mt is in location of player, yes;
	if player carries mt, yes;
	if player wears mt, yes;
	no;

to say no-oronyms: say "Oronyms are cool, but they aren't part of this game"

chapter Apse Spa

to decide whether spa-ish:
	if player is in Apse Spa, yes;
	if spa maps are quicknear, yes;
	no;

understand "apse vespa" as a mistake ("No wasps come out to sting you.[mis of 1]") when player is in Apse Spa.

understand "dosh sod" as a mistake ("You can't convert the dose sod to money. It has healing power.") when dose sod is quicknear or puce cup is soddy

understand "esp apse" as a mistake ("You don't see what to do next.[mis of 2]") when player is in Apse Spa.

understand "pat tap" as a mistake ("Nothing happens. Fortunately, you don't need anything from the tap.[mis of 3]") when player is in Apse Spa.

understand "pate tap" as a mistake ("You need nothing fancy from the tap.[mis of 3]") when player is in Apse Spa.

understand "path tap" as a mistake ("There is no path behind the tap[if spa maps are moot]--you already explored the go-by bog[else if player has spa maps]--one glance at the spa maps shows that[end if].[mis of 3]") when player is in Apse Spa.

understand "pool sloop" as a mistake ("No boat appears to take you across the watery bits. [if sage gas is off-stage]You'll need another way through[else]You already got the sage gas, anyway[end if].[mis of 4]") when player is in Apse Spa.

understand "saga gas" as a mistake ("You probably need wisdom more than description of someone else's epic right now.[mis of 5]") when sage gas is quicknear.

understand "sagene gas" as a mistake ("The sage gas would not be better as a fishing net.") when sage gas is quicknear.

understand "sago gas" as a mistake ("The sage gas fails to become an edible powder. Perhaps it is better as FOOD FOR THE MIND.[mis of 6]") when sage gas is quicknear.

understand "spa caps" as a mistake ("BUT YOU ALREADY HAVE YOUR PACE CAP![mis of 7]") when spa-ish.

understand "spa faps" as a mistake ("Some spas are for that, but not this one. Ailihphilia's jokes may be cheap, but they're not that crude. I hope.") when spa-ish.

understand "spa gaps" as a mistake ("[if player is not in Apse Spa]No, you want the maps to be complete[else]The Apse Spa is too sturdy. You don't want it to collapse[end if].[mis of 8]") when spa-ish.

understand "spa laps" as a mistake ("You never need to swim anywhere in this game. Or drink anything.[mis of 9]") when spa-ish.

understand "spa naps" as a mistake ("No time to relax! There's adventuring to be had![mis of 10]") when spa-ish.

understand "spa raps" as a mistake ("The spa is a place of peace. Stop that infernal beatboxing, and get off my lawn![mis of 11]") when spa-ish.

understand "spa saps" as a mistake ("One day, with the Diktat Kid gone, plenty of people will waste money on a spa, but your job is to get things there.[mis of 12]") when spa-ish.

understand "spa yaps" as a mistake ("The spa taps reveal no hints or small talk.[mis of 13]") when spa-ish.

understand "spa zaps" as a mistake ("You don't need a weapon.[mis of 14]") when spa-ish.

understand "spat taps" as a mistake ("You don't need to get in an argument with something inanimate right now.[mis of 15]") when player is in Apse Spa or spa maps are quicknear.

chapter Art Xtra

understand "art ecetra" as a mistake ("One silly misspelling does not beget another.[mis of 16]") when player is in Art Xtra.

understand "part trap" as a mistake ("[if player has party trap]That'd ruin it[else]There's got to be a way to make the full trap[end if].[mis of 17]") when trap art is quicknear or player has party trap.

understand "trad art" as a mistake ("You need something practical and forward-thinking for adventure. Traditional art would not do that.[mis of 18]") when trap art is quicknear.

understand "trade dart" as a mistake ("[no-oronyms].") when player is in Art Xtra.

understand "trak art" as a mistake ("You don't need trains or anything right now.[mis of 19]") when trap art is quicknear.

understand "tram art" as a mistake ("Public transport is the least of Grebeberg/Yelpley's issues at the moment.[mis of 20]") when trap art is quicknear.

understand "tray art" as a mistake ("There is no restaurant nearby.[mis of 21]") when trap art is quicknear.

chapter Cold Loc

understand "cola loc" as a mistake ("You'd be better off with a warmer drink. Which isn't here.[mis of 22]") when player is in Cold Loc.

understand "colt loc" as a mistake ("No gandered nag appears. Or gun(ug).[mis of 23]") when player is in Cold Loc.

understand "kin nik" and "kine nik" as a mistake ("Sorry. You're not related, and that's that.[mis of 24]") when King Nik is quicknear.

understand "kind nik" as a mistake ("He already seems pretty nice. His deficiencies are more ... administrative.[mis of 25]") when King Nik is quicknear.

understand "kink nik" as a mistake ("He's already bent out of shape over his country's problems.[mis of 26]") when King Nik is quicknear.

understand "kino nik" as a mistake ("He doesn't need to be distracted with gambling.[mis of 27]") when King Nik is quicknear.

understand "kins nik" as a mistake ("Nik has family back home. You'll want to help him so they can be proud of him.") when King Nik is quicknear.

understand "nik siskin" and "nik pipkin" and "nik nankin" as a mistake ("You don't need to change King Nik into a non-human.") when King Nik is quicknear.

understand "nik skin" as a mistake ("This isn't that sort of game. Really.") when King Nik is quicknear.

understand "pass sap" as a mistake ("[if liar grail is moot]Yes, you can pass on the sap, now that you used it to destroy the Liar Grail[else]You decide not to do anything constructive with the sap. Well, THIS turn[end if].[mis of 379]") when player is in Cold Loc

understand "pua up" as a mistake ("That's completely the wrong way to gain confidence.[mis of 28]") when player has spur ups.

understand "pub up" as a mistake ("Alcohol is not the answer.[mis of 29]") when player has spur ups.

understand "pun up" as a mistake ("No time for lame jokes! Well, on your end, anyway.[mis of 30]") when player has spur ups.

understand "pup" and "pug up" and "pup up" as a mistake ("You don't need a dog to help you feel braver. You need something inside you, to help you feel up.[mis of 31]") when player has spur ups.

understand "purer up" as a mistake ("This game isn't about morality.[mis of 32]") when player has spur ups.

understand "purr up" as a mistake ("The Spur Ups make you feel you can be anyone, but not anything.[mis of 33]") when player has spur ups.

understand "puss up" as a mistake ("No cat appears.[mis of 34]") when player has spur ups.

understand "put up" and "put it up" as a mistake ("[if spur ups are moot]The Spur Ups taught you how to put up with nonsense, and you reflect on their lesson[else]The Spur Ups are for more than just getting by.[mis of 35]") when spur ups are not off-stage.

understand "putt up" as a mistake ("The Spur Ups have no suitable flat edge with which to hit a golf ball.[mis of 36]") when player has spur ups.

understand "puz up" and "puzz up" as a mistake ("Oh, there are plenty of puzzles ahead.[mis of 37]") when player has spur ups.

understand "rife fir" as a mistake ("It's already big enough.[mis of 38]") when player is in Cold Loc.

understand "riff fir" as a mistake ("It's rife enough to block passage west and to provide past sap.[mis of 39]") when player is in Cold Loc.

understand "scold locs" and "scolded locs" as a mistake ("You don't have time for extended arguing, here. [if Diktat Kid is moot]You managed[else]You're trying[end if] to unite Yelpley and Grebeberg.") when player is in Cold Loc.

understand "spud ups" as a mistake ("The Spur Ups don't become potatoes or French fries or whatever.[mis of 40]") when player has spur ups.

understand "spue ups" as a mistake ("The Spur Ups fail to spit anything out.[mis of 41]") when player has spur ups.

understand "spun ups" as a mistake ("One of the Spur Ups rotates slightly. Maybe it needs to be UP, not UPS.[mis of 42]") when player has spur ups.

understand "up apu" as a mistake ("Apu would have some helpful advice, but he'd have to leave Springfield.[mis of 43]") when player has spur ups.

understand "up cpu" as a mistake ("You shouldn't need many cycles to run a text adventure.[mis of 44]") when player has spur ups.

chapter Deft Fed

understand "defy fed" as a mistake ("[if yob attaboy is moot]Way to go! Keep that HUNGER! Well, I hope it's that and not conspiracy theories about the Fed[else]No problem, you're not getting fed anyway[end if].[mis of 45]") when player is in Deft Fed.

understand "deli filed" as a mistake ("You are not a government bureaucrat.[mis of 46]") when player is in Deft Fed.

understand "nato tan" as a mistake ("No alliance of nations appears to save the day. Guess it's just you.[mis of 383]") when Nat's Tan is quicknear.

understand "smeggems" as a mistake ("Smuggums isn't THAT insufferable. You don't want to MAKE Smuggums that insufferable.") when player is in Deft Fed and Sniffins-reintro is true.

understand "stan gnats" as a mistake ("Clever, but nobody's a fan of gnats. [if player has Nat's Tan]You did what you could to get it[else]Focus on what to do with Nat's[end if].[mis of 377]") when Nat's Tan is quicknear.

understand "stan nats" and "stan nat's" as a mistake ("Well, Nat's must have its stans, but you don't want to be one.[mis of 47]") when Nat's Tan is quicknear.

understand "stank nats" and "stank nat's" as a mistake ("Yes, it's pretty awful.[mis of 48]") when Nat's Tan is quicknear.

understand "tang nat" as a mistake ("The orange-ish goop fails to turn into orange-ish drink-mix powder.[mis of 384]") when Nat's Tan is quicknear.

understand "tank nat" as a mistake ("No, even a small amount of Nat's is enough.[mis of 50]") when Nat's Tan is quicknear.

understand "tannin nat" as a mistake ("It probably has enough weird, horrible ingredients.[mis of 51]") when Nat's Tan is quicknear.

understand "tans nat" as a mistake ("You wonder if there is more than one type of Nat's Tan. You hope not.[mis of 385]") when Nat's Tan is quicknear.

section Bon Snob

understand "bon knob" as a mistake ("You don't need to help Sniffins with interior decorating, here.[mis of 52]") when player is in Deft Fed and YOB ATTABOY is moot.

chapter Dirge Grid

understand "dike kid" as a mistake ("The Diktat Kid has fingers in more than a dike.") when Diktat Kid is quicknear.

understand "dir grid" as a mistake ("With only one way out, you don't need directions.[mis of 53]") when player is in Dirge Grid.

understand "dirge me grid" as a mistake ("Boy, if this game weren't polite on the Zarfian cruelty scale, you'd be in trouble now![mis of 54]") when player is in Dirge Grid.

understand "par crap" as a mistake ("Making fun of others['] clothing isn't as evil as the Diktat Kid, but it's not what REAL heroes do![mis of 55]") when Verses Rev is quicknear.

understand "par trap" as a mistake ("You aren't on a golf course.[mis of 56]") when Verses Rev is quicknear.

understand "po top" as a mistake ("No, it's better like this.") when player is in Dirge Grid and Diktat Kid is moot.

understand "verb rev" as a mistake ("[if verses rev is quicknear]Oh, the Verses Rev is active enough[else]The commands from VERBS flash through your head, too quick to read[end if].[mis of 57]"). [okall]

understand "versus rev" as a mistake ("The Verses Rev is already against you.[mis of 58]") when Verses Rev is quicknear.

understand "very rev" as a mistake ("The Verses Rev fails to become extremely spiritual. But it was worth a try.[mis of 59]") when Verses Rev is quicknear.

chapter Dopy Pod

understand "cash sac" as a mistake ("You look extra carefully at the sac. No, no secret compartments.[mis of 60]") when cassettes sac is quicknear and player does not have cash sac.

understand "demi med" as a mistake ("You don't need to split up the demo med.") when demo med is quicknear.

understand "dir rid" as a mistake ("Rm -r is fewer keystrokes.[mis of 61]") when Dirt Rid is quicknear.

understand "dire rid" as a mistake ("Your situation isn't that bad, but it doesn't get any better.[mis of 62]") when Dirt Rid is quicknear.

understand "dirk rid" as a mistake ("If you had a dagger in your back, which you don't, that might be useful. But you don't.[mis of 63]") when Dirt Rid is quicknear.

understand "do pod" as a mistake ("[if cassettes sac is in Dopy Pod]But what to do to it? How to change it?[else]You've done enough here.[end if][mis of 64]") when player is in Dopy Pod.

understand "pi lip" as a mistake ("No digits starting 3.14 appear on the lip, which is all for the best. Memorization doesn't seem necessary here.[mis of 65]") when pill lip is quicknear.

understand "pile lip" as a mistake ("Nothing really fits on the pill lip besides the demo med.[mis of 66]") when pill lip is quicknear.

understand "pilf lip" as a mistake ("You don't need to take the pill lip like you took the pact cap.[mis of 67]") when pill lip is quicknear.

understand "pod op" as a mistake ("But what sort of op?[mis of 68]") when player is in Dopy Pod.

understand "xanax" as a mistake ("No, any medicine in this game is for physical ills.") when demo med is quicknear or gulf lug is quicknear or Bond Nob is quicknear.

chapter Drawl Ward

understand "bone nob" as a mistake ("Out of your league.[paragraph break]I mean, the Bond Nob has an active social life that revolves around bars, and you ... well, you're just a text adventure. That's barely a step above people who program text adventures![mis of 69]") when Bond Nob is quicknear.

understand "bong nob" as a mistake ("The Bond Nob probably knows someone but prefers alcohol.[mis of 70]") when Bond Nob is quicknear.

understand "bonk nob" as a mistake ("That'd let you get west ... until [the Bond Nob] woke up and called a few less-sick friends.[mis of 71]") when Bond Nob is quicknear.

understand "bono nob" as a mistake ("The Bond Nob blinks but still hasn't found what they're looking for. Like, er, a cure for their condition. You haven't, either. Hint, hint.") when Bond Nob is quicknear.

understand "bony nob" as a mistake ("The Bond Nob's body weight is not an important issue, here.[mis of 72]") when Bond Nob is quicknear.

understand "drawn ward" and "draws ward" as a mistake ("The room remains text-based.[mis of 73]") when player is in Drawl Ward.

chapter Dumb Mud

to say dung-w-coop: say "[if gnu dung is not in Dumb Mud] with the poo coop[end if]"

to say rut-check: say "It's too large to redirect[if poo coop is moot], and besides, you already have a way across[end if]"

to say self-help: say "You whisper some world-appropriate self-help"

understand "dump mud" as a mistake ("It's already kind of dumped here[if poo coop is not moot]. Maybe you could dump the mud into the rut for passage south, but it might take too long, and you don't have a shovel. You'd need something else[end if].[mis of 74]") when player is in Dumb Mud.

understand "gnu bung" as a mistake ("There's no way to put the toothpaste back in the tube, as it were.[mis of 75]") when y-poopy.

understand "gnu hung" as a mistake ("Uggh. It's good you're in a text adventure, I guess.[mis of 76]") when y-poopy.

understand "gnu jung" as a mistake ("The gnu fails to bring forth the spirit of a famous psychiatrist from the collective unconscious.") when y-poopy.

understand "gnu lung" as a mistake ("The gnu dung smells bad enough without dropping more internal organs into the mix.[mis of 77]") when y-poopy.

understand "gnu ng" as a mistake ("It won't do to chastise the gnu now. What's dung is dung. Uh, what's done is done.") when y-poopy.

understand "gnu rung" as a mistake ("You want to move west from here, not up.[mis of 78]") when y-poopy.

understand "gnu sung" as a mistake ("You don't need to speculate what the gnu was doing.[mis of 79]") when y-poopy.

understand "lie ceil" as a mistake ("Good try, but there's not enough of the Lie Veil to make a ceiling.") when lie veil is quicknear.

understand "lie deil" as a mistake ("You don't need to deal with supernatural stuff.") when lie veil is quicknear.

understand "oops poo" as a mistake ("The coop is useful in emergencies, but let's not MAKE one, okay?[mis of 80]") when poo coop is quicknear.

understand "sun gnus" as a mistake ("You try to shine a light on possible culprits, but to no avail.[mis of 81]") when y-poopy.

understand "turd rut" as a mistake ("Hmm! Maybe you could fill the rut up with ... something ... to cross it.[mis of 82]") when player is in Dumb Mud and poo coop is not moot.

understand "turk rut" as a mistake ("Maybe there's a teleport to distant lands in the rut, but you don't want to risk it.[mis of 83]") when player is in Dumb Mud and poo coop is not moot.

understand "turn rut" as a mistake ("[if player is in dumb mud][rut-check][else][self-help][end if].[mis of 84]"). [okall]

understand "turnon rut" and "turn on rut" as a mistake ("[if player is in Dumb Mud]No innuendo here! The gnu dung[dung-w-coop] is about as close as you'll get to R-rated[else][self-help][end if].[mis of 85]") when player is in Dumb Mud.

understand "turp rut" as a mistake ("Adding either turpitude or turpentine to the rut could not possibly help things.[mis of 86]") when player is in Dumb Mud and poo coop is not moot.

understand "un gnu" as a mistake ("Eliminating the perpetrator won't eliminate what they've dung. Uh, dun. Er, done.[mis of 87]") when y-poopy.

chapter Emo Dome

understand "did id" as a mistake ("There's saying you got or found an ID, and there's doing.[mis of 88]") when player is in Emo Dome and Ms Ism is not moot.

understand "die id" as a mistake ("The Diff-ID is a machine.[mis of 89]") when player is in Emo Dome and Ms Ism is not moot.

understand "dig id" as a mistake ("You spend a moment being impressed by however the DIFF-ID operates.[mis of 90]") when player is in Emo Dome and Ms Ism is not moot.

understand "dill id" as a mistake ("You're in no less of a pickle now than before.[mis of 91]") when player is in Emo Dome and Ms Ism is not moot.

understand "dim id" as a mistake ("The DIFF-ID remains fully charged.[mis of 92]") when player is in Emo Dome and Ms Ism is not moot.

understand "dip id" as a mistake ("You'll need to ID yourself more positively than THAT.[mis of 93]") when player is in Emo Dome and Ms Ism is not moot.

understand "dir id" as a mistake ("The Diff-ID can't be operated so easily.[mis of 94]") when player is in Emo Dome and Ms Ism is not moot.

understand "dis id" and "diss id" as a mistake ("You feel better after whispering a meaningless insult.[mis of 95]") when player is in Emo Dome and Ms Ism is not moot.

understand "div id" as a mistake ("You vow, once you've finished this world-saving, to buckle down and learn HTML tags beyond <b>, <i> and <u>.[mis of 96]") when player is in Emo Dome and Ms Ism is not moot.

understand "diy id" as a mistake ("You may have to, to get by the DIFF ID, but how?[mis of 97]") when player is in Emo Dome and Ms Ism is not moot.

understand "emo come" as a mistake ("You feel increased whininess inside.[mis of 98]") when player is in Emo Dome.

understand "emo home" as a mistake ("It's too wide open a space.[mis of 99]") when player is in Emo Dome.

understand "emo rome" as a mistake ("This game is not remotely close to historical fiction. Sorry.[mis of 100]") when player is in Emo Dome.

understand "emo some" as a mistake ("Oh no. Once you get a little sad, you'll get a lot sad.[mis of 100]") when player is in Emo Dome.

understand "emo tome" as a mistake ("That would be out of place among all the stupid jokes, here.[mis of 101]") when player is in Emo Dome.

understand "puck cup" as a mistake ("There's no rink nir. Near.[mis of 102]") when puce cup is quicknear.

chapter Evaded Ave

to say bunt-err: say "[one of]. Strike one![or]. Strike two![or]. Your third foul bunt is a strikeout. Sorry, them's the rules![etg][stopping]"

understand "bun nub" and "buns nub" as a mistake ("No free food. Boo.[mis of 103]") when bunk nub is quicknear.

understand "bung nub" as a mistake ("The bunk nub is in bad enough shape as-is.[mis of 104]") when bunk nub is quicknear.

understand "bunt nub" and "bunt at nub" as a mistake ("Baseball references are a bit too Zork 2[bunt-err][mis of 105]") when bunk nub is quicknear.

understand "door brood" as a mistake ("Just one guardian is enough to deal with.[mis of 106]") when Door Frood is quicknear.

understand "pcp" as a mistake ("While searching for a boost, or maybe hoping for a Last Lousy Point, you're apprehended by a crank narc! I'm very disappointed in you. Not the whole drugs bit, but that this game didn't alter reality ENOUGH for you.[etg][mis of 107]") when player is in Yell Alley or player is in Evaded Ave.

understand "tube debut" as a mistake ("It already did.[mis of 108]") when tube but is quicknear.

chapter Flu Gulf

to decide whether either-sac:
	if cassettes sac is quicknear or player has cash sac, yes;
	no;

understand "casaba sac" and "casava sac" as a mistake ("You are hungry for adventure, not physically hungry.") when either-sac.

understand "case sac" as a mistake ("You look extra carefully at the sac. No, no secret compartments.[mis of 109]") when either-sac.

understand "cast sac" as a mistake ("No need to fling stuff around, and no need for magic, either.[mis of 110]") when either-sac.

understand "gull lug" and "gull ug" as a mistake ("The Gulf Lug is too heavy to be a bird.[mis of 111]") when gulf lug is quicknear.

understand "gulp lug" as a mistake ("Cannibalism is wrong. Besides, you'd probably catch whatever the Gulf Lug has.[mis of 112]") when gulf lug is quicknear.

understand "musc sum" as a mistake ("You don't need Dave to return.[mis of 113]") when player is in Flu Gulf.

understand "muse sum" as a mistake ("You think back to everyone who has inspired you, past and present. It's life-affirming![mis of 114]") when player is in Flu Gulf or Dave is quicknear.

understand "musk sum" as a mistake ("[location of player] still smells the same. For better or worse.[mis of 115]") when player is in Flu Gulf or Dave is quicknear.

understand "must sum" as a mistake ("[if Dave is quicknear]No, you don't NEED to guesstimate how strong Dave is[else]You do some random mental math, which gives you a headache, which is sort of appropriate for Flu Gulf ... but also totally useless[end if].[mis of 116]") when player is in Flu Gulf or Dave is quicknear.

section scorn rocs

understand "corn roc" as a mistake ("The scorn rocs remain plural and inorganic.[mis of 117]") when scorn rocs are quicknear.

understand "rocs cor" as a mistake ("Your flattery doesn't move the rocs.[mis of 118]") when scorn rocs are quicknear.

understand "score rocs" as a mistake ("[if flu gulf is not visited]You don't need allies like that. But, spoiler: there are enemies like that[else if scorn rocs are not moot]0/10 would not pet. They're bad rocs, Brent ... but you'll get a point for getting rid of them[else]You already scored ON them[end if].[mis of 119]"). [if you didn't see the reference, it's WeRateDogs on twitter and "They're good dogs Brent"] [okall]

understand "scornin rocs" as a mistake ("Yes, they are that, too.") when scorn rocs are quicknear.

chapter Frush Surf

understand "fresh serf" as a mistake ("Nobody appears to do your work for you.") when player is in Frush Surf.

understand "kayak a yak" and "kayak ayak" and "kayak yak" as a mistake ("[if kayak is quicknear and yak is quicknear]You've got the right idea, sort of, but the wrong place[else if kayak is moot]You already used the kayak[else if yak is moot]The yak has done its job[else if Frush Surf is unvisited]There's a yak around, just not here[else if Lac Oft Focal is unvisited]There's a kayak around, just not here[else]You don't need to bring the yak and kayak together[end if].[mis of 376]") when yak is quicknear or kayak is quicknear.

understand "yak kay" and "kay yak" as a mistake ("The yak perks its ears up slightly, then goes back to looking bored. Maybe you didn't quite say things right.[mis of 122]") when yak is quicknear.

understand "yak mkay" and "mkay yak" as a mistake ("Right idea, wrong pronunciation.[mis of 123]") when yak is quicknear.

chapter Fun Enuf

understand "dare rad" as a mistake ("You try to gain inspiration from the Darer Ad, but it's a bit too silly.[mis of 124]") when Darer Ad is carried.

understand "dood" as a mistake ("[if player has El Doodle]You exclaim 'dood' at El Doodle, hoping to simplify a bit of it, but it needs some serious editing. [end if][if poop-boob-yet is false]Whoah! That was dangerously close to getting a LLP for cussing 'appropriately' for this game.[else]You already got a point for cussing 'appropriately.'[end if][mis of 125]") [okall]

understand "evaded ave" as a mistake ("That'll appear later.[mis of 126]") when player is in Fun Enuf and Evaded Ave is unvisited.

understand "eval ave" as a mistake ("[if player has pact cap]You've already been[else]You're currently being[end if] evaluated.[mis of 127]") when player is in Fun Enuf.

understand "evar ave" as a mistake ("Evac Ave seems pretty timeless.[mis of 128]") when player is in Fun Enuf.

understand "fu nuf" as a mistake ("Any FU is too much FU in a (Zarfian) polite game like this. [if poop-boob-yet is true]You found a better[else]There's a more appropriate[end if] way to swear in this game.[mis of 129]") when player is in Fun Enuf.

understand "fun nuf" as a mistake ("Still ungrammatical![mis of 130]") when player is in Fun Enuf.

understand "fun snuf" as a mistake ("You vow to take saving fantasy worlds much more seriously. No more frivolity![mis of 131]") when player is in Fun Enuf.

understand "fund nuf" as a mistake ("Nonsense! Adventure is its own reward![mis of 132]") when player is in Fun Enuf.

understand "funk nuf" as a mistake ("No cool music plays, but at least it doesn't smell worse.[mis of 133]") when player is in Fun Enuf.

understand "kaos soak" and "soak kaos" and "soaky kaos" as a mistake ("The [kaoscaps] fails to collapse in a torrent of water.[mis of 134]") when KAOS Oak is quicknear.

understand "senile pipelines" as a mistake ("The felines don't need a passage elsewhere.") when senile felines are quicknear.

understand "take kat" as a mistake ("[if senile felines are quicknear]They're cats, so you need to do something different with them[else]There is no kat in this game---only the Pact Cap needs a riff on TAKE[end if].[mis of 135]") [okall]

understand "tilded lit" as a mistake ("The writing on the tile lit remains free of diacritical marks.[mis of 136]") when player is in Fun Enuf.

understand "till lit" as a mistake ("You possess no farm tools. And this would be pointless anyway.[mis of 137]") when player is in Fun Enuf.

understand "tilt lit" as a mistake ("It's stuck into the ground.[mis of 138]") when player is in Fun Enuf.

section cap abuse

to say pace-clue-maybe:
	say "[if pace-prev is true or cap-ever-pace is true]There's nothing else special to do with the pace cap[else]There may be one more thing to do other than PACK the cap, but that's not it[end if]"

understand "pa cap" as a mistake ("[if flee elf is quicknear]The word DAD briefly flashes on the Pact Cap. Weird, but not really[else]Unfortunately, parental advice doesn't help, here[end if].[mis of 139]") when Pact Cap is quicknear.

understand "pac cap" as a mistake ("You almost take the cap, but you fumble it slightly. The Flee Elf blinks. 'You're almost there, but ... umm, well, you need to do a little more.'[paragraph break]Also, PACs aren't necessarily evil, but they aren't terribly heroic.[mis of 140]") when Flee Elf is quicknear.

understand "paca cap" and "pacb cap" and "pacc cap" and "pacd cap" and "pacf cap" and "pacg cap" and "pach cap" and "paci cap" and "pacj cap" and "pacl cap" and "pacm cap" and "pacn cap" and "pacp cap" and "pacq cap" and "pacr cap" and "pacu cap" and "pacv cap" and "pacw cap" and "pacx cap" and "pacz cap" as a mistake ("[if player has pact cap][pace-clue-maybe][else]'Hmm, try again,' grumps the Flee Elf[end if].[mis of 141]") when Pact Cap is quicknear. [this should be trivially true, but just in case...]

understand "pace recap" as a mistake ("You run in place briefly to make sure you've still got that extra burst of speed.[mis of 142]") when player has pact cap and cap-pace is true.

understand "paco cap" as a mistake ("[if player has pact cap][pace-clue-maybe][else]The Flee Elf notes that's a pejorative term for policemen in Central America--not quite what you want, for decency or for practicality[end if].[mis of 143]") when Pact Cap is quicknear.

understand "pacs cap" as a mistake ("PACs aren't necessarily evil, but they aren't terribly heroic.[mis of 144]") when Pact Cap is quicknear.

understand "pact cap" as a mistake ("It already is![mis of 145]") when Pact Cap is quicknear.

understand "perk rep" as a mistake ("The Flee Elf is already awake.[mis of 146]") when Flee Elf is quicknear.

understand "space caps" as a mistake ("Really, you only need one. Who do you think you are, Bartholomew Cubbins? Zaphod Beeblebrox?[mis of 147]") when Pact Cap is quicknear.

section flee elf abuse

to say elf-note: now tried-elf is true;

tried-elf is a truth state that varies.

understand "elf i rifle" as a mistake ("The elf is on your side, and this is a nonviolent game.") when flee elf is quicknear.

understand "flea elf" and "flea" as a mistake("[elf-note]The elf scratches for a bit, then looks embarrassed.[mis of 148]") when Flee Elf is quicknear.

understand "fled elf" and "fled" as a mistake("[elf-note]The elf will be, once you figure how to take the cap.[mis of 149]") when Flee Elf is quicknear.

understand "fleece elf" and "fleece" as a mistake("[elf-note]There is much more fortune and glory in adventure! It's the cap you want to concentrate on.[mis of 150]") when Flee Elf is quicknear.

understand "flem elf" and "flem" as a mistake("[elf-note]The elf coughs ickily and quickly lists pros and cons of whether words should by pronounced phonetically.[mis of 151]") when Flee Elf is quicknear.

understand "flen elf" and "flen" as a mistake("[elf-note]Dry ketchup is gross. Besides, the elf is one of the good guys.[mis of 152]") when Flee Elf is quicknear.

understand "flew elf" and "flew" as a mistake("[elf-note]The elf mumbles, apropos of nothing, 'Boy, are my arms tired!'[mis of 153]") when Flee Elf is quicknear.

understand "flex elf" and "flex" as a mistake("[elf-note]The elf looks more flexible than you. It's the cap you want to concentrate on.[mis of 154]") when Flee Elf is quicknear.

section Set O Notes abuse

to say girt-clue:
	if row-prog > 1:
		say "Hmm. You seem to have found the three configurations for Worn Row[if psi wisp is not moot]. Maybe Worn Row will be useful in the future, maybe not[else], and you even used the Redness Ender[end if]";
	else if row-prog is 0:
		say "You need to figure out what that means. It seems to indicate [if Worn Row is visited][Worn Row][else]a room south of, but not directly, [Fun Enuf][end if]";
	else:
		say "Hmm. Tri indicates three. You've found two different configurations for Worn Row/[Worn Row]. What is the third, you wonder";

understand "tri girt" as a mistake ("[girt-clue].[mis of 155]") when player has Set O Notes.

chapter Gross Org

to say no-gro: say "[one of]This game is just a bunch of dumb jokes and silly wordplay mashed together, and any attempt at personal growth is severely frowned upon. So stop that![or]Your height does not change.[stopping]"

understand "bra garb" as a mistake ("I've tried to keep this game gender neutral.[mis of 156]") when brag garb is quicknear.

understand "de ned" and "dened" as a mistake ("It's not that easy to get rid of Ned. Okay, it's almost that easy, but you can't just vanish him.") when Ned is quicknear.

understand "den ed" as a mistake ("There isn't much to learn about Ned's Den, and you don't want to bring in someone named Ed.") when player is in Gross Org.

understand "den ozoned" as a mistake ("You smell cut grass for a second.[mis of 157]") when player is in Gross Org and Ned is moot.

understand "denses Ned" as a mistake ("Maybe if you and ten other people held hands and danced around in a circle chanting 'Dense's Ned,' repeatedly, he'd flee. But there's only one of you, and Ned probably doesn't like having his intelligence insulted.[mis of 159]") when Ned is quicknear.

understand "dent Ned" as a mistake ("Less violence, more subtlety.[mis of 158]") when Ned is quicknear.

understand "eta gate" as a mistake ("The gate reveals no time it will magically spring open. Guess that's up to you.")

understand "gro borg" as a mistake ("You don't need any more adversaries than you have.") when player is in Gross Org.

understand "gro org" and "grow org" as a mistake ("[no-gro][mis of 160]") when player is in Gross Org.

understand "grob org" as a mistake ("Whoah! It's pretty crazy here, but not crazy enough to open a chess game with g4.[mis of 161]") when player is in Gross Org.

understand "grok org" as a mistake ("You achieve no transcendent consciousness, but you suddenly sort of realize why your English teacher yammered on excitedly about ... THAT book in the syllabus.[mis of 162]") when player is in Gross Org.

understand "groo org" as a mistake ("No slavering light-fearing beasts find it worthwhile to punish you for bad spelling.[mis of 163]") when player is in Gross Org.

understand "grot org" as a mistake ("Gross, grot ... same thing.[mis of 164]") when player is in Gross Org.

understand "knit ink" as a mistake ("No, the knits can be rehabilitated.") when stinky knits are quicknear.

understand "Ned eden" as a mistake ("Mythology or Bible thumping may cause other people to flee, but not Ned. It would probably make him madder. Gotta calm him down.[mis of 165]") when Ned is quicknear.

understand "stinko knits" as a mistake ("AFTER cleaning up Yelpley and Grebeberg is when to get drunk. Nurd.[mis of 166]") when stinky knits are quicknear.

understand "tag gate" and "gate tag" as a mistake ("Small spoiler: that's what you'll get when you open the gate. But you need a way to unlock it.[mis of 378]") when etage gate is quicknear.

chapter Lac Oft Focal

understand "calf lac" as a mistake ("There is [if Moo Room is not visited]another room with that, sort of[else]already the Moo Room. Let's not overdo it[end if]. Plus, cows can't swim.[mis of 167]") when player is in Lac Oft Focal.

understand "calk lac" as a mistake ("It is not leaking.[mis of 168]") when player is in Lac Oft Focal.

understand "call lac" as a mistake ("It does not respond.[mis of 169]") when player is in Lac Oft Focal.

understand "calm lac" as a mistake ("It is calm enough.[mis of 170]") when player is in Lac Oft Focal.

understand "k no wonk" as a mistake ("The wonk doesn't need snarky smackdowns.") when Known Wonk is quicknear.

section moor broom

understand "moor groom" as a mistake ("There is no romance, here. Besides, I can't do anything with 'bride.'[mis of 171]") when player has moor broom.

understand "moor vroom" as a mistake ("The moor broom is not equipped for transport. Some brooms are, but this isn't.[mis of 172]") when player has moor broom.

section tao boat

understand "tao coat" as a mistake ("You don't need protection from the weather here.[mis of 173]") when player is in Lac Oft Focal.

understand "tao goat" as a mistake ("The goat wouldn't remain placid for long once it was plunged into water.[mis of 174]") when player is in Lac Oft Focal.

understand "tao moat" as a mistake ("The lake is peaceful enough as-is.[mis of 175]") when player is in Lac Oft Focal.

section ME gem

understand "mega gem" as a mistake ("That'd be useful in Kingdom of Loathing, but not here.[mis of 176]") when ME gem is quicknear.

chapter Lair Trial

understand "er go ogre" and "ogre er go" as a mistake ("You'll need to be much more aggressive than that around the ogre. But perhaps a command like that could help someone or something else to knock the ogre off.[mis of 177]") when ergot ogre is quicknear.

understand "erg ogre" as a mistake ("The ogre would destroy you in a grunting match.[mis of 178]") when ergot ogre is quicknear.

understand "ergo ogre" as a mistake ("You aren't going to impress it with your smarts.[mis of 179]") when ergot ogre is quicknear.

chapter Le Babel

understand "broc orb" as a mistake ("The orb sprouts no broccoli.[mis of 180]") when Bros' Orb is quicknear.

understand "bron orb" as a mistake ("King James's orb is a basketball, and that's that.[mis of 181]") when Bros' Orb is quicknear.

understand "brosnans orb" as a mistake ("Let's not bring any Hollywood actors into this.[mis of 377]") when Bros' Orb is quicknear.

understand "brow orb" as a mistake ("The orb fails to develop facial features.[mis of 182]") when Bros' Orb is quicknear.

chapter Mont Nom

understand "Ian ai" as a mistake ("Ian remains naturally sentient. Though it's quite possible that any intellectual posturing of his is fake.[mis of 183]") when Ian is quicknear.

understand "krab ark" as a mistake ("You don't have the materials to climb the ark, and you don't need to.[mis of 184]") when player is in Mont Nom.

understand "kram ark" as a mistake ("You don't need to stuff litter or anything in the Ark of Okra.[mis of 185]") when player is in Mont Nom.

understand "mar tram" as a mistake ("No. [if epicer recipe is xed]You need it to build the north-tron[else]It must be good for something[end if].[mis of 186]") when martini tram is quicknear.

understand "mo nom" as a mistake ("Greedy! There's enough food to find around here, really.[mis of 187]") when player is in Mont Nom.

understand "mong nom" as a mistake ("No 'interesting' brownies appear.[mis of 188]") when player is in Mont Nom.

understand "monk nom" as a mistake ("Cannibalism, or super sparse food, is not an option.[mis of 189]") when player is in Mont Nom.

understand "mono nom" as a mistake ("Planning to eat alone is kinda sad.[mis of 190]") when player is in Mont Nom.

understand "naif Ian" as a mistake ("Sadly, mind control is beyond your powers.[mis of 191]") when Ian is quicknear.

understand "nain Ian" as a mistake ("Owning/pwning would embarrass Ian, but that is too archaic a synonym.[mis of 192]") when Ian is quicknear.

understand "nair Ian" as a mistake ("That would be painful and embarrassing enough to chase him, or someone named Brian, off, but alas, you don't have anything to do the job[if player has Nat's Tan]. The bottle of Nat's Tan doesn't count[end if].[mis of 193]") when Ian is quicknear.

chapter Motto Bottom

understand "gurn rug" as a mistake ("It's a guru rug. It's too good to be moved by such a cheap bailout.[mis of 194]") when guru rug is quicknear.

understand "maid i am" as a mistake ("I meant to give the player-character no fixed gender.[mis of 380]") when tame mat is quicknear.

understand "mail i am" as a mistake ("You would not fit in a postal envelope.[mis of 381]") when tame mat is quicknear.

understand "maim i am" as a mistake ("I meant for this game to be nonviolent.[mis of 382]") when tame mat is quicknear.

understand "stir brits" as a mistake ("Alas, there are no spell-organized-with-an-'s' degenerates around TO stir.[mis of 195]") when player has stir writs.

understand "stir crits" as a mistake ("The stir writs are not about doing critical damage. They are about critical self-awareness.[mis of 196]") when player has stir writs.

understand "stir grits" as a mistake ("But the stir writs are nourishment for the SOUL.[mis of 197]") when player has stir writs.

understand "stir its" as a mistake ("You wait for a man to appear after a long journey, only to be crushed by a giant foot, but it doesn't happen. No point waiting for something completely different.[mis of 198]") when player has stir writs.

understand "ta mat" as a mistake ("You give cursory thanks for the mat's over-general advice.[mis of 199]") when player is in Motto Bottom and tame mat is in Motto Bottom.

understand "tamp mat" as a mistake ("It's already pretty beaten down.[mis of 200]") when player is in Motto Bottom and tame mat is in Motto Bottom.

chapter Moo Room

understand "moo boom" as a mistake ("You hear something strafe farts far away.[mis of 201]") when player is in Moo Room.

understand "moo doom" as a mistake ("Die? I'd...[mis of 202]") when player is in Moo Room.

understand "moo loom" as a mistake ("The noises stay around.[mis of 203]") when player is in Moo Room.

understand "moo zoom" as a mistake ("Nothing speeds up or gets magnified.[mis of 204]") when player is in Moo Room.

understand "poo boop" and "poo foop" and "poo zoop" as a mistake ("That's not the appropriate sound effect for the coop or [if gnu dung is moot]its[else]any potential[end if] contents.[mis of 205]") when poo coop is quicknear.

understand "poo goop" as a mistake ("The coop is intended to prevent AGAINST having to carry yucky stuff, here.[mis of 206]") when poo coop is quicknear.

understand "poo hoop" and "poo loop" as a mistake ("No, the coop needs to hold something.[mis of 207]") when poo coop is quicknear.

understand "poo noop" as a mistake ("Doing nothing with the coop or what [if gnu dung is moot]is[else]could go[end if] in it is not an option.[mis of 208]") when poo coop is quicknear.

understand "poo soop" as a mistake ("Good thing this isn't a cooking sim.[mis of 209]") when poo coop is quicknear.

understand "poo woop" as a mistake ("How or why it excites you, I don't want to know.[mis of 210]") when poo coop is quicknear.

chapter My Gym

understand "bull u b" and "bum u b" and "bud u b" and "bux u b" and "bus u b" and "buzz u b" and "bug u b" and "butt u b" and "busks u b" and "busts u b" as a mistake ("The Buff-U-B is unimportant, but yes, there are many other things it could be.") when Buff U B is quicknear.

understand "eva Dave" as a mistake ("Dave isn't distracted by women or slang.[mis of 211]") when Dave is quicknear.

understand "mush sum" as a mistake ("Dave worked hard to build these muscles. It'd be mean if you could wipe them out. And impractical--they might be slowing him down a bit, and that could help you.[mis of 213]") when Dave is quicknear.

understand "my pym" as a mistake ("You suddenly have a brilliant idea for a Britcom featuring Edgar Allan Poe (a Poe-op?), but it slips away just as quickly.[mis of 214]") when player is in My Gym.

understand "sto bots" as a mistake ("No cool robots pop out.[mis of 215]") when sto lots is quicknear.

understand "sto cots" as a mistake ("No, it can store all kinds of things.[mis of 216]") when sto lots is quicknear.

understand "sto dots" as a mistake ("The Sto Lots remains unadorned.[mis of 217]") when sto lots is quicknear.

understand "sto gots" as a mistake ("Yes, you gots a lot of space, and you will gots a lot of stuff as the game goes on.[mis of 218]") when sto lots is quicknear.

understand "sto jots" as a mistake ("There's already a bookcase in this game.[mis of 219]") when sto lots is quicknear.

understand "sto nots" as a mistake ("That would defeat the purpose![mis of 220]") when sto lots is quicknear.

understand "sto pots" as a mistake("No, it's more efficient as one entity. Also, this is not a cooking sim.[mis of 221]") when sto lots is quicknear.

understand "sto sots" as a mistake ("It's not big enough to be a drunk tank.[mis of 222]") when sto lots is quicknear.

understand "wasp saw" as a mistake ("You don't need the wash saw to turn into something that might sting you, especially since you are carrying it.[mis of 223]") when wash saw is quicknear.

chapter Ooze Zoo

understand "eel flee" as a mistake ("Well, you could maybe get one eel to leave, but there are a lot.[mis of 224]") when sleep eels are quicknear.

understand "eel glee" as a mistake ("The eels squirm a bit. I bet they're having fun dreams! Too bad I can't describe them.[mis of 225]") when sleep eels are quicknear.

understand "sleek eels" as a mistake ("The eels don't need dexterity. They need comfort. They are slippery enough.[mis of 226]") when sleep eels are quicknear.

understand "sleet eels" as a mistake ("Eels are cold-blooded, but turning them to ice would be going way too far. They don't need the BIG sleep, just a good one.[mis of 227]") when sleep eels are quicknear.

understand "zoo dooz" as a mistake ("This zoo is free to visit! Yippee![mis of 228]") when player is in Ooze Zoo.

understand "zoo hooz" as a mistake ("The eels [if eels are moot]were[else]are[end if] the only visible occupants of this zoo.[mis of 229]") when player is in Ooze Zoo.

understand "zoo looz" as a mistake ("There are no bathrooms in this zoo, but there don't need to be.[mis of 230]") when player is in Ooze Zoo.

understand "zoo mooz" as a mistake ("That's [if Moo Room is unvisited]a bit further on[else]south and east, as you found[end if].[mis of 231]") when player is in Ooze Zoo.
understand "zoo pooz" as a mistake ("[if Moo Room is unvisited]It's icky enough[else if poo coop is moot]The poo coop had another use[else]The poo coop has another use[end if].[mis of 232]") when player is in Ooze Zoo.

understand "zoo nooz" as a mistake ("[if eels are moot]You made some news. The eels are gone[else]The eels wouldn't be able to tell you the latest[end if].[mis of 233]") when player is in Ooze Zoo.

understand "zoo rooz" as a mistake ("Caught between feeling sad and playing tricks, you wind up doing neither.[mis of 234]") when player is in Ooze Zoo.

understand "zoo tooz" as a mistake ("I know it's not a VERY good zoo, but it's the only one in this game, and that's that.[mis of 235]") when player is in Ooze Zoo.

understand "zoo wooz" as a mistake ("You recall the thrill of visiting your first zoo.[mis of 236]") when player is in Ooze Zoo.

chapter Pro Corp

to decide whether in-bald-lab:
	if player is in Pro Corp and bald-lab, yes;
	no;

to say is-was-hay: say "[if yahoo hay is moot]was[else]is[end if]"

understand "bale lab" as a mistake ("'Hay!' you whine to yourself after nothing happens. [if Moo Room is unvisited]Maybe there's another room with hay[else]There [is-was-hay] enough hay in the Moo Room, though[end if].[mis of 237]") when in-bald-lab.

understand "balk lab" as a mistake ("There's not much to do or say here, for sure[if balm-LLP-yet is false]![else]--well, maybe something that's not quite BALK.[end if][mis of 238]") when in-bald-lab.

understand "ball lab" as a mistake ("Nothing fun explodes out from the walls or ceiling.[mis of 239]") when in-bald-lab.

understand "balsas lab" as a mistake ("The lab is for decidedly stronger stuff than wood[if player has balsa slab]. You need to do something less technical with the balsa slab, anyway[end if].") when in-bald-lab.

understand "banana nab" as a mistake ("You're not hungry.[mis of 240]") when Mr Arm is quicknear.

understand "band nab" as a mistake ("Mr. Arm tries to grip his own wrist but can't quite.[mis of 241]") when Mr Arm is quicknear.

understand "bane nab" as a mistake ("It's usually death that grips YOU.[mis of 242]") when Mr Arm is quicknear.

understand "bank nab" as a mistake ("Whoah! You're one of the good guys, here.[mis of 243]") when Mr Arm is quicknear.

understand "bannon nab" as a mistake ("That's up to Muelle ... um, there's enough political references in the game with the Yuge Guy.[mis of 244]") when Mr Arm is quicknear.

understand "butt tub" as a mistake ("A smoked-down cigarette fails to appear in the tub. What? You expected something else?[mis of 245]") when butene tub is quicknear.

understand "DNA hand" as a mistake ("Right idea, but you can't do it on your own. You need technology to help you.[mis of 246]") when DNA band is quicknear.

understand "dna land" as a mistake ("Biochemistry has its own nuances with symmetry, but we're sticking with something a lot dumber, here.[mis of 247]") when DNA band is quicknear or DNA hand is quicknear.

understand "DNA sand" as a mistake ("That will happen with the passage of time.[mis of 248]") when DNA band is quicknear or DNA hand is quicknear.

understand "dna wand" as a mistake ("No. You know TRUE MAGIC MUST COME FROM WITHIN.[mis of 249]") when DNA band is quicknear or DNA hand is quicknear.

understand "gasp sap" as a mistake ("It's not big enough to be impressed by.[mis of 250]") when gash sag is quicknear.

understand "hand nah" as a mistake ("The hand isn't helpful enough in its present form, but that's no reason to dismiss it.[mis of 251]") when DNA hand is quicknear.

understand "i spy psi" as a mistake ("It isn't in the mood for games.[mis of 252]") when psi wisp is quicknear.

understand "mr erm" as a mistake ("Mr. Arm doesn't need to speak--or be indecisive.[mis of 253]") when Mr Arm is quicknear.

understand "mra arm" as a mistake ("No! Mr. Arm is on the side of social justice.[mis of 254]") when Mr Arm is quicknear.

understand "mraz arm" as a mistake ("You don't need Mr. Arm singing 'I'm yours.' He is already in your inventory.[mis of 255]") when Mr Arm is quicknear.

understand "pro gorp" as a mistake ("You score no free trail mix, alas.[mis of 256]") when player is in Pro Corp.

understand "pro vorp" as a mistake ("No stat junkies appear to drive you up the wall.[mis of 257]") when player is in Pro Corp.

understand "psi lisp" as a mistake ("The Psi Wisp can't speak.[mis of 258]") when Psi Wisp is quicknear.

understand "rm mr" as a mistake ("No, Mr. Arm will be helpful. (Spoiler: he'll leave for better things once he has helped, so happy endings all around. Yay!)[mis of 259]") when Mr Arm is quicknear.

understand "sci bics" as a mistake ("You don't need any exotic writing implements.[mis of 260]") when player is in Pro Corp.

understand "sci dics" as a mistake ("You don't have time to learn weird terminology now.[mis of 261]") when player is in Pro Corp.

understand "sci fics" as a mistake ("But you already have reading material![mis of 262]") when player is in Pro Corp.

understand "sci mics" as a mistake ("Your experience remains relatively quiet but also free of static.[mis of 263]") when player is in Pro Corp.

understand "sci sics" as a mistake ("You think you spy a typo somewhere in the sci pics, leaving you feel free to feel smarter than something you don't unerstand. Go, you![mis of 264]") when player is in Pro Corp.

understand "sci tics" as a mistake ("You laugh at how silly the sci pics are, then sniff a bit, then tap your head.[mis of 265]") when player is in Pro Corp.

section gold log/dork rod

understand "do rod" as a mistake ("You need to do something with the rod, or use something on it.") when dork rod is quicknear.

understand "dorm rod" and "dorm" as a mistake ("You reveal no frat. Arf![mis of 266]") when dork rod is quicknear.

understand "go log" as a mistake ("[unless gold log is quicknear]You contemplate writing your memoirs after leaving Yelpley and Grebeberg[else]It's not particularly magical or motivational. But at least it can't become a go-loco log[end if].[mis of 267]"). [okall]

understand "golf log" as a mistake ("There is no Par Trap or Tee Meet to navigate here, so you don't need to make a golf log.[mis of 268]") when gold log is quicknear.

chapter Red Roses Order

understand "gal blag" as a mistake ("You don't need to steal the flag from Ms. Ism.[mis of 269]") when Ms Ism is quicknear.

understand "gal slag" as a mistake ("You managed to annoy Ms. Ism enough that she lashes out and conks you with a mortal blow with the Gal Flag.[etg][mis of 270]") when Ms Ism is quicknear.

understand "mire rim" as a mistake ("It would be nice to get rid of the mirror rim, but a mire rim would cause problems.") when mirror rim is quicknear.

understand "ms fsm" as a mistake ("Ms. Ism does not grow tentacles and form a Flying Spaghetti Monster.") when Ms Ism is quicknear.

understand "red rod order" as a mistake ("You don't need to worry what the order is, precisely. You have bigger things to do.") when player is in Red Roses Order.

understand "sworn rows" and "swore rows" as a mistake ("The sword rows are inanimate and neutral. Unless you get too close to them.[mis of 271]") when sword rows are quicknear.

understand "yar dray" as a mistake ("[no-oronyms].") when player has yard ray.

understand "yar xray" as a mistake ("The yard ray is powerful enough as-is.") when player has yard ray.

section yard ray misuse

understand "yar gray" as a mistake ("Quite the opposite! The yard ray is there to bring light back![mis of 272]") when player has yard ray.

understand "yar pray" as a mistake ("That's an effective battle cry, but maybe not quite appropriate for a good guy.[mis of 273]") when player has yard ray.

understand "yar ray" and "yarg ray" and "yarr ray" as a mistake ("Becoming a pirate at the end? A clever heel turn! Especially since Talk like a Pirate Day is 9/19, and that's a palindrome ... but wait, real pirates shouldn't get distracted by silly text adventures. Never mind.
[mis of 274]") when player has yard ray.

understand "yarn ray" as a mistake ("If you want more story, then sorry, this one's nearly at an end.[mis of 275]") when player has yard ray.

chapter Scrap Arcs

understand "gi rig" as a mistake ("You don't need anything military-grade here. Even if you got one, you wouldn't know how to operate it.[mis of 276]") when player is in Scrap Arcs.

understand "gird rig" as a mistake ("It is already substantial enough.[mis of 277]") when player is in Scrap Arcs.

understand "gire rig" as a mistake ("The rig fails to collapse. Even if it did, it might collapse on you.[mis of 278]") when player is in Scrap Arcs.

understand "girl rig" as a mistake ("I don't want to know why you thought this was a good idea.[mis of 279]") when player is in Scrap Arcs.

understand "girn rig" as a mistake ("It's sturdy enough.[mis of 280]") when player is in Scrap Arcs.

understand "giro rig" as a mistake ("No greasy sandwich appears.[mis of 281]") when player is in Scrap Arcs.

understand "late metal" as a mistake ("The [slate metals] should only disappear after they've served their purpose.[mis of 121]") when slate metals are quicknear.

understand "scram arcs" as a mistake ("The arcs stay still, but you can just go back east if you want.[mis of 282]") when player is in Scrap Arcs.

understand "slate petals" as a mistake ("The metals are for a didactic and not an aesthetic purpose.[mis of 121]") when slate metals are quicknear.

chapter Seer Trees

understand "seer brees" as a mistake ("[one of]A man in black and gold throws a football at you from 50 yards away, and it drills you right in the chest, leaving no doubt he saw you. Accurate![or]The man doesn't appear again. He probably has better things to do than schlep around in some text adventure. Perhaps he is off eating at a QB BBQ.[stopping][mis of 283]") when player is in Seer Trees.

understand "seer frees" as a mistake ("[if stark rats are in Seer Trees]It won't be THAT easy[else]You already feel free enough here[end if].[mis of 284]") when player is in Seer Trees.

section stark rats

to say use-need: say ". Perhaps an action on its own isn't enough, and you need to use something on them to get them out of the way"

understand "star rats" and "star" as a mistake ("You would rather they didn't star in your adventure, here. Must be some way to dispose of them[use-need].[mis of 285]") when stark rats are quicknear.

understand "stare rats" and "stare" as a mistake ("You try to win a blinking contest, and maybe you could with one, but not that many[use-need].[mis of 286]") when stark rats are quicknear.

understand "start rats" and "start" as a mistake ("You sort of need to stop them, instead[use-need].[mis of 287]") when stark rats are quicknear.

section gift fig

understand "gi fig" as a mistake ("Hard to imagine how to weaponize the fig.[mis of 288]") when gift fig is quicknear.

understand "gif fig" and "fig gif" and "gifs fig" as a mistake ("The fig remains firmly text-based. Eh, it's more edible that way.[mis of 289]") when gift fig is quicknear.

chapter Sneer Greens

understand "guy ug" as a mistake ("Your tame disgust fails to change the Yuge Guy.[mis of 290]") when Yuge Guy is quicknear.

understand "sneer preens" as a mistake ("Enough of that here with the smirk rims, already.") when Yuge Guy is quicknear.

understand "sneer treens" as a mistake ("There's no room for cookware here.") when Yuge Guy is quicknear.

understand "y u guy" as a mistake ("The Yuge Guy isn't interested in metaphysics.[mis of 290]") when Yuge Guy is quicknear.

understand "yugo guy" as a mistake ("No cheap car arrives to drive the Yuge Guy away to eastern Europe.") when Yuge Guy is quicknear.

chapter Swamp Maws

understand "damn mad" as a mistake ("You don't have any hulk powers to smash the dam and travel behind it. You don't need them[if eroded ore is off-stage], but maybe there's a way to detect something. Well, if anything is there[end if].[mis of 291]") when player is in Swamp Maws.

understand "damp mad" as a mistake ("You imagine the dam bursting and getting wet and being upset. And washed away, too.[mis of 292]") when player is in Swamp Maws.

understand "swam maws" as a mistake ("Perhaps someone has, but you don't need to.[mis of 294]") when player is in Swamp Maws.

understand "swami maws" and "swamy maws" as a mistake ("[if Yack Cay is visited and Uneven U is visited]Aw, come on, you've already met TWO SMART PEOPLE nearby[else if Yack Cay is unvisited and Uneven U is unvisited]There might be someone smart nearby[else]Aw, come on, you've already met someone smart nearby[end if].[mis of 295]") when player is in Swamp Maws.

section eroded ore

to decide whether got-ore:
	if player has ore zero or player has eroded ore, yes;
	no;

understand "eros ore" as a mistake ("I don't even want to know what you're trying to do, there.[mis of 296]") when got-ore.

understand "ore cicero" as a mistake ("The ore fails to acquire oratorical powers.") when got-ore.

understand "ore dero" as a mistake ("The ore can do more than just create some loafer with nothing better to do than play (or write) silly computer games. It can create something for social good![mis of 297]") when got-ore.

understand "ore hero" as a mistake ("No! You do not need to craft a new hero. YOU ARE THE HERO![mis of 298]") when got-ore.

understand "ore nero" as a mistake ("Maybe that ancient Roman emperor reincarnated would cancel out the Diktat Kid, maybe not. But in the meantime, they'd probably muck things up even worse together.[mis of 299]") when got-ore.

understand "ore torero" as a mistake ("The ore fails to jump out of your hands.[mis of 300]") when got-ore.

chapter Swept Pews

understand "fra barf" as a mistake ("Don't dirty up the pews![mis of 301]") when player is in Swept Pews.

understand "fra zarf" as a mistake ("This would send you on a long journey to Hadean Lands. One you might enjoy so much, you'll forget about Yelpley![mis of 302]") when player is in Swept Pews.

understand "liar frail" and "liar trail" as a mistake ("The grail remains in your way to the south. But it was worth a try.[mis of 303]") when liar grail is quicknear.

understand "nun" as a mistake ("Alas, you have missed the mass (A.M.) to see a religious leader.") when player is in Swept Pews.

understand "trod ort" as a mistake ("[if player has troll ort]Nah, you should keep it[else]It looks run-down enough[end if].[mis of 304]") when troll ort is quicknear.

understand "trog ort" as a mistake ("Maybe it is low-class food, but you don't need to overdo mentioning it.[mis of 305]") when troll ort is quicknear.

understand "troi ort" as a mistake ("You don't need a counselor to tell you not to eat stuff like the troll ort.[mis of 306]") when troll ort is quicknear.

understand "tron ort" as a mistake ("No MCP orders light cycles to run you over. Whew![mis of 307]") when troll ort is quicknear.

understand "trop ort" as a mistake ("The ort fails to split and reproduce until there is too much of it.[mis of 308]") when troll ort is quicknear.

understand "trow ort" as a mistake ("You wonder how the ort's potential stinkiness could work in your favor, somehow, somewhere.[mis of 309]") when troll ort is quicknear.

understand "troy ort" as a mistake ("There's enough to save here. You don't want to have to deal with a 10-year war.[mis of 310]") when troll ort is quicknear.

chapter Toll Lot

to decide whether either-arc:
	if player is in Toll Lot or player is in Scrap Arcs, yes;
	no;

to say ufo-mad:
	say "You feel [one of]a moment of annoyance the UFO dropped something on you[or]a little more anger at the UFO: A UFO MO['] FU moment, if you will[stopping], but it passes. You go on to consider what sort of martial arts the aliens in the UFO know"

understand "crab arc" as a mistake ("That's just what you need, a giant crab coming after you[if cross orc is in Toll Lot and player is in Toll Lot], along with the cross orc[end if].[mis of 311]") when either-arc.

understand "crac arc" and "crak arc" as a mistake ("While there may be a correlation between bad spelling and extreme strength, there's no causation. Sorry[if UFO tofu is not off-stage and player is in Toll Lot]. Besides, you got something, already[end if].[mis of 312]") when either-arc.

understand "cram arc" as a mistake ("Litterbug. Besides, you need pretty much everything you're carrying. And nothing would fit, anyway.[mis of 313]") when either-arc.

understand "crap arc" as a mistake ("You might cause a mudslide, or worse.[mis of 314]") when either-arc.

understand "crass arc" as a mistake ("[if player is in Scrap Arcs]The Scrap Arcs remain tasteful and separate[else if cross orc is in Toll Lot]The cross orc and crag arc don't fuse together. Rats[else]You spend a few seconds feeling deeply offended by the crag arc[end if].[mis of 315]") when either-arc.

understand "cray arc" as a mistake ("The arc doesn't need to change shape or become more volatile.[mis of 316]") when either-arc.

understand "croc orc" as a mistake ("The orc is fearsome enough without becoming a total genetic monstrosity.[mis of 317]") when cross orc is quicknear.

understand "cron orc" as a mistake ("The orc doesn't have many daily tasks to check off on.[mis of 318]") when cross orc is quicknear.

understand "crook o orc" as a mistake ("Hey, just because you like being bribed doesn't make you a crook!") when cross orc is quicknear.

understand "croon o orc" as a mistake ("The orc is not artistic.") when cross orc is quicknear.

understand "crop orc" as a mistake ("That attack would boomerang, and not just because this is a palindrome-y game. The orc is lots, lots bigger than you.[paragraph break]Also, there is no farm nearby.[mis of 319]") when cross orc is quicknear.

understand "crow orc" as a mistake ("The orc remains silent (yay) and flightless (boo).[mis of 320]") when cross orc is quicknear.

understand "of ufo" as a mistake ("You remind yourself that the UFO tofu came from a UFO. The circular reasoning seems appropriate to a palindrome world but is unhelpful.[mis of 321]") when UFO tofu is quicknear.

understand "told lot" as a mistake ("[if cross orc is in Toll Lot]The cross orc isn't open to verbal negotiation[else]You pretend you won an argument against the cross orc and didn't just hand over money[end if].[mis of 322]") when player is in Toll Lot.

understand "ufo f u" and "ufo fu" and "ufofu" as a mistake ("[ufo-mad].[mis of 323]") when UFO tofu is quicknear.

chapter Trapeze Part

understand "depiped" and "de piped" as a mistake ("Clever, but you can't get rid of the pipe like that. And you don't need to.") when player is in Trapeze Part.

understand "pole lop" as a mistake ("The pole is compact enough as-is.[mis of 324]") when player has elope pole.

understand "tendered net" as a mistake ("[if player has tent net]You already have the tent[else]Nobody comes by to hand anything to you. You're on the right track. Maybe you're overthinking things with that big long word[end if].[mis of 325]") when level net is quicknear or tent net is quicknear.

understand "tenet" as a mistake ("That's too abstract. [unless tent net is quicknear]You need some sort of action[else]The tent net could be useful to someone[end if].[mis of 326]") when level net is quicknear or tent net is quicknear.

understand "tenses net" as a mistake ("The net was [unless tent net is off-stage][hn of Trapeze Part], is in your Sto-Lots[else]here, is here[end if], and will be until you figure [if level net is quicknear]how to fix it[else]who or what could use it[end if].[mis of 327]") when level net is quicknear or tent net is quicknear.

understand "tent net" as a mistake ("Hmm. Even if you were able to tent the net, it'd be less wide overall. You get the feeling you're on the right track, though.[mis of 328]") when level net is quicknear and tent net is off-stage.

understand "trape part" as a mistake ("You mill around a bit, [if epicer recipe is off-stage]wondering if[else]pleased[end if] you could fix the ten-level net.[mis of 329]") when player is in Trapeze Part.

chapter Uneven U

understand "co doc" and "codoc" as a mistake ("It would take too long to apply for an adjunct professorship. Or to get an advanced degree.[mis of 330]") when player is in Uneven U.

understand "cod doc" and "doc cod" and "doc a cod" as a mistake ("The Code Doc suddenly mumbles something about needing to hire someone with a strong marine biology background.[mis of 331]") when player is in Uneven U.

understand "coda doc" as a mistake ("The Code Doc has a whole career of research ahead. Don't shorten it.[mis of 332]") when player is in Uneven U.

understand "codene doc" as a mistake ("That's just wrong, and I don't mean the spelling, or labeling the Code Doc as an MD and not a PhD.[mis of 333]") when player is in Uneven U.

understand "cods doc" as a mistake ("No way. It's nice to be around someone non-fishy, actually.[mis of 334]") when player is in Uneven U.

chapter Worn Row

to say maybe-hint-other-wr:
	say "[if ever-wordrow is false and ever-workrow is false]. There HAS to be more than just Worn Row here, though[else if ever-workrow is false or ever-wordrow is false]. You wonder if you have exhausted all the possibilities for [Worn Row], though[else]. Worn, Work and Word Row are the only possibilities here[end if]"

to say red-clue: if redness ender is not moot, say ", but who knows, that redness ender might help you some day"

understand "bade dab" as a mistake ("You didn't bring it here. It appeared all by itself.[mis of 336]") when bad dab is quicknear.

understand "bo Rob" as a mistake ("If he did suddenly smell worse, he probably wouldn't know it. It would just repel you a bit more.[mis of 337]") when Rob is quicknear.

understand "bordered Rob" as a mistake ("Nothing sneaks up next to Rob to edge him out.[mis of 338]") when Rob is quicknear.

understand "boree Rob" as a mistake ("Ooh! Close! How would you MAKE him a boree?[mis of 339]") when Rob is quicknear.

understand "borf Rob" as a mistake ("No laser-disc-graphic quality space alien appears in a UFO to kidnap Rob. Well, it probably would've done something awful to you, too.[mis of 340]") when Rob is quicknear.

understand "borg Rob" as a mistake ("He is already assimilated.[mis of 341]") when Rob is quicknear.

understand "bork Rob" as a mistake ("Maybe there is a more nonviolent way to get him to give up. Or less political, if you're old enough.[mis of 342]") when Rob is quicknear.

understand "born Rob" as a mistake ("Rob's regular babble is bad enough. His full life story would be truly enervating.[mis of 343]") when Rob is quicknear.

understand "dl old" as a mistake ("You dismiss DWELT LEWD as beneath you, also dismissing the urge to make sure it's still beneath you by scanning a few pages.[mis of 335]") when DWELT LEWD is quicknear.

understand "dwell lewd" as a mistake ("DWELT LEWD should NOT be read as an instruction manual. Well, it shouldn't be read at all, really.[mis of 344]") when DWELT LEWD is quicknear.

understand "indeed ni" as a mistake("You nod knowingly at the copious life wisdom enclosed by [NULL ILLUN]. Some of it seems obvious, but then again, there is thinking, and there is doing.") when NULL ILLUN is quicknear.

understand "indexed ni" as a mistake ("You check that [NULL ILLUN] has an index. Like most good nonfiction, it does. Well, if it didn't, that would be kind of illun['].") when NULL ILLUN is quicknear.

understand "pi tip" as a mistake ("4/1 - 4/3 + 4/5 - 4/7 + 4/9 - 4/11 ... wait, no, that's a bit slow.[paragraph break]3 + 4/(2*3*4) - 4/(4*5*6) + 4/(6*7*8) - 4/(8*9*10) + 4/(10*11*12) - 4/(12*13*14) ...[mis of 345]") when pity tip is quicknear.

understand "pita tip" as a mistake ("Sorry, you're getting ambiguous snack cans and not any specific cuisine.[mis of 346]") when pity tip is quicknear.

understand "pith tip" as a mistake ("It's already pretty pithy, and there's not enough material for a helmet.[mis of 347]") when pity tip is quicknear.

understand "pits tip" as a mistake ("It's not a very good tip, but why make it worse?") when pity tip is quicknear.

understand "row or" as a mistake ("[if row-prog is 3]You've flipped Worn Row all the ways you can.[else if row-prog is 2]You've seen Worn Row in all three of its forms.[else if row-prog is 1]Hmm. Maybe [Worn Row] can become something else.[else]There are lots of possibilities what Worn Row can become! Why not try a few?[end if][mis of 348]") when player is in Worn Row.

understand "sd ads" as a mistake ("SOME DEMOS is delightfully ad-free. Best to keep it that way.[mis of 349]") when SOME DEMOS is quicknear.

understand "sd ids" as a mistake ("Yes, SOME DEMOS IDs useful artistic techniques.[mis of 350]") when SOME DEMOS is quicknear.

understand "track cart" as a mistake ("[if DWELT LEWD is off-stage]Right idea, but the cart isn't going anywhere[else]It's not going anywhere. You already unlocked a secret, anyway[end if].[mis of 351]") when tract cart is quicknear.

understand "word drow" as a mistake ("You'll get to see the drow later[maybe-hint-other-wr].[mis of 352]") when player is in Worn Row and Swept Pews are unvisited.

understand "wore row" as a mistake ("No second-hand clothing shop appears. You don't know what you'd do if one appeared, anyway[maybe-hint-other-wr].[mis of 353]") when player is in Worn Row.

understand "worf row" as a mistake ("No Enterprise security officer arrives to help or hinder you[maybe-hint-other-wr].[mis of 354]") when player is in Worn Row.

understand "worm row" as a mistake ("[if Worn Row is worny]Ugh! You don't need to make this place worse[else]You already upgraded Worn Row. No need to make it worse than it was[red-clue][end if][maybe-hint-other-wr].[mis of 355]") when player is in Worn Row.

understand "worsts row" and "worses row" as a mistake ("It [if Worn Row is worny]is[else]was[end if] bad enough already[maybe-hint-other-wr].[mis of 356]") when player is in Worn Row.

understand "wort row" as a mistake ("[Worn Row] is not meant to be a garden. Maybe it would look nicer that way, but it wouldn't be helpful to you[maybe-hint-other-wr].[mis of 357]") when player is in Worn Row.

chapter Yack Cay

understand "edit tide" as a mistake ("In Diktat Kid-controlled Yelpley, tide edits you[if el doodle is not moot]! Or, well, something you have that needs editing.[else]![end if][mis of 293]") when player is in Yack Cay.

understand "kno wonk" as a mistake ("The wonk would dismiss you as eny fule.[mis of 358]") when Known Wonk is quicknear.

understand "know wonk" and "know a wonk" and "wonk know" as a mistake ("The wonk is already known. Well, not REALLY, but then, this game isn't about existentially reaching people.[mis of 359]") when Known Wonk is quicknear.

understand "misdeed sim" as a mistake ("The mist-sim is just in your way. Let's not make it active.") when mist sim is quicknear.

understand "miss sim" as a mistake ("The Known Wonk moans 'It's not that easy! Of course it's not!' And it isn't[if cap-vol is true], especially since the pact cap didn't make any noise[end if]. You'll need to use something on the Known Wonk--or the mist sim.[mis of 360]") when Known Wonk is quicknear.

understand "shard rahs" as a mistake ("The rahs are on paper, and besides, they might be useful.[mis of 361]") when sharp rahs are quicknear.

understand "share rahs" as a mistake ("You're on this quest by yourself.[mis of 362]") when sharp rahs are quicknear.

understand "shark rahs" as a mistake ("You don't want to alert any land sharks.[mis of 363]") when sharp rahs are quicknear.

understand "store rots" as a mistake ("You don't need to buy anything in this game, and any store wouldn't sell anything good.[mis of 364]") when player is in Yack Cay.

understand "stork rots" as a mistake ("You don't want to know what sort of carcasses are buried in the swamp.[mis of 365]") when player is in Yack Cay.

understand "story rots" as a mistake ("No, the storm rots help keep you focused on the story. They aren't blocking anything. Or good for anything.[mis of 366]") when player is in Yack Cay.

understand "wonk now" as a mistake ("The [wonk] seems in no hurry to do anything.[mis of 367]") when Known Wonk is quicknear.

chapter Yawn Way

understand "way aw" as a mistake ("You take a moment to feel bummed about how quiet it is here.[mis of 368]") when player is in Yawn Way.

understand "yaw away" and "yaws way" as a mistake ("Well, you can go pretty much any way, and you probably don't want [Yawn Way] to tilt.") when player is in Yawn Way.

understand "yawnin way" and "yawn in way" as a mistake ("You let out an extra long yawn, just to show you belong.") when player is in Yawn Way.

understand "yawp way" and "yawl way" as a mistake ("It's still quiet here.[mis of 369]") when player is in Yawn Way.

understand "yell ley" as a mistake ("That won't help any passage to a new new world open. Not that you need one.") when mrlp is Yelpley.

chapter Yell Alley

understand "ling nil" as a mistake ("The [Line Nil] already protects against fish invading Yell Alley. That, and Yell Alley not being close to water.[mis of 371]") when Line Nil is quicknear.

understand "link nil" as a mistake ("The [Line Nil] security system fails to break apart. That's pretty secure![mis of 372]") when Line Nil is quicknear.

understand "lint nil" as a mistake ("The [Line Nil] security system, sadly, can't clean up the mess Yell Alley already is. It can only prevent it getting worse. Well, getting worse too fast.[mis of 373]") when Line Nil is quicknear.

understand "may yam" as a mistake ("You don't want the yam to age. It would probably start to smell bad.[mis of 374]") when the mayo yam is quicknear.

understand "mob om" as a mistake ("The bomb mob fails to find inner peace. I guess that's not their sort of chant.[mis of 370]") when Bomb Mob is quicknear.

understand "nacelle can" as a mistake ("You don't need a huge engine.[mis of 375]") when player has snack cans.

understand "navette van" as a mistake ("The navy van is seedy enough. It doesn't need to be selling gems, too.[mis of 376]") when navy van is quicknear.

volume checking off mistakes from the player

mist-found is a number that varies.

mis-yet is a truth state that varies.

cur-LLP-hint-row is a number that varies. cur-LLP-hint-row is 0.

checkoffs is a list of truth states variable. checkoffs is { false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }.

hint-every-x is a number that varies. hint-every-x is 5.

mist-index is a number that varies.

to say mis of (n - a number):
	consider the notify cycling rule;
	let Q be false;
	if N > 0, now Q is entry N in checkoffs;
	if being-chased is true, now chase-mulligan is true;
	if Q is false:
		if N > 0, now entry N in checkoffs is true;
		increment mist-found;
		increment mist-index;
		if mist-found is 1:
			say "[paragraph break](NOTE: this was a specific reject for a good try. For the most part, the pact cap[if flee elf is not moot], once you get it,[end if] will tell you what else you need to riff on, but enough good guesses such as what you tried will not only give better clues how to get secret points but also let you EYE items for approximately how far along in the game you might use them[unless player has pact cap] once you have the pact cap[end if].)[run paragraph on][line break]";
			continue the action;
		if debug-state is true, say "DEBUG: [mist-index] of [hint-every-x] so far.";
		if mist-index is hint-every-x:
			now mist-index is 0;
			while cur-LLP-hint-row < number of rows in table of last lousy points:
				increment cur-LLP-hint-row;
				choose row cur-LLP-hint-row in table of last lousy points;
				process the dorule entry;
				if the rule failed:
					say "[paragraph break]A voice from behind the fourth wall whispers: [i][cluey entry][r].[if mis-yet is true][run paragraph on][end if]";
					now mclu entry is true;
					if mis-yet is false:
						now mis-yet is true;
						say "[line break]NOTE: THINK[if refer-yet is true]/REFER[end if] will show you the LLPs clued so far that you haven't figured, yet.[run paragraph on][line break]";
					break;
			say "[line break][if flee elf is not moot]A pip in the[else]The pip in your[end if] pact cap [if eye-charges > 0]brightens further[else if ever-pip is false]lights up! [now-cap][else]lights back up[end if].[no line break]";
			now ever-pip is true;
			increment eye-charges;

to say now-cap: say "[if flee elf is moot]You'll be able to EYE something, now[else]Maybe when you get the pact cap, the Flee Elf will explain what that's about[end if]"

volume old school verbs

chapter no-loc

to decide whether dung-near:
	if gnu dung is quicknear, yes;
	if gnu dung is moot and player has poo coop, yes;
	no;

to decide whether thug-near:
	repeat with Z running through guhthugs:
		if Z is quicknear, yes;
	no;

to say no-calls: say "Like your average random NPC, anyone you tried to call from [b][if player is in Yawn Way]Name ME, Man[else]Oh Who[end if][r] would probably just have random general useless things to say like '[next-rand-txt of table of npc mistakes]"

to say or-ups: if word number 1 in the player's command is "ups", say ", much less spu";

understand "buy [text]" as a mistake ("A voice booms Y U BUY? then BUY? U B... You don't need to buy anything, but USEing an item can trade it.")

understand "dial [text]" and "call [text]" and "phone [text]" as a mistake ("[no-calls]!'") when phonebook-near.

understand "gift fig" as a mistake ("It already is one. And you don't need to pass it on.") when gift fig is quicknear.

understand "guh" and "thug" and "guh thug" as a mistake ("That's what [random visible guhthug] is, but you need to figure how to get rid of him.") when thug-near.

understand "look kool" as a mistake ("[if peeped-yet is true]You already managed to PEEP for an LLP. This would be double dipping[else]There's a way to look differently, but it's just one word. Four letters[end if].")

understand "rm gnu/dung" and "rm gnu dung" as a mistake ("You don't have the proper permissions. It is (wait for it) too root.") when dung-near.

understand "rub [text]" as a mistake ("[no-burt].")

understand "sees" as a mistake ("[if peeped-yet is true]You already managed to PEEP for an LLP. This would be double dipping[else]There's a way to look differently, and it's a four letter word, but not this one[end if].")

understand "shed eh" and "shed ehs" as a mistake ("It doesn't do you much good. Maybe it could help someone further in the dumps than you, though.") when yob attaboy is quicknear and yob attaboy is xed.

understand "tap at [text]" as a mistake ("That's in the spirit of the game, but sadly, I couldn't find a way to make it useful. Sorry!")

understand "tar at [text]" as a mistake ("That's in the spirit of the game, but sadly, I couldn't find a way to make it useful. Sorry!")

understand "up [text]" and "ups [text]" as a mistake ("You need to do something UP with the spurs, but ... UP needs to come second. Or last. You can't do much with PU[or-ups].") when player has spur ups.

understand "wash [text]" as a mistake ("The wash saw only has enough liquid to loosen something up for cutting. It can't clean anything.") when player has wash saw.

understand "wave" as a mistake ("Nobody named Eva is beyond the fourth wall.")

chapter deprecated mistakes

[understand "truce curt" as a mistake ("You'll need something more violent, here.") when player is in Mont Nom and Curt is in Mont Nom.]

[understand "truco curt" as a mistake ("You don't have a deck of cards, and Curt wouldn't want to play.[mis of 100]") when player is in Mont Nom and Curt is in Mont Nom.]

Ailihphilia Mistakes ends here.

---- DOCUMENTATION ----
