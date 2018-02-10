Version 1/171220 of Put It Up Mistakes by Andrew Schultz begins here.

volume Mistakes

to decide whether (mt - a thing) is quicknear:
	if mt is in location of player, yes;
	if player carries mt, yes;
	no;

[todo: (programming exercise) change when player is in x and (y) is in x to when (y) is quicknear)]

part locations

book Fun 'Nuf

chapter flee elf abuse

understand "flea elf" and "flea" as a mistake("[fe0]The elf scratches for a bit, then looks embarrassed.") when Flee Elf is quicknear.

understand "flex elf" and "flex" as a mistake("[fe1]The elf looks more flexible than you. It's the cap you want to concentrate on.") when Flee Elf is quicknear.

understand "fleece elf" and "fleece" as a mistake("[fe2]There is much more fortune and glory in adventure! It's the cap you want to concentrate on.") when Flee Elf is quicknear.

flea-elf is a truth state that varies.
flex-elf is a truth state that varies.
fleece-elf is a truth state that varies.

to say fe0:
	now flea-elf is true;

to say fe1:
	now flex-elf is true;

to say fe2:
	now fleece-elf is true;

chapter yard ray misuse

understand "yarn ray" as a mistake ("If you want more story, then sorry, this one's nearly at an end.") when player has yard ray.

understand "yarg ray" and "yarr ray" as a mistake ("Becoming a pirate at the end? A clever heel turn!") when player has yard ray.

book My Gym

understand "evade dave" as a mistake ("Dave's not here, man!") when player is not in My Gym.

book Worn Row

understand "worm row" as a mistake ("Ugh! You don't need to make this place worse.") when player is in Worn Row.

understand "bork rob" as a mistake ("Maybe there is a more nonviolent way to get him to give up.") when Rob is quicknear.

understand "borg rob" as a mistake ("He is already assimilated.") when Rob is quicknear.

book Emo Dome

understand "emo home" as a mistake ("It's too wide open a space.") when player is in Emo Dome.

book Toll Lot

understand "crop orc" as a mistake ("That attack would boomerang, and not just because this is a palindrome-y game. The orc is lots, lots bigger than you.") when cross orc is quicknear.

understand "crap arc" as a mistake ("You might cause a mudslide, or worse.") when player is in Toll Lot.

understand "crab arc" as a mistake ("That's just what you need, a giant crab coming after you[if cross orc is in toll lot], along with the cross orc[end if].") when player is in Toll Lot.

book Dumb Mud

understand "gnu bung" as a mistake ("Yes, that's where it came from.") when gnu dung is quicknear.

understand "gnu lung" as a mistake ("The gnu dung smells bad enough without dropping more internal organs into the mix.") when gnu dung is quicknear.

understand "turd rut" as a mistake ("Hmm! Maybe you could fill the rut up with ... something ... to cross it.") when player is in dumb mud and poo coop is not in ZeroRez.

understand "turn rut" as a mistake ("It's too large to redirect[if poo coop is in ZeroRez], and besides, you already have a way across[end if].")

book Cold Loc

understand "rife fir" as a mistake ("It's already big enough.") when player is in Cold Loc.

book Mont Nom

[understand "truce curt" as a mistake ("You'll need something more violent, here.") when player is in Mont Nom and Curt is in Mont Nom.

understand "truco curt" as a mistake ("You don't have a deck of cards, and Curt wouldn't want to play.") when player is in Mont Nom and Curt is in Mont Nom.]

part things

book dork rod

understand "dorm rod" and "dorm" as a mistake ("You reveal no frat. Arf!") when dork rod is quicknear.

volume prospective

[understand "tame mat" as a mistake ("That's not quite what to do. This is a game about palindromes, not homonyms.") when player is in Toll Lot and tame mat is in Toll Lot. ?? ]

Put It Up Mistakes ends here.

---- DOCUMENTATION ----
