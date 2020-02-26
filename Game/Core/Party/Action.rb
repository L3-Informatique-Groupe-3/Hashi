################################################################################
# File: Action.rb                                                                #
# Project: Hashi                                                               #
# File Created: Tuesday, 20th February 2020 11:00:27 am                        #
# Author: <Adrali>Lemaitre P                                                   #
# -----                                                                        #
# Last Modified: Tuesday, 20th February 2020 11:00:27 am                       #
# Modified By: <Adrali>Lemaitre P                                               #
################################################################################

##
# ===== Presentation
#   Cell is a class that define the cell's behaviors
#
# ===== Variables
# * +x+ - x coordonate of the cell
# * +y+ - y coordonate of the cell
# * +grid+ - Store the grid where the action will be applied
# ===== Methods
# * +applyAction+ - Apply an action
# * +applyOpposite+ - Apply the opposite action
##
class ActionCreate
    ##
    # The class' constructor.
    def initialize(x,y,grid)
        @x = x
        @y = y
        @grid = grid
    end

    ##
    # Apply the action
    #
    # ===== Return
    # return true
    # ---
    def applyAction
        return true
    end

    ##
    # Apply the opposite action
    #
    # ===== Return
    # return true
    # ---
    def applyOpposite
        return true
    end
end