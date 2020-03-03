################################################################################
# File: ActionCreate.rb                                                                #
# Project: Hashi                                                               #
# File Created: Tuesday, 20th February 2020 11:00:27 am                        #
# Author: <Adrali>Lemaitre P                                                   #
# -----                                                                        #
# Last Modified: Tuesday, 20th February 2020 11:00:27 am                       #
# Modified By: <Adrali>Lemaitre P                                               #
################################################################################

require "./Action"

##
# ===== Presentation
# ActionCreate is an Action.
# Represents the action of the player when he create a bridge between to IslandCells
#
# ===== Variables
# * +x1+ - x coordonate of the first cell
# * +y1+ - y coordonate of the first cell
# * +x2+ - x coordonate of the second cell
# * +y2+ - y coordonate of the second cell
# ===== Methods
# * +applyAction+ - Create a bridge between two islands
# * +applyOpposite+ - Destroy a bridge between two islands
##
class ActionCreate < Action
    @x1
    @y1
    @x2
    @y2

    attr_reader :x1,:y1,:x2,:y2,:grid #:nodoc:

    ##
    # The class' constructor.
    #
    # ===== Attributes
    # * +grid+ - The grid where the action will be applied 
    # * +x1+ - x coordonate of the first cell
    # * +y1+ - y coordonate of the first cell
    # * +x2+ - x coordonate of the second cell
    # * +y2+ - y coordonate of the second cell
    # ---
    def initialize(grid, x1, y1, x2, y2)
        super(grid)
        @x1 = x1
        @y1 = y1
        @x2 = x2
        @y2 = y2
    end

    ##
    # Create a bridge between two islands
    #
    # ===== Return
    # return true if the action have been made, else false
    # ---
    def applyAction
        return @grid.createBridge(@x1,@y1, @x2, @y2)
    end

    ##
    # Destroy a bridge between two islands
    #
    # ===== Return
    # return true if the action have been made, else false
    # ---
    def applyOpposite
        return @grid.removeBridge(@x1, @y1, @x2, @y2)
    end
end