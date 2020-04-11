# @Author: Dubois Clément <Clemdbs>
# @Date:   19-Feb-2020
# @Email:  clement_dubois.etu@univ-lemans.fr
# @Filename: PauseScreen.rb
# @Last modified by:   checkam
# @Last modified time: 03-Apr-2020



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../AssetsClass/Asset"
require File.dirname(__FILE__) + "/../Constants"

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



  def initialize(win,gameScreen,uiManager, saveAction: nil)
    # TO DO
    super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

    @gtkObject = Gtk::Table.new(4,4)

    screen=Gdk::Screen.default
    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3
    pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

    #Unpause button to find
    unpauseButton = Button.new(label: "Reprendre", width: screen.width*0.1,height: screen.height*0.08)
    unpauseButton.onClick(){

      gameScreen.resume()
      gameScreen.applyOn(win)
    }

    #Restart button (level)
    restartButton = Button.new(label:"Recommencer", width: screen.width*0.1,height: screen.height*0.08)
    restartButton.onClick(){

      gameScreen.restart()
      gameScreen.applyOn(win)
    }

    #Button to go back to main menu
    backButton = Button.new(label:"Menu Principal", width: screen.width*0.1,height: screen.height*0.08, size: 20)
    backButton.onClick(){
      saveAction.call if saveAction != nil
      uiManager.mainmenu.applyOn(win)
    }


    #Box horizontal for the text
    #Tracing help enable/disable
    textTrace = Text.new(label:"Aide au tracé",width:screen.width*0.2, height:screen.height*0.1)
    textTrace.setBackground(1,1,1,1)

    boxTrace = Gtk::Box.new(:horizontal)

    #Button to able/disable the tracing help
    tracingEnable = Button.new(label: "Activé", width: screen.width*0.1,height:screen.height*0.08, size: Constants::TEXT_SIZE)
    tracingEnable.resizeImage(40,40)
    tracingEnable.setFocusActive(false)
    if gameScreen.gridUi.tracerActive?
      tracingEnable.colorChange("green")
    else
      tracingEnable.colorChange("red")
    end


    tracingDisable = Button.new(label: "Désactivé", width: screen.width*0.1,height:screen.height*0.08, size: Constants::TEXT_SIZE)
    tracingDisable.resizeImage(40,40)
    tracingDisable.setFocusActive(false)
    if gameScreen.gridUi.tracerActive?
      tracingDisable.colorChange("red")
    else
      tracingDisable.colorChange("green")
    end

    tracingDisable.onClick(){
      gameScreen.gridUi.setTracer(false)
      tracingEnable.colorChange("red")
      tracingDisable.colorChange("green")
    }
    tracingEnable.onClick(){
      gameScreen.gridUi.setTracer(true)
      tracingEnable.colorChange("green")
      tracingDisable.colorChange("red")
    }

    boxTrace.pack_start(textTrace.gtkObject,expand: true, fill: false, padding: 10)
    boxTrace.pack_start(tracingEnable.gtkObject,expand: true, fill: false, padding: 10)
    boxTrace.pack_start(tracingDisable.gtkObject,expand: true, fill: false, padding: 10)
    #Title of the window
    pause=Titre.new(label:"Pause")

    #Box concerning label and pause/unpause buttons
    globalBox = Gtk::Box.new(:vertical)
    globalBox.pack_start(pause.gtkObject,expand: true, fill: false, padding: 10)
    globalBox.pack_start(unpauseButton.gtkObject,expand: false, fill: false, padding: 10)
    globalBox.pack_start(restartButton.gtkObject,expand: false, fill: false, padding: 10)
    globalBox.add(boxTrace)

    globalBoxH = Gtk::Box.new(:horizontal).add(globalBox)
    globalAli  = Gtk::Alignment.new(0.5, 0, 0, 0).add(globalBoxH)

    #Box concerning the main menu
    menuBoxH = Gtk::Box.new(:horizontal)
    menuBoxH.add(boxTrace)
    menuAli  = Gtk::Alignment.new(0.05, 0.95, 0, 0).add(menuBoxH)

    @gtkObject.attach( Gtk::Alignment.new(0.05, 0.95, 0, 0).add(backButton.gtkObject),0,4,0,4)
    @gtkObject.attach(menuAli,0,1,0,4)
    @gtkObject.attach(globalAli,0,4,0,4)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)

  end
end
