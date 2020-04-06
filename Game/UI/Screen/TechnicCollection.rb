# @Author: Dubois Clement <Clemdbs>
# @Date:   03-Apr-2020
# @Email:  clement_dubois.etu@univ-lemans.fr
# @Filename: MenuTutorial.rb
# @Last modified by:   Clemdbs
# @Last modified time: 03-Apr


require 'gtk3'
require_relative File.dirname(__FILE__) + "/Screen"
require_relative File.dirname(__FILE__) + "/../GridUi"
require_relative File.dirname(__FILE__) + "/../AssetsClass/Asset"

##
# ===== Presentation
#   TechnicCollection is a class that displays the interface of the menu tutorial 
#
# ===== Variables
#    
#   @gtkObject
#
# ===== Methods
#
#   new initialization method
#
class TechnicCollection < Screen

    @gtkObject

    def initialize(win, uiManager)

        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        screen=Gdk::Screen.default

        mainMenuScreen = MenuScreen.new(win, uiManager)

        @gtkObject = Gtk::Table.new(4,4)

        backToMenuButton = Button.new(label:"Main menu", width: screen.width*0.1,height: screen.height*0.08)
        backToMenuButton.onClick(){
            uiManager.mainMenuScreen.applyOn(win)
        }

        titre1 = Text.new(label: "Techniques pour débuter", width:screen.width*0.2, height:screen.height*0.05)
        titre1.setBackground(1,1,1,1)
        texte1 = Text.new(label:"-Si un 4 est dans un coin, il doit être relié deux fois par deux ponts à ses deux voisins.\n
        -Si un 8 est au milieu, il doit absolument être relié par deux ponts à tout ses voisins.\n
        -Si un 6 est sur un bord de la grille, il doit aussi être relié par deux ponts à tout ses voisins.");
        texte1.setBackground(1,1,1,1)

        titre2 = Text.new(label: "Techniques de bases", width:screen.width*0.2, height:screen.height*0.05)
        titre2.setBackground(1,1,1,1)
        texte2 = Text.new(label:"-Il faut essayer de repérer les îles qui n'auraient qu'un seul voisin.\n
        -Si il y a un 3 dans un coin alors il aura un voisin relié avec un pont et un autre avec deux.\n
        -Si c'est un 5 sur un bord de la grille il est relié par un pont à tout ses voisins au minimum (deux ponts à deux voisins).\n
        -Si il y a un 7 au milieu de la grille il doit être relié au moins par un pont à tout ses voisins (deux ponts à 3 de ses voisins).\n
        -Si un 3, un 5 ou un 7, toujours dans les mêmes conditions que juste avant, ont pour voisin un 1, alors tout leurs autres voisins seront reliés par deux ponts.\n
        -Si un 4 a trois voisins dont deux qui sont des 1, le dernier sera relié par deux ponts.");
        texte2.setBackground(1,1,1,1)

        titre3 = Text.new(label: "Techniques d'isolation", width:screen.width*0.2, height:screen.height*0.05)
        titre3.setBackground(1,1,1,1)
        texte3 = Text.new(label:"-Si deux 1 ou deux 2 sont voisins entre eux, il ne faut pas les relier avec le maximum de pont. Cela créerais une isolation.\n
        -Si une île a deux voisins, il ne faut pas saturer le nombre de pont de chaque île pour éviter que l'île et ses voisins forment un circuit fermé.\n
        -Si toutes les îles dans la grille sont saturés sauf une, faites en sorte de ne pas créer un isolement sans avoir fini totalement la grille.\n
        -Il faut faire attention quand vous ajoutez un pont aux enchaînements de 2 et de 3 pour ne pas créer un isolement.\n
        -Enfin il faut faire attention de ne pas isoler une île en créant des ponts tout autour");
        texte3.setBackground(1,1,1,1)

        menuBox = Gtk::Box.new(:vertical)
        menuBox.add(backToMenuButton.gtkObject)

        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(titre1.gtkObject,expand: true, fill: false, padding: 10)
        globalBox.pack_start(texte1.gtkObject,expand: true, fill: false, padding: 10)
        globalBox.pack_start(titre2.gtkObject,expand: true, fill: false, padding: 10)
        globalBox.pack_start(texte2.gtkObject,expand: true, fill: false, padding: 10)
        globalBox.pack_start(titre3.gtkObject,expand: true, fill: false, padding: 10)
        globalBox.pack_start(texte3.gtkObject,expand: true, fill: false, padding: 10)

        globalAli  = Gtk::Alignment.new(0.5, 0, 0, 0).add(globalBox)

        menuAli2  = Gtk::Alignment.new(0.05, 0.95, 0, 0).add(menuBox)
        @gtkObject.attach(menuAli2,0,1,0,4)
        @gtkObject.attach(menuAli,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)

    end
end