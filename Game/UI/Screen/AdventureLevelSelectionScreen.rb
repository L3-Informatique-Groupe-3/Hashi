# @Author: Despres Maxence <checkam>
# @Date:   05-Apr-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: AdventureLevelSelectionScreen.rb
# @Last modified by:   checkam
# @Last modified time: 05-Apr-2020



################################################################################
# File: AdventureLevelSelectionScreen.rb                                       #
# Project: Hashi                                                              #
# File Created: Friday, 3rd April 2020 4:15:35 pm                              #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Saturday, 4th April 2020 3:44:01 pm                           #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require 'gtk3'
require_relative "./Screen"
require_relative "../Component/Titre"
require_relative "../Component/Button"
require_relative "../AssetsClass/Asset"
require_relative "../../Core/FreeMode"

##
# ===== Presentation
#
# ===== Variables
# * +variableName+ - description
# ===== Methods
# * +myMethod+ - description
##
class AdventureLevelSelectionScreen < Screen

    ##
	# The class' constructor.
	#
	# ===== Attributes
    # * +win+ -
    # -----------------------------------
    def initialize(window:win, uiManager:nil,save: nil, countryNumber: 0)
        super(window,"/../../../Assets/Backgrounds/fond-naturel.png")

        screen=Gdk::Screen.default
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"
        @gtkObject = Gtk::Table.new(4,4)

        selectionTitle=Titre.new(label: "Sélection du niveau", width:screen.width*0.2, height:screen.height*0.05)

        # Levels
        list = Gtk::Box.new(:vertical)
        (1..5).each { |levelNumber|
						info = save.loadGame(countryNumber * 100 + levelNumber)

            levelBox = Gtk::Box.new(:horizontal)
            levelButton = Button.new(label:"Niveau " + levelNumber.to_s, width:screen.width*0.7, height:screen.height*0.05)
            levelButton.onClick(){
								game = Party.new(info[0])
								gameScreen = GameScreen.new(window,game,uiManager,victoryAction:
									lambda{
										save.loadGame(countryNumber * 100 + levelNumber)
									 	save.completeMap
									})
								gameScreen.applyOn(window)
            }

            levelCheckBox = Gtk::Box.new(:horizontal)
						assetsButton = "Button/cancel.png"

						if !save.isLocked(countryNumber * 100 + levelNumber)
								assetsButton = "Button/validate.png"
						elsif save.isLocked(countryNumber * 100 + levelNumber)
								assetsButton = "Button/cancel.png"
						end

						levelCheck = Asset.new(pathAssets + assetsButton)
						levelCheck.resize(screen.height * 0.05, screen.height * 0.05)
						levelCheck.applyOn(levelCheckBox)

            levelBox.pack_start(levelButton.gtkObject, expand: false, fill: false, padding: 10)
            levelBox.pack_start(levelCheckBox, expand: false, fill: false, padding: 10)

            levelAli = Gtk::Alignment.new(0.5, 0, 0, 0).add(levelBox)

            list.pack_start(levelAli, expand: false, fill: false, padding: 10)
        }

        # Scroll Bar Levels
        scroll = Gtk::ScrolledWindow.new
        vp = Gtk::Viewport.new #Implement scrollable
        vp.add(list)
        scroll.add_with_viewport(vp)
        scroll.height_request=(screen.height * 0.6)
				scroll.override_background_color(:normal,Gdk::RGBA.new(0.22, 0.45, 0.50, 1))
        # scroll.width_request=(screen.width)

        #Button to go back to main menu
        backToButton = Button.new(label:"Retour à la carte", width: screen.width*0.1,height: screen.height*0.08, size: 20)
        backToButton.onClick(){
            uiManager.adventureScreen.applyOn(window)
        }

        # Layout
        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(selectionTitle.gtkObject, expand: false, fill: false, padding: 50)
        globalBox.pack_start(scroll, expand: false, fill: false, padding: 10)

        @gtkObject.attach( Gtk::Alignment.new(0.05, 0.95, 0, 0).add(backToButton.gtkObject),0,4,0,4)
        @gtkObject.attach(globalBox,0,4,0,4)
				@gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
    end
end

# win = Gtk::Window.new.fullscreen

# win.title = "Hashi"

# win.signal_connect('destroy') {
#     Gtk.main_quitopp
#     exit
# }
# win.override_background_color(:normal,Gdk::RGBA.new(0.1, 0.6, 1, 1))

# AdventureLevelSelectionScreen.new(window:win).applyOn(win)
# win.show_all

# Gtk.main
