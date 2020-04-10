# @Author: Despres Maxence <checkam>
# @Date:   18-Mar-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: MenuScreen.rb
# @Last modified by:   checkam
# @Last modified time: 03-Apr-2020



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class MenuScreen < Screen
    @gtkObject

    def initialize(window:win,title:"",button1:"",button2:"",button3:"",buttonAction1:nil,buttonAction2:nil,buttonAction3:nil,haveBackButton:false,uiManager:nil)
        super(window,"/../../../Assets/Backgrounds/fond-naturel.png")
        screen=Gdk::Screen.default



        @gtkObject = Gtk::Table.new(4,4)
        globalBox = Gtk::Box.new(:vertical)
        if title != ""
          menuTitle=Titre.new(label:title)
          globalBox.pack_start(menuTitle.gtkObject, expand: false, fill: false, padding: 50)
        end

        if button1 != ""
          b1=Button.new(label:button1)
          b1.onClick(){
            buttonAction1.call if buttonAction1 != nil
          }
          globalBox.pack_start(b1.gtkObject, expand: false, fill: false, padding: 50)
        end

        if button2 != ""
          b2=Button.new(label:button2)
          b2.onClick(){
            buttonAction2.call if buttonAction2 != nil
          }
          globalBox.pack_start(b2.gtkObject, expand: false, fill: false, padding: 50)
        end

        if button3 != ""
          b3=Button.new(label:button3)
          b3.onClick(){
            buttonAction3.call if buttonAction3 != nil
          }
          globalBox.pack_start(b3.gtkObject, expand: false, fill: false, padding: 50)
        end




        if haveBackButton == true
          backToButton = Button.new(label:"Menu Principal", width: screen.width*0.1,height: screen.height*0.08, size: 20)
          backToButton.onClick(){
            uiManager.mainmenu.applyOn(window) if uiManager != nil
          }
          @gtkObject.attach( Gtk::Alignment.new(0.05, 0.95, 0, 0).add(backToButton.gtkObject),0,4,0,4)
        end

        @gtkObject.attach(globalBox,0,4,0,4)
        @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)

    end

end
