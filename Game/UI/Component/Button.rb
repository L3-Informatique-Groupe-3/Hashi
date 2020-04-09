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
      @gtkObject.window.set_cursor(Click::CURSORIN) unless @gtkObject.window == nil
      if @label != ""
        @color="orange"
      end
      if @imageFocus != nil
        @imageFocus.applyOn(@imageBox)
      end
      apply
    }
    @eventBox.signal_connect("leave_notify_event") { |widget, event|
      @gtkObject.window.set_cursor(Click::CURSOROUT) unless @gtkObject.window == nil
      if @label != ""
        @color="black"
      end
      if @image != nil
        @image.applyOn(@imageBox)
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

  def setBackgroundSize(width,height)
    super(width,height)
    @imageBox.set_size_request(width,height)
    self
  end

  def setBackground(r,g,b,a)
    super(r,g,b,a) if @image == nil
    @imageAlignment.override_background_color(:normal,Gdk::RGBA.new(r,g,b,a))
    self
  end

  def resizeImage(width,height)
    if @image != nil
      @image.resize(width,height)
      @image.applyOn(@imageBox)
    end
  end

  def resizeImageFocus(width,height)
    if @imageFocus != nil
      @imageFocus.resize(width,height)
      @imageFocus.applyOn(@imageBox)
    end
  end

  def setPicture(image)
    @image = Asset.new(image)
    @image.applyOn(@gtkObject)
  end

end
