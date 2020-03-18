################################################################################
# File: IsleCell.rb                                                            #
# Project: Hashi                                                               #
# File Created: Monday, 19th February 2020 11:00:27 am                         #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Monday, 24th February 2020 5:17:27 pm                         #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require "./Cell"

##
# ===== Presentation
#   IsleCell is a Cell.
#
# ===== Variables
# * +bridgeNumber+ - Number of bridge which must be connected
#
# ===== Methods
# * +getBridgeNumber+ - return the number of bridge which must be connected (alias IsleCell#bridgeNumber)
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
    def initialize(bridgeNb)
        @state = :isle
        @bridgeNumber = bridgeNb
    end
end