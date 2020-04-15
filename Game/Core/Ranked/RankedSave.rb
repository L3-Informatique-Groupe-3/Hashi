################################################################################
# File: RankedSave.rb                                                          #
# Project: Hashi                                                               #
# File Created: Friday, 10th April 2020 2:17:46 pm                             #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Tuesday, 14th April 2020 4:50:48 pm                           #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require_relative "../SaveObject"

##
# ===== Presentation
# This class is a SaveObject.
#
# ===== Variables
# * +dirPath+ - Directory path of the save
#
# ===== Methods
# * +RankedSave.getFilePath+ - Return the file path of a save in terms of the parameters
##
class RankedSave < SaveObject
    @@dirPath = "Ranked/"

    ##
    # Return the file path of a save in terms of the parameters
    #
    # ===== Attributes
    # * +levelNumber+ - the level number
    #
    # ===== Return
    # Return the file path of a save
    # ---
    def RankedSave.getFilePath(levelNumber)
        return @@dirPath + levelNumber.to_s
    end
end
