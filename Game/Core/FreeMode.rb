################################################################################
# File: FreeMode.rb                                                            #
# Project: Hashi                                                                #
# File Created: Monday, 6th April 2020 2:16:35 pm                              #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Thursday, 9th April 2020 6:25:41 pm                           #
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
end
