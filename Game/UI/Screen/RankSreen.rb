# @Author: Noemie Farizon <NoemieFarizon>
# @Date:   9-Mar-2020
# @Email:  noemie.farizon.etu@univ-lemans.fr
# @Filename: RankScreen.rb
# @Last modified by:   s174383

require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class RankScreen < Screen
    @gtkObject
    
    def initialize(win)
        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

        screen=Gdk::Screen.default
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"
        
        screenTitle=Titre.new(label:"Ranked", width:screen.width*0.2, height:screen.height*0.05)

        #creation d'un bouton qui accede au GameSreen
        lvl1Button=Button.new(label:"lvl 1", width: screen.width*0.12,height: screen.height*0.3)
        lvl1Button.onClick(){
            #aller au niveau conserné
        }
        #creation d'un bouton qui accede au GameSreen
        lvl2Button=Button.new(label:"lvl 2", width: screen.width*0.12,height: screen.height*0.3)
        lvl2Button.onClick(){
            #aller au niveau conserné        
        }
        #creation d'un bouton qui accede au GameSreen
        lvl3Button=Button.new(label:"lvl 3", width: screen.width*0.12,height: screen.height*0.3)
        lvl3Button.onClick(){
            #aller au niveau conserné
        }
        #creation d'un bouton qui accede au GameSreen
        lvl4Button=Button.new(label:"lvl 4", width: screen.width*0.12,height: screen.height*0.3)
        lvl4Button.onClick(){
            #aller au niveau conserné
        }
        #creation d'un bouton qui accede au GameSreen
        lvl5Button=Button.new(label:"lvl 5", width: screen.width*0.12,height: screen.height*0.3)
        lvl5Button.onClick(){
            #aller au niveau conserné
        }
        #creation d'un bouton qui accede au GameSreen
        lvl6Button=Button.new(label:"lvl 6", width: screen.width*0.12,height: screen.height*0.3)
        lvl6Button.onClick(){
            #aller au niveau conserné
        }
        #creation d'un bouton qui accede au GameSreen
        lvl7Button=Button.new(label:"lvl 7", width: screen.width*0.12,height: screen.height*0.3)
        lvl7Button.onClick(){
            #aller au niveau conserné
        }
        #creation d'un bouton qui accede au GameSreen
        lvl8Button=Button.new(label:"lvl 8", width: screen.width*0.12,height: screen.height*0.3)
        lvl8Button.onClick(){
            #aller au niveau conserné
        }
        #creation d'un bouton qui accede au GameSreen
        lvl9Button=Button.new(label:"lvl 9", width: screen.width*0.12,height: screen.height*0.3)
        lvl9Button.onClick(){
            #aller au niveau conserné
        }
        #creation d'un bouton qui accede au GameSreen
        lvl10Button=Button.new(label:"lvl 10", width: screen.width*0.12,height: screen.height*0.3)
        lvl10Button.onClick(){
            #aller au niveau conserné
        }

        #creation du bouton qui retourne au menu precedent
        backButton=Button.new(image:pathAssets + "Button/back.png", width: screen.width*0.08,height: screen.height*0.08)
        backButton.onClick(){
            #aller au menu precedent
        }

        menuBox = Gtk::Box.new(:horizontal)
        menuBox.pack_start(backButton.gtkObject, expand: false, fill: false, padding: 10)
        menuBox.pack_start(screenTitle.gtkObject, expand: false, fill: false, padding: 100)

        lvlBox1 = Gtk::Box.new(:horizontal)
        lvlBox1.pack_start(lvl1Button.gtkObject, expand: false, fill: false, padding: 20)
        lvlBox1.pack_start(lvl2Button.gtkObject, expand: false, fill: false, padding: 20)
        lvlBox1.pack_start(lvl3Button.gtkObject, expand: false, fill: false, padding: 20)
        lvlBox1.pack_start(lvl4Button.gtkObject, expand: false, fill: false, padding: 20)
        lvlBox1.pack_start(lvl5Button.gtkObject, expand: false, fill: false, padding: 20)

        lvlBox2 = Gtk::Box.new(:horizontal)
        lvlBox2.pack_start(lvl6Button.gtkObject, expand: false, fill: false, padding: 20)
        lvlBox2.pack_start(lvl7Button.gtkObject, expand: false, fill: false, padding: 20)
        lvlBox2.pack_start(lvl8Button.gtkObject, expand: false, fill: false, padding: 20)
        lvlBox2.pack_start(lvl9Button.gtkObject, expand: false, fill: false, padding: 20)
        lvlBox2.pack_start(lvl10Button.gtkObject, expand: false, fill: false, padding: 20)

        lvlBox = Gtk::Box.new(:vertical)
        lvlBox.pack_start(menuBox, expand: false, fill: false, padding: 50)
        lvlBox.pack_start(lvlBox1, expand: false, fill: false, padding: 20)
        lvlBox.pack_start(lvlBox2, expand: false, fill: false, padding: 20)


        # liste sur le coté droit de l'ecran, qui s'active quand on clique sur un niveau 
        rankedBox = Gtk::Box.new(:vertical)
        

        globalBox = Gtk::Box.new(:horizontal)
        globalBox.pack_start(lvlBox, expand: false, fill: false, padding: 20)
        globalBox.pack_start(rankedBox, expand: false, fill: false, padding: 20)


        @gtkObject = Gtk::Table.new(4,4)
        @gtkObject.attach(globalBox,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
        
    end

end