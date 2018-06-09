Version 1/171220 of Ailihphilia Mistakes by Andrew Schultz begins here.

volume Mistakes

[the rooms here are arranged alphabetically. When an item triggers the mistake, the room will be the one where you first find the item. If there are two places, we go with the first: for instance, (partial spoiler) the roto motor appears in the west of the two locations where it can turn up.]

[programmer's note: the utility aam.py adds or sorts the 'mis' numbers. Mist.py makes sure each mistake is in the appropriate rbr-* or reg-* test file.]

to decide whether (mt - a thing) is/are quicknear:
	if mt is in location of player, yes;
	if player carries mt, yes;
	if player wears mt, yes;
	no;

[todo: (programming exercise) write script that can automatically change when player is in x and (y) is in x to when (y) is quicknear)]

chapter Apse Spa

understand "esp apse" as a mistake ("You don't see what to do next.[mis of 1]") when player is in Apse Spa.

understand "pool sloop" as a mistake ("No boat appears to take you across the watery bits. [if sage gas is off-stage]You'll need another way through[else]You already got the sage gas, anyway[end if].[mis of 2]") when player is in Apse Spa.

understand "spa caps" as a mistake ("But you already have your pace cap![mis of 3]") when player is in Apse Spa or spa maps are quicknear.

understand "spa gaps" as a mistake ("[if player is not in Apse Spa]No, you want the maps to be complete[else]The Apse Spa is too sturdy. You don't want it to collapse[end if].[mis of 4]") when player is in Apse Spa or spa maps are quicknear.

understand "spa laps" as a mistake ("You never need to swim anywhere in this game. Or drink anything.[mis of 5]") when player is in Apse Spa or spa maps are quicknear.

understand "spa naps" as a mistake ("No time to relax! There's adventuring to be had![mis of 6]") when player is in Apse Spa or spa maps are quicknear.

understand "spa raps" as a mistake ("The spa is a place of peace. Stop that noise, and get off my lawn![mis of 7]") when player is in Apse Spa or spa maps are quicknear.

understand "spa saps" as a mistake ("One day, with the Diktat Kid gone, plenty of people will waste money on a spa, but your job is to get things there.[mis of 8]") when player is in Apse Spa or spa maps are quicknear.

understand "spa zaps" as a mistake ("You don't need a weapon.[mis of 9]") when player is in Apse Spa or spa maps are quicknear.

chapter Art Xtra

understand "art ecetra" as a mistake ("One silly misspelling does not beget another.[mis of 10]") when player is in Art Xtra.

chapter Ivy Villa

understand "cods doc" as a mistake ("No way. It's nice to be around someone non-fishy, actually.[mis of 11]") when player is in Den Ivy Vined.

chapter Calcific Lac

understand "calf lac" as a mistake ("There is [if moo room is not visited]another room with that, sort of[else]already the Moo Room. Let's not overdo it[end if]. Plus, cows can't swim.[mis of 12]")

understand "calk lac" as a mistake ("It is not leaking.[mis of 13]")

understand "call lac" as a mistake ("It does not respond.[mis of 14]")

understand "calm lac" as a mistake ("It is calm enough.[mis of 15]")

section moor broom

understand "moor groom" as a mistake ("There is no romance, here. Besides, I can't do anything with 'bride.'[mis of 16]") when player has moor broom.

understand "moor vroom" as a mistake ("The moor broom is not equipped for transport. Some brooms are, but this isn't.[mis of 17]") when player has moor broom.

section tao boat

understand "tao coat" as a mistake ("You don't need protection from the weather here.[mis of 18]") when player is in Calcific Lac.

understand "tao goat" as a mistake ("The goat wouldn't remain placid for long once it was plunged into water.[mis of 19]") when player is in Calcific Lac.

understand "tao moat" as a mistake ("The lake is peaceful enough as-is.[mis of 20]") when player is in Calcific Lac.

section ME gem

understand "mega gem" as a mistake ("That'd be useful in Kingdom of Loathing, but not here.[mis of 21]") when ME gem is quicknear.

chapter Cold Loc

understand "cola loc" as a mistake ("You'd be better off with a warmer drink. Which isn't here.[mis of 22]") when player is in Cold Loc.

understand "colt loc" as a mistake ("No gandered nag appears. Or gun(ug).[mis of 23]") when player is in Cold Loc.

understand "kin nik" and "kine nik" as a mistake ("Sorry. You're not related, and that's that.[mis of 24]") when King Nik is quicknear.

understand "kind nik" as a mistake ("He already seems pretty nice. His deficiencies are more ... administrative.[mis of 25]") when King Nik is quicknear.

understand "pua up" as a mistake ("That's completely the wrong way to gain confidence.[mis of 26]") when player has spur ups.

understand "pub up" as a mistake ("Alcohol is not the answer.[mis of 27]") when player has spur ups.

understand "pug up" and "pup up" as a mistake ("You don't need a dog.[mis of 28]") when player has spur ups.

understand "pun up" as a mistake ("No time for lame jokes! Well, on your end, anyway.[mis of 29]") when player has spur ups.

understand "purr up" as a mistake ("The Spur Ups make you feel you can be anyone, but not anything.[mis of 30]") when player has spur ups.

understand "puss up" as a mistake ("No cat appears.[mis of 31]") when player has spur ups.

understand "put up" as a mistake ("The Spur Ups are for more than just getting by.[mis of 32]") when player has spur ups.

understand "putt up" as a mistake ("The Spur Ups have no suitable flat edge with which to hit a golf ball.[mis of 33]") when player has spur ups.

understand "puz up" and "puzz up" as a mistake ("Oh, there are plenty of puzzles ahead.[mis of 34]") when player has spur ups.

