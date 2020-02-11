# @Author: Despres Maxence
# @Date:   11-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: Screen.rb
# @Last modified by:   Checkam
# @Last modified time: 11-Feb-2020




require 'gtk3'
require File.dirname(__FILE__) + "/../Constants"


class Screen
  @gtkObject
  @backgroundPath

  def initialize(parent)
    screen = Constants::SCREEN
    @parent=parent
  	@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/fond_low_poly.png")
    @buffer=@buffer.scale(screen.width,screen.height)
  	@buffer2 = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/fond_low_poly.png")
    @buffer2=@buffer2.scale(screen.width,screen.height)
  end

  def applyOn(widget)
    widget.each { |child|
      widget.remove(child)
    }
    widget.add(@gtkObject)
    widget.show_all
  end
end
