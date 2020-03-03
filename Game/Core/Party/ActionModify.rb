################################################################################
# File: ActionModify.rb                                                                #
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
# ActionModify is an Action.
# Represents the action of the player when he change the state of a bridge on this order : Simple to Double and Double to none
#
# ===== Variables
# * +x+ - x coordonate of a BridgeCell
# * +y+ - y coordonate of a BridgeCell
# * +bridge+ - An array with the coordonates of the island link to the (x,y) BridgeCell
# ===== Methods
# * +applyAction+ - Modify an existing bridge
# * +applyOpposite+ - Modify a bridge as the opposite of the action
##
class ActionModify < Action
    @bridge = nil
    @x
    @y

    attr_reader :x, :y, :grid #:nodoc:
    

    ##
    # The class' constructor.
    #
    # ===== Attributes
    # * +grid+ - The grid where the action will be applied 
    # * +x+ - x coordonate of a BridgeCell
    # * +y+ - y coordonate of a BridgeCell
    #---
    def initialize(grid, x, y)
        super(grid)
        @x = x
        @y = y
    end

    ##
    # Create a bridge between two islands
    #
    # ===== Return
    # return true if the action have been made, else false
    # ---
    def applyAction
        @bridge = @grid.nextBridge(@x,@y)
        return !(@bridge.empty?())
    end

    ##
    # Destroy a bridge between two islands
    #
    # ===== Return
    # return true if the action have been made, else false
    # ---
    def applyOpposite
        if(@bridge != nil)
            return @grid.previousBridge(@bridge[0][0], @bridge[0][1], @bridge[1][0], @bridge[1][1])
        end
        return false
    end
end