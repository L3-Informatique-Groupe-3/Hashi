##
# BOUQUET Tristan
#
# 
##

require 'sqlite3'
require 'digest'

class Ranked
	#=Variables d'instance
	@rankedDB		#Contain the database of the ranked mod
	@rankedTimeDB	#Contain the database of the time from ranked mod
	@idMap			#Contain the id of the next map the player will play
	@infoMap		#Contain the information from the map to play
	
	
	attr_reader :rankedDB
	attr_reader :rankedTimeDB
	attr_reader :idMap
	attr_reader :map
	
	#== Builder
	
	def Ranked.access()
		new()
	end
	
	def initialize()
		openDBRanked()
	end
	
	
	#== Methods
	
	#Open the database of the ranked mod
	# @return database of rank
	def openDBRanked()
		@rankedDB 		= SQLite3::Database.new File.expand_path('../../../Data/ranked.db', File.dirname(__FILE__))
		@rankedTimeDB 	= SQLite3::Database.new File.expand_path('../../../Data/rankedTime.db', File.dirname(__FILE__))
	end
	
	def loadGame(idMap)
		@idMap = idMap
		@infoMap = [loadMap(), loadHistoric(), loadTime()]
		return @infoMap
	end
	
	
	#Load the map to complete
	def loadMap()
		return @rankedDB.execute("SELECT map FROM ranked WHERE idMap = '#{@idMap}'").shift.shift
	end
	
	#Load the historic of the map
	def loadHistoric()
		return @rankedDB.execute("SELECT historic FROM ranked WHERE idMap = '#{@idMap}'").shift.shift
	end
	
	#Load the time of the map
	def loadTime()
		return @rankedTimeDB.execute("SELECT idMap,name,time FROM rankedTime WHERE idMap = '#{@idMap}' ORDER BY time ASC")
	end
	
	#Save the informations of the player
	def savePlayer(theName, theTime)
		@rankedTimeDB.execute("INSERT INTO rankedTime (name, time, idMap)  VALUES('#{theName}', #{theTime}, #{@idMap})")	
	end
	
	#Delete the informations of the player
	def deletePlayer()
		timeMax = @rankedTimeDB.execute("SELECT MAX(time) FROM rankedTime WHERE idMap = '#{@idMap}'").shift.shift
		@rankedTimeDB.execute("DELETE FROM rankedTime WHERE time = '#{timeMax}'")
		
	end
	
	#Check if the time to complete the map will be saved
	def saveTime?(theName, theTime)
		if(@rankedTimeDB.execute("SELECT COUNT(name) FROM rankedTime WHERE idMap = '#{@idMap}' AND time = '#{theTime}' AND  name = '#{theName}'").shift.shift == 0) then
			if(@rankedTimeDB.execute("SELECT COUNT(name) FROM rankedTime WHERE idMap = '#{@idMap}'").shift.shift < 10) then
				savePlayer(theName, theTime)
				return true
			else
				if(@rankedTimeDB.execute("SELECT MAX(time) FROM rankedTime WHERE idMap = '#{@idMap}'").shift.shift > theTime) then
					deletePlayer()
					savePlayer(theName, theTime)
					return true
				else
					return false
				end
			end
		end
	end
	
end