understand "rife fir" as a mistake ("It's already big enough.[mis of 35]") when player is in Cold Loc.

understand "riff fir" as a mistake ("It's rife enough to block passage west and to provide past sap.[mis of 36]") when player is in Cold Loc.

understand "spud ups" as a mistake ("The Spur Ups don't become potatoes or French fries or whatever.[mis of 37]") when player has spur ups.

understand "spun ups" as a mistake ("The Spur Ups fail to rotate.[mis of 38]") when player has spur ups.

understand "up apu" as a mistake ("Apu would have some helpful advice, but he'd have to leave Springfield.[mis of 39]") when player has spur ups.

understand "up cpu" as a mistake ("You shouldn't need many cycles to run a text adventure.[mis of 40]") when player has spur ups.

chapter Deft Fed

understand "defy fed" as a mistake ("[if yob attaboy is moot]Way to go! Keep that Hunger! Well, I hope it's that and not conspiracy theories about the Fed[else]No problem, you're not getting fed anyway[end if].[mis of 41]") when player is in Deft Fed.

understand "deli filed" as a mistake ("You are not a government bureaucrat.[mis of 42]") when player is in Deft Fed.

understand "stan nats" and "stan nat's" as a mistake ("Well, Nat's must have its stans, but you don't want to be one.[mis of 43]") when nat's tan is quicknear.

understand "stank nats" and "stank nat's" as a mistake ("Yes, it's pretty awful.[mis of 44]") when nat's tan is quicknear.

understand "tang nat" as a mistake ("It's probably already too tangy.[mis of 45]") when nat's tan is quicknear.

understand "tank nat" as a mistake ("No, even a small amount of Nat's is enough.[mis of 46]") when nat's tan is quicknear.

understand "tannin nat" as a mistake ("It probably has enough weird, horrible ingredients.[mis of 47]") when nat's tan is quicknear.

section Bon Snob

understand "bon knob" as a mistake ("You don't need to help Sniffins with interior decorating, here.[mis of 48]") when player is in Deft Fed and YOB ATTABOY is moot.

chapter Dirge Grid

understand "dir grid" as a mistake ("With only one way out, you don't need directions.[mis of 49]") when player is in Dirge Grid.

understand "dirge me grid" as a mistake ("Boy, if this game weren't polite on the Zarfian cruelty scale, you'd be in trouble now![mis of 50]") when player is in Dirge Grid.

understand "par crap" as a mistake ("Making fun of others['] clothing isn't as evil as the Diktat Kid, but it's not what REAL heroes do![mis of 51]") when Verses Rev is quicknear.

understand "par trap" as a mistake ("You aren't on a golf course.[mis of 52]") when Verses Rev is quicknear.

understand "verb rev" as a mistake ("Oh, the Verses Rev is active enough.[mis of 53]") when Verses Rev is quicknear.

understand "versus rev" as a mistake ("The Verses Rev is already against you.[mis of 54]") when Verses Rev is quicknear.

understand "very rev" as a mistake ("The Verses Rev fails to become extremely spiritual. But it was worth a try.[mis of 55]") when Verses Rev is quicknear.

chapter Dopy Pod

understand "cash sac" as a mistake ("You look extra carefully at the sac. No, no secret compartments.[mis of 56]") when cassettes sac is quicknear and player does not have cash sac.

understand "dir rid" as a mistake ("Rm -r is fewer keystrokes.[mis of 57]") when Dirt Rid is quicknear.

understand "dire rid" as a mistake ("Your situationisn't that bad, but it doesn't get any better.[mis of 58]") when Dirt Rid is quicknear.

understand "dirk rid" as a mistake ("If you had a dagger in your back, which you don't, that might be useful. But you don't.[mis of 59]") when Dirt Rid is quicknear.

understand "do pod" as a mistake ("But what to do to it? How to change it?[mis of 60]") when player is in Dopy Pod.

understand "pod op" as a mistake ("But what sort of op?[mis of 61]") when player is in Dopy Pod.

chapter Drawl Ward

understand "bone nob" as a mistake ("Out of your league.[paragraph break]I mean, the Bond Nob has an active social life that revolves around bars, and you ... well, you're just a text adventure. That's barely a step above people who program text adventures![mis of 62]") when Bond Nob is quicknear.

understand "bong nob" as a mistake ("The Bond Nob probably knows someone but prefers alcohol.[mis of 63]") when Bond Nob is quicknear.

understand "bonk nob" as a mistake ("That'd let you get west ... until the nob woke up and called a few friends.[mis of 64]") when Bond Nob is quicknear.

understand "bony nob" as a mistake ("The Bond Nob's body weight is not an important issue, here.[mis of 65]") when Bond Nob is quicknear.

understand "drawn ward" and "draws ward" as a mistake ("The room remains text-based.[mis of 66]") when player is in Drawl Ward.

understand "gi rig" as a mistake ("You don't need anything military-grade here. Even if you got one, you wouldn't know how to operate it.[mis of 67]") when player is in Drawl Ward.

understand "gird rig" as a mistake ("It is already substantial enough.[mis of 68]") when player is in Drawl Ward.

understand "gire rig" as a mistake ("The rig fails to collapse. Even if it did, the hole it left would lead no way south.[mis of 69]") when player is in Drawl Ward.

understand "girl rig" as a mistake ("I don't want to know why you thought this was a good idea.[mis of 70]") when player is in Drawl Ward.

understand "girn rig" as a mistake ("It's sturdy enough.[mis of 71]") when player is in Drawl Ward.

