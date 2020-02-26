################################################################################
# File: ActionModify.rb                                                                #
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
# * +applyAction+ - Modify an existing bridge
# * +applyOpposite+ - Modify a bridge as the opposite of the action
##
class ActionCreate
    attr_reader :x,:y,:grid

    ##
    # The class' constructor.
    def initialize(x,y,grid)
        @x = x
        @y = y
        @grid = grid
    end

    ##
    # Create a bridge between two islands
    #
    # ===== Return
    # return true
    # ---
    def applyAction
        grid.changeBridge(@x,@y)
        return true
    end

    ##
    # Destroy a bridge between two islands
    #
    # ===== Return
    # return true
    # ---
    def applyOpposite
        return true
    end
end