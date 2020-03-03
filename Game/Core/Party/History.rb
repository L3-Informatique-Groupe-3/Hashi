################################################################################
# File: History.rb                                                                #
# Project: Hashi                                                               #
# File Created: Tuesday, 20th February 2020 11:00:27 am                        #
# Author: <Adrali>Lemaitre P                                                   #
# -----                                                                        #
# Last Modified: Tuesday, 20th February 2020 11:00:27 am                       #
# Modified By: <Adrali>Lemaitre P                                               #
################################################################################

require "./Hypothesis"
require "./Grid"

##
# ===== Presentation
# History manage an hypothesis list from a grid reference.
#
# ===== Variables
# * +grid+ - Store the Grid
# * +hypotheses+ - Store the current hypotheses performed by the player.
# * +index+ - Point on the current hypothesis of the player.
# ===== Methods
# * +applyAction+ - Apply an action
# * +applyOpposite+ - Apply the opposite action
##
class History
    @hypotheses
    @index
    @grid
    
    ##
    # The class' constructor.
    #
    # ===== Attributes
    # * +saveGrid+ - the grid at the moment where the hypothesis is create.
    # * +type+ - Hypothesis's type
    # ---
    def initialize(grid)
        @grid = grid
        @hypotheses = [Hypothesis.new(@grid.getCurrentGrid(), :created)]
        @index = 0
    end

    

    def newHypothesis
        @hypotheses -= @hypotheses.drop(@index + 1)
        @index+=1
        @hypotheses.push(Hypothesis.new(@grid.getCurrentGrid(), :created))
    end

    def validateHypothesis
        @hypotheses -= @hypotheses.drop(@index + 1)
        @index+=1
        @hypotheses.push(Hypothesis.new(@grid.getCurrentGrid(), :validated))
    end

    def refuteHypothesis
        if(@hypotheses[@index].type != :validated)
            @grid.loadCurrentGrid(@hypotheses[@index].saveGrid)
            @index -=1
        end
    end

    def addAction(action)
        @hypotheses[index].addAction(action)
    end

    # def undo()
    #     @hypotheses[index].undo()
    # end

    # def redo()
    #     @hypotheses[index].redo()
    # end
end


# h = History.new(Grid.new("9x9:2c3-1-1c3a-b-a3d3b4d4-aa-a3a3dd5a-2a3a--b1-a3b3cc6dd4b3a--a-1a3a2c1a-a1a2c2c3c3c2"))
# h.newHypothesis
# h.refuteHypothesis
# h.validateHypothesis