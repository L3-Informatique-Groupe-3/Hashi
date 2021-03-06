# @Author: Despres Maxence <checkam>
# @Date:   27-Mar-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: AventureScreen.rb
# @Last modified by:   checkam
# @Last modified time: 05-Apr-2020

require 'gtk3'
require_relative File.dirname(__FILE__) + "/Screen"

##
# ===== Presentation
# This class is a Screen. It represents the selection of the country
#
# ===== Variables
# * +win+ - The window to applicate the screen
# * +uiManager+ - The UI manager
# * +save+ - The current save
# * +countryButton+ - All the button to access to the country level selection
#
# ===== Methods
# * +setSave+ - Set the save and create all the selection screen
##
class AdventureScreen < Screen
  @win
  @uiManager
  @save
  @countryButton

  ##
  # The class' constructor.
  #
  # ===== Attributes
  # * +win+ - The window to applicate the screen
  # * +uiManager+ - THe UI manager
  # -----------------------------------
  def initialize(win,uiManager)
    super(win,"/../../../Assets/Backgrounds/worldmap.png")
    @gtkObject =  Gtk::Table.new(4,4)

    @win = win
    @uiManager = uiManager

    pathAssets=File.dirname(__FILE__) + "/../../../Assets/"
    screen=Gdk::Screen.default
    @save=nil
    backToMenuButton = Button.new(label:"Menu Principal", width: screen.width*0.1,height: screen.height*0.08, size: 20)
    backToMenuButton.onClick(){
      uiManager.mainmenu.applyOn(win)
    }
    @gtkObject.attach( Gtk::Alignment.new(0.05, 0.95, 0, 0).add(backToMenuButton.gtkObject),0,4,0,4)

    @countryButton = Hash.new
    @countryButton["afrique"] = ButtonShape.new(shape: pathAssets + "ShapeButton/afrique.png", width: screen.width, height: screen.height)
    @countryButton["amerique_sud"] = ButtonShape.new(shape: pathAssets + "ShapeButton/amerique_sud.png", width: screen.width, height: screen.height)
    @countryButton["asie"] = ButtonShape.new(shape: pathAssets + "ShapeButton/asie.png", width: screen.width, height: screen.height)
    @countryButton["europe"] = ButtonShape.new(shape: pathAssets + "ShapeButton/europe.png", width: screen.width, height: screen.height)
    @countryButton["australie"] = ButtonShape.new(shape: pathAssets + "ShapeButton/australie.png", width: screen.width, height: screen.height)
    @countryButton["us"] = ButtonShape.new(shape: pathAssets + "ShapeButton/us.png", width: screen.width, height: screen.height)

    manager = ButtonShapeManager.new
    @gtkObject.attach(manager.gtkObject,0,4,0,4)

    @countryButton.each_key { |key|
          @gtkObject.attach(@countryButton[key].gtkObject,0,4,0,4)
          manager.addButton(@countryButton[key])
    }


    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
  end

  ##
  # Set the save and create all the selection screen
  #
  # ===== Attributes
  # * +save+ - the save instance
  # ---
  def setSave(save)
    @save = save
    keys = @countryButton.keys
    keys.each_index { |i|
      @countryButton[keys[i]].setAction(lambda { AdventureLevelSelectionScreen.new(window:@win,uiManager:@uiManager, save: @save, countryNumber: i + 1).applyOn(@win)})
    }
  end

end
