# @Author: Dubois Clement <Clemdbs>
# @Date:   03-Apr-2020
# @Email:  clement_dubois.etu@univ-lemans.fr
# @Filename: MenuTutorial.rb
# @Last modified by:   Clemdbs
# @Last modified time: 03-Apr


require 'gtk3'
require_relative File.dirname(__FILE__) + "/Screen"
require_relative File.dirname(__FILE__) + "/../GridUi"
require_relative File.dirname(__FILE__) + "/../AssetsClass/Asset"

##
# ===== Presentation
#   MenuTutorial is a class that displays the interface of the menu tutorial 
#
# ===== Variables
#    
#   @gtkObject
#
# ===== Methods
#
#   new initialization method
#
class MenuTutorial < Screen

    @gtkObject

    def initialize(win, uiManager)

        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        screen=Gdk::Screen.default

        mainMenuScreen = MenuScreen.new(win, uiManager)
        tutoScreen = TutorialScreen.new(win, uiManager)
        collecScreen = TechnicCollection.new(win, uiManager)

        @gtkObject = Gtk::Table.new(4,4)

        tutorialButton = Button.new(label:"Tutorial", width: screen.width*0.1,height: screen.height*0.1)
        tutorialButton.onClick(){
            uiManager.tutoScreen.applyOn(win)
        }

        collectionButton = Button.new(label:"Technical collection", width: screen.width*0.1,height: screen.height*0.1)
        collectionButton.onClick(){
            uiManager.collecScreen.applyOn(win)
        }

        backToMenuButton = Button.new(label:"Main menu", width: screen.width*0.1,height: screen.height*0.08)
        backToMenuButton.onClick(){
            uiManager.mainMenuScreen.applyOn(win)
        }

        menuBox = Gtk::Box.new(:vertical)
        menuBox.add(backToMenuButton.gtkObject)

        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(tutorialButton.gtkObject,expand: true, fill: false, padding: 10)
        globalBox.pack_start(collectionButton.gtkObject,expand: false, fill: false, padding: 10)

        globalAli  = Gtk::Alignment.new(0.5, 0, 0, 0).add(globalBox)
        menuAli  = Gtk::Alignment.new(0.05, 0.95, 0, 0).add(menuBox)

        @gtkObject.attach(globalAli,0,4,0,4)
        @gtkObject.attach(menuAli,0,1,0,4)

        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
          
      end
 end