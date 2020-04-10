
require 'gtk3'
require_relative File.dirname(__FILE__) + "/../AssetsClass/Asset"

##
# ===== Presentation
#   TutorialScreen is a class that displays the interface of the tutorial
#
# ===== Variables
#
#   @gtkObject
#
# ===== Methods
#
#   new initialization method
#
class TutorialComponent

    @gtkObject

    attr_reader :gtkObject

    def initialize(label: "", image1: "", image2: "")
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        screen=Gdk::Screen.default

        @gtkObject = Gtk::Table.new(4,4)

        textTuto = Text.new(label: label, width:screen.width*0.2, height:screen.height*0.05)
        image0 = Asset.new(pathAssets + "Tutorial/pic1.png")
        #image0.resize(500,500)
        image1 = Asset.new(pathAssets + "Tutorial/pic2.png")
        #image1.resize(500,500)
        boxPicture = Gtk::Box.new(:horizontal)
        boxPicture2 = Gtk::Box.new(:horizontal)
        boxPictureGlobal= Gtk::Box.new(:horizontal)
        image0.applyOn(boxPicture)
        image1.applyOn(boxPicture2)
        boxPictureGlobal.add(boxPicture)
        boxPictureGlobal.add(boxPicture2)
        # alignBoxPicture = Gtk::Alignment.new(0.5,0.3,0,0).add(boxPictureGlobal)
        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(textTuto.gtkObject,expand: true, fill: false, padding: 10)
        globalBox.pack_start(boxPictureGlobal,expand: true, fill: false, padding: 10)

        @gtkObject.attach(globalBox,0,4,0,4)
    end
end
