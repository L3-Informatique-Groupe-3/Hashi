# fichier pour l'ecran de victoire
# possede 3 boutons : menuPrincipal, recommencer, suivant (pas toujours du texte, ca peut etre des images)
# on doit afficher le chrono dans un champs delimité
# devant on doit mettre un texte
# au dessus on doit mettre un texte

# menuPrincipal => image sur la gauche et texte sur la droite
# recommencer => image
# suivant => image

# @Author: Noemie Farizon <NoemieFarizon>
# @Date:   11-Feb-2020
# @Email:  noemie.farizon.etu@univ-lemans.fr
# @Filename: VictoryScreen.rb
# @Last modified by:   checkam


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class VictoryScreen < Screen
    @gtkObject
    @chronoUi

    def initialize(win, game, uiManager)
        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

        screen=Gdk::Screen.default
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        menuTitle=Titre.new(label:"Victoire", width:screen.width*0.2, height:screen.height*0.05)
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
            #aller au menu principal
            uiManager.mainmenu.applyOn(win)
        }

        #creation du bouton recommencer
        replayButton=Button.new(image:pathAssets + "Button/replay.png", width: screen.width*0.1,height: screen.height*0.08)
        replayButton.resizeImage(40,40)
        replayButton.onClick(){
            #recharger le niveau sur lequel on etait
            game.restart
            gameScreen = GameScreen.new(win,game,uiManager)
            gameScreen.applyOn(win)
        }

        # save = uiManager.adventureScreen.save
        # if save != nil
        #   info = save.loadGame(save.getNextMap())
        #   #filePath = AdventureSave.getFilePath(save.idSave, countryNumber, levelNumber)
        # end
        #creation du bouton suivant
        # nextButton=Button.new(image:pathAssets + "Button/next.png", width: screen.width*0.1,height: screen.height*0.08)
        # nextButton.resizeImage(40,40)
        # nextButton.onClick(){
          # if(save != nil && AdventureSave.hasSave(filePath))
          #   LoadSaveScreen.new(
          #     window: window,
          #     uiManager: uiManager,
          #     loadButtonAction: lambda {
          #       game = AdventureSave.loadSave(filePath)
          #       gameScreen = GameScreen.new(window,game,uiManager,
          #         saveAction: lambda{AdventureSave.save(filePath, game)},
          #         victoryAction: lambda{
          #           save.loadGame(countryNumber * 100 + levelNumber)
          #           save.completeMap
          #           AdventureSave.delete(filePath)
          #         })
          #       game.resume
          #       gameScreen.applyOn(window)
          #     },
          #     restartButtonAction: lambda {
          #       game = AdventureSave.loadSave(filePath)
          #       game.restart
          #       gameScreen = GameScreen.new(window,game,uiManager,
          #         saveAction: lambda{AdventureSave.save(filePath, game)},
          #         victoryAction: lambda{
          #           save.loadGame(countryNumber * 100 + levelNumber)
          #           save.completeMap
          #           AdventureSave.delete(filePath)
          #         })
          #       gameScreen.applyOn(window)
          #     },
          #     backButtonAction: lambda { self.applyOn(window) }
          #   ).applyOn(window)
          # else
          #   game = Party.new(info[0])
          #   gameScreen = GameScreen.new(window,game,uiManager,
          #     saveAction: lambda{AdventureSave.save(filePath, game)},
          #     victoryAction: lambda{
          #       save.loadGame(countryNumber * 100 + levelNumber)
          #       save.completeMap
          #       AdventureSave.delete(filePath)
          #     })
          #   gameScreen.applyOn(window)
          # end
        # }

        chronoBox = Gtk::Box.new(:horizontal)
        chronoBox.pack_start(chronoText.gtkObject, expand: true, fill: false, padding: 20)
        chronoBox.pack_start(@chronoUi.gtkObject, expand: true, fill: false, padding: 20)

        buttonBox = Gtk::Box.new(:horizontal)
        buttonBox.pack_start(menuButton.gtkObject, expand: true, fill: false, padding: 0)
        buttonBox.pack_start(replayButton.gtkObject, expand: true, fill: false, padding: 0)
        #buttonBox.pack_start(nextButton.gtkObject, expand: true, fill: false, padding: 0)

        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(menuTitle.gtkObject, expand: true, fill: false, padding: 10)
        globalBox.pack_start(chronoBox, expand: true, fill: false, padding: 10)
        globalBox.pack_start(buttonBox, expand: true, fill: false, padding: 10)

        @gtkObject = Gtk::Table.new(4,4)
        @gtkObject.attach(globalBox,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)

    end

end