understand "giro rig" as a mistake ("No greasy sandwich appears.[mis of 72]") when player is in Drawl Ward.

chapter Dumb Mud

understand "dump mud" as a mistake ("It's already kind of dumped here[if poo coop is not moot]. Maybe you could dump the mud into the rut for passage south, but it might take too long, and you don't have a shovel. You'd need something else[end if].[mis of 73]") when player is in Dumb Mud.

understand "gnu bung" as a mistake ("There's no way to put the toothpaste back in the tube, as it were.[mis of 74]") when gnu dung is quicknear.

understand "gnu hung" as a mistake ("Uggh. It's good you're in a text adventure, I guess.[mis of 75]") when gnu dung is quicknear.

understand "gnu lung" as a mistake ("The gnu dung smells bad enough without dropping more internal organs into the mix.[mis of 76]") when gnu dung is quicknear.

understand "gnu rung" as a mistake ("You want to move west from here, not up.[mis of 77]") when gnu dung is quicknear.

understand "gnu sung" as a mistake ("You don't need to speculate what the gnu was doing.[mis of 78]") when gnu dung is quicknear.

understand "turd rut" as a mistake ("Hmm! Maybe you could fill the rut up with ... something ... to cross it.[mis of 79]") when player is in Dumb Mud and poo coop is not moot.

understand "turn rut" as a mistake ("It's too large to redirect[if poo coop is moot], and besides, you already have a way across[end if].[mis of 80]") when player is in Dumb Mud.

understand "turnon rut" and "turn on rut" as a mistake ("No innuendo here! The gnu dung[if gnu dung is not in Dumb Mud] with the poo coop[end if] is about as close as you'll get to R-rated.[mis of 81]") when player is in Dumb Mud.

understand "un gnu" as a mistake ("Eliminating the perpetrator won't eliminate what they've dung. Uh, dun. Er, done.[mis of 82]") when gnu dung is quicknear.

chapter Emo Dome

understand "emo come" as a mistake ("You feel increased whininess inside.[mis of 83]") when player is in Emo Dome.

understand "emo home" as a mistake ("It's too wide open a space.[mis of 84]") when player is in Emo Dome.

understand "emo rome" as a mistake ("This game is not remotely close to historical fiction. Sorry.[mis of 85]") when player is in Emo Dome.

understand "emo tome" as a mistake ("That would be out of place among all the stupid jokes, here.[mis of 86]") when player is in Emo Dome.

understand "puck cup" as a mistake ("There's no rink nir. Near.[mis of 87]") when puce cup is quicknear.

chapter Evaded Ave

understand "bun nub" and "buns nub" as a mistake ("No free food. Boo.[mis of 88]") when bunk nub is quicknear.

understand "bung nub" as a mistake ("The bunk nub is in bad enough shape as-is.[mis of 89]") when bunk nub is quicknear.

understand "bunt nub" as a mistake ("Baseball references are a bit too Zork 2.[mis of 90]") when bunk nub is quicknear.

understand "door brood" as a mistake ("Just one guardian is enough to deal with.[mis of 91]") when Door Frood is quicknear.

understand "pcp" as a mistake ("While searching for a boost, you're apprehended by a crank narc! I'm very disappointed in you. Not the whole drugs bit, but that this game didn't alter reality ENOUGH for you.[etg][mis of 92]") when player is in Yell Alley or player is in Evaded Ave.

chapter Flu Gulf

to decide whether either-sac:
	if cassettes sac is quicknear or player has cash sac, yes;
	no;

understand "case sac" as a mistake ("You look extra carefully at the sac. No, no secret compartments.[mis of 93]") when either-sac.

understand "cast sac" as a mistake ("No need to fling stuff around, and no need for magic, either.[mis of 94]") when either-sac.

understand "gull lug" as a mistake ("You shouldn't try to take advantage of sick people. Help the Gulf Lug instead.[mis of 95]") when gulf lug is quicknear.

understand "gulp lug" as a mistake ("Cannibalism is wrong. Besides, you'd probably catch whatever the Gulf Lug has.[mis of 96]") when gulf lug is quicknear.

understand "musc sum" as a mistake ("You don't need Dave to return.[mis of 97]") when player is in Flu Gulf.

understand "muse sum" as a mistake ("You think back to everyone who has inspired you, past and present. It's life-affirming![mis of 98]") when player is in Flu Gulf or Dave is quicknear.

understand "musk sum" as a mistake ("[location of player] still smells the same.[mis of 99]") when player is in Flu Gulf or Dave is quicknear.

understand "must sum" as a mistake ("You take stock of all you need to do--or at least, all you know you need to do. Or you think back to horrible repetitive exercises in math class, which were horrible whether you were good at them or not.[mis of 100]") when player is in Flu Gulf or Dave is quicknear.

section scorn rocs

understand "corn roc" as a mistake ("The scorn rocs remain plural and inorganic.[mis of 101]") when scorn rocs are quicknear.

understand "rocs cor" as a mistake ("Your flattery doesn't move the rocs.[mis of 102]") when scorn rocs are quicknear.

understand "score rocs" as a mistake ("You don't have any witty way to score off them, or steal them, or whatever, and you don't need to.[mis of 103]") when scorn rocs are quicknear.

chapter Frush Surf

understand "slate petals" as a mistake ("The metals are for a didactic and not an aesthetic purpose.[mis of 104]") when slate metals are quicknear.

understand "yak kay" as a mistake ("The yak perks its ears up slightly, then goes back to looking bored. Maybe you didn't quite say things right.[mis of 105]") when yak is quicknear.

chapter Fun Nuf

understand "evaded ave" as a mistake ("That'll appear later.[mis of 106]") when player is in Fun Nuf and Evaded Ave is unvisited. [?? see Dave in Evaded Ave]

