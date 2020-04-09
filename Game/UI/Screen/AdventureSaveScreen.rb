# @Author: Despres Maxence <checkam>
# @Date:   06-Apr-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: AdventureSaveScreen.rb
# @Last modified by:   checkam
# @Last modified time: 06-Apr-2020



require 'gtk3'
require_relative "../../Core/Adventure/Save"
require_relative File.dirname(__FILE__) + "/Screen"

class AdventureSaveScreen < Screen

  def initialize(win,uiManager)
    super(win,"/../../../Assets/Backgrounds/fond-naturel.png")
    pathAssets=File.dirname(__FILE__) + "/../../../Assets/"
    screen=Gdk::Screen.default
    @gtkObject = Gtk::Table.new(1,1)

    save1 = Button.new(label: "Sauvegarde 1",image: pathAssets + "ShapeButton/save.png", imageFocus: pathAssets + "ShapeButton/saveGlow.png", width: screen.width*0.3, height: screen.height*0.3)
    save2 = Button.new(label: "Sauvegarde 2",image: pathAssets + "ShapeButton/save.png", imageFocus: pathAssets + "ShapeButton/saveGlow.png", width: screen.width*0.3, height: screen.height*0.3)
    save3 = Button.new(label: "Sauvegarde 3",image: pathAssets + "ShapeButton/save.png", imageFocus: pathAssets + "ShapeButton/saveGlow.png", width: screen.width*0.3, height: screen.height*0.3)

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

    globalBox = Gtk::Box.new(:vertical)
    globalBox.add(save1.gtkObject)
    globalBox.add(save2.gtkObject)
    globalBox.add(save3.gtkObject)

    @gtkObject.attach(globalBox,0,1,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,1,0,1)
  end

end
