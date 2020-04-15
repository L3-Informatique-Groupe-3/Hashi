
require 'gtk3'
require_relative File.dirname(__FILE__) + "/../AssetsClass/Asset"

##
# ===== Presentation
#   TutorialComponent is a Component that displays a tutorial
#
# ===== Variables
#
#   +gtkObject+ - Object to display
#
# ===== Methods
#
#   +new+ - initialization method
#
class TutorialComponent

    @gtkObject

    attr_reader :gtkObject

    ##
    # The class' constructor.
    #
    # ===== Attributes
    # * +label+ - text for describe image
    # * +image1+ - path of first image
    # * +image2+ - path of second image
    #-------------------------------------------------
    def initialize(label: "", image1: "", image2: "")
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        screen=Gdk::Screen.default

        @gtkObject = Gtk::Table.new(4,4)

        textTuto = Text.new(label: label)
        textTuto.setWrap(true)
        textTuto.setBackgroundSize(screen.width*0.7,screen.height*0.2)
        textTuto.setBackground(1,1,1,1)
        boxPictureGlobal= Gtk::Box.new(:horizontal)
        if image1 != ""
          image1 = Asset.new(pathAssets + image1)
          image1.resize(screen.width*0.3,screen.height*0.3) if image1.buffer.width > screen.height*0.3 && image1.buffer.width > screen.height*0.3
          boxPicture = Gtk::Box.new(:horizontal)
          image1.applyOn(boxPicture)
          boxPictureGlobal.pack_start(boxPicture,expand: false, fill: false, padding: 10)
        end

        if image2 != ""
          image2 = Asset.new(pathAssets + image2)
          image2.resize(screen.width*0.3,screen.height*0.3) if image2.buffer.width > screen.height*0.3 && image2.buffer.width > screen.height*0.3
          boxPicture2 = Gtk::Box.new(:horizontal)
          image2.applyOn(boxPicture2)
          boxPictureGlobal.pack_start(boxPicture2,expand: false, fill: false, padding: 10)
        end



        globalBox = Gtk::Box.new(:vertical)
        globalBox.pack_start(textTuto.gtkObject,expand: false, fill: false, padding: 10)
        globalBox.pack_start(Gtk::Alignment.new(0.5,0.5,0,0).add(boxPictureGlobal),expand: false, fill: false, padding: 10)

        @gtkObject.attach(globalBox,0,4,0,4)
    end
end
