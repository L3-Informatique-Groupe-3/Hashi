# @Author: Despres Maxence <checkam>
# @Date:   11-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   checkam
# @Last modified time: 16-Feb-2020




require 'gtk3'
require File.dirname(__FILE__) + "/../Constants"

##
# ===== Presentation
#   Screen is a abstract class needed to display all screen
#
# ===== Variables
#    
#   @gtkObject
#   @backgroundPath
#   @parent
#   @buffer
#
# ===== Methods
#
#   new initialization method
#   applyOn Use to display something on a screen
#
class Screen
  @gtkObject
  @backgroundPath
  @parent
  @buffer

  ##
  # The class' constructor.
  #
  # ===== Attributes
  # * +parent+ -
  # * +background+ - default value "/../../../Assets/Backgrounds/fond_low_poly.png"
  #
  #-------------------------------------------------
  def initialize(parent, background="/../../../Assets/Backgrounds/fond_low_poly.png")
    screen = Constants::SCREEN
    @parent=parent
  	@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + background)
    @buffer=@buffer.scale(screen.width,screen.height)
  end

  ##
  # Use to display something on a screen
  #
  # ===== Attributes
  # * +widget+ - widget to display on this screen
  #
  #-------------------------------------------------
  def applyOn(widget)
    widget.each { |child|
      widget.remove(child)
    }
    widget.add(@gtkObject)
    widget.show_all
  end
end
