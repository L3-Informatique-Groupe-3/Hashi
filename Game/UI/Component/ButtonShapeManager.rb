# @Author: Despres Maxence <checkam>
# @Date:   27-Mar-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: ButtonShapeManager.rb
# @Last modified by:   checkam
# @Last modified time: 03-Apr-2020

##
# ===== Presentation
#  	A manager for manager ButtonShape
# ===== Variables
#  * +gtkObject+ - Object to display
#   * +tabButtonShape+   - Array of Button Shape
#   * +gtkEvent+   - Event on the global box to test all ButtonShape
# ===== Methods
#
#   new - initialization method
# 	addButton  - Create a button clickable
class ButtonShapeManager

    attr_reader :gtkObject

    ##
    # The class' constructor.
    #-------------------------------------------------
    def initialize
      @tabButtonShape = []
      @gtkEvent = Gtk::EventBox.new
      @gtkObject =  Gtk::Table.new(4,4)

      @gtkEvent.signal_connect("button_release_event") { |_, event|
          @tabButtonShape.each { | button |
            button.isClick(event.x.truncate,event.y.truncate)
          }
        }
      @gtkObject.attach(@gtkEvent,0,4,0,4)
    end

    ##
    # Add a button to array of ButtonShape
    #
    # ===== Attributes
    #
    # * +button+ -  a instance ButtonShape
    #-------------------------------------------------
    def addButton(button)
      @tabButtonShape << button
    end
end
