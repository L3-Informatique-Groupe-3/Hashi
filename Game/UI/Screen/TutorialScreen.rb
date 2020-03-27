# @Author: Dubois Clement <Clemdbs>
# @Date:   09-Mar-2020
# @Email:  clement_dubois.etu@univ-lemans.fr
# @Filename: TutorialScreen.rb
# @Last modified by:   Clemdbs
# @Last modified time: 09-Mar


require 'gtk3'
require_relative File.dirname(__FILE__) + "/Screen"
require_relative File.dirname(__FILE__) + "/../GridUi"
require_relative File.dirname(__FILE__) + "/../AssetsClass/Asset"

##
# ===== Presentation
#   TutorialScreen is a class that displays the interface of the tutorial 
#
# ===== Variables
#    
#   @gtkObject
#
# ===== Methods
#
#   new initialization method
#
class TutorialScreen < Screen

    @gtkObject

    def initialize(win)

        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        screen=Gdk::Screen.default

        mainMenu = MenuScreen.new(win)

        @gtkObject = Gtk::Table.new(4,4)

        compteur = 0

        textTuto = Text.new(label: "Pour tracer un lien entre 2 îles il faut faire un \n Drag'n drop en partant d'une île et en lachant quand \n on arrive sur l'autre.", width:screen.width*0.2, height:screen.height*0.05)
        image0 = Asset.new(pathAssets + "Tutorial/pic1.png")
        #image0.resize(500,500)
        image1 = Asset.new(pathAssets + "Tutorial/pic2.png")
        #image1.resize(500,500)
        image2 = Asset.new(pathAssets + "Tutorial/pic3.png")
        #image2.resize(500,500)
        image3 = Asset.new(pathAssets + "Tutorial/pic4.png")
        boxPicture = Gtk::Box.new(:horizontal)
        boxPicture2 = Gtk::Box.new(:horizontal)
        boxPictureGlobal= Gtk::Box.new(:horizontal)

        image0.applyOn(boxPicture)
        image1.applyOn(boxPicture2)
        boxPictureGlobal.add(boxPicture)
        boxPictureGlobal.add(boxPicture2)

        #Button to go back to previous window
        previousButton=Button.new(image:pathAssets + "Button/undo.png", width: screen.width*0.1,height: screen.height*0.08)
        previousButton.onClick(){
            # Create screen's changement
            # TO DO

            compteur -= 1

            if compteur < 0
                compteur += 1 
            end
            
            case compteur
            when 0
                #Display screen with pic 0
                textTuto.updateLabel("Pour tracer un lien entre 2 îles il faut faire un \nDrag'n drop en partant d'une île et en lachant quand \non arrive sur l'autre.")
                image0.applyOn(boxPicture)
                image1.applyOn(boxPicture2)
                boxPictureGlobal.add(boxPicture)
                boxPictureGlobal.add(boxPicture2)
                
            when 1 
                #Display screen with pic 1
                textTuto.updateLabel("Pour tracer un second lien entre 2 îles il suffit de cliquer sur le lien déjà existant.")
                image1.applyOn(boxPicture)
                image2.applyOn(boxPicture2)
                boxPictureGlobal.add(boxPicture)
                boxPictureGlobal.add(boxPicture2)
            end

        }

        #Button to go to the next window
        nextButton=Button.new(image:pathAssets + "Button/redo.png", width: screen.width*0.1,height: screen.height*0.08)
        nextButton.onClick(){
            # Create screen's changement
            # TO DO

            compteur += 1
            
            if compteur > 2
                compteur -= 1
            end
            
            case compteur
            when 1 
                #Display screen with pic 1
                textTuto.updateLabel("Pour tracer un second lien entre 2 îles il suffit de cliquer sur le lien déjà existant.")
                image1.applyOn(boxPicture)
                image2.applyOn(boxPicture2)
                boxPictureGlobal.add(boxPicture)
                boxPictureGlobal.add(boxPicture2)           
            when 2
                #Display screen with picture 2
                textTuto.updateLabel("Pour supprimer une liaison entre 2 îles il faut cliquer sur un double lien.")
                image2.applyOn(boxPicture)
                image3.applyOn(boxPicture2)
                boxPictureGlobal.add(boxPicture)
                boxPictureGlobal.add(boxPicture2)
            
            end
            
        }

        #Button to go back to main menu
        backToMenuButton = Button.new(label:"Main menu", width: screen.width*0.1,height: screen.height*0.08)
        backToMenuButton.onClick(){
        #Do smth 
            mainMenu.applyOn(win)
        }

        alignBoxPicture = Gtk::Alignment.new(0.5,0.3,0,0).add(boxPictureGlobal)

        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(textTuto.gtkObject,expand: true, fill: false, padding: 10)
        globalBox.pack_start(alignBoxPicture,expand: true, fill: false, padding: 10)

        boxLeft = Gtk::Alignment.new(0,0.5,0,0).add(previousButton.gtkObject)
        boxRight = Gtk::Alignment.new(1,0.5,0,0).add(nextButton.gtkObject)

        menuAli  = Gtk::Alignment.new(0.5, 0.3, 0, 0).add(globalBox)
        #menuAli2  = Gtk::Alignment.new(0.95, 0.5, 0, 0).add(nextButton.gtkObject)

        @gtkObject.attach(menuAli,0,1,0,4)
        @gtkObject.attach(boxLeft,0,1,0,4)
        @gtkObject.attach(boxRight,0,1,0,4)
    
    end
end