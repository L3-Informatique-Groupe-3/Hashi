# @Author: Despres Maxence <checkam>
# @Date:   10-Apr-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: PageManager.rb
# @Last modified by:   checkam
# @Last modified time: 10-Apr-2020



require 'gtk3'
require_relative File.dirname(__FILE__) + "/../AssetsClass/Asset"

##
# ===== Presentation
#   PageManager is a class that displays a list of component with button to change the component display
#
# ===== Variables
#
#  * +gtkObject+ - Object to display
#  * +globalBox+ - box to display
#  * +listComponent+ - List of component to display
#
# ===== Methods
#
#   +new+ - initialization method
#   +addComponent+ - add a component to the listComponent
#   +removeAll+ - remove all display component
#   +showFirst+ - show first component
#
class PageManager
    @gtkObject
    @globalBox
    @listComponent

    attr_reader :gtkObject

    def initialize()

        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        screen=Gdk::Screen.default

        @gtkObject = Gtk::Table.new(4,4)

        compteur = 0
        @globalBox = Gtk::Box.new(:horizontal)

        @listComponent = []


        #Button to go back to previous window
        previousButton=Button.new(image:pathAssets + "Button/undo.png", width: screen.width*0.1,height: screen.height*0.08)
        previousButton.onClick(){
            # Create screen's changement
            removeAll()
            if compteur > 0
              compteur-=1
            end
            @globalBox.add(@listComponent[compteur].gtkObject)
            @globalBox.show_all
        }

        #Button to go to the next window
        nextButton=Button.new(image:pathAssets + "Button/redo.png", width: screen.width*0.1,height: screen.height*0.08)
        nextButton.onClick(){
            # Create screen's changement
            removeAll()
            if compteur < @listComponent.length - 1
              compteur+=1
            end
            @globalBox.add(@listComponent[compteur].gtkObject)
            @globalBox.show_all
        }

        alignBoxPicture = Gtk::Alignment.new(0.5,0.3,0,0).add(@globalBox)


        boxLeft = Gtk::Alignment.new(0,0.5,0,0).add(previousButton.gtkObject)
        boxRight = Gtk::Alignment.new(1,0.5,0,0).add(nextButton.gtkObject)

        @gtkObject.attach(alignBoxPicture,0,4,0,4)
        @gtkObject.attach(boxLeft,0,1,0,4)
        @gtkObject.attach(boxRight,0,1,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
    end

    def addComponent(component)
      @listComponent << component
    end

    def removeAll()
      @globalBox.each { |x| @globalBox.remove(x) }
    end

    def showFirst()
      removeAll()
      if @listComponent.length >= 1
        @globalBox.add(@listComponent[0].gtkObject)
      end
    end
end
