##
# BOUQUET Tristan
#
#
##

require 'sqlite3'
require 'digest'
require 'yaml'

##
# ===== Presentation
# This class manipulates the adventure database
#
# ===== Variables
# * +idSave+ - Contain the number of the save used
# * +aventureDB+ - Contain the database of the aventure mod
# * +currentMap+ - Contain the id of the next map the player will play
# * +map+ - Contain the map to play
#
# ===== Methods
# * +Save.access+ - Builder
# * +openDBAventure+ - Return database of aventure
# * +resetDB+ - Delete all informations of the save
# * +loadMap+ - Load the next map to complete
# * +loadAssets+ - Load the assets of the next map
# * +loadHistoric+ - Load the historic of the next map
# * +loadGame+ - Give all informations about a map the player wants to play
# * +createSave+ - Create a new save of the adventure mod if the slot is open
# * +getNextMap+ - Return the id of the next map from the current one
# * +completeMap+ - Change the state of a map to DONE
# * +isLocked+ - Check if the map has the state BLOCK
# * +isLastArea+ - Check if the parameter is the id of the last area and return a boolean
##
class Save

	#=Variables d'instance
	@idSave		  #Contain the number of the save used
	@aventureDB   #Contain the database of the aventure mod
	@currentMap   #Contain the id of the next map the player will play
	@map		  #Contain the map to play


	attr_reader :saveSlot
	attr_reader :currentMap
	attr_reader :progressArea
	attr_reader :map
	attr_reader :idSave

	#== Builder

	def Save.access(aSaveSlot)
		new(aSaveSlot)
	end

	def initialize(aSaveSlot)
		@idSave = aSaveSlot
		@aventureDB = openDBAventure()
	end



	#== Methods

	#Open the database of the aventure mod
	# @return database of aventure
	def openDBAventure()
		return SQLite3::Database.new File.expand_path("../../../Data/aventure.db", File.dirname(__FILE__))

	end

	#Delete all informations of the save
	def resetDB()
		@aventureDB.execute("UPDATE aventure SET state = 'BLOCK', historic = '' WHERE idSave = '#{@idSave}' ")
		@aventureDB.execute("UPDATE aventure SET state = 'DOING' WHERE idSave = '#{@idSave}' AND idMap = 101")
	end

	#Load the next map to complete
	def loadMap()
		@map = @aventureDB.execute("SELECT map FROM aventure WHERE idSave = '#{@idSave}' AND idMap = '#{@currentMap}'").shift.shift
	end

	#Load the assets of the next map
	def loadAssets()
		@assets = @aventureDB.execute("SELECT assets FROM aventure WHERE idSave = '#{@idSave}' AND idMap = '#{@currentMap}'").shift.shift
	end

	#Load the historic of the next map
	def loadHistoric()
		historicName = @aventureDB.execute("SELECT historic FROM aventure WHERE idSave = '#{@idSave}' AND idMap = '#{@currentMap}'").shift.shift
		return historicName
	end

	#Give all informations about a map the player wants to play
	def loadGame(idMap)
		@currentMap = idMap
		loadAssets()
		loadMap()
		historic = loadHistoric()
		arrayDataBase = [@map, @assets, historic]
		return arrayDataBase
	end

	#Create a new save of the adventure mod if the slot is open
	def createSave(historicName)

		@aventureDB.execute("UPDATE aventure historic = '#{historicName}' WHERE idMap = '#{@currentMap}' AND idSave = '#{@idSave}'")

	end

	#Return the id of the next map from the current one
	def getNextMap()
		nextMap = currentMap+1
		if(@aventureDB.execute("SELECT COUNT('#{nextMap}') FROM aventure WHERE idSave = '#{@idSave}' AND idMap = '#{nextMap}'").shift.shift) then
			return (@currentMap+1)
		else
			previousArea = (currentMap / 100)
			if(!(isLastArea(previousArea)))
				nextMap = (previousArea + 1) * 100 + 1
				return nexMap
			else
				return 101
			end
		end
	end

	#Change the state of a map to DONE
	def completeMap()
		@aventureDB.execute("UPDATE aventure SET state = 'DONE'  WHERE idMap = '#{@currentMap}' AND idSave = '#{@idSave}'")
		@aventureDB.execute("UPDATE aventure SET historic = ''  WHERE idMap = '#{@currentMap}' AND idSave = '#{@idSave}'")
		nextMap = getNextMap()
		if(isLocked(nextMap)) then
			@aventureDB.execute("UPDATE aventure SET state = 'DOING' WHERE idMap = '#{nextMap}' AND idSave = '#{@idSave}'")
		end
	end

	#Check if the map has the state BLOCK
	def isLocked(map)
		if(@aventureDB.execute("SELECT COUNT(*) FROM aventure WHERE idSave = '#{@idSave}' AND idMap = '#{map}' AND state!='DONE'").shift.shift == 1) then
			return true
		else
			return false
		end
	end

	#Check if the parameter is the id of the last area and return a boolean
	def isLastArea(area)
		maxArea = ((@aventureDB.execute("SELECT MAX(idMap) FROM aventure").shift.shift) / 100)
		if(maxArea == area)
			return true
		else
			return false
		end
	end

end
