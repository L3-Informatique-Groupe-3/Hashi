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
# Action is an abstract class
# It represent an action from the player
#
# ===== Variables
# * +grid+ - Store the grid where the action will be applied
# ===== Methods
# * +applyAction+ - Apply an action
# * +applyOpposite+ - Apply the opposite action
##
class Action
    @grid

    attr_reader :grid #:nodoc:
    ##
    # The class' constructor.
    #
    # ===== Attributes
    # * +grid+ - The grid where the action will be applied 
    # ---
    def initialize(grid)
        @grid = grid
    end

    ##
    # Apply the action
    #
    # ===== Return
    # return false
    # ---
    def applyAction
        return false
    end

    ##
    # Apply the opposite action
    #
    # ===== Return
    # return false
    # ---
    def applyOpposite
        return false
    end

    private_class_method :new
end