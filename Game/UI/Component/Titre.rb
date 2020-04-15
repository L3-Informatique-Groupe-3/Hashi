# @Author: Despres Maxence <checkam>
# @Date:   15-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: Titre.rb
# @Last modified by:   checkam
# @Last modified time: 05-Apr-2020

require_relative "./Text"

##
# ===== Presentation
#   Class to create a Title to display
#
# ===== Variables
# @see Text Variables
# ===== Methods
#
#   +new+ - initialization method
#   +updateLabel+ - Change the label of this Text
#   +setWrap+ - Setter of the wrap value of this Text
#   +setBackground+ -  Setter of the background color of this Text
#   +setMarginBottom+ - Set size of the margin bottom of this Text
#   +apply+ - Apply the style,font on the text
#   +colorChange+ - Change the color of the text
class Titre < Text
    @weight
    @font
    @color
    @size
    @gtkObject

    ##
    # The class' constructor.
    # @see Text#new
    #-------------------------------------------------
    def initialize(label: "",size: Constants::TITTLE_SIZE ,padding: 10, width: nil, height: nil)
      super(label:label, size:size, padding: padding, width:width, height: height)
      @weight = "ultrabold"
      @font = "arial"
      @color = "white"
      @size = Constants::TITTLE_SIZE
      apply

      underText = Text.new(label:label, size: Constants::TITTLE_SIZE+2)
      underText.font="arial"
      underText.color="black"
      underText.weight="bold"
      underText.style="normal"
      underText.apply

      @gtkObject.each { |child|
        @gtkObject.remove(child)
      }
      table=Gtk::Table.new(1,1)

      table.attach(@textBox, 0, 1, 0, 1)
      table.attach(underText.gtkObject, 0, 1, 0, 1 )
      @gtkObject.add(table)
    end


end
