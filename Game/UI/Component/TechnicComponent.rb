# @Author: Despres Maxence <checkam>
# @Date:   12-Apr-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: TechnicComponent.rb
# @Last modified by:   checkam
# @Last modified time: 14-Apr-2020


##
# ===== Presentation
#   Composant to display a Technic
#
# ===== Variables
#
#  * +gtkObject+ - Object to display
#
# ===== Methods
#
#   +new+ - initialization method

class TechnicComponent

  @gtkObject

  attr_reader :gtkObject

  ##
  # The class' constructor.
  #
  # ===== Attributes
  # * +label+ - text for describe image
  # * +image1+ - path of first image
  # * +image2+ - path of second image
  # * +image3+ - path of third image
  #-------------------------------------------------
  def initialize(label: "", image1: "", image2: "", image3: "")
      pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

      screen=Gdk::Screen.default

      @gtkObject = Gtk::Table.new(4,4)
      boxPictureGlobal= Gtk::Box.new(:horizontal)

      textTuto = Text.new(label: label).setWrap(true)
      textTuto.setBackground(1,1,1,1)
      textTuto.setBackgroundSize(screen.width*0.6,screen.height*0.2)

      if image1 != ""
        image1 = Asset.new(pathAssets + image1)
        image1.resize(screen.height*0.25,screen.height*0.25)
        boxPicture1 = Gtk::Box.new(:horizontal)
        image1.applyOn(boxPicture1)
        boxPictureGlobal.pack_start(boxPicture1,expand: false, fill: false, padding: 10)
      end

      if image2 != ""
        image2 = Asset.new(pathAssets + image2)
        image2.resize(screen.height*0.25,screen.height*0.25)
        boxPicture2 = Gtk::Box.new(:horizontal)
        image2.applyOn(boxPicture2)
        boxPictureGlobal.pack_start(boxPicture2,expand: false, fill: false, padding: 10)
      end

      if image3 != ""
        image3 = Asset.new(pathAssets + image3)
        image3.resize(screen.height*0.25,screen.height*0.25)
        boxPicture3 = Gtk::Box.new(:horizontal)
        image3.applyOn(boxPicture3)
        boxPictureGlobal.pack_start(boxPicture3,expand: false, fill: false, padding: 10)
      end

      globalBox = Gtk::Box.new(:vertical)
      globalBox.pack_start(textTuto.gtkObject,expand: false, fill: false, padding: 10)
      globalBox.pack_start(Gtk::Alignment.new(0.5,0.5,0,0).add(boxPictureGlobal),expand: false, fill: false, padding: 10)

      @gtkObject.attach(globalBox,0,4,0,4)
  end

end
