################################################################################
# File: FreeMode.rb                                                            #
# Project: Hashi                                                                #
# File Created: Monday, 6th April 2020 2:16:35 pm                              #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Tuesday, 14th April 2020 5:14:29 pm                           #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require_relative "./SaveObject"

##
# ===== Presentation
# This class manages the free mode.
#
# ===== Variables
# * +mode+ - All available mode
# * +filePath+ - Save path
# * +gridPath+ - Grid path
# * +grids+ - All grids of the free mode
#
# ===== Methods
# * +FreeMode.hasSave+ - Return true if the mode has a save
# * +FreeMode.loadSave+ - Return the save for a specified mode if it exists, nil if not
# * +FreeMode.save+ - Save the party for a specified mode
# * +FreeMode.delete+ - Delete the save for a specified mode
# * +FreeMode.getNewGrid+ - Return a random grid for a specified mode
# * +FreeMode.getGrids+ - Return the grids of the file for a specified mode
##
class FreeMode
    @@mode = [:easy, :medium, :difficult]

    @@filePath = {
        @@mode[0] => "freeMode/easy",
        @@mode[1] => "freeMode/medium",
        @@mode[2] => "freeMode/difficult"
    }

    @@gridPath = {
        @@mode[0] => File.expand_path('../../Assets/Files/Grid/FreeMode/Easy', File.dirname(__FILE__)),
        @@mode[1] => File.expand_path('../../Assets/Files/Grid/FreeMode/Medium', File.dirname(__FILE__)),
        @@mode[2] => File.expand_path('../../Assets/Files/Grid/FreeMode/Difficult', File.dirname(__FILE__))
    }

    @@grids = Hash.new

    ##
    # Return true if the mode has a save
    #
    # ===== Attributes
    # * +mode+ - The mode
    #
    # ===== Return
    # Return true if the mode has a save
    # ---
    def FreeMode.hasSave(mode)
        if(@@filePath.has_key?(mode))
            return SaveObject.hasSave(@@filePath[mode])
        end
        return false
    end

    ##
    # Return the save for a specified mode if it exists, nil if not
    #
    # ===== Attributes
    # * +mode+ - The mode
    #
    # ===== Return
    # Return the save for a specified mode if it exists, nil if not
    # ---
    def FreeMode.loadSave(mode)
        if(FreeMode.hasSave(mode))
            return SaveObject.loadSave(@@filePath[mode])
        end

        return nil
    end

    ##
    # Save the party for a specified mode
    #
    # ===== Attributes
    # * +mode+ - The mode
    # * +party+ - The party
    #
    # ===== Return
    # Return true if no error
    # ---
    def FreeMode.save(mode, party)
        if(@@filePath.has_key?(mode) && party != nil)
            return SaveObject.save(@@filePath[mode], party)
        end
        return false
    end

    ##
    # Delete the save for a specified mode
    #
    # ===== Attributes
    # * +mode+ - The mode
    # ---
    def FreeMode.delete(mode)
        if(@@filePath.has_key?(mode))
            SaveObject.delete(@@filePath[mode])
        end
    end

    ##
    # Return a random grid for a specified mode
    #
    # ===== Attributes
    # * +mode+ - The mode
    #
    # ===== Return
    # Return a grid
    # ---
    def FreeMode.getNewGrid(mode)
        if(! @@grids.has_key?(mode))
            @@grids[mode] = FreeMode.getGrids(mode)
        end

        randLine = Random::DEFAULT.rand(@@grids[mode].size)

        return @@grids[mode][randLine]
    end

    ##
    # Return the grids of the file for a specified mode 
    #
    # ===== Attributes
    # * +mode+ - The mode
    #
    # ===== Return
    # Return the grids
    # ---
    def FreeMode.getGrids(mode)
        file = File.open(@@gridPath[mode])
        grids = file.readlines.map(&:chomp)
        file.close

        return grids
    end
end
