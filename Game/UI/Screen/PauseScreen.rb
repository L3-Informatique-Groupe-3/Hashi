# @Author: Dubois Clément <Clemdbs>
# @Date:   19-Feb-2020
# @Email:  clement_dubois.etu@univ-lemans.fr
# @Filename: PauseScreen.rb
# @Last modified by:   Clemdbs
# @Last modified time: 19-Feb-2020



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../AssetsClass/Asset"

##
# ===== Presentation
#   PauseScreen is a class that displays the interface of the pause menu
#
# ===== Variables
#
#   
#
# ===== Methods
#
#   new initialization method
#   update update the display screen
#

class PauseScreen < Screen

  @pause
  @gtkObject

  def initialize(pause,win,gameScreen)
    # TO DO
    super(win,"/../../../Assets/Backgrounds/fond-naturel.png")
    @pause = pause
    
    @gtkObject = Gtk::Table.new(4,4)

    screen=Gdk::Screen.default
    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3
    pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

    #Bouton unpause en png à trouver
    unpauseButton = Button.new(image:pathAssets + "Button/add.png", width: screen.width*0.1,height: screen.height*0.08)
    unpauseButton.onClick(){
    #Do smth
    gameScreen.applyOn(win)
    }

    #Bouton recommencer le niveau
    restartButton = Button.new(label:"Recommencer", width: screen.width*0.1,height: screen.height*0.08)
    restartButton.onClick(){
    #Do smth
    }

    #Bouton pour retourner au menu principal
    backToMenuButton = Button.new(label:"Menu principal", width: screen.width*0.1,height: screen.height*0.08)
    backToMenuButton.onClick(){
    #Do smth 
    }
      
    pause=Text.new(label:"Partie en pause",width:screen.width*0.5, height:screen.height*0.05)
    pause.setBackground(1,1,1,1)

    #Box concernant le label et les boutons unpause et restart
    globalBox = Gtk::Box.new(:vertical)
    globalBox.pack_start(pause.gtkObject,expand: true, fill: false, padding: 10)
    globalBox.pack_start(unpauseButton.gtkObject,expand: false, fill: false, padding: 10)
    globalBox.pack_start(restartButton.gtkObject,expand: false, fill: false, padding: 10)

    globalBoxH = Gtk::Box.new(:horizontal).add(globalBox)
    globalAli  = Gtk::Alignment.new(0.5, 0, 0, 0).add(globalBoxH)

    #Box concernant le bouton menu principal
    menuBox = Gtk::Box.new(:vertical)
    menuBox.add(backToMenuButton.gtkObject)
    menuBoxH = Gtk::Box.new(:horizontal).add(menuBox)
    menuAli  = Gtk::Alignment.new(0.05, 0.95, 0, 0).add(menuBoxH)
    #
    @gtkObject.attach(menuAli,0,1,0,4)
    @gtkObject.attach(globalAli,0,4,0,4)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
      
  end
end