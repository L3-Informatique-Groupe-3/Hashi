################################################################################
# File: Hypothesis.rb                                                                #
# Project: Hashi                                                               #
# File Created: Tuesday, 20th February 2020 11:00:27 am                        #
# Author: <Adrali>Lemaitre P                                                   #
# -----                                                                        #
# Last Modified: Thursday, 5th March 2020 12:39:56 pm                          #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require "./ActionCreate"
require "./ActionModify"

##
# ===== Presentation
# Hypothesis manage an action list from a grid reference.
#
# ===== Variables
# * +saveGrid+ - Store the grid at the moment where the hypothesis is create.
# * +actions+ - Store the current actions performed by the player.
# * +index+ - Point on the current action of the player.
# * +types+ - This class knows a list of all possible types:
#       @@types = [:validated, :created] 
# * +type+ - the Hypothesis's type. It must be one the values given in the +types+ list
# ===== Methods
# * +getSaveGrid+ - Apply an action
# * +applyOpposite+ - Apply the opposite action
##
class Hypothesis
    @saveGrid
    @actions
    @index
    @@types = [:validated, :created] 
    @type

    
    attr_reader :type, :saveGrid
    ##
    # The class' constructor.
    #
    # ===== Attributes
    # * +saveGrid+ - the grid at the moment where the hypothesis is create.
    # * +type+ - Hypothesis's type
    # ---
    def initialize(saveGrid, type)
        @saveGrid = saveGrid
        @type = type
        @index = -1
        @actions = []
    end

    def addAction(action)
        @index += 1
        @actions -= @actions.drop(@index + 1)
        @actions.push(action)
    end
    
    def isAtEnd
        return @index >= @actions.size
    end

    def isAtBeginning
        return @index <= -1
    end

    def undo
        if !(isAtBeginning)
            @actions[@index].applyOpposite
            @index -= 1
        end
    end

    def redo
        if !(isAtEnd)
            @index += 1
            @actions[@index].applyAction
        end
    end
end