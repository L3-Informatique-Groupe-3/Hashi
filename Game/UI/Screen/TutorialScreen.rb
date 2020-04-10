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

    def initialize(win, uiManager)

        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        screen=Gdk::Screen.default
        @gtkObject = Gtk::Table.new(4,4)

        text1 = "Pour tracer un lien entre 2 îles il faut faire un \nDrag'n drop en partant d'une île et en lachant quand \non arrive sur l'autre."
        text2 = "Pour tracer un second lien entre 2 îles il suffit de cliquer sur le lien déjà existant."
        text3 = "Pour supprimer une liaison entre 2 îles il faut cliquer sur un double lien."

        image0 = "Tutorial/pic1.png"
        #image0.resize(500,500)
        image1 = "Tutorial/pic2.png"
        #image1.resize(500,500)
        image2 = "Tutorial/pic3.png"
        #image2.resize(500,500)
        image3 = "Tutorial/pic4.png"

        pageManager = PageManager.new()
        pageManager.addComponent(TutorialComponent.new(label:text1))
        pageManager.addComponent(TutorialComponent.new(label:text2))
        pageManager.addComponent(TutorialComponent.new(label:text3))
        pageManager.showFirst()

        #Button to go back to main menu
        backToMenuButton = Button.new(label:"Menu Principal", width: screen.width*0.1,height: screen.height*0.08, size: 20)
        backToMenuButton.onClick(){
        #Do smth
          uiManager.mainmenu.applyOn(win)
        }

        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(pageManager.gtkObject,expand: true, fill: false, padding: 10)

        @gtkObject.attach(Gtk::Alignment.new(0.05, 0.95, 0, 0).add(backToMenuButton.gtkObject),0,4,0,4)
        @gtkObject.attach(globalBox,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
    end
end
