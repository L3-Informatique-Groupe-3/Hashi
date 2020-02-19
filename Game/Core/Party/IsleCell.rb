# Create 19/02/2020

##
# ===== Presentation
#   IsleCell is a Cell.
#
# ===== Variables
# * +bridgeNumber+ - Number of bridge which must be connected
#
# ===== Methods
# * +getBridgeNumber+ - return the number of bridge which must be connected (alias IsleCell#BridgeNumber)
##
class IsleCell < Cell
    @bridgeNumber

    
    attr_reader :bridgeNumber
    #:nodoc:
    alias getBridgeNumber bridgeNumber
    #:startdoc:

    ##
    # The class' constructor.
    # Init +state+ to :isle and +alterable+ to false by default
    # ---
    def initialize
        @state = :isle
        @alterable = false
    end
end