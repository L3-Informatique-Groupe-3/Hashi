# @Author: Noemie Farizon <NoemieFarizon>
# @Date:   9-Mar-2020
# @Email:  noemie.farizon.etu@univ-lemans.fr
# @Filename: RankScreen.rb
# @Last modified by:   checkam

require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class RankScreen < Screen
    @gtkObject

    def initialize(win,uiManager)
        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

        screen=Gdk::Screen.default
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        screenTitle=Titre.new(label:"Ranked", width:screen.width*0.2, height:screen.height*0.05)

        # Levels creation
        lvlBox = Gtk::Grid.new
        (1..2).each { |row|
            (1..5).each { |col|
                lvlButton = Button.new(label:"lvl " + ((row - 1) * 5 + col).to_s, width: screen.width*0.1,height: screen.height*0.3)
                lvlButton.onClick(){
                    #TODO
                }
                
                lvlBox.attach(lvlButton.gtkObject, col - 1, row - 1, 1, 1)
            }
        }
        lvlBox.set_row_spacing(2)
        lvlBox.set_column_spacing(2)
        lvlBox.set_halign(Gtk::Align::CENTER)


        # Score table
        scoreBox = Gtk::Grid.new

        numTextH = Text.new(label: "N°", width:screen.width*0.08, height:screen.height*0.1,padding: 0)
        numTextH.colorChange("white")
        nicknameTextH = Text.new(label: "Pseudo", width:screen.width*0.08, height:screen.height*0.1,padding: 0)
        nicknameTextH.colorChange("white")
        timeTextH = Text.new(label: "Temps", width:screen.width*0.08, height:screen.height*0.1,padding: 0)
        timeTextH.colorChange("white")

        scoreBox.attach(numTextH.gtkObject, 0, 0, 1, 1)
        scoreBox.attach(nicknameTextH.gtkObject, 1, 0, 1, 1)
        scoreBox.attach(timeTextH.gtkObject, 2, 0, 1, 1)

        # List
        listScore = Gtk::Grid.new
        listScore.set_column_spacing(1)
        (0..9).each { |i|
            rankText = Text.new(label: i.to_s, width:screen.width*0.08, height:screen.height*0.1,padding: 0)
            nicknameText = Text.new(label: "Pseudo " + i.to_s, width:screen.width*0.08, height:screen.height*0.1,padding: 0)
            timeText = Text.new(label: "00:0" + i.to_s, width:screen.width*0.08, height:screen.height*0.1,padding: 0)

            # Change color
            color = 0.7
            if(i % 2 == 0)
                color = 1
            end
            rankText.setBackground(color,color,color,1)
            nicknameText.setBackground(color,color,color,1)
            timeText.setBackground(color,color,color,1)

            listScore.attach(rankText.gtkObject, 0, i, 1, 1)
            listScore.attach(nicknameText.gtkObject, 1, i, 1, 1)
            listScore.attach(timeText.gtkObject, 2, i, 1, 1)
        }

        # Scroll Bar score
        scroll = Gtk::ScrolledWindow.new
        vp = Gtk::Viewport.new #Implement scrollable
        vp.add(listScore)
        scroll.add_with_viewport(vp)
        scroll.set_propagate_natural_width(true)
        #scroll.set_propagate_natural_height(true)
        scroll.height_request=(screen.height * 0.54)

        scoreBox.attach(scroll, 0, 1, 3, 1)
        scoreBox.override_background_color(:normal,Gdk::RGBA.new(0.5,0.5,0.5,1))
        scoreBox.set_halign(Gtk::Align::CENTER)

        # Back Button
        backToButton = Button.new(label:"Retour", width: screen.width*0.1,height: screen.height*0.08, size: 20)
        backToButton.onClick(){
            uiManager.gamemode.applyOn(win) if uiManager != nil
        }
        backBox = Gtk::Alignment.new(0.05, 0.5, 0, 0).add(backToButton.gtkObject)

        middleBox = Gtk::Table.new(1, 2)
        middleBox.attach(lvlBox, 0, 1, 0, 1)
        middleBox.attach(scoreBox, 1, 2, 0, 1)
        #middleBox.height_request=(screen.height * 0.52)

        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(screenTitle.gtkObject, expand: false, fill: false, padding: 20)
        globalBox.pack_start(middleBox, expand: false, fill: false, padding: 20)
        globalBox.pack_start(backBox, expand: false, fill: false, padding: 3)

        @gtkObject = Gtk::Table.new(4,4)
        @gtkObject.attach(globalBox,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)

    end

end