understand "fun enuf" as a mistake ("Still ungrammatical![mis of 107]") when player is in Fun Nuf.

understand "fun snuf" as a mistake ("You vow to take saving fantasy worlds much more seriously. No more frivolity![mis of 108]") when player is in Fun Nuf.

understand "fund nuf" as a mistake ("Nonsense! Adventure is its own reward![mis of 109]") when player is in Fun Nuf.

understand "funk nuf" as a mistake ("No cool music plays, but at least it doesn't smell worse.[mis of 110]") when player is in Fun Nuf.

understand "till lit" as a mistake ("You possess no farm tools. And this would be pointless anyway.[mis of 111]") when player is in Fun Nuf.

understand "tilt lit" as a mistake ("It's stuck into the ground.[mis of 112]") when player is in Fun Nuf.

section cap abuse

to say pace-clue-maybe:
	say "[if pace-prev is true or cap-ever-pace is true]There's nothing else special to do with the pace cap[else]There may be one more thing to do other than PACK the cap, but that's not it[end if]"

understand "pa cap" as a mistake ("The word DAD briefly flashes on the Pact Cap. Weird, but not really.[mis of 113]") when Pact Cap is quicknear.

understand "pac cap" as a mistake ("You almost take the cap, but you fumble it slightly. The Flee Elf blinks. 'You're almost there, but ... umm, well, you need to do a little more.'[paragraph break]Also, PACs aren't necessarily evil, but they aren't terribly heroic.[mis of 114]") when Flee Elf is quicknear.

understand "paca cap" and "pacb cap" and "pacc cap" and "pacd cap" and "pacf cap" and "pacg cap" and "pach cap" and "paci cap" and "pacj cap" and "pacl cap" and "pacm cap" and "pacn cap" and "pacp cap" and "pacq cap" and "pacr cap" and "pacu cap" and "pacv cap" and "pacw cap" and "pacx cap" and "pacz cap" as a mistake ("[if player has pact cap][pace-clue-maybe][else]'Hmm, try again,' grumps the Flee Elf[end if].[mis of 115]") when Pact Cap is quicknear. [this should be trivially true, but just in case...]

understand "paco cap" as a mistake ("[if player has pact cap][pace-clue-maybe][else]The Flee Elf notes that's a pejorative term for policemen in Central America--not quite what you want, for decency or for practicality[end if].[mis of 116]") when Pact Cap is quicknear.

understand "pacs cap" as a mistake ("PACs aren't necessarily evil, but they aren't terribly heroic.[mis of 117]") when Pact Cap is quicknear.

understand "pact cap" as a mistake ("It already is![mis of 118]") when Pact Cap is quicknear.

section flee elf abuse

understand "flea elf" and "flea" as a mistake("The elf scratches for a bit, then looks embarrassed.[mis of 119]") when Flee Elf is quicknear.

understand "fleece elf" and "fleece" as a mistake("There is much more fortune and glory in adventure! It's the cap you want to concentrate on.[mis of 120]") when Flee Elf is quicknear.

understand "flen elf" and "flen" as a mistake("Dry ketchup is gross. Besides, the elf is one of the good guys.[mis of 121]") when Flee Elf is quicknear.

understand "flex elf" and "flex" as a mistake("The elf looks more flexible than you. It's the cap you want to concentrate on.[mis of 122]") when Flee Elf is quicknear.

section Set O Notes abuse

to say girt-clue:
	if row-prog > 1:
		say "Hmm. You seem to have found the three configurations for Worn Row[if psi wisp is not moot]. Maybe Worn Row will be useful in the future, maybe not[else], and you even used the Redness Ender[end if].";
	else if row-prog is 0:
		say "You need to figure out what that means. It seems to indicate [if Worn Row is visited][Worn Row][else]a room south of [Fun Nuf][end if]";
	else:
		say "Hmm. Tri indicates three. You've found two different configurations for Worn Row/[Worn Row]. What is the third, you wonder";

understand "tri girt" as a mistake ("[girt-clue].[mis of 123]") when player has Set O Notes.

chapter Gross Org

understand "bra garb" as a mistake ("I've tried to keep this game gender neutral.[mis of 124]") when brag garb is quicknear.

understand "dent Ned" as a mistake ("Less violence, more subtlety.[mis of 125]") when Ned is quicknear.

understand "gro org" and "grow org" as a mistake ("[one of]This game is just a bunch of dumb jokes and silly wordplay mashed together, and any attempt at personal growth is severely frowned upon. So stop that![or]Your height does not change.[stopping][mis of 126]") when player is in Gross Org.

understand "grob org" as a mistake ("Whoah! It's pretty crazy here, but not crazy enough to open a chess game with g4.[mis of 127]") when player is in Gross Org.

understand "grok org" as a mistake ("You achieve no transcendent consciousness, but you suddenly sort of realize why your English teacher yammered on excitedly about ... THAT book in the syllabus.[mis of 128]") when player is in Gross Org.

understand "groo org" as a mistake ("No slavering light-fearing beasts find it worthwhile to punish you for bad spelling.[mis of 129]") when player is in Gross Org.

understand "grot org" as a mistake ("Gross, grot ... same thing.[mis of 130]") when player is in Gross Org.

understand "stinko knits" as a mistake ("AFTER cleaning up Yelpley and Grebeberg is when to get drunk. Nurd.[mis of 131]") when stinky knits are quicknear.

chapter Lair Trial

understand "erg ogre" as a mistake ("The ogre would destroy you in a grunting match.[mis of 132]") when ergot ogre is quicknear.

