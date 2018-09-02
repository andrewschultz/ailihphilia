Version 1/171220 of Ailihphilia Tables by Andrew Schultz begins here.

volume big random table

[use dbh.py to generate debug table version of this file]

part the code

to next-rand (t - a table name):
	choose row with tabnam of t in table of all randoms;
	increment tabidx entry;
	if tabidx entry > number of rows in tabnam entry:
		if debug-state is true, say "(Cycling) ";
		now tabidx entry is 1;
		if thru-yet entry is 0:
			now thru-yet entry is 1;
			now rand-cycle is true;
	let Q be tabidx entry;
	let lb be lbrk entry;
	choose row Q in tabnam entry;
	say "[randtxt entry][if lb is true][line break][else][no line break][end if]";

to say next-rand-txt of (t - a table name):
	next-rand t;

table of all randoms
tabnam	tabidx	thru-yet	lbrk	desc	cycle-note
table of altbooks	0	0	false	"extra books in the Tract Cart"	"You've read all the books on the tract cart. Hooray for curiosity!"
table of attackings	0	0	true	"responses to ATTACK"	--
table of babel babble	0	0	false	"babbles if you LISTEN in Le Babel"	--
table of Bond Nob bars	0	0	false	"bars the Bond Nob visits"	-- [?? may cause a problem cycling talking to nob]
table of burnies	0	0	true	"responses to BURN"	--
table of businesses	0	0	true	"businesses in Day-Away Ad"	"Oh goody. You were worried an NRA barn might appear, but it didn't."
table of diktat taunts	0	0	false	"Diktat Kid taunts"	--
table of King Nik ancestors	0	0	false	"King Nik ancestors (TALK to King Nik)"
table of Moo Room animals	0	0	false	"Moo Room animals (LISTEN)"	--
table of Ms Ism pals	0	0	false	"Ms Ism's pals (TALK to Ms Ism)"	--
table of My Gym songs	0	0	false	"songs in My Gym (LISTEN)"	"All those tunes, and nothing by ABBA! Low class, low class."
table of noesies	0	0	true	"responses to NO"	--
table of nothings	0	0	true	"responses to empty commands"	--
table of random authors	0	0	false	"random author names (ones I particularly liked)"	--
table of random palindrome firstlast names	0	0	false	"First/last names in Name ME Man"	--
table of random palindrome lastfirst names	0	0	false	"Last/first names in OH WHO"	--
table of rejected kid sidekicks	0	0	false	"the Diktat Kid's rejected kid sidekicks"	--
table of Rob droning	0	0	false	"things Rob babbles about"	"Rob takes a moment to shape 'pahs' again."
table of singstuff	0	0	true	"responses to SINGing"	"Won't be joining OctetCo with that voice."
table of snooty toon ads	0	0	true	"snooty toons ads"	"At the end is La Usual, because of course."
table of swearstuff	0	0	true	"responses to SWEARing"	--
table of undoings	0	0	true	"UNDOing notifications"	--
table of university targets	0	0	true	"Dr. D/Code Doc's prospective colleagues"	--
table of waittxt	0	0	true	"responses to WAITing"	--
table of wordy drow laments	0	0	false	"Wordy Drow laments"	--
table of yessies	0	0	true	"responses to YES"	--
table of yuge baits	0	0	false	"Yuge Guy bait if you run away"	"The Yuge Guy emits a side-dis you probably weren't meant to hear fuly. can't quite hear, and you are enraged enough to go back."
table of yuge battle cries	0	0	false	"Yuge Guy battle cries"	"'BOSS! SOB!' the Yuge Guy cries, finally free from the shackles of political correctness. Señor drones, you think you yourself, as he winds up for a repeat round of nonsense."

rand-cycle is a truth state that varies.

every turn (this is the notify cycling rule):
	if rand-cycle is true:
		let tn be a table-name;
		let tables-found be 0;
		now rand-cycle is false;
		repeat through table of all randoms:
			if thru-yet entry is 1:
				now thru-yet entry is 2;
				increment tables-found;
				if tables-found is 1:
					say "[if there is a cycle-note entry][cycle-note entry][line break][else]Whoah...that sounds familiar. You suspect things will loop again.[end if]";
				else if tables-found is 2:
					say "This is a further note to say you've done so more than once this turn, which is an impressive bit of timing, even if it doesn't get you any points.";
		if tables-found is 0 and debug-state is true, say "This is a BUG--you should have been notified of random cycling in a table, but you weren't.";
		the rule succeeds;

volume random names of people and places

chapter random names

[NOTE: can-m + can-f = a unisex name. False/False should never happen.]
table of random authors
randtxt	can-m	can-f
"Eliza Bazile"	false	true
"Kera Marek"	false	true
"Leta Patel"	false	true
"Marge Pegram"	false	true
"Mika Hakim"	false	true
"Norma Damron"	false	true
"Reiko Kier"	false	true
"Rhea Baehr"	false	true
"Signe Kengis"	false	true
"Blake DeKalb"	true	true
"Corky Kroc"	true	true
"Leigh Giel"	true	true
"Adam Imada"	true	false
"Eldon Odle"	true	false
"Elias Osaile"	true	false
"Emory Rome"	true	false
"Gino Konig"	true	false
"Levi Rivel"	true	false
"Mark Cockram"	true	false
"Neil Klien"	true	false

