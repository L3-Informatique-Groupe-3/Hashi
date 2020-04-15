# @Author: Dubois Clement <Clemdbs>
# @Date:   03-Apr-2020
# @Email:  clement_dubois.etu@univ-lemans.fr
# @Filename: MenuTutorial.rb
# @Last modified by:   checkam
# @Last modified time: 14-Apr-2020


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

        @gtkObject = Gtk::Table.new(4,4)

        backToMenuButton = Button.new(label:"Retour à la sélection", width: screen.width*0.1,height: screen.height*0.08, size: 20)
        backToMenuButton.onClick(){
            uiManager.tutorialmenu.applyOn(win)
        }

        pageManager = PageManager.new()
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si un 4 est dans un coin, il doit être relié deux fois par deux ponts à ses deux voisins.",
          image1: "Technic/image1.gif",
          image2: "Technic/image1bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si un 8 est au milieu, il doit absolument être relié par deux ponts à tout ses voisins.",
          image1: "Technic/image1.gif",
          image2: "Technic/image1bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si un 6 est sur un bord de la grille, il doit aussi être relié par deux ponts à tout ses voisins.",
          image1: "Technic/image1.gif",
          image2: "Technic/image1bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Il faut essayer de repérer les îles qui n'auraient qu'un seul voisin.",
          image1: "Technic/image2.gif",
          image2: "Technic/image2bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si il y a un 3 dans un coin alors il aura un voisin relié avec un pont et un autre avec deux.",
          image1: "Technic/image3.gif",
          image2: "Technic/image3bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si c'est un 5 sur un bord de la grille il est relié par un pont à tout ses voisins au minimum (deux ponts à deux voisins).",
          image1: "Technic/image3.gif",
          image2: "Technic/image3bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si il y a un 7 au milieu de la grille il doit être relié au moins par un pont à tout ses voisins (deux ponts à 3 de ses voisins).",
          image1: "Technic/image3.gif",
          image2: "Technic/image3bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si un 3, un 5 ou un 7, toujours dans les mêmes conditions que juste avant, ont pour voisin un 1, alors tout leurs autres voisins seront reliés par deux ponts.",
          image1: "Technic/image4.gif",
          image2: "Technic/image4bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si un 4 a trois voisins dont deux qui sont des 1, le dernier sera relié par deux ponts.",
          image1: "Technic/image5.gif",
          image2: "Technic/image5bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si deux 1 ou deux 2 sont voisins entre eux, il ne faut pas les relier avec le maximum de pont. Cela créerais une isolation.",
          image1: "Technic/image7.gif",
          image2: "Technic/image7bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si une île a deux voisins, il ne faut pas saturer le nombre de pont de chaque île pour éviter que l'île et ses voisins forment un circuit fermé.",
          image1: "Technic/image8.gif",
          image2: "Technic/image8bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Si toutes les îles dans la grille sont saturés sauf une, faites en sorte de ne pas créer un isolement sans avoir fini totalement la grille.",
          image1: "Technic/image9.gif",
          image2: "Technic/image9bis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Il faut faire attention quand vous ajoutez un pont aux enchaînements de 2 et de 3 pour ne pas créer un isolement.",
          image1: "Technic/image12.gif",
          image2: "Technic/image12bis.gif",
          image3: "Technic/image12bisbis.gif"))
        pageManager.addComponent(TechnicComponent.new(
          label:"-Enfin il faut faire attention de ne pas isoler une île en créant des ponts tout autour",
          image1: "Technic/image13.gif",
          image2: "Technic/image13bis.gif",
          image3: "Technic/image13bisbis.gif"))
        pageManager.showFirst()

        @gtkObject.attach(Gtk::Alignment.new(0.05, 0.95, 0, 0).add(backToMenuButton.gtkObject),0,4,0,4)
        @gtkObject.attach(pageManager.gtkObject,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
    end
end
