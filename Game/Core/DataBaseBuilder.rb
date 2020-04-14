##
# BOUQUET Tristan
#
# This file build all database to save data from the game Hashi
##

#the idMap will be stock like 203 meaning world 2 map 03

require 'sqlite3'
require 'digest'
require 'fileutils'

# Directory creation
FileUtils.mkdir_p(File.expand_path('../../', File.dirname(__FILE__)) + "/Data/")

dbAventure 	= File.expand_path("../../Data/aventure.db", File.dirname(__FILE__))
dbRanked	= File.expand_path("../../Data/ranked.db", File.dirname(__FILE__))
dbRankedTime= File.expand_path("../../Data/rankedTime.db", File.dirname(__FILE__))


if !File.exist?(dbAventure)

	dbAventure 	= SQLite3::Database.new dbAventure


	resultat = dbAventure.execute <<-SQL
		CREATE TABLE IF NOT EXISTS aventure
		(
			idMap INT,
			map VARCHAR(300),
			idSave INT,
			historic VARCHAR(50),

			state VARCHAR(6) CHECK(state IN ('DONE', 'DOING', 'BLOCK')),
			assets VARCHAR(30),

			PRIMARY KEY (idMap, idSave)

		);
	SQL

	#Récupération de la composition de la grille
	readFile = File.open(File.expand_path("../../Assets/Files/Grid/Adventure/AdventureGrid", File.dirname(__FILE__))).to_a
	for k in 1..3
		for i in 1..6
			for j in 1..5
				currentIdMap = i*100+j
				map = readFile.at((i-1)*5+j-1)
				dbAventure.execute("INSERT INTO aventure (idMap, map, idSave, state, assets) VALUES (#{currentIdMap}, '#{map}', #{k}, 'BLOCK', '')")
			end
		end
	end
end

if !File.exist?(dbRanked) || !File.exist?(dbRankedTime) then

	dbRanked 		= SQLite3::Database.new dbRanked
	dbRankedTime	= SQLite3::Database.new dbRankedTime
	
	
	resultat = dbRanked.execute <<-SQL
		CREATE TABLE IF NOT EXISTS ranked
		(
			idMap INT, 
			map VARCHAR(300),
			historic VARCHAR(50),
			
			assets VARCHAR(30),
			
			PRIMARY KEY (idMap)
			
		);
	SQL
	
	resultat = dbRankedTime.execute <<-SQL
		CREATE TABLE IF NOT EXISTS rankedTime
		(
			idMap INT,
			name VARCHAR(300),
			time INT,

			FOREIGN KEY(idMap) REFERENCES ranked(idMap),
			PRIMARY KEY (idMap, name, time)
			
		);
	SQL
	
	#Récupération de la composition de la grille
	readFile = File.open(File.expand_path("../../Assets/Files/Grid/Ranked/RankedGrid", File.dirname(__FILE__))).to_a
	for i in 1..10
		currentIdMap = i
		map = readFile.at(i-1)
		dbRanked.execute("INSERT INTO ranked (idMap, map, assets) VALUES (#{currentIdMap}, '#{map}', '')")
	end
end