table of random palindrome firstlast names
randtxt
"Abe Keba"
"Agnus Unga"
"Alena Panela"
"Ali Vila"
"Alina Manila"
"Alona Zanola"
"Ami Cima"
"Amy Ma"
"Anika Kina"
"Anitra Martina"
"Annalee Lanna"
"Anne Kenna"
"Annika Kinna"
"Anya Rayna"
"Art Ra"
"Asa Casa"
"Ava Lava"
"Azalee Laza"
"Bernie Weinreb"
"Bert Streb"
"Betsey Esteb"
"Blake Kalb"
"Breana Erb"
"Breanna Erb"
"Bret Erb"
"Bruce Curb"
"Burt Strub"
"Cami Mac"
"Cassie Issac"
"Daisy Siad"
"Dara Jarad"
"Dee Reed"
"Denese Ned"
"Dian Aid"
"Diann Aid"
"Dorene Rod"
"Dori Girod"
"Duane Renaud"
"Ed Larralde"
"Ed Lazalde"
"Edie Weide"
"Edna Lalande"
"Edra Garde"
"Edy Hyde"
"Ela Bale"
"Ela Cicale"
"Ela Dale"
"Ela Yale"
"Elana Canale"
"Elda Wadle"
"Eli Kile"
"Elida Nadile"
"Elisa Basile"
"Ella Malle"
"Ellena Fanelle"
"Elli Tille"
"Elly Hylle"
"Elsie Isle"
"Elva Mavle"
"Ely Pyle"
"Emiko Kime"
"Emil Glime"
"Emily Lime"
"Emma Hamme"
"Emmitt Imme"
"Emmitt Timme"
"Ena Lane"
"Ena Sayasane"
"Enoch Cone"
"Enola Malone"
"Essie Heisse"
"Essie Weisse"
"Etta Matte"
"Eugene Gue"
"Eura Larue"
"Eva Dave"
"Eve Leve"
"Evo Love"
"Ewa Hawe"
"Ezra Marze"
"Fae Leaf"
"Flo Rolf"
"Flo Wolf"
"Flora Marolf"
"Florene Rolf"
"Gia Haig"
"Gil Lellig"
"Gina Hanig"
"Gino Honig"
"Gio Doig"
"Gitte Rettig"
"Glenn Elg"
"Hal Olah"
"Harold Lorah"
"Helene Leh"
"Herb Reh"
"Hoyt Yoh"
"Ike Ueki"
"Ila Bali"
"Ileana Eli"
"Ilene Li"
"Ilona Noli"
"Ima Kawakami"
"Ina Kakani"
"Inga Bagni"
"Inga Magni"
"Inga Pagni"
"Inga Papagni"
"Iola Kaloi"
"Iola Loi"
"Iona Manoi"
"Ira Gari"
"Irena Neri"
"Irene Neri"
"Irene Veneri"
"Iva Ravi"
"Jade Dedaj"
"Jame Maj"
"Jamee Maj"
"Jani Kinaj"
"Ka Dudak"
"Kai Ziak"
"Kai Zuziak"
"Kala Balak"
"Kali Milak"
"Kamala Mak"
"Kami Kimak"
"Kami Mak"
"Kara Barak"
"Kari Jirak"
"Karisa Sirak"
"Karl Rak"
"Kate Tak"
"Katy Tak"
"Kay Babyak"
"Keely Leek"
"Keira Riek"
"Keli Bilek"
"Keli Cilek"
"Keli Lek"
"Kelle Sellek"
"Ken Okonek"
"Kena Danek"
"Kena Janek"
"Kena Vanek"
"Kena Yanek"
"Keri Sirek"
"Keva Pavek"
"Kia Haik"
"Kiana Naik"
"Kim Adamik"
"Kina Panik"
"King Nik"
"Kyla Halyk"
"Kyra Caryk"
"Lacy Cal"
"Lael Cleal"
"Lala Kalal"
"Lani Pinal"
"Lara Baral"
"Lavelle Val"
"Lavette Val"
"Lawanna Wal"
"Leda Nadel"
"Lee Keel"
"Lee Mcmeel"
"Lee Neel"
"Lee Peel"
"Leena Neel"
"Lenna Kannel"
"Leo Joel"
"Leona Noel"
"Leora Roel"
"Lera Karel"
"Lesa Basel"
"Lesia Maisel"
"Lessie Geissel"
"Lia Gail"
"Liana Nail"
"Liane Nail"
"Liberty Trebil"
"Lien Oneil"
"Lila Kalil"
"Lisa Basil"
"Lisa Vasil"
"Lise Sil"
"Lisette Sil"
"Lissa Bassil"
"Lita Patil"
"Liza Bazil"
"Lona Nol"
"Long Nol"
"Loni Nol"
"Lora Carol"
"Lory Tyrol"
"Love Devol"
"Lu Aul"
"Luann Aul"
"Luna Canul"
"Ma Eleam"
"Mamie Imam"
"Marcene Cram"
"Marci Cram"
"Marco Cram"
"Margene Gram"
"Margot Ogram"
"Mari Ram"
"Maria Bairam"
"Mark Akram"
"Marta Tram"
"Marty Tram"
"Mary Byram"
"Matt Tam"
"Maya Rayam"
"Maybelle Byam"
"Mel Klem"
"Melba Blem"
"Mika Kim"
"Mike Kim"
"Mila Lim"
"Mina Nim"
"Minh Nim"
"Mira Karim"
"Mirta Trim"
"Miyoko Yim"
"Na Gahagan"
"Na Gilligan"
"Na Henehan"
"Na Holohan"
"Na Noonan"
"Na Susan"
"Naida Hadian"
"Nam Dudman"
"Nan Onan"
"Nana Kanan"
"Naomi Moan"
"Ned Aden"
"Ned Dudden"
"Ned Eden"
"Ned Oden"
"Ned Rarden"
"Neda Baden"
"Neda Haden"
"Neda Vaden"
"Nedra Darden"
"Nedra Varden"
"Neely Leen"
"Neida Dien"
"Nella Gallen"
"Nella Mallen"
"Nelle Mcmellen"
"Nelle Yellen"
"Neoma Moen"
"Neomi Moen"
"Neta Paten"
"Nettie Leitten"
"Neva Haven"
"Nevada Daven"
"Nia Cain"
"Nia Fain"
"Nia Mcmain"
"Nia Pain"
"Nida Sadin"
"Nigel Klegin"
"Niki Aikin"
"Niki Kin"
"Nila Balin"
"Nilda Gadlin"
"Nilsa Gaslin"
"Nilsa Maslin"
"Nina Ganin"
"Nina Susanin"
"Nita Patin"
"Noemi Simeon"
"Nola Salon"
"Noma Damon"
"Nona Manon"
"Nora Aaron"
"Nora Baron"
"Nora Maron"
"Norah Aharon"
"Norah Aron"
"Norah Charon"
"Norah Sharon"
"Norene Ron"
"Nova Lavon"
"Nyla Lyn"
"Oda Bado"
"Odell Ledo"
"Odette Do"
"Odile Lido"
"Ola Salo"
"Olene Lo"
"Ollie Aeillo"
"Oma Didamo"
"Omar Amo"
"Omer Emo"
"Omer Gremo"
"Ona Kano"
"Ona Llano"
"Onie Reino"
"Onita Patino"
"Onita Tino"
"Opal Apo"
"Ora Caro"
"Ora Faro"
"Ora Paparo"
"Oralee Laro"
"Oren Ero"
"Otis Ito"
"Pa Yap"
"Rae Gear"
"Raelene Lear"
"Ramiro Rimar"
"Ramon Omar"
"Ray Dyar"
"Rea Baer"
"Reba Faber"
"Reba Jaber"
"Reda Nader"
"Reda Sader"
"Reena Neer"
"Regan Ager"
"Regina Saniger"
"Regine Weniger"
"Reina Lanier"
"Reita Matier"
"Rema Hamer"
"Ren Hohner"
"Rena Waner"
"Renae Deaner"
"Renda Ladner"
"Rene Gener"
"Renea Haener"
"Renee Deener"
"Renita Tiner"
"Renna Danner"
"Renna Tanner"
"Ressie Weisser"
"Reta Yater"
"Retta Satter"
"Reva Baver"
"Rey Byer"
"Rey Dyer"
"Rey Iyer"
"Rhea Ehr"
"Rheba Behr"
"Ria Fair"
"Rima Jamir"
"Risa Nasir"
"Rod Amador"
"Rod Odor"
"Roger Gregor"
"Rolf Lor"
"Roman Amor"
"Romana Mor" [okdup]
"Ron Oconor"
"Roni Minor"
"Rosana Sor"
"Rose Sor"
"Roselle Sor"
"Rosita Tisor"
"Ross Sor"
"Rosy Sor"
"Rosy Tysor"
"Rubi Bur"
"Ruby Bur"
"Russ Sur"
"Ruth Tur"
"Sade Das"
"Sal Blas"
"Samara Mas"
"Sana Llanas"
"Sara Taras"
"Sarah Dharas"
"Sari Miras"
"Sari Ras"
"Selena Caneles"
"Selina Niles"
"Sena Vanes"
"Setsuko Kustes"
"Shawanna Wahs"
"Sher Drehs"
"Si Tatis"
"Sim Amis"
"Sim Aramis"
"Sima Damis"
"Sina Mcmanis"
"Sirena Neris"
"Sol Abalos"
"Sol Avalos"
"Sona Danos"
"Sona Llanos"
"Soraya Ros"
"Su Titus"
"Sue Reus"
"Sy Pepys"
"Tara Marat"
"Telma Hamlet"
"Tena Banet"
"Tena Llanet"
"Tera Jaret"
"Tera Maret"
"Tera Naret"
"Terra Barret"
"Terra Garret"
"Terra Jarret"
"Tessa Basset"
"Tessa Rasset"
"Tia Hait"
"Tim Smit"
"Toni Minot"
"Tracee Cart"
"Tressa Gassert"
"Tressie Weissert"
"Troy Ort"
"Wade Daw"
"Yetta Battey"
"Yetta Mattey"
"Yevette Vey"
"Yoko Koy"
"Yuki Kuy"
"Zaida Diaz"
"Zena Llanez"
"Zita Batiz"
"Zoe Oz"
"Zula Luz"

