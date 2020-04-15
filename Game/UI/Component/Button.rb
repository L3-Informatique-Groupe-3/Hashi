# @Author: Despres Maxence <checkam>
# @Date:   15-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: Button.rb
# @Last modified by:   clément
# @Last modified time: 6-Mar-2020

require File.dirname(__FILE__) + "/Text"
require_relative "../Click"


##
# ===== Presentation
#  	Button is a herite class of Text
# ===== Variables
# 	* +@see Text variable+
#  * +gtkObject+ - Object to display
#   * +eventBox+   - Event box to catch event
#   * +gtkTable+   - Gtk Table to display image in background of text
#   * +imageBox+   - Gtk Box where image is apply
#   * +imageAlignment+   - Gtk Alignement where image is apply
#   * +focusActive+   - Boolean to know if  the button change on focus
#   * +image+   -  Gtk Image
#   * +imageFocus+   -  Gtk Image
# ===== Methods
#   * +@see Text method+
#
#   new - initialization method
# 	onClick      -    Create a button clickable
#   setBackgroundSize - Set the size of the button
#   setBackground - Set the background color
#   resizeImage - set the size of the image
#   setFocusActive - Set if the button change on focus
#   setImage -  Set a new image on button
#   resizeImageFocus - Set the size of the image focus
class Button < Text
  # +see+ - see other in Text
  @gtkObject
  @eventBox
  @gtkTable
  @imageBox
  @imageAlignment
  @focusActive
  @image
  @imageFocus

  ##
  # The class' constructor.
  # @see Text#new
  #
  # ===== Attributes
  # * +size+ -  Default value Constants::BUTTON_SIZE
  # * +image+ - image on this button
  # * +imageFocus+ -
  # * +label+ -
  # * +padding+ -
  # * +width+ -
  # * +height+ -
  #-------------------------------------------------
  def initialize(label: "",size: Constants::BUTTON_SIZE,padding: 10, image: nil, imageFocus: nil, width: nil, height: nil)
    super(label:label,size:size,padding:padding)
    @gtkObject.each { |child|
      @gtkObject.remove(child)
    }
    @eventBox = Gtk::EventBox.new
    @gtkTable = Gtk::Table.new(1,1)
    @gtkObject.add(@eventBox)
    @eventBox.add(@gtkTable)

    @imageBox = Gtk::Alignment.new(0.5, 0.5, 0, 0)
    @imageAlignment = Gtk::Box.new(:vertical).add(@imageBox)
    @focusActive = true

    center = Gtk::Alignment.new(0.5, 0.5, 0, 0).add(@textBox)
    @gtkTable.attach(center,0,1,0,1)
    @gtkTable.attach(@imageAlignment,0,1,0,1)

    if image != nil
      @image = Asset.new(image)

      @image.applyOn(@imageBox)
    end

    if imageFocus != nil
      @imageFocus = Asset.new(imageFocus)
    end

    if width != nil && height != nil
      setBackgroundSize(width,height)
    end


    setBackground(1,1,1,1)
    apply

    @eventBox.signal_connect("enter_notify_event") { |widget, event|
      @eventBox.window.set_cursor(Click::CURSORIN) unless @eventBox.window == nil
      if @focusActive == true
        if @label != ""
          @color="orange"
        end
        if @imageFocus != nil
          @imageFocus.applyOn(@imageBox)
        end
      end
      apply
    }
    @eventBox.signal_connect("leave_notify_event") { |widget, event|
      @eventBox.window.set_cursor(Click::CURSOROUT) unless @eventBox.window == nil
      if @focusActive == true
        if @label != ""
          @color="black"
        end
        if @image != nil
          @image.applyOn(@imageBox)
        end
      end
      apply
    }
  end



  ##
  # Create a button clickable and can execute a block
  # ===== Attributes
  # * +block+ -
  #-------------------------------------------------
  def onClick(block=nil)
    temp=@color
    @gtkObject.signal_connect("button_release_event") { |_, event|
      if event.button==Click::LEFT
        Thread.new{
          sleep(0.5)
          if  !@gtkObject.mapped?
            @gtkObject.window.set_cursor(Click::CURSOROUT) unless @gtkObject.window == nil
            @color=temp
            apply
          end
        }
        yield
      end
    }
    self
  end

  ##
  # Set the size of the button
  # ===== Attributes
  # * +width+ - the new width of the button
  # * +height+ -  the new height of the button
  #-------------------------------------------------
  def setBackgroundSize(width,height)
    super(width,height)
    @imageBox.set_size_request(width,height)
    self
  end

  ##
  # Set the background color
  # ===== Attributes
  # * +r+ - red (between 0 and 1)
  # * +g+ - green (between 0 and 1)
  # * +b+ - blue (between 0 and 1)
  # * +a+ - opacity (between 0 and 1)
  #-------------------------------------------------
  def setBackground(r,g,b,a)
    super(r,g,b,a) if @image == nil
    @imageAlignment.override_background_color(:normal,Gdk::RGBA.new(r,g,b,a))
    self
  end

  ##
  # set the size of the image
  # ===== Attributes
  # * +width+ - the new width of the button
  # * +height+ -  the new height of the button
  #-------------------------------------------------
  def resizeImage(width,height)
    if @image != nil
      @image.resize(width,height)
      @image.applyOn(@imageBox)
    end
  end

  ##
  # Set the size of the image focus
  # ===== Attributes
  # * +width+ - the new width of the image on focus
  # * +height+ -  the new height of the image on focus
  #-------------------------------------------------
  def resizeImageFocus(width,height)
    if @imageFocus != nil
      @imageFocus.resize(width,height)
    end
  end

  ##
  # Set a new image on button
  # ===== Attributes
  # * +image+ - path to image
  # * +width+ - the new width of the image
  # * +height+ -  the new height of the image
  #-------------------------------------------------
  def setImage(image, width: nil, height: nil)
    @image = Asset.new(image)
    @image.resize(width, height) if (width != nil && height != nil)
    @image.applyOn(@imageBox)
  end

  ##
  # Set if the button change on focus
  # ===== Attributes
  # * +bool+ -  a boolean true for have focus else false
  #   default +focusActive+ was true
  #-------------------------------------------------
  def setFocusActive(bool)
    @focusActive = bool
  end

end
