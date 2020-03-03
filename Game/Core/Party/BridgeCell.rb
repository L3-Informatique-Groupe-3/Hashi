################################################################################
# File: BridgeCell.rb                                                          #
# Project: Hashi                                                               #
# File Created: Monday, 24th February 2020 11:10:57 am                         #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Tuesday, 25th February 2020 11:43:44 am                       #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require "./Cell"

##
# ===== Presentation
# BridgeCell is a Cell
# 
# ===== Variables
# * +frozen+ - true if the cell is frozen
# * +directions+ - This class knows a list of all possible directions:
#       @@directions = [:vertical, :horizontal]
# * +direction+ - the cell's direction. It must be one of the values given in the +directions+ list
# * +types+ - This class knows a list of all possible types:
#       @@types = [:empty, :simple, :double]
# * +type+ - the cell's type. It must be one the values given in the +types+ list
# 
# ===== Methods
# * +getDirection+ - Return the current direction of the cell. (alias BridgeCell#direction)
# * +setDirection+ - Set the direction. (alias BridgeCell#direction=)
# * +getType+ - Return the current type of the cell. (alias BridgeCell#type)
# * +setType+ - Set the type. (alias BridgeCell#type=)
# * +freeze+ - Set frozen variable to true
# * +unfreeze+ - Set frozen variable to false
# * +isAlterable?+ - Return true if the frozen variable is false.
# * +nextType+ - Change the +type+ to the next type (simple->double->empty)
##
class BridgeCell < Cell
    @@directions = [:vertical, :horizontal]
    @@types = [:empty, :simple, :double]
    @direction
    @type
    @frozen

    attr_accessor :direction, :type
    #:nodoc:
    alias getDirection direction
    alias setDirection direction=
    alias getType type
    alias setType type=
    #:startdoc:

    ##
    # The class' constructor.
    # Init +state+ to :bridge and +frozen+ to false by default
    # ---
    def initialize(pdirection = :vertical, ptype = :empty)
        @state = :bridge
        @frozen = false
        @direction = pdirection
        @type = ptype
    end

    ##
    # Return true if the frozen variable is false.
    #
    # ===== Return
    # Return true if the frozen variable is false.
    # ---
    def isAlterable?
        return (@frozen == false)
    end

    ##
    # Set frozen variable to true
    #
    # ===== Return
    # Return self
    # ---
    def freeze
        @frozen = true
        self
    end

    ##
    # Set frozen variable to false
    #
    # ===== Return
    # Return self
    # ---
    def unfreeze
        @frozen = false
        self
    end

    ##
    # Change the type to the next type (simple->double->empty)
    # ---
    def nextType
        case @type
            when :simple
                @type = :double
            when :double
                @type = :empty
        end
    end
end
