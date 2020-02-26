################################################################################
# File: ActionCreate.rb                                                                #
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
# * +x1+ - x coordonate of the first cell
# * +y1+ - y coordonate of the first cell
# * +x2+ - x coordonate of the second cell
# * +y2+ - y coordonate of the second cell
# * +grid+ - Store the grid where the action will be applied
# ===== Methods
# * +applyAction+ - Create a bridge between two islands
# * +applyOpposite+ - Destroy a bridge between two islands
##
class ActionCreate
    attr_reader :x1,:y1,:x2,:y2,:grid

    ##
    # The class' constructor.
    def initialize(x1,y1,x2,y2,grid)
        @x1 = x1
        @y1 = y1
        @x2 = x2
        @y2 = y2
        @grid = grid
    end

    ##
    # Create a bridge between two islands
    #
    # ===== Return
    # return true
    # ---
    def applyAction
        grid.createBridge(@x1,@y1, @x2, @y2)
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