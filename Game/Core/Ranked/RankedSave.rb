################################################################################
# File: RankedSave.rb                                                          #
# Project: Hashi                                                               #
# File Created: Friday, 10th April 2020 2:17:46 pm                             #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Sunday, 12th April 2020 5:07:26 pm                            #
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
class RankedSave < SaveObject
    @@dirPath = "Ranked/"

    def RankedSave.getFilePath(levelNumber)
        return @@dirPath + levelNumber.to_s
    end
end