understand "ergo ogre" as a mistake ("You aren't going to impress it with your smarts.[mis of 133]") when ergot ogre is quicknear.

chapter Le Babel

understand "bron orb" as a mistake ("King James's orb is a basketball, and that's that.[mis of 134]") when Bro Orb is quicknear.

chapter Mont Nom

understand "krab ark" as a mistake ("You don't have the materials to climb the ark, and you don't need to.[mis of 135]") when player is in Mont Nom.

understand "mar tram" as a mistake ("No. [if epicer recipe is xed]You need it to build the north-tron[else]It must be good for something[end if].[mis of 136]") when martini tram is quicknear.

understand "mo nom" as a mistake ("Greedy! There's enough food to find around here, really.[mis of 137]") when player is in Mont Nom.

understand "mong nom" as a mistake ("No 'interesting' brownies appear.[mis of 138]") when player is in Mont Nom.

understand "monk nom" as a mistake ("Cannibalism, or super sparse food, is not an option.[mis of 139]") when player is in Mont Nom.

understand "mono nom" as a mistake ("Planning to eat alone is kinda sad.[mis of 140]") when player is in Mont Nom.

understand "naif Ian" as a mistake ("Sadly, mind control is beyond your powers.[mis of 141]") when Ian is quicknear.

understand "nain Ian" as a mistake ("Owning/pwning would embarrass Ian, but that is too archaic a synonym.[mis of 142]") when Ian is quicknear.

understand "nair Ian" as a mistake ("That would be painful and embarrassing enough to chase him, or someone named Brian, off, but alas, you don't have anything to do the job[if player has nat's tan]. The bottle of Nat's Tan doesn't count[end if].[mis of 143]") when Ian is quicknear.

chapter Motto Bottom

understand "gurn rug" as a mistake ("It's a guru rug. It's too good to be moved by such a cheap bailout.[mis of 144]") when guru rug is quicknear.

understand "tamp mat" as a mistake ("It's already pretty beaten down.[mis of 145]") when player is in Motto Bottom and tame mat is in Motto Bottom.

chapter Moo Room

understand "moo boom" as a mistake ("You hear something strafe farts far away.[mis of 146]") when player is in Moo Room.

understand "moo doom" as a mistake ("Die? I'd...[mis of 147]") when player is in Moo Room.

understand "moo loom" as a mistake ("The noises stay around.[mis of 148]") when player is in Moo Room.

understand "moo zoom" as a mistake ("Nothing speeds up or gets magnified.[mis of 149]") when player is in Moo Room.

understand "poo boop" and "poo foop" and "poo zoop" as a mistake ("That's not the appropriate sound effect for the coop or [if gnu dung is moot]its[else]any potential[end if] contents.[mis of 150]") when poo coop is quicknear.

understand "poo goop" as a mistake ("The coop is intended to prevent AGAINST having to carry yucky stuff, here.[mis of 151]") when poo coop is quicknear.

understand "poo hoop" and "poo loop" as a mistake ("No, the coop needs to hold something.[mis of 152]") when poo coop is quicknear.

understand "poo noop" as a mistake ("Doing nothing with the coop or what [if gnu dung is moot]is[else]could go[end if] in it is not an option.[mis of 153]") when poo coop is quicknear.

understand "poo soop" as a mistake ("Good thing this isn't a cooking sim.[mis of 154]") when poo coop is quicknear.

understand "poo woop" as a mistake ("How or why it excites you, I don't want to know.[mis of 155]") when poo coop is quicknear.

chapter My Gym

understand "evade dave" as a mistake ("Dave's not here, man![mis of 156]") when player is in My Gym and Dave is moot.

understand "mush sum" as a mistake ("Dave worked hard to build these muscles. It'd be mean if you could wipe them out. And impractical--they might be slowing him down a bit, and that could help you.[mis of 157]") when Dave is quicknear.

understand "my pym" as a mistake ("You suddenly have a brilliant idea for a Britcom featuring Edgar Allan Poe (a Poe-op?), but it slips away just as quickly.[mis of 158]") when player is in My Gym.

understand "sto bots" as a mistake ("No cool robots pop out.[mis of 159]") when sto lots is quicknear.

understand "sto cots" as a mistake ("No, it can store all kinds of things.[mis of 160]") when sto lots is quicknear.

understand "sto dots" as a mistake ("The Sto Lots remains unadorned.[mis of 161]") when sto lots is quicknear.

understand "sto gots" as a mistake ("Yes, you gots a lot of space, and you will gots a lot of stuff as the game goes on.[mis of 162]") when sto lots is quicknear.

understand "sto jots" as a mistake ("There's already a bookcase in this game.[mis of 163]") when sto lots is quicknear.

understand "sto nots" as a mistake ("That would defeat the purpose![mis of 164]") when sto lots is quicknear.

understand "sto pots" as a mistake("No, it's more efficient as one entity. Also, this is not a cooking sim.[mis of 165]") when sto lots is quicknear.

understand "sto sots" as a mistake ("It's not big enough to be a drunk tank.[mis of 166]") when sto lots is quicknear.

understand "wasp saw" as a mistake ("You don't need the wash saw to turn into something that might sting you, especially since you are carrying it.[mis of 167]") when wash saw is quicknear.

chapter Ooze Zoo

understand "eel flee" as a mistake ("Well, you could maybe get one eel to leave, but there are a lot.[mis of 168]") when sleep eels are quicknear.

understand "eel glee" as a mistake ("The eels squirm a bit. I bet they're having fun dreams! Too bad I can't describe them.[mis of 169]") when sleep eels are quicknear.

