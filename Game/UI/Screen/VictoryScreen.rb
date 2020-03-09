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
# @Last modified by:   s174383


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class VictoryScreen < Screen
    @gtkObject
    @chronoUi
    
    def initialize(win, gameScreen)
        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

        @menuScreen = MenuScreen.new(win)

        screen=Gdk::Screen.default
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"
        
        #creation du texte avant la zone d'affichage du chrono
        chronoText=Text.new(label:"Votre temps :", width:screen.width*0.2, height:screen.height*0.05)

        #creation de la zone d'affichage du chrono
        @chronoUi=ChronoUi.new(300)
        # chronoZone=Text.new(width:screen.width*0.2, height:screen.height*0.05)

        #creation du bouton menuPrincipal
        menuButton=Button.new(image:pathAssets + "Button/menu.png", width: screen.width*0.1,height: screen.height*0.08)
        menuButton.onClick(){
            #aller au menu principal
            @menuScreen.applyOn(win)
        }

        #creation du bouton recommencer
        replayButton=Button.new(image:pathAssets + "Button/replay.png", width: screen.width*0.1,height: screen.height*0.08)
        replayButton.onClick(){
            #recharger le niveau sur lequel on etait
        }

        #creation du bouton suivant
        nextButton=Button.new(image:pathAssets + "Button/next.png", width: screen.width*0.1,height: screen.height*0.08)
        nextButton.onClick(){
            #aller au prochain niveau
        }

        chronoBox = Gtk::Box.new(:horizontal)
        chronoBox.pack_start(chronoText.gtkObject, expand: true, fill: false, padding: 50)
        chronoBox.pack_start(@chronoUi.gtkObject, expand: true, fill: false, padding: 50)

        buttonBox = Gtk::Box.new(:horizontal)
        buttonBox.pack_start(menuButton.gtkObject, expand: true, fill: false, padding: 0)
        buttonBox.pack_start(replayButton.gtkObject, expand: true, fill: false, padding: 0)
        buttonBox.pack_start(nextButton.gtkObject, expand: true, fill: false, padding: 0)
        
        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(chronoBox, expand: true, fill: false, padding: 10)
        globalBox.pack_start(buttonBox, expand: true, fill: false, padding: 10)

        @gtkObject = Gtk::Table.new(4,4)
        @gtkObject.attach(globalBox,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
        
    end

end