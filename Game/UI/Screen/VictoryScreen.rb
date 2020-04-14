# @Author: Noemie Farizon <NoemieFarizon>
# @Date:   11-Feb-2020
# @Email:  noemie.farizon.etu@univ-lemans.fr
# @Filename: VictoryScreen.rb
# @Last modified by:   checkam


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

##
# ===== Presentation
#   PageManager is a class that displays a list of component with button to change the component display
#
# ===== Variables
#
#  * +gtkObject+ - Object to display
#
# ===== Methods
#
#   +new+ - initialization method
#
class VictoryScreen < Screen
    @gtkObject

    ##
    # The class' constructor.
    #
    # ===== Attributes
    # * +win+ - The window to applicate the screen
    # * +game+ - The game which is finished
    # * +uiManager+ - The UI manager
    # * +backAction+ - action do when back button is click 
    # -----------------------------------
    def initialize(win, game, uiManager, backAction)
        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

        screen=Gdk::Screen.default
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        menuTitle=Titre.new(label:"Victoire", width:screen.width*0.2, height:screen.height*0.05)
        chronoText=Text.new(label:"Votre temps :", width:screen.width*0.2, height:screen.height*0.05)
        chronoText.setBackgroundSize(screen.width*0.2,screen.height*0.05)
        chronoText.setBackground(1,1,1,1)
        chronoUi=ChronoUi.new(game.getTimer)

        menuButton=Button.new(label: "Retour à la selection", width: screen.width*0.1,height: screen.height*0.08, size: 20)
        menuButton.onClick(){
            backAction.call
        }

        replayButton=Button.new(image:pathAssets + "Button/replay.png", width: screen.width*0.1,height: screen.height*0.08)
        replayButton.resizeImage(40,40)
        replayButton.onClick(){
            game.restart
            gameScreen = GameScreen.new(win,game,uiManager, backAction)
            gameScreen.applyOn(win)
        }


        chronoBox = Gtk::Box.new(:horizontal)
        chronoBox.pack_start(chronoText.gtkObject, expand: true, fill: false, padding: 20)
        chronoBox.pack_start(chronoUi.gtkObject, expand: true, fill: false, padding: 20)

        buttonBox = Gtk::Box.new(:horizontal)
        buttonBox.pack_start(menuButton.gtkObject, expand: true, fill: false, padding: 0)
        buttonBox.pack_start(replayButton.gtkObject, expand: true, fill: false, padding: 0)

        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(menuTitle.gtkObject, expand: true, fill: false, padding: 10)
        globalBox.pack_start(chronoBox, expand: true, fill: false, padding: 10)
        globalBox.pack_start(buttonBox, expand: true, fill: false, padding: 10)

        @gtkObject = Gtk::Table.new(4,4)
        @gtkObject.attach(globalBox,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)

    end

end
