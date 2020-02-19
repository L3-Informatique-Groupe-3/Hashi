require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class MenuScreen < Screen
    @gtkObject
    
    def initialize(win)
        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

        screen=Gdk::Screen.default
        
        menuText=Text.new(label:"Menu Principal", width:screen.width*0.2, height:screen.height*0.05)

        #creation du bouton aventure
        adventureButton=Button.new(label:"Aventure", width: screen.width*0.1,height: screen.height*0.08)
        adventureButton.onClick(){
            #aller au menu aventure
        }

        #creation du bouton libre
        freeButton=Button.new(label:"Libre", width: screen.width*0.1,height: screen.height*0.08)
        freeButton.onClick(){
            #aller au menu libre (choix du niveau)
        }

        #creation du bouton suivant
        rankedButton=Button.new(label:"Classé", width: screen.width*0.1,height: screen.height*0.08)
        rankedButton.onClick(){
            #aller au menu classé (choix du niveau)
        }

        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(menuText.gtkObject, expand: true, fill: false, padding: 0)
        globalBox.pack_start(adventureButton.gtkObject, expand: true, fill: false, padding: 0)
        globalBox.pack_start(freeButton.gtkObject, expand: true, fill: false, padding: 0)
        globalBox.pack_start(rankedButton.gtkObject, expand: true, fill: false, padding: 0)


        @gtkObject = Gtk::Table.new(4,4)
        @gtkObject.attach(globalBox,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
        
    end

end