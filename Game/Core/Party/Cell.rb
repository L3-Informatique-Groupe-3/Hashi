################################################################################
# File: Cell.rb                                                                #
# Project: Hashi                                                               #
# File Created: Monday, 19th February 2020 11:00:27 am                         #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Monday, 24th February 2020 2:40:03 pm                         #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

##
# ===== Presentation
#   Cell is a class that define the cell's behaviors
#
# ===== Variables
# * +states+ - This class knows a list of all the possible states:
#       @@states = [:bridge, :isle, :obstacle, :empty]
# * +state+ - the cell's state. It must be one the values given in the +states+ list
#
# ===== Methods
# * +getState+ - return the current state of the cell (alias Cell#state)
# * +isAlterable?+ - return true if the cell is alterable
##
class Cell
    @@states = [:bridge, :isle, :obstacle]
    @state

    attr_reader :state
    #:nodoc:
    alias getState state
    #:startdoc:

    ##
    # The class' constructor.
    # Init +state+ to :obstacle and +alterable+ to false by default
    # ---
    def initialize
        @state = :obstacle
    end

    ##
    # Return true if the cell is alterable. It's false by default.
    #
    # ===== Return
    # Return true if the cell is alterable.
    # ---
    def isAlterable?
        return false
    end
end