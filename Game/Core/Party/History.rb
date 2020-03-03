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
        @hypotheses -= @hypotheses.drop(index + 1)

        @hypotheses.push(Hypothesis.new(@grid.getCurrentGrid(), :created))
    end
end