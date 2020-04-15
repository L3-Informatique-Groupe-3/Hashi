# @Author: Despres Maxence <checkam>
# @Date:   27-Mar-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: ButtonShape.rb
# @Last modified by:   checkam
# @Last modified time: 05-Apr-2020


##
# ===== Presentation
#  	ButtonShape is a button with shape of an image
# ===== Variables
#  * +shape+ - Object to display
#   * +gtkEvent+   - Event box to catch event
#   * +gtkObject+   - Gtk Table to display image in background of text
#   * +action+   - Gtk Box where image is apply
#   * +n_channel+   - Gtk Alignement where image is apply
#   * +rowstride+   - Boolean to know if  the button change on focus
#   * +tabPixel+   -  Gtk Image
# ===== Methods
#
#   new - initialization method
# 	onClick      -    Set the button clickable
#   isClick - methods execute when button isClick
#   setAction - Set action when button is click
class ButtonShape

  attr_reader :gtkObject

  ##
  # The class' constructor.
  #
  # ===== Attributes
  # * +shape+ - path of a image of the shape
  # * +width+ - the width of this Button
  # * +height+ - the height of this Button
  #-------------------------------------------------
  def initialize(shape: nil, width: nil, height: nil )
    @shape = Asset.new(shape)
    if width && height
      @shape.resize(width,height)
    end
    @gtkEvent = Gtk::EventBox.new
    @gtkObject=Gtk::Table.new(4,4)
    @shape.applyOn(@gtkEvent)
    @action = nil
    @gtkObject.attach(@gtkEvent,0,4,0,4)
    @n_channel = @shape.buffer.n_channels
    @rowstride = @shape.buffer.rowstride
    @tabPixel = @shape.buffer.pixels
  end

  ##
  # Set the button clickable
  #-------------------------------------------------
  def onClick(block=nil)
    @gtkEvent.signal_connect("button_release_event") { |_, event|
      isClick(event.x.truncate,event.y.truncate)
    }
  end

  ##
  # methods execute when button isClick
  #
  # ===== Attributes
  # * +x+ - coord of mouse
  # * +y+ - coord of mouse
  #-------------------------------------------------
  def isClick(x,y)
    @pixel = y * @rowstride + x * @n_channel
    if @tabPixel[@pixel+3] == 255
      @action.call
    end
     return @tabPixel[@pixel+3] == 255
  end

  ##
  # Set action when button is click
  #
  # ===== Attributes
  # * +action+ - the new action
  #-------------------------------------------------
  def setAction(action)
    @action = action
  end

end
