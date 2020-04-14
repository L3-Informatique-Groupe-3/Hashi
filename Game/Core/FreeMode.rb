################################################################################
# File: FreeMode.rb                                                            #
# Project: Hashi                                                                #
# File Created: Monday, 6th April 2020 2:16:35 pm                              #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Tuesday, 14th April 2020 3:47:06 pm                           #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require_relative "./SaveObject"

##
# ===== Presentation
#
# ===== Variables
# * +variableName+ - description
# ===== Methods
# * +myMethod+ - description
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

    def FreeMode.hasSave(mode)
        if(@@filePath.has_key?(mode))
            return SaveObject.hasSave(@@filePath[mode])
        end
        return false
    end

    def FreeMode.loadSave(mode)
        if(FreeMode.hasSave(mode))
            return SaveObject.loadSave(@@filePath[mode])
        end

        return nil
    end

    def FreeMode.save(mode, party)
        if(@@filePath.has_key?(mode) && party != nil)
            return SaveObject.save(@@filePath[mode], party)
        end
        return false
    end

    def FreeMode.delete(mode)
        if(@@filePath.has_key?(mode))
            SaveObject.delete(@@filePath[mode])
        end
    end

    def FreeMode.getNewGrid(mode)
        if(! @@grids.has_key?(mode))
            @@grids[mode] = FreeMode.getGrids(mode)
        end

        randLine = Random::DEFAULT.rand(@@grids[mode].size)

        return @@grids[mode][randLine]
    end

    def FreeMode.getGrids(mode)
        file = File.open(@@gridPath[mode])
        grids = file.readlines.map(&:chomp)
        file.close

        return grids
    end
end
