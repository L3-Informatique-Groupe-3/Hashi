################################################################################
# File: Chrono.rb                                                              #
# Project: Hashi                                                               #
# File Created: Monday, 24th February 2020 11:00:27 am                         #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Monday, 16th March 2020 3:56:18 pm                            #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

##
# ===== Presentation
# Chrono is a class that define a timer's behaviors
# 
# ===== Variables
# * +totalDuration+ - Total duration saved before the current starting
# * +timeStart+ - Time of the current starting
#
# ===== Methods
# * +start+ - Start the chrono. (alias Chrono#continue)
# * +stop+ - Stop the chrono. (alias Chrono#pause)
# * +reset+ - Reset the chrono
# * +getTime+ - Return the total time which have been passing since the first chrono start
##
class Chrono
    @totalDuration
    @timeStart

    ##
    # The class' constructor.
    # ---
    def initialize
        @totalDuration = Time.new(0)
        @timeStart = nil
    end

    ##
    # Start the chrono
    #
    # ===== Return
    # Return self
    # ---
    def start
        if @timeStart == nil
            @timeStart = Time.now()
        end
        self
    end
    alias continue start

    ##
    # Stop the chrono
    #
    # ===== Return
    # Return self
    # ---
    def stop
        if @timeStart != nil
            @totalDuration += Time.now() - @timeStart
            @timeStart = nil
        end
        self
    end
    alias pause stop

    ##
    # Reset the chrono
    #
    # ===== Return
    # Return self
    # ---
    def reset
        @totalDuration = Time.new(0)
        @timeStart = Time.now()
        self
    end

    ##
    # Return the total time which have been passing since the first chrono start
    # The return type is a Time instance
    #
    # ===== Return
    # Return the total time which have been passing since the first chrono start
    # ---
    def getTime
        if @timeStart != nil
            return @totalDuration + (Time.now() - @timeStart)
        else
            return @totalDuration
        end
    end

    def to_s
        min = self.getTime.min.to_s
        sec = self.getTime.sec.to_s
        return "%02d:%02d" % [min, sec]
    end
end
