# Create 19/02/2020

##
# ===== Presentation
#   Cell is a class that define the cell's behaviors
#
# ===== Variables
# * +states+ - This class knows a list of all the possible states:
#       @@states = [:bridge, :isle, :obstacle, :empty]
# * +state+ - the cell's state. It must be one the values given in the +states+ list
# * +alterable+ - true if the cell is an alterable cell
#
# ===== Methods
# * +getState+ - return the current state of the cell (alias Cell#state)
# * +isAlterable?+ - return if the cell is alterable (alias Cell#alterable)
##
class Cell
    @@states = [:bridge, :isle, :obstacle]
    @state
    @alterable

    attr_reader :state, :alterable
    #:nodoc:
    alias getState state
    alias isAlterable? alterable
    #:startdoc:

    ##
    # The class' constructor.
    # Init +state+ to :obstacle and +alterable+ to false by default
    # ---
    def initialize
        @state = :obstacle
        @alterable = false
    end
end