understand "sleek eels" as a mistake ("The eels don't need dexterity. They need comfort. They are slippery enough.[mis of 170]") when sleep eels are quicknear.

understand "sleet eels" as a mistake ("They are alive. Turning them to metal would be cruel.[mis of 171]") when sleep eels are quicknear.

chapter Pro Corp

understand "balk lab" as a mistake ("There's not much to do or say here, for sure[if balm-got is false]![else]--well, maybe something that's not quite BALK.[end if][mis of 172]") when player is in Pro Corp.

understand "ball lab" as a mistake ("Nothing fun explodes out from the walls or ceiling.[mis of 173]") when player is in Pro Corp.

understand "band nab" as a mistake ("Mr. Arm tries to grip his own wrist but can't quite.[mis of 174]") when Mr Arm is quicknear.

understand "bank nab" as a mistake ("Whoah! You're one of the good guys, here.[mis of 175]") when Mr Arm is quicknear.

understand "bannon nab" as a mistake ("That's up to Muelle ... um, there's enough political references in the game with the Yuge Guy.") when Mr Arm is quicknear.

understand "DNA hand" as a mistake ("Right idea, but you can't do it on your own. You need technology to help you.[mis of 176]") when DNA band is quicknear.

understand "dna land" as a mistake ("Biochemistry has its own nuances with symmetry, but we're sticking with something a lot dumber, here.[mis of 177]") when DNA band is quicknear or DNA hand is quicknear.

understand "DNA sand" as a mistake ("That will happen with the passage of time.[mis of 178]") when DNA band is quicknear or DNA hand is quicknear.

understand "dna wand" as a mistake ("No. You know TRUE MAGIC MUST COME FROM WITHIN.[mis of 179]") when DNA band is quicknear or DNA hand is quicknear.

understand "mra arm" as a mistake ("No! Mr. Arm is on the side of social justice.[mis of 180]") when Mr Arm is quicknear.

understand "psi lisp" as a mistake ("The Psi Wisp can't speak.[mis of 181]") when Psi Wisp is quicknear.

understand "rm mr" as a mistake ("No, Mr. Arm will be helpful. (Spoiler: he'll leave for better things once he has helped, so happy endings all around. Yay!)[mis of 182]") when Mr Arm is quicknear.

understand "sci bics" as a mistake ("You don't need any exotic writing implements.[mis of 183]") when player is in Pro Corp.

understand "sci dics" as a mistake ("You don't have time to learn weird terminology now.[mis of 184]") when player is in Pro Corp.

understand "sci fics" as a mistake ("But you already have reading material![mis of 185]") when player is in Pro Corp.

understand "sci mics" as a mistake ("Your experience remains relatively quiet but also free of static.[mis of 186]") when player is in Pro Corp.

understand "sci sics" as a mistake ("You think you spy a typo somewhere in the sci pics, leaving you feel free to feel smarter than something you don't unerstand. Go, you![mis of 187]") when player is in Pro Corp.

understand "sci tics" as a mistake ("You laugh at how silly the sci pics are, then sniff a bit, then tap your head.[mis of 188]") when player is in Pro Corp.

section golf log/dork rod

understand "dorm rod" and "dorm" as a mistake ("You reveal no frat. Arf![mis of 189]") when dork rod is quicknear.

understand "golf log" as a mistake ("There is no Par Trap or Tee Meet to navigate here, so you don't need to make a golf log.[mis of 190]") when gold log is quicknear.

chapter Red Roses Order

understand "gal slag" as a mistake ("You managed to annoy Madam enough that she lashes out and conks you with a mortal blow with the Gal Flag. Okay, not really, but name calling won't help.[mis of 191]") when Madam is quicknear. [?? do fake death thing]

understand "sworn rows" and "swore rows" as a mistake ("The sword rows are inanimate and neutral. Unless you get too close to them.[mis of 192]") when sword rows are quicknear.

section yard ray misuse

understand "yarg ray" and "yarr ray" as a mistake ("Becoming a pirate at the end? A clever heel turn![mis of 193]") when player has yard ray.

understand "yarn ray" as a mistake ("If you want more story, then sorry, this one's nearly at an end.[mis of 194]") when player has yard ray.

chapter Scrap Arcs

understand "scram arcs" as a mistake ("The arcs stay still, but you can just go back east if you want.[mis of 195]") when player is in Scrap Arcs.

chapter Seer Trees

understand "seer brees" as a mistake ("[one of]A man in black and gold throws a football at you from 50 yards away, and it drills you right in the chest. Accurate![or]The man doesn't appear again. He probably has better things to do than schlep around in some text adventure. Perhaps he is off eating at a QB BBQ.[stopping][mis of 196]") when player is in Seer Trees.

understand "seer frees" as a mistake ("[if stark rats are in Seer Trees]It won't be THAT easy[else]You already feel free enough here[end if].[mis of 197]") when player is in Seer Trees.

section stark rats

understand "star rats" as a mistake ("You would rather they didn't star in your adventure, here. Must be some way to dispose of them.[mis of 198]") when stark rats are quicknear.

understand "stare rats" as a mistake ("You try to win a blinking contest, and maybe you could with one, but not that many.[mis of 199]") when stark rats are quicknear.

understand "start rats" as a mistake ("You sort of need to stop them, instead.[mis of 200]") when stark rats are quicknear.

section gift fig

understand "gi fig" as a mistake ("Hard to imagine how to weaponize the fig.[mis of 201]") when gift fig is quicknear.

understand "gif fig" and "fig gif" as a mistake ("The fig remains firmly text-based. Eh, it's more edible that way.[mis of 202]") when gift fig is quicknear.

chapter Sneer Greens

chapter Swamp Maws

