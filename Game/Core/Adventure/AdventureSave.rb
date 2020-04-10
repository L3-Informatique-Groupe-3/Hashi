################################################################################
# File: AdventureSave.rb                                                       #
# Project: Hashi                                                           #
# File Created: Friday, 10th April 2020 2:17:46 pm                             #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Friday, 10th April 2020 2:54:02 pm                            #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require_relative "../SaveObject"

##
# ===== Presentation
# 
# ===== Variables
# * +variableName+ - description
# ===== Methods
# * +myMethod+ - description
##
class AdventureSave < SaveObject
    @@dirPath = "Adventure/"

    def AdventureSave.getFilePath(saveNumber, countryNumber, levelNumber)
        return @@dirPath + saveNumber.to_s + "/" + countryNumber.to_s + "/" + levelNumber.to_s
    end
end
