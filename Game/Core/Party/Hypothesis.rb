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
# * +addAction+ - Add an Action
# * +isAtEnd+ - Return if the +index+ is in the end
# * +isAtBeginning+ - Return if the +index+ is in the beginning
# * +undo+ - Move the +index+ by -1 and apply the opposite action if it's possible
# * +redo+ - Move the +index+ by +1 and apply the action if it's possible
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

    ##
    # Add an action to the hypothesis
    #
    # ===== Attributes
    # * +action+ - The action to add to history
    # ---
    def addAction(action)
        @index += 1
        @actions -= @actions.drop(@index + 1)
        @actions.push(action)
    end
 
    
    ##
    # Return true if the index of the hypothesis correspond to the last
    #
    # ---
    def isAtEnd
        return @index >= (@actions.size - 1)
    end


    ##
    # Return true if the index of the hypothesis correspond to the last
    #
    # ---
    def isAtBeginning
        return @index <= -1
    end

    ##
    # Undo the action corresponding to the current index
    #
    # ---
    def undo
        if !(isAtBeginning)
            @actions[@index].applyOpposite
            @index -= 1
        end
    end

    ##
    # Redo the action corresponding to the current index
    #
    # ---
    def redo
        if !(isAtEnd)
            @index += 1
            @actions[@index].applyAction
        end
    end

    def redoHypothesis
        (-1..@index).each do |i|
            @actions[i].applyAction
        end
    end
        
end