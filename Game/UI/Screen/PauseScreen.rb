# @Author: Dubois Clément <Clemdbs>
# @Date:   19-Feb-2020
# @Email:  clement_dubois.etu@univ-lemans.fr
# @Filename: PauseScreen.rb
# @Last modified by:   checkam
# @Last modified time: 18-Mar-2020



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
#

class PauseScreen < Screen

  @gtkObject



  def initialize(pause,win,gameScreen)
    # TO DO
    super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

    @menuScreen = MenuScreen.new(win)

    @gtkObject = Gtk::Table.new(4,4)

    screen=Gdk::Screen.default
    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3
    pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

    #Unpause button to find
    unpauseButton = Button.new(image:pathAssets + "Button/add.png", width: screen.width*0.1,height: screen.height*0.08)
    unpauseButton.onClick(){
    #Do smth
    gameScreen.applyOn(win)
    }

    #Restart button (level)
    restartButton = Button.new(label:"Restart", width: screen.width*0.1,height: screen.height*0.08)
    restartButton.onClick(){
    #Do smth
    }

    #Button to go back to main menu
    backToMenuButton = Button.new(label:"Main menu", width: screen.width*0.1,height: screen.height*0.08)
    backToMenuButton.onClick(){
    #Do smth
    @menuScreen.applyOn(win)
    }

    validate=0
    #Button to able/disable the tracing help
    tracingHelp = Button.new(image:pathAssets + "Button/validate.png", width: screen.width*0.1,height: screen.height*0.1)
    tracingHelp.onClick(){
      if validate == 0
        tracingHelp.setPicture(pathAssets + "Button/undo.png")
        validate = 1
      elsif validate == 1
        tracingHelp.setPicture(pathAssets + "Button/validate.png")
        validate = 0
      end
    }

    #Box horizontal pour le texte
    #Aide au tracé activable/désactivable
    textTrace = Text.new(label:"Aide au tracé activé/désactivé",width:screen.width*0.2, height:screen.height*0.05)
    textTrace.setBackground(1,1,1,1)

    boxTrace = Gtk::Box.new(:horizontal)

    boxTrace.pack_start(textTrace.gtkObject,expand: true, fill: false, padding: 10)


    pause=Text.new(label:"Game paused",width:screen.width*0.5, height:screen.height*0.05)
    pause.setBackground(1,1,1,1)

    #Box concerning label and pause/unpause buttons
    globalBox = Gtk::Box.new(:vertical)
    globalBox.pack_start(pause.gtkObject,expand: true, fill: false, padding: 10)
    globalBox.pack_start(unpauseButton.gtkObject,expand: false, fill: false, padding: 10)
    globalBox.pack_start(restartButton.gtkObject,expand: false, fill: false, padding: 10)
    globalBox.pack_start(tracingHelp.gtkObject,expand: false, fill: false, padding: 10)
    globalBox.add(boxTrace)

    globalBoxH = Gtk::Box.new(:horizontal).add(globalBox)
    globalAli  = Gtk::Alignment.new(0.5, 0, 0, 0).add(globalBoxH)

    #Box concerning the main menu
    menuBox = Gtk::Box.new(:vertical)
    menuBox.add(backToMenuButton.gtkObject)
    menuBoxH = Gtk::Box.new(:horizontal).add(menuBox)
    menuBoxH.add(boxTrace)#A mettre dans la même box que la boite aide au tracé
    menuAli  = Gtk::Alignment.new(0.05, 0.95, 0, 0).add(menuBoxH)
    #
    @gtkObject.attach(menuAli,0,1,0,4)
    @gtkObject.attach(globalAli,0,4,0,4)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)

  end
end