table of random palindrome lastfirst names
randtxt
"Adelizzi, Leda"
"Adels, Leda"
"Ader, Freda"
"Adle, Zelda"
"Adler, Elda"
"Adling, Nilda"
"Adner, Brenda"
"Adney, Enda"
"Ady, Lyda"
"Agle, Helga"
"Ahsan, Asha"
"Ahsing, Nisha"
"Aikins, Nikia"
"Ailes, Elia"
"Airola, Loria"
"Akima, Tamika"
"Alesi, Gisela"
"Ali, Cecila"
"Ali, Lila"
"Ali, Mila"
"Alice, Cecila"
"Alimo, Mila"
"Aline, Nila"
"Allen, Ella"
"Alley, Ella"
"Aloisi, Ola"
"Amell, Ema"
"Amill, Ima"
"Ammer, Emma"
"Amonette, Noma"
"Amons, Noma"
"Amoroso, Roma"
"Amory, Roma"
"Anand, Nana"
"Anast, Sana"
"Anawalt, Lawana"
"Anawaty, Tawana"
"Andel, Edna"
"Ander, Edna"
"Andes, Edna"
"Anelli, Willena"
"Anes, Ena"
"Anesi, Sena"
"Anez, Ena"
"Anidi, Dina"
"Anis, Ina"
"Arai, Kiara"
"Arakawa, Kara"
"Aramini, Mara"
"Arata, Tara"
"Arato, Tara"
"Ard, Isidra"
"Arden, Edra"
"Ardis, Isidra"
"Arevalo, Lavera"
"Ariaza, Ira"
"Arico, Cira"
"Arie, Keira"
"Arif, Ira"
"Arimoto, Mira"
"Aris, Ira"
"Armato, Tamra"
"Aroca, Cora"
"Aron, Elenora"
"Arone, Nora"
"Arons, Nora"
"Asif, Isa"
"Aslett, Elsa"
"Asley, Elsa"
"Ater, Greta"
"Aveni, Neva"
"Avenoso, Neva"
"Aver, Treva"
"Averette, Reva"
"Avery, Reva"
"Avie, Iva"
"Avis, Iva"
"Axel, Alexa"
"Bela, Caleb"
"Borg, Rob"
"Brehm, Herb"
"Camara, Mac"
"Camilli, Mac"
"Cassio, Issac"
"Darby, Brad"
"Datz, Tad"
"Deneen, Ed"
"Deneke, Ned"
"Deng, Ned"
"Depp, Ed"
"Dora, Jarod"
"Dorff, Rod"
"Dorn, Rod"
"Dornon, Rod"
"Dotolo, Tod"
"Drane, Lenard"
"Dua, Maud"
"Earl, Rae"
"Edie, Heide"
"Edu, Jude"
"Eid, Edie"
"Eisler, Elsie"
"Eisley, Elsie"
"Ekin, Ike"
"Eli, Cecile"
"Elia, Maile"
"Elleby, Belle"
"Ellena, Janelle"
"Ely, Kyle"
"Emore, Jerome"
"Eron, Elenore"
"Esler, Else"
"Etter, Everette"
"Gramm, Marg"
"Guo, Doug"
"Halik, Akilah"
"Halima, Kamilah"
"Hano, Jonah"
"Haro, Norah"
"Hnat, Anh"
"Hsi, Tish"
"Iburg, Rubi"
"Ilse, Lesli"
"Iman, Ami"
"Imoto, Tomi"
"Issacs, Cassi"
"Kral, Clark"
"Kramm, Mark"
"Lahr, Hal"
"Lama, Jamal"
"Laman, Amal"
"Lamarr, Amal"
"Lamm, Al"
"Laro, Coral"
"Larock, Coral"
"Laselle, Sal"
"Lavy, Val"
"Law, Al"
"Leban, Abel"
"Leban, Anabel"
"Ledo, Del"
"Lemelle, Mel"
"Leone, Noel"
"Leonette, Noel"
"Leong, Noel"
"Lerra, Darrel"
"Leuga, Raguel"
"Levra, Marvel"
"Leza, Hazel"
"Li, Cecil"
"Li, Gil"
"Lieng, Neil"
"Lim, Emil"
"Llera, Darell"
"Lorr, Errol"
"Losada, Sol"
"Losh, Sol"
"Lua, Raul"
"Maday, Adam"
"Mapp, Pam"
"Marban, Abram"
"Mari, Hiram"
"Mash, Sam"
"Mikasa, Kim"
"Mott, Tom"
"Muta, Tatum"
"Naidoo, Dian"
"Naidu, Dian"
"Naik, Ian"
"Naill, Ian"
"Nair, Brian"
"Naji, Jan"
"Nall, Ellan"
"Namur, Truman"
"Nau, Juan"
"Navarra, Van"
"Navin, Ivan"
"Nay, Ryan"
"Neel, Ileen"
"Nell, Allen"
"Neller, Ellen"
"Nero, Loren"
"Neve, Keven"
"Newell, Ewen"
"Niles, Elin"
"No, Son"
"Noda, Don"
"Noe, Deon"
"Noh, Shon"
"Nojiri, Jon"
"Nola, Lon"
"Noll, Lon"
"Nolt, Lon"
"Nord, Ron"
"Notley, Elton"
"Novel, Evon"
"Novell, Evon"
"Nuse, Sun"
"Nush, Sun"
"Nybo, Robyn"
"Obama, Bo" [ha ha ha no really it's the former White House dog]
"Ord, Isidro"
"Osawa, So"
"Ott, Otto"
"Pike, Kip"
"Rama, Jamar"
"Rama, Lamar"
"Rama, Tamar"
"Ramos, Omar"
"Rase, Cesar"
"Rebman, Amber"
"Reh, Cher"
"Remley, Elmer"
"Remo, Homer"
"Remos, Omer"
"Reys, Yer"
"Rial, Blair"
"Rolff, Flor"
"Rona, Eleanor"
"Rover, Trevor"
"Sailer, Elias"
"Sallade, Dallas"
"Samo, Tomas"
"Sano, Jonas"
"Sele, Les"
"Self, Les"
"Selz, Les"
"Seng, Agnes"
"Seniff, Ines"
"Sidor, Odis"
"Siller, Ellis"
"Sina, Janis"
"Sircy, Cris"
"Sirin, Iris"
"Sirko, Kris"
"Siu, Luis"
"Siva, Davis"
"Siva, Mavis"
"Sivak, Avis"
"Sival, Avis"
"Sivan, Avis"
"Sivley, Elvis"
"Soman, Amos"
"Su, Gus"
"Sugiki, Gus"
"Sung, Agnus"
"Tapaha, Pat"
"Tena, Janet"
"Todd, Dot"
"Trass, Art"
"Traut, Stuart"
"Truby, Burt"
"Truka, Kurt"
"Tyo, Hoyt"
"Yamada, May"
"Yeo, Joey"
"Yero, Corey"
"Yerty, Trey"
"Yore, Leroy"
"York, Roy"
"Yu, Guy"
"Zapata, Paz"
"Zill, Liz"

chapter random businesses

table of businesses
biz-name
"Baher's Rehab"
"Colby Bloc"
"Dairy Myriad"
"Derby Bred"
"Goth Tog"
"Layaway Al"
"Le DO-Model"
"Le To-Hotel"
"Llama Mall"
"Looks Skool"
"Med [']Em"
"MRI Firm"
"Pot Stop"
"Potsdam Ad Stop"
"Rife Kefir"
"Seller Elle's"
"Shop O['] H's"
"Skooby Books"
"Stella['] Ballets"
"Stella['] Wallets"
"Tider Credit"
"Tramp Mart"
"Tru-Go Yogurt"
"We Sew"

volume random responses

part the tables

[arranged alphabetically]

table of altbooks
randtxt
"Aiding Nidia"
"Allay Alla"
"Ape Pa"
"Apollo, Pa"
"Ares's Era"
"Co-Data Doc"
"D'oh, Serene, Reshod"
"D'oh, Temp Method"
"Da Ennead"
"Dad, Dad"
"Denny [']N Ned"
"Dew Onuses Unowed"
"Dew, Awed"
"Dew, Owed"
"Dib [']Nuff Unbid"
"Die, Rended Nereid"
"Dif, Firth Triffid"
"Dig ruts? Turgid"
"Dim Anon Amid"
"Dip Such, Cuspid"
"Dip, Arc, Rapid"
"Dip, Ill Lipid"
"Do Banana Bod"
"Do Bozo Bod"
"Do Brewer Bod"
"Do Cede, Cod"
"Do Coo, Cod"
"Do Pacific a Pod"
"Do Pay a Pod"
"Do, Gamma God"
"Don Represser Pernod"
"Due Spy Pseud"
"Duo-Ladened Aloud"
"Eat, Roam, Aortae"
"Ebb, Acidic Abbe"
"Ebb, Error Rebbe"
"Emacs Came"
"Eponymy? Nope"
"Fit, O Motif"
"Gigolo Gig"
"If I Had a Hi-Fi"
"A Mardy Drama"
"Me, Lo, Golem"
"Miss a Passim"
"Mo['] Idiom"
"Mr. Owl Worm"
"My Nonacidic Anonym"
"Neil's Lien"
"O Bonobo"
"On In, Nino"
"Otter Amaretto"
"Pa, OAP"
"Re: Gallager"
"Re: Karraker"
"Rise, Aesir"
"Risk Sir"
"Satire Veritas"
"Solo Gigolos"
"Sore Heros"
"Sore Zeros"
"To Oldened Loot"
"Torsos, ROT"
"We Few"
"Wedded Dew"
"Yo Banana Boy"
"Zot: A to Z"

table of attackings
randtxt
"D00d!"
"Dude! Dud."
"Goon! Oog!"
"Harm! Rah!"
"Hood! Ooh!"
"Hurt! Ruh!"
"Knock! Conk!"
"Nae mean."
"Pah! Whap?"
"Pal, SLAP?!"
"Po['] bop!"
"Pop!"
"Pow-op! Pow-op!"
"Regard, rager!"
"Spar? Traps!"
"Spare raps!"
"Tiff. Fit."
"To ire! Riot!"
"Tonk? Not."
"Ye KO? Pokey!"
"Yob! Boy."

table of burnies
randtxt
"Burn! Rub!"
"Igniting, I!"
"Rah! Char!"
"To hot?!"

table of babel babble
randtxt
"App A"
"the day dyad"
"Dresser D"
"E Garage"
"Gnomon G"
"the gomorro-mog"
"H tooth"
"Hoodoo H" [ignore]
"Lotto L"
"Mojo M"
"Muumuu M"
"Tso St"
"Vanillin Av"
"Vasts Av"
"the Were-W"
"Zoo Z"

table of Bond Nob bars
randtxt
"Bar Crab"
"Brewer B"
"Clan ALC"
"Met [']Em"
"MRA Farm"
"Nigh Gin"
"Pat's Tap"
"Pub UP"
"Redic-U-Cider"
"Sara's"
"Scamp Mac's"
"Scene C's"
"Senor One's"
"Shakah's"
"Si's"
"Slack Cal's"
"Smote Tom's"
"Soho's"
"Soto's"
"Spate-Taps"
"Spike-Kip's"
"Struck Curt's"
"Su's"
"Susana-Su's"
"Tipsy Spit"
"Tope Depot"
"Vat Tav[']"
"Zara'z"
"Zorro'z"
"Zuzu'z"

[this may be related to Yuge battle cries, but the Diktat Kid insults you. The Yuge Guy puffs himself up.]
table of diktat taunts
randtxt
"Ahahahahahaha!"
"Be EW, dweeb!"
"Da bad! Da BAD!! DA BAD!!!"
"Dire! Rid!"
"Dude(tte)! Dud!"
"Duh, THUD!"
"El Bat-able!"
"Hah!"
"LOLOLOLOL!"
"Medicide'm!"
"Mess [']em!"
"Net foe, often!"
"Noogie! I, goon!"
"Noose soon!"
"Ok, TKO!"
"Peewee, weep!"
"Poorer! Oop!"
"Rah! Thar!"
"Resoldered loser!"
"Rofl! For..."
"Sux?! US?!"
"A tarred errata!"
"Tot!"
"ZAP, spaz!"

table of King Nik ancestors
randtxt
"Iolo I"
"Isais I"
"Isis I"
"Ivana VI"
"Ivette VI"
"Ivy VI"
"Vi V"
"Vi XIV"
"Vic IV"
"Vikki V"
"Vin IV"
"Xene X"
"Xia IX"
"Xiara IX"
"Xiu IX"

table of Moo Room animals
randtxt
"a buck cub"
"a go-here hog"
"a pirana (RIP)"
"a rat avatar"
"a red darer adder"
"reedy deer"
"sab mambas"
"sewed ewes"
"sewer ewes"
"ska yaks"
"smarm rams"
"smart rams"
"sum emus"
"a tart rat"
"an un-gnu"

table of My Gym songs
randtxt
"Ai, Tia"
"Ail, Emelia"
"Air Aria"
"All Illa[']"
"[']Allo, Dolla[']"
"Bebe B"
"Belle B"
"Darin['], I, RAD"
"Diana, I'd"
"Diva David"
"Do Mo['] Mod"
"El Tootle"
"Emote to Me"
"Er, AWARE"
"Ghosts, Oh, G"
"Gots To, G"
"H/T Fifth"
"H/T Ninth"
"Hat-stah"
"Honor On, Oh"
"Hook, Ooh"
"Hosts, Oh"
"Jesse J"
"Jojo J"
"Khalilah K"
"Koko K"
"Krew Twerk"
"LA's Reversal"
"Lana L"
"Le BE Rebel"
"LFO ROFL"
"Lulu L"
"Major Pro Jam"
"Manic in AM"
"Maybe By AM"
"Me: Opt, Poem"
"Miff [']Im"
"Mikki M"
"Miss [']Im"
"Morph Prom"
"Mug [']Um"
"Muh Chum"
"No, hon"
"O, Got to Go"
"O/T: Teh Ghetto"
"Ode: Dude, DO"
"Opera Repo"
"Or BE, Bro"
"Park Rap"
"Petite P"
"Playa LP"
"Po['] Pop"
"Pump 'M Up"
"Punk'N Up"
"Rap Spar"
"Rev [']Er"
"Rev [']Er Ever"
"Rikki R"
"See Lee's"
"Set-a-Dates"
"Set-a-Mates"
"So-BS ASBOS"
"SOBs['] ASBOs"
"Sum Us"
"Sun Is in Us"
"Sun on Us"
"Tae Beat"
"Tae Heat"
"Tha H/T"
"Thoro['] H/T"
"Tia, Wait"
"To Own: WOOT"
"To Sap a Sot"
"Too Fab Afoot"
"Wanna W"
"We Nab Anew"
"Woo Hoo W/"
"Y'All, Ay"
"Y'So Rosy"
"Yen O['] Money"
"Yet a Matey"
"Yo, Beer Free, Boy"
"YOLO'y"
"Yr. Every"

table of noesies
randtxt
"Dash sad."
"Derided! Ired!"
"Doomy mood?"
"Emo, me."
"EVAR Grave?"
"Fretter? F!"
"Hm. SMH."
"Huh-uh."
"Moody? Doom!"
"No way? Aw, ON!"
"Nuh-uh-un[']!"
"One no."
"Oo! Noo!"
"Poor droop."
"Too 'boohoo?' Boot!"
"Woe meow."
"Ye po['] mopey!"
"Ye Po['] Nopey."

table of nothings
randtxt
"Drown, word!"
"Dud!"
"Eh, the..."
"Hey! Eh?"
"Huh?"
"It? Nah, anti."
"Lapses, pal?"
"Line? Nil."
"Meh. Ahem!"
"Minim..."
"Mum?"
"No peep on?"
"One mime? NO!"
"Peep?!"
"POST, sop!"
"Spill, lips!"
"Too moot."
"Verb! Rev!"
"Ya, no! Nay!"
"Yo! Coy?"

table of Ms Ism pals
randtxt
"Able Melba"
"Aglow Olga"
"Akin Anika"
"'Alerts' Estrela"
"Alleging Nigella"
"Ally Dylla"
"Amiss Ima"
"Ammo Momma"
"Anigh Gina"
"Avid Iva"
"Eel Annalee"
"Eel Azalee"
"Elegant Nagele"
"Even Eve"
"Gemini Meg"
"Grammam Marg"
"Iller Elli"
"Irate Tari"
"'Ire' Geri"
"'Ire' Keri"
"'Ire' Teri"
"Janelle [']N AJ"
"Liv EVIL"
"'Lyre' Beryl"
"New Gwen"
"Ol['] Flo"
"Ordered Ro"
"Refine Jenifer"
"Tacy Cat"
"USA Su"
"Vile Liv"
"Yenta Oatney"
"Zulu Luz"

table of rejected kid sidekicks
randtxt
"Abler Elba"
"Accorded Rocca"
"ADHD A"
"Anon A"
"Arid Ira"
"Arne NRA"
"'Aroma' Zamora"
"ASAP Asa"
"Asset Tessa"
"Awake Kawa"
"Balla['] B"
"Bazza B"
"Best Seb"
"Blank'n Alb"
"Bloke Kolb"
"Boca Jacob"
"Booky Koob"
"Boyd Yob"
"Bozo B"
"Brony Norb"
"Cement Nemec"
"Crybaby R. C."
"Der Fred"
"DETH Ted"
"'Die' Reid"
"'Diss' Sid"
"'Dragnet' Engard"
"Drone Nord"
"eBay Abe"
"Eel Klee"
"Eelworm Rowlee"
"'Effort' Roffe"
"'Egresses' Serge"
"Emil Slime"
"Evan Knave"
"Evil Clive"
"Flag Alf"
"Flak Alf"
"Flan Alf"
"Flat Alf"
"Flax Alf"
"G-Nixing"
"Gaga G"
"Gazza G"
"'Gimme' Hemmig"
"'Gnaw' Hwang"
"'Gnaw' Kwang"
"Gnawy Wang"
"Goniffin['] Og"
"'Gorses' Rog"
"Gory Rog"
"Guru G"
"Gyppy G"
"Hat Ptah"
"Hobo H"
"Jefe J"
"Kazoo Zak"
"Lamin['] Animal"
"Lass Sal"
"Lax Al"
"Led Adel"
"'Leer' Creel"
"Legal Slagel"
"Legit Igel"
"Lesser Tressel"
"'Lice' Cecil"
"Loco L"
"Loopy Al Claypool"
"Lost Sol"
"Mad Adam"
"'Many' Bynam"
"Melee Lem"
"Melt-It Lem"
"Mildewed Lim"
"Mini-M" [ignore]
"Mofo M"
"'Mutton' Ottum"
"Namer Freman"
"Nash-San"
"Nasty Tsan"
"Needy Deen"
"'Nets' Osten"
"New Owen"
"Newer Ewen"
"Nino Ronin"
"Nitro-Hortin"
"Noir Brion"
"Nolo Rolon"
"Nomad Damon"
"Norse's Ron"
"Nosier Eison"
"Nosy Tyson"
"Noter Breton"
"Obese Bo"
"'Obsesses' Bo"
"'Oedemas' Amedeo"
"Oily Lio"
"Okay Ayako"
"Okinawa Niko"
"Okra Marko"
"Omen Emo"
"'On-us' Tatsuno"
"'One' Geno"
"Osiris O"
"Otaku Kato"
"Ozzie Izzo"
"Peewee P"
"Potato P"
"Presser P"
"Raving Nivar"
"Recluse Sulcer"
"Regal Slager"
"Regarded Rager"
"Reliant Nailer"
"Rely-Tyler"
"'Remarks' Kramer"
"'Renege' Wegener"
"'Rental' Platner"
"Revel Clever"
"Rocco R"
"Rollo R"
"Semi-Deified Imes"
"Semi-Hobo Himes"
"Senior Oines"
"'Tabu' Kubat"
"Tannin['] Nat"
"Tar Prat"
"'Teepee' Peet"
"Tim O['] Vomit"
"Toilless Elliot"
"Tony H. Why-Not"
"'Treble' Delbert"
"'Trebles' Elbert"
"Trekker T"
"Trev Re-Pervert"
"Tru Burt"
"Ur-Dru"
"'Vests' Ev"
"Wazza W"
"Weewee W"
"Wolf Low"
"X Essex"
"Yellow Swolley"
"Yelper Epley"
"'Yelps' Aspley"

table of Rob droning
randtxt
"Analyticity? Lana!"
"Bah! Ahab?!"
"Boone?! Noob!"
"Can Gignac!"
"Cull Luc!"
"Del fled!"
"Draco?! Card."
"E-dude?!"
"Edit-IDE?"
"Enos's one..."
"EOF, Foe!"
"Erase Cesare!"
"Field Leif!"
"Flag Alf!"
"Flay Alf!"
"H/t Emeth!"
"Habit, I? Bah!"
"Hank? Nah."
"Hans? Nah."
"Haw! ... Ah?"
"Hemp? Meh!"
"Hodad! Oh!"
"Hoses! Oh!"
"I: CMD MC, I!"
"Idea-ed, I!"
"If I wifi..."
"J****, EJ!"
"Mail Lilliam..."
"Mod?! ODOM?!"
"More ROM!"
"Nail Elian"
"Nail Lillian"
"Nip Pippin..."
"Phat? STAHP!"
"Piece IP?!"
"Pondered: nOP."
"Posts-op? POST, sop!"
"Posy sysop!"
"Prove VORP!"
"Resume [']m, user!"
"Segard? Rages!"
"SETI sites!"
"Signing is..."
"Spidered IPs?!"
"Steve vets..."
"SuSe? J****!" [ignore]
"[']Tis. Suss it!"
"To ban a bot..."
"Up, CPU!"
"Y-array?!"
"Yale? Delay!"

table of singstuff
randtxt
"Ode? Redo!"
"Rock! Cor!"
"Tone? Not!"
"Tune nut!"
"Yodeled? Oy!"

table of snooty toon ads
randtxt
"Ay, a papaya"
"Fee Beef"
"Food ... oof"
"Hep-met tempeh"
"I/O Poi"
"Mass assam"
"No revile-liver on"
"Nom la salmon"
"Risotto, Sir"
"Salad (alas)"
"Sup Opus"

[?? tafl.py sort so parentheses as well as a/an/the don't affect alphabetization]
table of swearstuff
randtxt
"(R)rude! Dur(r)!"
"Bad? A dab!"
"Dammit, I'm mad!"
"Dark. Rad!"
"Delivery: reviled!"
"Grunt'n! Urg!"
"Guff! Ug!"
"Harp! Rah!"
"Hell, eh?"
"Hoot! Ooh!"
"Hot! Oh!"
"Kook!"
"Not on!"
"Pah, chap!"
"Red? No wonder!"
"Redder... redder..."
"Rep me, temper!"
"Speel? Bleeps."
"Tact, cat!"
"Tic? Illicit."
"Tit!"
"Tut!"
"Ward raw..."
"We mew!"
"Well, EW!"
"Y'booby!"
"Y'kooky?"
"Yap? Ay!"

table of undoings
randtxt
"Ay, CYA."
"Delete-Led!"
"Did. [']Nuff? Undid."
"Did. Error? Redid."
"Dur. Crud."
"Eff a gaffe."
"It: Revert, I!"
"Nixin[']..."
"Or, Perp, REPRO!"
"Pah, simp! Mishap!"
"Pre-derp..."
"Re-deeder."
"Redo'd [']er."
"'Redo-coder! Redo-coder!'"
"Sod [']er! Redos!"
"Time: remit."

table of university targets
randtxt
"Dr. A. Card"
"Dr. A. Fafard"
"Dr. A. Gard"
"Dr. A. Ward"
"Dr. A. Wooward"
"Dr. Aagaard"
"Dr. Allard"
"Dr. E. Herd"
"Dr. Ellerd"
"Dr. I. Bird"
"Dr. O. Ford"
"Dr. O. Lord"
"Dr. Offord"
"Dr. Ord"
"Dr. U. Curd"
"Dr. U. Hurd"
"Dr. Y. Byrd"

table of waittxt
randtxt
"Camp, mac!"
"Deed, deed, deed!"
"Def['] faffed!"
"Do, STAT, sod!"
"Don't nod!"
"Elapses. Pale."
"Gall! Lag!"
"GO, dog!"
"A lag gala!"
"Mull! Um..."
"Nix ALERT. Relaxin[']!"
"No gig on?"
"Now? On!"
"Pal...flap!"
"Panic? I nap!"
"Pas ASAP!"
"Porer-op!"
"A rests era!"
"Resume, muser!" [okdup]
"Rev, O Rover!"
"Sod dos."
"Stare? Rats!"
"Stir! It's..."
"Task: SAT!"
"Truce, curt."
"Wait! I ... aw ..."
"Wandered? Naw."
"We nap anew."
"Won't, Now."
"Y'revery!" [ignore]
"Yon! Oy!"
"Zen? E-Z!"

table of wordy drow laments
randtxt
"Deity...tied!"
"Die, id!"
"Direr id!"
"Ebb? Be!"
"Eh, Tithe!"
"Guts, TUG!"
"Id-egged, I"
"Lama? Mal!"
"Nag a Pagan"
"No Sin is On!"
"Onan? A no!"
"Sad as..."
"Sin, I? Finis!"
"Sob! Mild Limbos!"
"Sog, Ebb, Egos!"
"Sue Zeus?!"
"Want? Naw!"

table of yessies
randtxt
"Hosannas, Oh!"
"Laud-ual!"
"Mirth? Trim!"
"Nod on!"
"Ooh, aye! Yahoo!"
"Pep!"
"Pip, pip!"
"Plus? Ulp."
"Too woot!"
"Wahoo! Haw!"
"Yay!"

table of yuge baits
randtxt
"BOO, NOOB!"
"Dim, I! Timid!"
"EY, BYE!"
"LOW AWOL!"
"Oft GTFO!"
"Ole! Lo!"
"PEER?! CREEP!"
"TRAWL, WART!"
"Y'lily!"

table of yuge battle cries
randtxt
"A-lists? I? La!"
"At a Hata[']!"
"Bilk-Lib!"
"Bosh, SOB!"
"Dig Id!"
"Drat, O Dotard!"
"El bannable!"
"Ere me, MERE!"
"EVAR crave!"
"Ey, dye?!"
"Gibe! Big!"
"Hog, oh!"
"Huge! Guh!"
"I B FBI!"
"I'm Too ... TMI!"
"Imam, I!"
"Iz no Ponzi!"
"KJU? J/k!"
"Maga'M!"
"Main, I am!"
"ME!!!! Haw. Ahem."
"Me, DEM?!" [okdup]
"Me: sees [']em!"
"Misdeeds? I'm ..."
"MLM! MLM! MLM!"
"Moobs: BOOM!"
"MSM?! MSM!"
"[']N I WIN!"
"Name: HE-MAN!"
"Nem O['] women!"
"Nil Appalin[']!"
"No con, no con!"
"Null [']un!"
"Odd-*** Saddo!" [ignore]
"Oh, BHO!"
"OK! Cis! Sicko!"
"On U! Y U no..."
"One Garage? No!"
"Ooh...shoo!"
"Pal! Clap!"
"Pal, rub burlap!"
"A papa! A papa!"
"Perform'r of REP!"
"Rail, Liar!"
"Re-sold LOSER!"
"ROB ALL LABOR!"
"Rug?! Ur..."
"So, PoS!"
"So-sos!"
"Soros! Soros!"
"Sue Me?! Us?!"
"Taft?! FAT!"
"Tariff? I? Rat!"
"Tases at..."
"Tawt?! WAT?!"
"Wane? Naw!"
"Y'r Dry!"
"Ye no-money!" [okdup]
"Yoink'n, I! Oy!"
"You! Oy!"

Ailihphilia Tables ends here.

---- DOCUMENTATION ----
