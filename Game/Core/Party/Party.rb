# @Author: Despres Maxence <makc>
# @Date:   09-Mar-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Last modified by:   makc
# @Last modified time: 09-Mar-2020



require_relative "./Grid"
require_relative "./History"

##
# ===== Presentation
#   Party is the public interface of the game. It contains all method you need to play the game
#
# ===== Variables
# * +grid+ - It contains the grid of the actual party
# * +history+ - It contains the history of the actual party
#
# ===== Methods
# * +getTimer+ - Return the timer in second since the begining of the game
# * +pause+ - Set the game in pause mode (pause the timer)
# * +resume+ - Resume a game in pause
# * +undo+ - Cancel the last action of the player
# * +redo+ - Cancel the last undo made by the player
# * +newHypothesis+ - Create a new hypothesis (no effect if there is no move on the actual hypothesis)
# * +validateHypothesis+ - Validate all pending Hypothesis ( no effect if there is no pending hypothesis)
# * +refuteHypothesis+ - Cancel the last pending hypothesis ( no effect if there is no pending hypothesis)
# * +createBridge+ - Create a bridge if it's possible between to islands
# * +modifyBridge+ - Modify the state of a bridge (if there is one at the specified coordonates) in this order : Simple -> Double -> None
# * +getCell+ - Return the cell at the specified coordinates
# * +getState+ - Get the actual state of the specified cell
# * +getType+ - Get the type of the specified bridge cell
# * +getValue+ - Get the value of the specified island cell
# * +getDirection+ - Get the direction of the specified bridge cell
# * +isAlterable+ - True if the specified cell can be modify
##
class Party
    @grid
    @history

    attr_reader :grid

    ##
    # The class' constructor.
    #
    # ===== Attributes
    # * +answerGrid+ - The string which represent the answer
    # ---
    def initialize(answerGrid)
        @grid = Grid.new(answerGrid)
        @history = History.new(@grid)
    end

    ##
    # Return the value of the timer of the actual party
    # ===== Returns
    # Returns an int with the value of the timer in second
    # ---
    def getTimer

    end

    ##
    # Set the game in pause
    # ---
    def pause

    end
    ##
    # Resume the game
    # ---
    def resume

    end

    ##
    # Undo the last action of the player
    # ---
    def undo
        if(@history != nil)
            @history.undo
        end
    end

    ##
    # Cancel the most recent undo made by the player
    # ---
    def redo
        if(@history != nil)
            @history.redo
        end
    end

    ##
    # Create a new hypothesis, no effect if the actual hypothesis have no moves.
    # ---
    def newHypothesis
        if(@history != nil)
            @history.newHypothesis
        end
    end

    ##
    # Validate pending hypothesis,no effect if there is no pending hypothesis).
    # ===== Return
    # True if pending hypothesis have been validated, else false
    # ---
    def validateHypothesis
        if(@history != nil)
            @history.validateHypothesis
        end
    end

    ##
    # Cancel the last pending hypothesis (no effect if there is no pending hypothesis)
    # ===== Return
    # True if an hypothesis have been canceled, else false
    # ---
    def refuteHypothesis
        if(@history != nil)
            @history.refuteHypothesis
        end
    end

    ##
    # Create if it's possible a bridge between two cells.
    # Creation condition :
    # * The two cells must be island cells
    # * All cells between the two islands must be free.
    # ===== Attributes
    # * +x1+ - the absciss of the first cell
    # * +y1+ - the ordonate ordinate of the first cell
    # * +x2+ - the absciss of the second cell
    # * +y2+ - the ordonate ordinate of the second cell
    # ===== Return
    # True if the bridge have been created, else return false
    # ---
    def createBridge(x1, y1, x2, y2)
        if(@grid != nil && @history != nil)
            action = ActionCreate.new(@grid,x1,y1,x2,y2)
            if (action.applyAction)
                @history.addAction(action)
                return true
            end
        end
        return false
    end
    ##
    # Modify if it's possible a bridge in this order : simple bridge become double bridge and double bridge become and empty cell
    # Creation condition :
    # * The bridge cell must be a simple or double cell.
    # ===== Attributes
    # * +x1+ - the absciss of the cell
    # * +y1+ - the ordonate ordinate of the cell
    # ===== Return
    # True if the bridge have been modify, else return false
    # ---
    def modifyBridge(x, y)
        if(@grid != nil && @history != nil)
            action = ActionModify.new(@grid,x,y)
            if (action.applyAction)
                @history.addAction(action)
                return true
            end
        end
        return false
    end

    ##
    # Return the cell at the specified coordinates
    #
    # ===== Attributes
    # * +x+ - the absciss of the cell
    # * +y+ - the ordonate of the cell
    # ===== Return
    # Return the cell at the specified coordinates
    # ---
    def getCell(x, y)
      return @grid.getCell(x,y)
    end

    ##
    # Return the state of the cell to know if the cell if a bridgeCell, a island cell or a obstacle cell
    # ===== Return
    # A value from states(bridge,isle,obstacle)
    # nil if there is an issue
    # ---
    def getState(x, y)
        if(@grid != nil)
            return @grid.getCell(x,y).getState
        end
        return nil
    end


    ##
    # Return the type of a bridgecell (simple, double or empty)
    # ===== Return
    # A value from types(empty, simple, double)
    # nil if there is an issue
    # ---
    def getType(x, y)
        if(@grid != nil && @grid.getCell(x,y).getState == :bridge)
            return @grid.getCell(x,y).getType
        end
        return nil

    end


    ##
    # Return the value of a islandcell
    # ===== Return
    # The value of the cell
    # nil if there is an issue
    # ---
    def getValue(x, y)
        if(@grid != nil && @grid.getCell(x,y).getState == :isle)
            return @grid.getCell(x,y).getBridgeNumber
        end
        return nil
    end


    ##
    # Return the direction of the bridgecell
    # ===== Return
    # A direction from directions (vertical, horizontal)
    # nil if there is an issue
    # ---
    def getDirection(x, y)
        if(@grid != nil && @grid.getCell(x,y).getState == :bridge)
            return @grid.getCell(x,y).getDirection
        end
        return nil
    end


    ##
    # Indicate if the cell can be modify
    # ===== Return
    # True if the cell is alterable, else false
    # nil if there is an issue
    # ---
    def isAlterable(x, y)
        if(@grid != nil)
            return @grid.getCell(x,y).isAlterable?
        end
        return nil
    end


end