understand "swam maws" as a mistake ("Perhaps someone has, but you don't need to.[mis of 203]") when player is in Swamp Maws.

understand "swami maws" and "swamy maws" as a mistake ("[if Yack Cay is visited and den ivy vined is visited]Aw, come on, you've already met TWO SMART PEOPLE nearby[else if Yack Cay is unvisited and den ivy vined is unvisited]There might be someone smart nearby[else]Aw, come on, you've already met someone smart nearby[end if].[mis of 204]") when player is in Swamp Maws.

section eroded ore

understand "eros ore" as a mistake ("I don't even want to know what you're trying to do, there.[mis of 205]") when eroded ore is quicknear or ore zero is quicknear.

chapter Swept Pews

understand "fra barf" as a mistake ("Don't dirty up the pews![mis of 206]") when player is in Swept Pews.

understand "fra zarf" as a mistake ("This would send you on a long journey to Hadean Lands. One you might enjoy so much, you'll forget about Yelpley![mis of 207]") when player is in Swept Pews.

understand "liar frail" and "liar trail" as a mistake ("The grail remains in your way to the south. But it was worth a try.[mis of 208]") when liar grail is quicknear.

understand "trod ort" as a mistake ("[if player has troll ort]Nah, you should keep it[else]It looks run-down enough[end if].[mis of 209]") when troll ort is quicknear.

understand "trog ort" as a mistake ("Maybe it is low-class food, but you don't need to overdo mentioning it.[mis of 210]") when troll ort is quicknear.

understand "troi ort" as a mistake ("You don't need a counselor to tell you not to eat stuff like the troll ort.[mis of 211]") when troll ort is quicknear.

understand "tron ort" as a mistake ("No MCP orders light cycles to run you over. Whew![mis of 212]") when troll ort is quicknear.

understand "trop ort" as a mistake ("The ort fails to split and reproduce until there is too much of it.[mis of 213]") when troll ort is quicknear.

understand "trow ort" as a mistake ("You wonder how the ort's potential stinkiness could work in your favor, somehow, somewhere.[mis of 214]") when troll ort is quicknear.

understand "troy ort" as a mistake ("There's enough to save here. You don't want to have to deal with a 10-year war.[mis of 215]") when troll ort is quicknear.

chapter Toll Lot

understand "crab arc" as a mistake ("That's just what you need, a giant crab coming after you[if cross orc is in Toll Lot], along with the cross orc[end if].[mis of 216]") when player is in Toll Lot.

understand "crac arc" and "crak arc" as a mistake ("While there may be a correlation between bad spelling and extreme strength, there's no causation. Sorry[if UFO tofu is not off-stage and player is in Toll Lot]. Besides, you got something, already[end if].[mis of 217]") when player is in Toll Lot or player is in Scrap Arcs.

understand "cram arc" as a mistake ("Litterbug. Besides, you need pretty much everything you're carrying. And nothing would fit, anyway.[mis of 218]") when player is in Toll Lot.

understand "crap arc" as a mistake ("You might cause a mudslide, or worse.[mis of 219]") when player is in Toll Lot or player is in Scrap Arcs.

understand "crass arc" as a mistake ("[if cross orc is in Toll Lot]The cross orc and crag arc don't fuse together. Rats[else]You spend a few seconds feeling deeply offended by the crag arc[end if].[mis of 220]") when player is in Toll Lot or player is in Scrap Arcs.

understand "cray arc" as a mistake ("The arc doesn't need to change shape or become more volatile.[mis of 221]") when player is in Toll Lot.

understand "croc orc" as a mistake ("The orc is fearsome enough without becoming a total genetic monstrosity.[mis of 222]") when cross orc is quicknear.

understand "crop orc" as a mistake ("That attack would boomerang, and not just because this is a palindrome-y game. The orc is lots, lots bigger than you.[paragraph break]Also, there is no farm nearby.[mis of 223]") when cross orc is quicknear.

understand "crow orc" as a mistake ("The orc remains silent (yay) and flightless (boo).[mis of 224]") when cross orc is quicknear.

understand "told lot" as a mistake ("[if cross orc is in Toll Lot]The cross orc isn't open to verbal negotiation[else]You pretend you won an argument against the cross orc and didn't just hand over money[end if].[mis of 225]") when player is in Toll Lot.

chapter Trapeze Part

understand "tendered net" as a mistake ("[if player has tent net]You already have it[else]Nobody comes by to hand it to you. You're on the right track. Maybe you're overthinking things[end if].[mis of 226]") when level net is quicknear or tent net is quicknear.

chapter Worn Row

to say red-clue: if redness ender is not moot, say ", but who knows, that redness ender might help you some day"

understand "borg Rob" as a mistake ("He is already assimilated.[mis of 227]") when Rob is quicknear.

understand "bork Rob" as a mistake ("Maybe there is a more nonviolent way to get him to give up.[mis of 228]") when Rob is quicknear.

understand "dwell lewd" as a mistake ("DWELT LEWD should NOT be read as an instruction manual. Well, it shouldn't be read at all, really.[mis of 229]") when DWELT LEWD is quicknear.

understand "pi tip" as a mistake ("4/1 - 4/3 + 4/5 - 4/7 + 4/9 - 4/11 ... wait, no, that's a bit slow.[paragraph break]3 + 4/(2*3*4) - 4/(4*5*6) + 4/(6*7*8) - 4/(8*9*10) + 4/(10*11*12) - 4/(12*13*14) ...[mis of 230]") when pity tip is quicknear.

understand "pita tip" as a mistake ("Sorry, you're getting ambiguous snack cans and not any specific cuisine.[mis of 231]") when pity tip is quicknear.

