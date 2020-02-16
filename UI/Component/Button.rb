# @Author: Despres Maxence <checkam>
# @Date:   15-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: Button.rb
# @Last modified by:   checkam
# @Last modified time: 16-Feb-2020

require File.dirname(__FILE__) + "/../Component/Text"


##
# ===== Presentation
  #  	Button is a herite class of Text
# 	* +@see Text+
# ===== Methods
# 	updateLabel - Change the display text of this ChronoUi
# 	onClick - Create a button clickable
class Button < Text

  ##
  # The class' constructor.
  # @see Text#new
  #
  # ===== Attributes
  # * +size+ - Default value Constants::BUTTON_SIZE
  # * +image+ - image on this button
  # * +image+ -
  #-------------------------------------------------
  def initialize(label: "",size: Constants::BUTTON_SIZE,padding: 10, image: nil, imageFocus: nil, width: nil, height: nil)
    super(label: label,size: size,padding: padding,width: width, height: height)
    if image != nil
      @image = Asset.new(image)
      @image.resize(40,40)
      @image.applyOn(@eventBox,removeAll: false)
    end
    if imageFocus != nil
      @imageFocus = Asset.new(image)
      @imageFocus.resize(40,40)
    end
    setBackground(1,1,1,1)
  end



  ##
  # Create a button clickable and can execute a block
  # ===== Attributes
  # * +block+ -
  #-------------------------------------------------
  def onClick(block=nil)
    temp=@color
    @eventBox.signal_connect("enter_notify_event") { |widget, event|
      @eventBox.window.set_cursor(Click::CURSORIN) unless @eventBox.window == nil
      if @label != ""
        @color="orange"
      elsif @imageFocus != nil
        @imageFocus.applyOn(@eventBox)
      end
      apply
    }
    @eventBox.signal_connect("leave_notify_event") { |widget, event|
      @eventBox.window.set_cursor(Click::CURSOROUT) unless @eventBox.window == nil
      if @label != ""
        @color=temp
      elsif @image != nil
        @image.applyOn(@eventBox)
      end
      apply
    }
    @eventBox.signal_connect("button_release_event") { |_, event|
      if event.button==Click::LEFT
        Thread.new{
          sleep(0.5)
          if  !@eventBox.mapped?
            @eventBox.window.set_cursor(Click::CURSOROUT) unless @eventBox.window == nil
            @color=temp
            apply
          end
        }
        yield
      end
    }
    self
  end

end
