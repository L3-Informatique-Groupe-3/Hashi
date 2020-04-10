
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

        textTuto = Text.new(label: label)
        textTuto.setBackground(1,1,1,1)
        image0 = Asset.new(pathAssets + image1)
        image1 = Asset.new(pathAssets + image2)
        boxPicture = Gtk::Box.new(:horizontal)
        boxPicture2 = Gtk::Box.new(:horizontal)
        boxPictureGlobal= Gtk::Box.new(:horizontal)
        image0.applyOn(boxPicture)
        image1.applyOn(boxPicture2)
        boxPictureGlobal.pack_start(boxPicture,expand: false, fill: false, padding: 10)
        boxPictureGlobal.pack_start(boxPicture2,expand: false, fill: false, padding: 10)
        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(textTuto.gtkObject,expand: false, fill: false, padding: 10)
        globalBox.pack_start(Gtk::Alignment.new(0.5,0.5,0,0).add(boxPictureGlobal),expand: false, fill: false, padding: 10)

        @gtkObject.attach(globalBox,0,4,0,4)
    end
end
