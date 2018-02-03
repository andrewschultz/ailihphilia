Version 1/171220 of Put It Up Mistakes by Andrew Schultz begins here.

volume Mistakes

part locations

book Fun 'Nuf

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

book My Gym

understand "evade dave" as a mistake ("Dave's not here, man!") when player is not in My Gym.

book Worn Row

understand "worm row" as a mistake ("Ugh! You don't need to make this place worse.") when player is in Worn Row.

understand "worn row" and "wornrow" as a mistake ("No need to revert things.") when shouldnt-revert. [ic]

part things

book dork rod

understand "dorm rod" and "dorm" as a mistake ("You reveal no frat. Arf!") when player has dork rod or player is in location of dork rod.

volume prospective

[understand "tame mat" as a mistake ("That's not quite what to do. This is a game about palindromes, not homonyms.") when player is in Toll Lot and tame mat is in Toll Lot. ?? ]

Put It Up Mistakes ends here.

---- DOCUMENTATION ----
