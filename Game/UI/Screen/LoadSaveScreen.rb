################################################################################
# File: LoadSaveScreen.rb                                                      #
# Project: Hashi                                                              #
# File Created: Monday, 6th April 2020 3:50:41 pm                              #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Monday, 6th April 2020 5:15:19 pm                             #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require 'gtk3'
require_relative "./Screen"

##
# ===== Presentation
# 
# ===== Variables
# * +variableName+ - description
# ===== Methods
# * +myMethod+ - description
##
class LoadSaveScreen < Screen
    def initialize(window:win,uiManager:nil,loadButtonAction:nil,restartButtonAction:nil,nextButtonAction:nil,backButtonAction:nil)
        super(window,"/../../../Assets/Backgrounds/fond-naturel.png")
        @gtkObject = Gtk::Table.new(4,4)
        screen=Gdk::Screen.default

        menuTitle=Text.new(label:"Voulez-vous continuer la partie en cours ?", width:screen.width*0.2, height:screen.height*0.05)

        loadButton=Button.new(label:"Reprendre la partie en cours", width: screen.width*0.1,height: screen.height*0.08)
        loadButton.onClick(){
          loadButtonAction.call if loadButtonAction != nil
        }

        restartButton=Button.new(label:"Recommencer", width: screen.width*0.1,height: screen.height*0.08)
        restartButton.onClick(){
          restartButtonAction.call if restartButtonAction != nil
        }

        nextButton=Button.new(label:"Nouveau", width: screen.width*0.1,height: screen.height*0.08)
        nextButton.onClick(){
          nextButtonAction.call if nextButtonAction != nil
        }

        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(menuTitle.gtkObject, expand: false, fill: false, padding: 50)
        globalBox.pack_start(loadButton.gtkObject, expand: false, fill: false, padding: 50) if loadButtonAction != nil
        globalBox.pack_start(restartButton.gtkObject, expand: false, fill: false, padding: 50) if restartButtonAction != nil
        globalBox.pack_start(nextButton.gtkObject, expand: false, fill: false, padding: 50) if nextButtonAction != nil

        if backButtonAction != nil
          backToButton = Button.new(label:"Retour", width: screen.width*0.1,height: screen.height*0.08, size: 20)
          backToButton.onClick(){
            backButtonAction.call
          }
          @gtkObject.attach( Gtk::Alignment.new(0.05, 0.95, 0, 0).add(backToButton.gtkObject),0,4,0,4)
        end

        @gtkObject.attach(globalBox,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
    end
end
