# @Author: Despres Maxence <checkam>
# @Date:   27-Mar-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: AventureScreen.rb
# @Last modified by:   checkam
# @Last modified time: 03-Apr-2020

require 'gtk3'
require_relative File.dirname(__FILE__) + "/Screen"

class AdventureScreen < Screen

  def initialize(win,uiManager)
    super(win,"/../../../Assets/Backgrounds/worldmap.png")
    @gtkObject =  Gtk::Table.new(4,4)
    pathAssets=File.dirname(__FILE__) + "/../../../Assets/"
    screen=Gdk::Screen.default

    backToMenuButton = Button.new(label:"Menu Principal", width: screen.width*0.1,height: screen.height*0.08, size: 20)
    backToMenuButton.onClick(){
      uiManager.mainmenu.applyOn(win)
    }
    @gtkObject.attach( Gtk::Alignment.new(0.05, 0.95, 0, 0).add(backToMenuButton.gtkObject),0,4,0,4)

    countryButton = Hash.new
    countryButton["groenland"] = ButtonShape.new(shape: pathAssets + "ShapeButton/groenland.png", width: screen.width, height: screen.height)
    countryButton["afrique"] = ButtonShape.new(shape: pathAssets + "ShapeButton/afrique.png", width: screen.width, height: screen.height)
    countryButton["amerique_sud"] = ButtonShape.new(shape: pathAssets + "ShapeButton/amerique_sud.png", width: screen.width, height: screen.height)
    countryButton["asie"] = ButtonShape.new(shape: pathAssets + "ShapeButton/asie.png", width: screen.width, height: screen.height)
    countryButton["europe"] = ButtonShape.new(shape: pathAssets + "ShapeButton/europe.png", width: screen.width, height: screen.height)
    countryButton["australie"] = ButtonShape.new(shape: pathAssets + "ShapeButton/australie.png", width: screen.width, height: screen.height)
    countryButton["us"] = ButtonShape.new(shape: pathAssets + "ShapeButton/us.png", width: screen.width, height: screen.height)

    manager = ButtonShapeManager.new
    @gtkObject.attach(manager.gtkObject,0,4,0,4)

    countryButton.each_key { |key|
          @gtkObject.attach(countryButton[key].gtkObject,0,4,0,4)
          countryButton[key].setAction(lambda { puts key })
          manager.addButton(countryButton[key])
    }


    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
  end

end
