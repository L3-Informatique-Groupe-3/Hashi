################################################################################
# File: AdventureSave.rb                                                       #
# Project: Hashi                                                           #
# File Created: Friday, 10th April 2020 2:17:46 pm                             #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Tuesday, 14th April 2020 4:37:10 pm                           #
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
# * +AdventureSave.getFilePath+ - Return the file path of a save in terms of the parameters
##
class AdventureSave < SaveObject
    @@dirPath = "Adventure/"

    ##
    # Return the file path of a save in terms of the parameters
    #
    # ===== Attributes
    # * +saveNumber+ - the save number 
    # * +countryNumber+ - the country number 
    # * +levelNumber+ - the level number
    #
    # ===== Return
    # Return the file path of a save
    # ---
    def AdventureSave.getFilePath(saveNumber, countryNumber, levelNumber)
        return @@dirPath + saveNumber.to_s + "/" + countryNumber.to_s + "/" + levelNumber.to_s
    end
end
