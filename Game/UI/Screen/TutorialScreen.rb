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
#  * +gtkObject+ - Object to display
#
# ===== Methods
#
#   new initialization method
#
class TutorialScreen < Screen

    @gtkObject

    ##
    # The class' constructor.
    #
    #-------------------------------------------------
    def initialize(win, uiManager)

        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        screen=Gdk::Screen.default
        @gtkObject = Gtk::Table.new(4,4)

        text1 = "Pour tracer un lien entre 2 îles il faut faire un \nDrag'n drop en partant d'une île et en lachant quand \non arrive sur l'autre."
        text2 = "Pour tracer un second lien entre 2 îles il suffit de cliquer sur le lien déjà existant."
        text3 = "Pour supprimer une liaison entre 2 îles il faut cliquer sur un double lien."

        image0 = "Tutorial/pic1.png"
        image1 = "Tutorial/pic2.png"
        image2 = "Tutorial/pic3.png"
        image3 = "Tutorial/pic4.png"

        pageManager = PageManager.new()
        pageManager.addComponent(TutorialComponent.new(label:"En ce qui concerne l'interface du jeu il y a :\n
        -le bouton d'aide,\n
        -le bouton d'hypothèse, \n
        -le bouton de confirmation, d'annulation d'une hypothèse,\n
        -le bouton de retour en arrière,\n
        -le bouton de retour en avant ,\n
        -le bouton de pause,\n
        - et le bouton de vérification de la partie."))
        pageManager.addComponent(TutorialComponent.new(label:"Le bouton d'aide permet d'afficher des aides à l'écran de plus en plus guidées.",image1:"Tutorial/game.png"))
        pageManager.addComponent(TutorialComponent.new(
        label:"Le bouton d'hypothèse '+' permet de créer une hypothèse.\n\nCela permet de figer la grille dans l'état actuelle et de faire des modifications qui pourront être annulées (croix) ou validées(coche) avec les boutons prévus à cet effet.",
        image1:"Tutorial/game.png"))

        pageManager.addComponent(TutorialComponent.new(label:"Les boutons de retour arrière(flèche vers la gauche), avant(flèche vers la droite)\n\npermettent de revenir au coup qui a été joué juste avant jusqu'au début de la partie,\n\nou d'annuler ces retours arrière jusqu'au dernier coup qui a été joué.",
        image1:"Tutorial/game.png"))

        pageManager.addComponent(TutorialComponent.new(label:"Le bouton de pause permet de mettre le jeu en pause en arrêtant le chrono et en accédant à quelques options comme l'aide au tracé ou encore le retour au menu principal.",
        image1:"Tutorial/game.png",image2:"Tutorial/pause.png"))

        pageManager.addComponent(TutorialComponent.new(label:"Chaque appui sur le bouton d'aide ou le bouton de check coûtent du temps.",
        image1:"Tutorial/game.png"))

        pageManager.addComponent(TutorialComponent.new(label:text1,image1: image0,image2: image1))
        pageManager.addComponent(TutorialComponent.new(label:text2,image1: image1,image2: image2))
        pageManager.addComponent(TutorialComponent.new(label:text3,image1: image2,image2: image3))
        pageManager.showFirst()


        backToMenuButton = Button.new(label:"Retour à la sélection", width: screen.width*0.1,height: screen.height*0.08, size: 20)
        backToMenuButton.onClick(){
          uiManager.tutorialmenu.applyOn(win)
        }
        @gtkObject.attach(Gtk::Alignment.new(0.05, 0.95, 0, 0).add(backToMenuButton.gtkObject),0,4,0,4)
        @gtkObject.attach(pageManager.gtkObject,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
    end
end
