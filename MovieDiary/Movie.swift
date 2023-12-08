import Foundation
import GRDB

struct MovieData {
    var dbPath: String = ""
    var dbResourcePath: String = ""
    var config = Configuration()
    let fileManager = FileManager.default
    
    var movies: [Movie] = []

    mutating func loadFromDatabase() {
        connect2DB()
        readDBSONG()
    }

    mutating func connect2DB() {
        config.readonly = true
        do {
            dbPath = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("moviedatabse.db")
                .path
            if !fileManager.fileExists(atPath: dbPath) {
                dbResourcePath = Bundle.main.path(forResource: "moviedatabse", ofType: "db")!
                try fileManager.copyItem(atPath: dbResourcePath, toPath: dbPath)
            }
        } catch {
            print("An error has occurred")
        }
    }

    mutating func readDBSONG() {
        do {
            let dbQueue = try DatabaseQueue(path: dbPath, configuration: config)

            try dbQueue.inDatabase { db in
                let rows = try Row.fetchCursor(db, sql: "SELECT * FROM movie")
                while let row = try rows.next() {
                    let movie = Movie(
                        id: row["movieid"],
                        title: row["moviename"],
                        director: row["director"],
                        image: row["moviepic"],
                        genre: row["moviegenre"],
                        releaseDate: row["movieyear"],
                        precis: row["movieprecis"]
                    )
                    movies.append(movie)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Movie: Codable{
    var id:Int
    var title: String
    var director: String
    var image: String
    var genre: String
    var releaseDate: String
    var precis: String
}









let movies = [
        
        Movies(title: "Jaws: The Revenge", director: "Joseph Sargent", imageName: "jaws4", genre: "Adventure", releaseDate: "1987",precis: "Chief Brody's widow believes that her family is deliberately being targeted by another shark in search of revenge."),

        Movies(title: "Jaws 3-D", director: "Joe Alves", imageName: "jaws3", genre: "Adventure", releaseDate: "1983",precis: "A giant thirty-five-foot shark becomes trapped in a SeaWorld theme park and it's up to the sons of police chief Brody to rescue everyone."),

        Movies(title: "Jaws 2", director: "Jeannot Szwarc", imageName: "jaws2", genre: "Adventure", releaseDate: "1978",precis: "Police chief Brody must protect the citizens of Amity after a second monstrous shark begins terrorizing the waters."),
        Movies(title: "Jurassic World Dominion", director: "Colin Trevorrow", imageName: "jurassicworld3", genre: "Adventure", releaseDate: "2022",precis: "Four years after the destruction of Isla Nublar, Biosyn operatives attempt to track down Maisie Lockwood, while Dr Ellie Sattler investigates a genetically engineered swarm of giant insects."),
        Movies(title: "Jurassic World: Fallen Kingdom", director: "J.A. Bayona", imageName: "jurassicworld2", genre: "Adventure", releaseDate: "2018",precis: "When the island's dormant volcano begins roaring to life, Owen and Claire mount a campaign to rescue the remaining dinosaurs from this extinction-level event."),
        Movies(title: "Jurassic Park III", director: "Joe Johnston", imageName: "jurassicpark3", genre: "Adventure", releaseDate: "2001",precis: "A decidedly odd couple with ulterior motives convince Dr. Grant to go to Isla Sorna for a holiday, but their unexpected landing startles the island's new inhabitants."),
        Movies(title: "The Lost World: Jurassic Park", director: "Steven Spielberg", imageName: "jurassicpark2", genre: "Adventure", releaseDate: "1997",precis: "A research team is sent to the Jurassic Park Site B island to study the dinosaurs there, while an InGen team approaches with another agenda."),
        Movies(title: "Jurassic Park", director: "Steven Spielberg", imageName: "jurassicpark1", genre: "Adventure", releaseDate: "1993",precis: "A pragmatic paleontologist touring an almost complete theme park on an island in Central America is tasked with protecting a couple of kids after a power failure causes the park's cloned dinosaurs to run loose."),
        Movies(title: "The Matrix", director: "Lana Wachowski,Lilly Wachowski", imageName: "thematrix", genre: "Action", releaseDate: "1999",precis: "When a beautiful stranger leads computer hacker Neo to a forbidding underworld, he discovers the shocking truth-the life he knows is the elaborate deception of an evil cyber-intelligence."),
        Movies(title: "Top Gun", director: "Tony Scott", imageName: "topgun", genre: "Drama", releaseDate: "1986",precis: "As students at the United States Navy's elite fighter weapons school compete to be best in the class, one daring young pilot learns a few things from a civilian instructor that are not taught in the classroom."),
        Movies(title: "Flipped", director: "Rob Reiner", imageName: "flipped", genre: "Romance", releaseDate: "2010",precis: "Two eighth-graders start to have feelings for each other despite being total opposites."),

        Movies(title: "Harry Potter and the Deathly Hallows: Part 2", director: "David Yates", imageName: "harrypotter7part2", genre: "Fantasy", releaseDate: "2011",precis: "Harry, Ron, and Hermione search for Voldemort's remaining Horcruxes in their effort to destroy the Dark Lord as the final battle rages on at Hogwarts."),
        Movies(title: "Harry Potter and the Deathly Hallows: Part 1", director: "David Yates", imageName: "harrypotter7", genre: "Fantasy", releaseDate: "2010",precis: "As Harry, Ron and Hermione race against time and evil to destroy the Horcruxes, they uncover the existence of the three most powerful objects in the wizarding world: the Deathly Hallows."),
        Movies(title: "Harry Potter and the Half-Blood Prince", director: "David Yates", imageName: "harrypotter6", genre: "Fantasy", releaseDate: "2009",precis: "As Harry Potter begins his sixth year at Hogwarts, he discovers an old book marked as the property of the Half-Blood Prince and begins to learn more about Lord Voldemort's dark past."),
        Movies(title: "Harry Potter and the Order of the Phoenix", director: "David Yates", imageName: "harrypotter5", genre: "Fantasy", releaseDate: "2007",precis: "With their warning about Lord Voldemort's return scoffed at, Harry and Dumbledore are targeted by the Wizard authorities as an authoritarian bureaucrat slowly seizes power at Hogwarts."),
        Movies(title: "Harry Potter and the Goblet of Fire", director: "Mike Newell", imageName: "harrypotter4", genre: "Fantasy", releaseDate: "2005",precis: "Harry Potter finds himself competing in a hazardous tournament between rival schools of magic, but he is distracted by recurring nightmares."),
        Movies(title: "Harry Potter and the Prisoner of Azkaban", director: "Alfonso Cuarón", imageName: "harrypotter3", genre: "Fantasy", releaseDate: "2004",precis: "Harry Potter, Ron and Hermione return to Hogwarts School of Witchcraft and Wizardry for their third year of study, where they delve into the mystery surrounding an escaped prisoner who poses a dangerous threat to the young wizard."),
        Movies(title: "Harry Potter and the Chamber of Secrets", director: "Chris Columbus", imageName: "harrypotter2", genre: "Fantasy", releaseDate: "2002",precis: "An ancient prophecy seems to be coming true when a mysterious presence begins stalking the corridors of a school of magic and leaving its victims paralyzed."),
        Movies(title: "Harry Potter and the Sorcerer's Stone", director: "Chris Columbus", imageName: "harrypotter1", genre: "Fantasy", releaseDate: "2001",precis: "An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family and the terrible evil that haunts the magical world."),
        Movies(title: "Barbie", director: "Greta Gerwig", imageName: "barbie", genre: "Fantasy", releaseDate: "2023",precis: "Barbie suffers a crisis that leads her to question her world and her existence."),
        Movies(title: "Meg 2: The Trench", director: "Ben Wheatley", imageName: "themeg2", genre: "Horror", releaseDate: "2023",precis: "A research team encounters multiple threats while exploring the depths of the ocean, including a malevolent mining operation."),
        Movies(title: "Me Before You", director: "Thea Sharrock", imageName: "mebeforeyou", genre: "Romance", releaseDate: "2016",precis: "A girl in a small town forms an unlikely bond with a recently-paralyzed man she's taking care of."),
        Movies(title: "Notting Hill", director: "Roger Michell", imageName: "nottinghill", genre: "Romance", releaseDate: "1999",precis: "The life of a simple bookshop owner changes when he meets the most famous film star in the world."),
        Movies(title: "Forrest Gump", director: "Robert Zemeckis", imageName: "forrestgump", genre: "Romance", releaseDate: "1994",precis: "The history of the United States from the 1950s to the '70s unfolds from the perspective of an Alabama man with an IQ of 75, who yearns to be reunited with his childhood sweetheart."),
        Movies(title: "Spider Man : Far From Home", director: "Jon Watts", imageName: "farfromhome", genre: "Comedy", releaseDate: "2019",precis: "Following the events of Avengers: Endgame (2019), Spider-Man must step up to take on new threats in a world that has changed forever."),
        Movies(title: "Captain Marvel", director: "Anna Boden,Ryan Fleck", imageName: "captainmarvel", genre: "Action", releaseDate: "2019",precis: "Carol Danvers becomes one of the universe's most powerful heroes when Earth is caught in the middle of a galactic war between two alien races."),
        Movies(title: "Ant Man and the Wasp", director: "Peyton Reed", imageName: "antman2", genre: "Comedy", releaseDate: "2018",precis: "As Scott Lang balances being both a superhero and a father, Hope van Dyne and Dr. Hank Pym present an urgent new mission that finds the Ant-Man fighting alongside The Wasp to uncover secrets from their past."),
        Movies(title: "Black Panther", director: "Ryan Coogler", imageName: "blackpanther", genre: "Adventure", releaseDate: "2018",precis: "T'Challa, heir to the hidden but advanced kingdom of Wakanda, must step forward to lead his people into a new future and must confront a challenger from his country's past."),
        Movies(title: "Thor : Ragnarok", director: "Taika Waititi", imageName: "ragnarok", genre: "Comedy", releaseDate: "2017",precis: "Imprisoned on the planet Sakaar, Thor must race against time to return to Asgard and stop Ragnarök, the destruction of his world, at the hands of the powerful and ruthless villain Hela."),
        Movies(title: "Doctor Strange", director: "Scott Derrickson", imageName: "doctorstrange", genre: "Fantasy", releaseDate: "2016",precis: "While on a journey of physical and spiritual healing, a brilliant neurosurgeon is drawn into the world of the mystic arts."),
        Movies(title: "Captain America : Civil War", director: "Anthony Russo,Joe Russo", imageName: "civilwar", genre: "Action", releaseDate: "2016",precis: "Political involvement in the Avengers' affairs causes a rift between Captain America and Iron Man."),

        Movies(title: "Irom Man3", director: "Jon Favreau", imageName: "ironman3", genre: "Action", releaseDate: "2010",precis: "When Tony Stark's world is torn apart by a formidable terrorist called the Mandarin, he starts an odyssey of rebuilding and retribution."),
        Movies(title: "Jaws", director: "Steven Spielberg", imageName: "jaws1", genre: "Adventure", releaseDate: "1975",precis: "When a killer shark unleashes chaos on a beach community off Cape Cod, it's up to a local sheriff, a marine biologist, and an old seafarer to hunt the beast down."),
        Movies(title: "Cast Away", director: "Robert Zemeckis", imageName: "castaway", genre: "Drama", releaseDate: "2000",precis: "A FedEx executive undergoes a physical and emotional transformation after crash landing on a deserted island."),
        Movies(title: "Moonlight", director: "Barry Jenkins", imageName: "moonlight", genre: "Drama", releaseDate: "2016",precis: "A young African-American man grapples with his identity and sexuality while experiencing the everyday struggles of childhood, adolescence, and burgeoning adulthood."),
        Movies(title: "Top Gun: Maverick", director: "Joseph Kosinski", imageName: "topgunmaverick", genre: "Drama", releaseDate: "2022",precis: "After thirty years, Maverick is still pushing the envelope as a top naval aviator, but must confront ghosts of his past when he leads TOP GUN's elite graduates on a mission that demands the ultimate sacrifice from those chosen to fly it."),
        Movies(title: "Oppenheimer", director: "Christopher Nolan", imageName: "oppenheimer", genre: "Drama", releaseDate: "2023",precis: "The story of American scientist, J. Robert Oppenheimer, and his role in the development of the atomic bomb."),
        Movies(title: "The Shape of Water", director: "Guillermo del Toro", imageName: "theshapeofwater", genre: "Drama", releaseDate: "2017",precis: "At a top secret research facility in the 1960s, a lonely janitor forms a unique relationship with an amphibious creature that is being held in captivity."),
        Movies(title: "Green Book", director: "Peter Farrelly", imageName: "greenbook", genre: "Drama", releaseDate: "2018",precis: "A working-class Italian-American bouncer becomes the driver for an African-American classical pianist on a tour of venues through the 1960s American South."),
        Movies(title: "Parasite", director: "Bong Joon Ho", imageName: "parasite", genre: "Drama", releaseDate: "2019",precis: "Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan."),
        Movies(title: "The Meg", director: "Jon Turteltaub", imageName: "themeg", genre: "Horror", releaseDate: "2018",precis: "A group of scientists exploring the Marianas Trench encounter the largest marine predator that has ever existed - the Megalodon."),
        Movies(title: "The Conjuring: The Devil Made Me Do It", director: "Michael Chaves", imageName: "theconjuring3", genre: "Horror", releaseDate: "2021",precis: "The Warrens investigate a murder that may be linked to a demonic possession."),
        Movies(title: "The Conjuring 2", director: "James Wan", imageName: "theconjuring2", genre: "Horror", releaseDate: "2016",precis: "Ed and Lorraine Warren travel to North London to help a single mother raising four children alone in a house plagued by a supernatural spirit."),
        Movies(title: "The Conjuring", director: "James Wan", imageName: "theconjuring1", genre: "Horror", releaseDate: "2013",precis: "Paranormal investigators Ed and Lorraine Warren work to help a family terrorized by a dark presence in their farmhouse."),
        Movies(title: "The Nun II", director: "Michael Chaves", imageName: "thenun2", genre: "Horror", releaseDate: "2023",precis: "1956 - France. A priest is murdered. An evil is spreading. The sequel to the worldwide smash hit follows Sister Irene as she once again comes face-to-face with Valak, the demon nun."),
        Movies(title: "The Nun", director: "Bradley Cooper", imageName: "thenun", genre: "Horror", releaseDate: "2018",precis: "A priest with a haunted past and a novice on the threshold of her final vows are sent by the Vatican to investigate the death of a young nun in Romania and confront a malevolent force in the form of a demonic nun."),
        Movies(title: "A Star Is Born", director: "Bradley Cooper", imageName: "astarisborn", genre: "Comedy", releaseDate: "2018",precis: "A musician helps a young singer find fame as age and alcoholism send his own career into a downward spiral."),
        Movies(title: "The Princess Diaries", director: "Garry Marshall", imageName: "theprincessdiaries", genre: "Comedy", releaseDate: "2001",precis: "Mia Thermopolis has just found out that she is the heir apparent to the throne of Genovia. With her friends Lilly and Michael Moscovitz in tow, she tries to navigate through the rest of her sixteenth year."),
        Movies(title: "Call Me by Your Name", director: "Luca Guadagnino", imageName: "callmebyyourname", genre: "Romance", releaseDate: "2017",precis: "In 1980s Italy, romance blossoms between a seventeen-year-old student and the older man hired as his father's research assistant."),
        Movies(title: "10 Things I Hate About You", director: "Gil Junger", imageName: "abouttime", genre: "Romance", releaseDate: "1999",precis: "A high-school boy, Cameron, cannot date Bianca until her anti-social older sister, Kat, has a boyfriend. So, Cameron pays a mysterious boy, Patrick, to charm Kat."),
        Movies(title: "About Time", director: "Richard Curtis", imageName: "forrestgump", genre: "Romance", releaseDate: "2013",precis: "At the age of 21, Tim discovers he can travel in time and change what happens and has happened in his own life. His decision to make his world a better place by getting a girlfriend turns out not to be as easy as you might think."),
        Movies(title: "Past Lives", director: "Celine Song", imageName: "pastlives", genre: "Romance", releaseDate: "2023",precis: "Nora and Hae Sung, two deeply connected childhood friends, are wrested apart after Nora's family emigrates from South Korea. Twenty years later, they are reunited for one fateful week as they confront notions of love and destiny."),
        Movies(title: "The Purge", director: "James DeMonaco", imageName: "thepurge", genre: "Horror", releaseDate: "2013",precis: "A wealthy family is held hostage for harboring the target of a murderous syndicate during the Purge, a 12-hour period in which any and all crime is legal."),
        Movies(title: "World War Z", director: "Marc Forster", imageName: "worldwarz", genre: "Horror", releaseDate: "2013",precis: "Former United Nations employee Gerry Lane traverses the world in a race against time to stop a zombie pandemic that is toppling armies and governments and threatens to destroy humanity itself."),
        Movies(title: "Mean Girls", director: "Mark Waters", imageName: "meangirls", genre: "Comedy", releaseDate: "2004",precis: "Cady Heron is a hit with The Plastics, the A-list girl clique at her new school, until she makes the mistake of falling for Aaron Samuels, the ex-boyfriend of alpha Plastic Regina George."),
        Movies(title: "The Twilight Saga: Breaking Dawn - Part 2", director: "Bill Condon", imageName: "twilight5", genre: "Fantasy", releaseDate: "2012",precis: "After the birth of Renesmee/Nessie, the Cullens gather other vampire clans in order to protect the child from a false allegation that puts the family in front of the Volturi."),
        Movies(title: "The Twilight Saga: Breaking Dawn - Part 1", director: "Bill Condon", imageName: "twilight4", genre: "Fantasy", releaseDate: "2011",precis: "The Quileutes close in on expecting parents Edward and Bella, whose unborn child poses a threat to the Wolf Pack and the towns people of Forks."),
        Movies(title: "The Twilight Saga: Eclipse", director: "David Slade", imageName: "twilight3", genre: "Fantasy", releaseDate: "2010",precis: "As a string of mysterious killings grips Seattle, Bella, whose high school graduation is fast approaching, is forced to choose between her love for vampire Edward and her friendship with werewolf Jacob."),
        Movies(title: "The Twilight Saga: New Moon", director: "Chris Weitz", imageName: "twilight2", genre: "Fantasy", releaseDate: "2009",precis: "Edward leaves Bella after an attack that nearly claimed her life, and, in her depression, she falls into yet another difficult relationship - this time with her close friend, Jacob Black."),
        Movies(title: "Twilight", director: "Catherine Hardwicke", imageName: "twilight1", genre: "Fantasy", releaseDate: "2008",precis: "When Bella Swan moves to a small town in the Pacific Northwest, she falls in love with Edward Cullen, a mysterious classmate who reveals himself to be a 108-year-old vampire."),
        Movies(title: "Beauty and the Beast", director: "Bill Condon", imageName: "beautyandthebeast", genre: "Comedy", releaseDate: "2017",precis: "A selfish Prince is cursed to become a monster for the rest of his life, unless he learns to fall in love with a beautiful young woman he keeps prisoner."),
        Movies(title: "Spider Man : Homecoming", director: "Jon Watts", imageName: "homecoming", genre: "Comedy", releaseDate: "2017",precis: "How Peter Parker's age and place in life differentiate him from other heroes. It also looks at casting Tom Holland in the lead role and the qualities he brings to the character and the MCU."),
        Movies(title: "Guardians of the Galaxy Vol. 2", director: "James Gunn", imageName: "guardians2", genre: "Comedy", releaseDate: "2017",precis: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father, the ambitious celestial being Ego."),
        Movies(title: "Ant Man", director: "Peyton Reed", imageName: "antman", genre: "Comedy", releaseDate: "2015",precis: "Armed with a super-suit with the astonishing ability to shrink in scale but increase in strength, cat burglar Scott Lang must embrace his inner hero and help his mentor, Dr. Hank Pym, pull off a plan that will save the world."),
        Movies(title: "Guardians of the Galaxy (2014)", director: "James Gunn", imageName: "guardians1", genre: "Comedy", releaseDate: "2014",precis: "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe."),
        Movies(title: "Captain America: The First Avenger", director: "Joe Johnstion", imageName: "captain", genre: "Action", releaseDate: "2011",precis: "Steve Rogers, a rejected military soldier, transforms into Captain America after taking a dose of a Super-Soldier serum. But being Captain America comes at a price as he attempts to take down a warmonger and a terrorist organization."),
        Movies(title: "Thor", director: "Kenneth Branagh", imageName: "thor", genre: "Action", releaseDate: "2011",precis: "The powerful but arrogant god Thor is cast out of Asgard to live amongst humans in Midgard (Earth), where he soon becomes one of their finest defenders."),
        Movies(title: "Ironman2", director: "Jon Favreau", imageName: "ironman2", genre: "Adventure", releaseDate: "2010",precis: "With the world now aware of his identity as Iron Man, Tony Stark must contend with both his declining health and a vengeful mad man with ties to his father's legacy."),
        Movies(title: "The Incredible Hulk", director: "Louis Leterrier", imageName: "hulk", genre: "Adventure", releaseDate: "2008",precis: "Bruce Banner, a scientist on the run from the U.S. Government, must find a cure for the monster he turns into whenever he loses his temper."),
        Movies(title: "Ironman", director: "Jon Favreau", imageName: "ironman", genre: "Adventure", releaseDate: "2008",precis: "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil."),
        Movies(title: "The Avengers", director: "Joss Whedon", imageName: "avengers1", genre: "Action", releaseDate: "2012",precis: "Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity."),
        Movies(title: "Spider-Man: No Way Home", director: "Jon Watts", imageName: "nowayhome", genre: "Adventure", releaseDate: "2021",precis: "With Spider-Man's identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man."),
        Movies(title: "Avengers: Infinity War", director: "Anthony Russo,Joe Russo", imageName: "infinitywar", genre: "Adventure", releaseDate: "2018",precis: "The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe."),
        Movies(title: "Avengers: Endgame", director: "Anthony Russo,Joe Russo", imageName: "endgame", genre: "Adventure", releaseDate: "2019",precis: "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe."),
        Movies(title: "Jurassic World", director: "Colin Trevorrow", imageName: "jurassicworld1", genre: "Adventure", releaseDate: "2015",precis: "A new theme park, built on the original site of Jurassic Park, creates a genetically modified hybrid dinosaur, the Indominus Rex, which escapes containment and goes on a killing spree."),
        Movies(title: "Titanic", director: "James Cameron", imageName: "titanic", genre: "Romance", releaseDate: "1997",precis: "A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic."),
        Movies(title: "DoctorStrage", director: "Scott Derrickson", imageName: "doctorstrange", genre: "Fantasy", releaseDate: "2016",precis: "While on a journey of physical and spiritual healing, a brilliant neurosurgeon is drawn into the world of the mystic arts."),
        Movies(title: "Avatar", director: "James Cameron", imageName: "avatar", genre: "Fantasy", releaseDate: "2009",precis: "A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home."),
        

    ]
