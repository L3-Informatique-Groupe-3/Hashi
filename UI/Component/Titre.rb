# @Author: Despres Maxence <checkam>
# @Date:   15-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: Titre.rb
# @Last modified by:   checkam
# @Last modified time: 16-Feb-2020

class Titre < Text
    ##
    # The class' constructor.
    #-------------------------------------------------
    def initialize(label: "",size: Constants::TITTLE_SIZE ,padding: 10, width: nil, height: nil)
      super(label:label, size:size, padding: padding, width:width, height: height)
      @weight = "ultrabold"
      @font = "arial"
      @color = "empty"
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
      table=Gtk::Table.new(3,3)
      table.attach(@eventBox, 1, 2, 1, 2)
      table.attach(underText.gtkObject, 0, 3, 0, 3)
      @gtkObject.add(table)
    end


end
