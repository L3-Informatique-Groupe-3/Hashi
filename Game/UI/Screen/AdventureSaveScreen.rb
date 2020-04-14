# @Author: Despres Maxence <checkam>
# @Date:   06-Apr-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: AdventureSaveScreen.rb
# @Last modified by:   jashbin
# @Last modified time: 14-Apr-2020



require 'gtk3'
require_relative "../../Core/Adventure/Save"
require_relative File.dirname(__FILE__) + "/Screen"

class AdventureSaveScreen < Screen

  def initialize(win,uiManager)
    super(win,"/../../../Assets/Backgrounds/fond-naturel.png")
    pathAssets=File.dirname(__FILE__) + "/../../../Assets/"
    screen=Gdk::Screen.default
    @gtkObject = Gtk::Table.new(1,1)

    width = screen.width*0.4
    height = screen.height*0.26

    save1 = Button.new(label: "Sauvegarde 1",image: pathAssets + "ShapeButton/save.png", imageFocus: pathAssets + "ShapeButton/saveGlow.png", width: width, height: height)
    save2 = Button.new(label: "Sauvegarde 2",image: pathAssets + "ShapeButton/save.png", imageFocus: pathAssets + "ShapeButton/saveGlow.png", width: width, height: height)
    save3 = Button.new(label: "Sauvegarde 3",image: pathAssets + "ShapeButton/save.png", imageFocus: pathAssets + "ShapeButton/saveGlow.png", width: width, height: height)

    save1.resizeImage(width,height)
    save2.resizeImage(width,height)
    save3.resizeImage(width,height)

    save1.resizeImageFocus(width,height)
    save2.resizeImageFocus(width,height)
    save3.resizeImageFocus(width,height)

    save1.onClick{
      uiManager.adventureScreen.setSave(Save.access(1))
      uiManager.adventureScreen.applyOn(win)
    }

    save2.onClick{
      uiManager.adventureScreen.setSave(Save.access(2))
      uiManager.adventureScreen.applyOn(win)
    }

    save3.onClick{
      uiManager.adventureScreen.setSave(Save.access(3))
      uiManager.adventureScreen.applyOn(win)
    }

    save1.setBackground(0,0,0,0)
    save2.setBackground(0,0,0,0)
    save3.setBackground(0,0,0,0)

    saveBox = Gtk::Box.new(:vertical)
    saveBox.add(save1.gtkObject)
    saveBox.add(save2.gtkObject)
    saveBox.add(save3.gtkObject)

    #Button to go back to main menu
    backToButton = Button.new(label:"Retour à la sélection", width: screen.width*0.1,height: screen.height*0.08, size: 20)
    backToButton.onClick(){
        uiManager.gamemode.applyOn(win)
    }
    backBtnAli = Gtk::Alignment.new(0.05, 0.95, 0, 0).add(backToButton.gtkObject)

    globalBox = Gtk::Box.new(:vertical)
    globalBox.pack_start(saveBox, expand: false, fill: false, padding: 8)
    globalBox.pack_start(backBtnAli, expand: false, fill: false, padding: 3)

    @gtkObject.attach(globalBox,0,1,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,1,0,1)
  end

end
