# @Author: Despres Maxence <checkam>
# @Date:   11-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: Text.rb
# @Last modified by:   checkam
# @Last modified time: 16-Feb-2020



require File.dirname(__FILE__) + "/../Constants"


##
# ===== Presentation
#   Text is a class use to display stylize text
#
# ===== Variables
#
#   @label
#   @gtkObject
#   @eventBox
#   @size
#   @font
#   @color
#   @weight
#   @style
#   @textBox
#   @padding
# ===== Methods
#
#   new initialization method
#   update update the display screen
class Text
  @label
  @gtkObject
  @size
  @font
  @color
  @weight
  @style
  @textBox
  @padding

  attr_reader :size, :gtkObject
  attr_writer :weight, :style, :size, :color, :font, :padding

  ##
  # The class' constructor.
  #
  # ===== Attributes
  # * +label+ -
  # * +size+ - default value Constants::TEXT_SIZE
  # * +padding+ - default value 10 px
  # * +
  #-------------------------------------------------
  def initialize(label: "",size: Constants::TEXT_SIZE ,padding: 10, width: nil, height: nil)
    @label=label
    @gtkObject=Gtk::Alignment.new(0.5, 0.5, 0, 0)
    @size=size
    @font="Arial"
    @color="black"
    @weight="bold"
    @style="normal"
    @textBox = Gtk::Label.new(@label)
    @padding=padding
    @textBox.use_markup = true
    @textBox.set_margin_bottom(@padding)
    @textBox.set_margin_top(@padding)
    @textBox.set_margin_right(@padding)
    @textBox.set_margin_left(@padding)
    @gtkObject.add(@textBox)
    if width != nil && height != nil
      setBackgroundSize(width,height)
    end
    apply
  end

  ##
  # Setter of the wrap value of this Text
  # ===== Attributes
  # * +bool+ - true to have a wrap text else false
  #-------------------------------------------------
  def setWrap(bool)
    @textBox.wrap=bool
    self
  end

  ##
  #  Setter of the background of this Text
  # ===== Attributes
  # * +r+ - Value between 0-1 for red color
  # * +g+ - Value between 0-1 for green color
  # * +b+ - Value between 0-1 for blue color
  # * +a+ - Value between 0-1 for opacity
  #-------------------------------------------------
  def setBackground(r,g,b,a)
    @textBox.override_background_color(:normal,Gdk::RGBA.new(r,g,b,a))
    self
  end

  ##
  # Change the label of this Text
  # ===== Attributes
  # * +newLabel+ - new label to display
  #-------------------------------------------------
  def updateLabel(newLabel)
    @label=newLabel
    apply
    self
  end

  ##
  # Set the size of the Text box
  # ===== Attributes
  # * +width+ - width in pixel
  # * +height+ - height in pixel
  #-------------------------------------------------
  def setBackgroundSize(width,height)
    @textBox.set_size_request(width,height)
    self
  end

  ##
  # ===== Attributes
  # * +size+ - size of the margin
  #-------------------------------------------------
  def setMarginBottom(size)
    @textBox.set_margin_bottom(size)
    self
  end

  ##
  # Apply the style,font on the text
  #-------------------------------------------------
  def apply
    @textBox.set_markup("<span style='"+@style.to_s+"' weight='"+@weight.to_s+"' foreground='"+@color.to_s+"' font_desc='"+@font.to_s+" "+@size.to_s+"'>"+@label+"</span>")
  end

  ##
  # Change the color of the text
  # ===== Attributes
  # * +couleur+ - name of the color
  #-------------------------------------------------
  def colorChange(couleur)
    @color=couleur
    apply
  end
end
