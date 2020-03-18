################################################################################
# File: History.rb                                                                #
# Project: Hashi                                                               #
# File Created: Tuesday, 20th February 2020 11:00:27 am                        #
# Author: <Adrali>Lemaitre P                                                   #
# -----                                                                        #
# Last Modified: Thursday, 5th March 2020 12:50:49 pm                          #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require_relative "./Hypothesis"
require_relative "./Grid"

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
    # * +grid+ - The Grid
    # ---
    def initialize(grid)
        @grid = grid
        @hypotheses = [Hypothesis.new(@grid.getCurrentGrid(), :created)]
        @index = 0
    end

    

    ##
    # Create a new hypothesis
    #
    # ---
    def newHypothesis
        #puts("Index Hypothèse : " + @index.to_s)
        @hypotheses -= @hypotheses.drop(@index + 1)
        @index += 1
        @hypotheses.push(Hypothesis.new(@grid.getCurrentGrid(), :created))
        @grid.freeze
        puts("New Nouvel Index : " + @index.to_s)
    end

    ##
    # Validate previous hypothesis
    #
    # ---
    def validateHypothesis
        puts("Validate Ancien Index : " + @index.to_s)
        @hypotheses -= @hypotheses.drop(@index + 1)
        @index += 1
        @hypotheses.push(Hypothesis.new(@grid.getCurrentGrid(), :validated))
        @grid.unfreeze
        puts("Validate Nouvel Index : " + @index.to_s)
    end


    ##
    # Refute current hypothesis if it's not a validate hypothesis
    #
    # ---
    def refuteHypothesis
        #puts("Index Hypothèse : " + @index.to_s)
        if(@hypotheses[@index].type != :validated)
            @grid.loadCurrentGrid(@hypotheses[@index].saveGrid)
            @index -= 1
            puts("Refute Nouvel Index : " + @index.to_s)
        end
    end

    ##
    # Add an action to the current hypothesis
    #
    # ===== Attributes    
    # * +action+ An ActionCreate or an ActionModify
    # ---
    def addAction(action)
        @hypotheses -= @hypotheses.drop(@index + 1)
        @hypotheses[@index].addAction(action)
    end

    ##
    # Undo the current action in the current hypothesis
    #
    # ---
    def undo
        if(@index >= 0)
            puts("Undo Index : " + @index.to_s)
            if !(@hypotheses[@index].isAtBeginning)
                @hypotheses[@index].undo
            else
                @grid.loadCurrentGrid(@hypotheses[@index].saveGrid)
                if(@index>0)
                    @index -= 1
                    @hypotheses[@index].setAtEnd
                    puts("Undo Nouvel Index : " + @index.to_s)
                end
            end
        end
    end

    ##
    # Redo the current action in the current hypothesis
    #
    # ---
    def redo
        if(@index < @hypotheses.size)
            puts("Redo Index : " + @index.to_s)
            if !(@hypotheses[@index].isAtEnd)
                @hypotheses[@index].redo
            elsif(@index < (@hypotheses.size-1))
                @index += 1
                
                if(@hypotheses[@index].type == :created)
                    @grid.freeze
                else
                    @grid.unfreeze
                end
                @hypotheses[@index].redoHypothesis
                puts("Redo Nouvel Index : " + @index.to_s)
            end
        end
    end
end


# h = History.new(Grid.new("9x9:2c3-1-1c3a-b-a3d3b4d4-aa-a3a3dd5a-2a3a--b1-a3b3cc6dd4b3a--a-1a3a2c1a-a1a2c2c3c3c2"))
# h.newHypothesis
# h.refuteHypothesis
# h.validateHypothesis