understand "pith tip" as a mistake ("It's already pretty pithy, and there's not enough material for a helmet.[mis of 232]") when pity tip is quicknear.

understand "track cart" as a mistake ("[if DWELT LEWD is off-stage]Right idea, but the cart isn't going anywhere[else]It's not going anywhere. You already unlocked a secret, anyway[end if].[mis of 233]") when tract cart is quicknear.

understand "worf row" as a mistake ("No Enterprise security officer arrives to help you.[mis of 234]") when player is in Worn Row.

understand "worm row" as a mistake ("[if Worn Row is worny]Ugh! You don't need to make this place worse[else]You already upgraded Worn Row. No need to make it worse than it was[red-clue][end if].[mis of 235]") when player is in Worn Row.

understand "worsts row" and "worses row" as a mistake ("It [if Worn Row is worny]is[else]was[end if] bad enough already.[mis of 236]") when player is in Worn Row.

understand "wort row" as a mistake ("[Worn Row] is not meant to be a garden. Maybe it would look nicer that way, but it wouldn't be helpful to you.[mis of 237]") when player is in Worn Row.

chapter Yack Cay

understand "shard rahs" as a mistake ("The rahs are on paper, and besides, they might be useful.[mis of 238]") when sharp rahs are quicknear.

understand "share rahs" as a mistake ("You're on this quest by yourself.[mis of 239]") when sharp rahs are quicknear.

understand "shark rahs" as a mistake ("You don't want to alert any land sharks.[mis of 240]") when sharp rahs are quicknear.

understand "store rots" as a mistake ("You don't need to buy anything in this game, and any store wouldn't sell anything good.[mis of 241]") when player is in Yack Cay.

understand "stork rots" as a mistake ("You don't want to know what sort of carcasses are buried in the swamp.[mis of 242]") when player is in Yack Cay.

understand "story rots" as a mistake ("No, the storm rots help keep you focused on the story. They aren't blocking anything. Or good for anything.[mis of 243]") when player is in Yack Cay.

chapter Yawn Way

understand "yawp way" and "yawl way" as a mistake ("It's still quiet here.[mis of 244]") when player is in Yawn Way.

chapter Yell Alley

understand "link nil" as a mistake ("The Line Nil security system fails to break apart. That's pretty secure![mis of 245]") when Line Nil is quicknear.

understand "may yam" as a mistake ("You don't want the yam to age. It would probably start to smell bad.[mis of 246]") when mayo yam is quicknear.

understand "nacelle can" as a mistake ("You don't need a huge engine.[mis of 247]") when player has snack cans.

volume checking off mistakes from the player

mist-found is a number that varies.

mis-yet is a truth state that varies.

cur-LLP-hint-row is a number that varies. cur-LLP-hint-row is 0.

checkoffs is a list of truth states variable. checkoffs is { false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }.

hint-every-x is a number that varies. hint-every-x is 5.

to say mis of (n - a number):
	let Q be entry N in checkoffs;
	if Q is false:
		now entry N in checkoffs is true;
		increment mist-found;
		if mist-found is 1:
			say "[paragraph break](NOTE: this was a specific reject for a good try. For the most part, you don't need to riff on any item after the pact cap, but enough good guesses will tell you how to get secret points.)[run paragraph on][line break]";
			continue the action;
		if the remainder after dividing mist-found by hint-every-x is 0:
			while cur-LLP-hint-row < number of rows in table of last lousy points:
				increment cur-LLP-hint-row;
				choose row cur-LLP-hint-row in table of last lousy points;
				process the dorule entry;
				if the rule failed:
					say "[paragraph break]A voice from behind the fourth wall whispers: [i][cluey entry][r].[if mis-yet is true][run paragraph on][end if]";
					now mclu entry is true;
					if mis-yet is false:
						now mis-yet is true;
						say "[line break]NOTE: THINK[if refer-bonus is true]/REFER[end if] will show you the LLPs clued so far that you haven't figured, yet.[run paragraph on][line break]";
					continue the action;

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

to say or-ups: if word number 1 in the player's command is "ups", say ", much less spu";

understand "gift fig" as a mistake ("It already is one. And you don't need to pass it on.") when gift fig is quicknear.

understand "guh" and "thug" and "guh thug" as a mistake ("That's what [random visible guhthug] is, but you need to figure how to get rid of him.") when thug-near.

understand "put it up" as a mistake ("That's what the Spur Ups say, but you need to re-interpret it slightly, to help yourself.") when player has spur ups.

understand "rm gnu/dung" and "rm gnu dung" as a mistake ("You don't have the proper permissions. It is (wait for it) too root.") when dung-near.

understand "rub [text]" as a mistake ("There's no one named Burt or Babbur or Liwilbur anything like that in this game, so you don't have to rub anyone or anything.")

understand "tap at [text]" as a mistake ("That's in the spirit of the game, but sadly, I couldn't find a way to make it useful. Sorry!")

understand "up [text]" and "ups [text]" as a mistake ("You need to do something UP with the spurs, but ... UP needs to come second. Or last. You can't do much with PU[or-ups].") when player has spur ups.

understand "wave" as a mistake ("Nobody named Eva is beyond the fourth wall.")

chapter deprecated mistakes

[understand "truce curt" as a mistake ("You'll need something more violent, here.") when player is in Mont Nom and Curt is in Mont Nom.]

[understand "truco curt" as a mistake ("You don't have a deck of cards, and Curt wouldn't want to play.[mis of 100]") when player is in Mont Nom and Curt is in Mont Nom.]

Ailihphilia Mistakes ends here.

---- DOCUMENTATION ----
