################################################################################
# File: VictoryRankedScreen.rb                                                 #
# Project: Hashi                                                              #
# File Created: Sunday, 12th April 2020 6:34:35 pm                             #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Wednesday, 15th April 2020 6:26:46 pm                         #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require 'gtk3'
require_relative "./Screen"
require_relative "../Popup.rb"

##
# ===== Presentation
# This class is a Screen. It represents the victory rank screen
#
# ===== Variables
# * +chronoUi+ - The chrono ui which displays the time
# * +nicknameInput+ - Contains true if the time has been saved
# * +game - The game which is finished
# * +entry+ - The entry where the user enters his nickname
# * +uiManager+ - The UI manager
#
# ===== Methods
# * +saveNickname+ - Save the time in the database
# * +createPopup+ - Create an info popup
##
class VictoryRankedScreen < Screen
    @gtkObject
    @chronoUi
    @nicknameInput
    @game
    @entry
    @uiManager

    ##
    # The class' constructor.
    #
    # ===== Attributes
    # * +win+ - The window to applicate the screen
    # * +game+ - The game which is finished
    # * +uiManager+ - THe UI manager
    # -----------------------------------
    def initialize(win, game, uiManager)
        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

        @nicknameInput = false
        @game = game
        @uiManager = uiManager

        screen=Gdk::Screen.default
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        menuTitle=Titre.new(label:"Victoire", width:screen.width*0.2, height:screen.height*0.05)

        # Nickname input
        @entry = Gtk::Entry.new
        @entry.set_placeholder_text("Saisir votre pseudo")
        @entry.set_max_length(7)

        # Nickname validation
        nicknameValidateBtn = Button.new(image: pathAssets + "Button/validate.png", width: screen.height * 0.1, height: screen.height * 0.1, padding: 0)
        nicknameValidateBtn.resizeImage(screen.height * 0.1, screen.height * 0.1)
        nicknameValidateBtn.onClick(){
            saveNickname(uiManager.rankedLevel)
        }

        #creation du texte avant la zone d'affichage du chrono
        chronoText=Text.new(label:"Votre temps :", width:screen.width*0.2, height:screen.height*0.05)
        chronoText.setBackgroundSize(screen.width*0.2,screen.height*0.05)
        chronoText.setBackground(1,1,1,1)
        #creation de la zone d'affichage du chrono
        @chronoUi=ChronoUi.new(game.getTimer)
        # chronoZone=Text.new(width:screen.width*0.2, height:screen.height*0.05)

        #creation du bouton menuPrincipal
        menuButton=Button.new(image:pathAssets + "Button/menu.png", width: screen.width*0.1,height: screen.height*0.08)
        menuButton.resizeImage(40,40)
        menuButton.onClick(){
            if(@nicknameInput)
                #aller au menu principal
                uiManager.rankScreen.applyOn(win)
                uiManager.victoryScreenType = :normal
            end
        }

        #creation du bouton recommencer
        replayButton=Button.new(image:pathAssets + "Button/replay.png", width: screen.width*0.1,height: screen.height*0.08)
        replayButton.resizeImage(40,40)
        replayButton.onClick(){
            if(@nicknameInput)
                #recharger le niveau sur lequel on etait
                game.restart
                gameScreen = GameScreen.new(win,game,uiManager, lambda { uiManager.rankScreen.applyOn(win) },)
                gameScreen.applyOn(win)
            end
        }


        nicknameInputBox = Gtk::Grid.new
        nicknameInputBox.set_halign(Gtk::Align::CENTER)
        nicknameInputBox.attach(@entry, 0, 0, 3, 1)
        nicknameInputBox.attach(nicknameValidateBtn.gtkObject, 3, 0, 1, 1)

        chronoBox = Gtk::Box.new(:horizontal)
        chronoBox.pack_start(chronoText.gtkObject, expand: true, fill: false, padding: 20)
        chronoBox.pack_start(@chronoUi.gtkObject, expand: true, fill: false, padding: 20)

        buttonBox = Gtk::Box.new(:horizontal)
        buttonBox.pack_start(menuButton.gtkObject, expand: true, fill: false, padding: 0)
        buttonBox.pack_start(replayButton.gtkObject, expand: true, fill: false, padding: 0)

        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(menuTitle.gtkObject, expand: true, fill: false, padding: 10)
        globalBox.pack_start(nicknameInputBox, expand: false, fill: false, padding: 10)
        globalBox.pack_start(chronoBox, expand: true, fill: false, padding: 10)
        globalBox.pack_start(buttonBox, expand: true, fill: false, padding: 10)

        @gtkObject = Gtk::Table.new(4,4)
        @gtkObject.attach(globalBox,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)

    end

    private

    ##
    # Save the time in the database
    #
    # ===== Attributes
    # * +levelNumber+ - the level number
    # ---
    def saveNickname(levelNumber)
        if(@nicknameInput == false && @entry.text_length > 0)
            rank = Ranked.access()
            rank.loadGame(levelNumber)

            finalTime = @game.getTimer
            rank.saveTime?(@entry.text, finalTime.min * 60 + finalTime.sec)

            @uiManager.victoryScreenType = :normal

            @nicknameInput = true
            createPopup("Votre temps a été sauvegardé")
        elsif(@nicknameInput == true)
            createPopup("Votre temps est déjà enregistré")
        else
            createPopup("Saisissez un pseudo valide")
        end
    end

    ##
    # Create an info popup
    #
    # ===== Attributes
    # * +message+ - the message to display
    # ---
    def createPopup(message)
        popup = Popup.new(titre: "INFO")
        popup.creerTitre(titre: message)
        popup.creerZoneBoutons
        popup.addBouton(titre: "Ok"){
            popup.destroy
        }
        popup.run
    end
end
