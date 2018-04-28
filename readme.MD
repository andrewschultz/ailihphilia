README for Ailihphilia, 2018 IFComp candidate

It's about, well, palindromes.

To-do:

* Fix issues with slightly (or more than slightly?) obscure puzzles especially the Yak, where I know what to do in my mind but I'm not translating it in the game
* Let the player know about the epilogue. There will be more books, especially 3-letter ones, as well as businesses and ways to look for LLPs.
  * should we hide them from the player if the player hasn't examined the DAY AWAY AD and the TRACT CART/RELATE TALER?
* have a "west first" walkthrough and an "east first" walkthrough. This won't catch everything, but it will track different ways through.
* have a set of scripts to run, including one that features all mistakes
  * walkthroughs that verify the game is solvable
    * bare bones walkthrough = minimum 77/88 points
    * "observant" walkthrough = 88 points with the player also examining all the people that make the cap beep
    * "pitfalls" walkthrough = all the way through, triggering all the mistakes and all the random text as well and also stuff that's dropped in once you win (taler/day away) along with areas now cordoned off
  * walkthroughs that cover potential mistakes
    * "double play" walkthrough = run each scoring command twice to make sure the total is 88
    * "break the game" walkthrough = try to go certain directions before we are allowed to

Utils explanations are in the Utils subdirectory.

Regular expressions tests are in the Regtest subdirectory. They are used with Zarf's regtest.py and an Ubuntu emulator. REG files can be run. RBR = regtest breakup and are used to generate REG files.

