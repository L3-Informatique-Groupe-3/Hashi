# @Author: Despres Maxence <checkam>
# @Date:   15-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   makc
# @Last modified time: 10-Mar-2020



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../AssetsClass/Asset"

##
# ===== Presentation
#   GameScreen is a class that displays the interface of a game
#
# ===== Variables
#
#   @game instance of a Game
#   @gridUi instance of a GridUi
#   @gtkObject gtk object to displays on the window
#   @helpResponseUi text to displays help
#   @chronoUi instance of a chronoUi
#
# ===== Methods
#
#   new initialization method
#   update update the display screen
#
class GameScreen < Screen
  @game
  @gridUi
  @gtkObject
  @helpResponseUi
  @chronoUi

  ##
	# The class' constructor.
	#
	# ===== Attributes
  # * +win+ -
	# * +game+ -
  # * +cellAssets+ -
  # * +victoryScreen+ -
  # -----------------------------------
  def initialize(win,game,cellAssets)
    super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

    puts "A:" + @game.to_s
    @game=game

    @gridUi=GridUi.new(9,9, cellAssets,@game)
    @gtkObject = Gtk::Table.new(4,4)

    screen=Gdk::Screen.default
    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3
    pathAssets=File.dirname(__FILE__) + "/../../../Assets/"


    guess=Text.new(label:"Guess",width:screen.width*0.2, height:screen.height*0.05)
    guess.setBackground(1,1,1,1)

    newGuess=Button.new(image:pathAssets + "Button/add.png", width: screen.width*0.1,height: screen.height*0.08)
    newGuess.onClick(){
      # Create new game guess
      # TO DO
      @gridUi.refresh
    }

    validateGuess=Button.new(image:pathAssets + "Button/validate.png", width: screen.width*0.1,height: screen.height*0.08)
    validateGuess.onClick(){
      # Create new game guess
      # TO DO
      @gridUi.refresh
    }

    removeGuess=Button.new(image:pathAssets + "Button/cancel.png", width: screen.width*0.1,height: screen.height*0.08)
    removeGuess.onClick(){
      # Remove game guess
      # TO DO
      @gridUi.refresh
    }

    @time = 0
    @chronoUi=ChronoUi.new(@time)
    @pauseScreen = PauseScreen.new(win, self)
    #  ======== Pause
    pause=Button.new(image:pathAssets + "Button/pause.png", width: screen.width*0.1,height: screen.height*0.07)
    pause.setMarginBottom(10)
    pause.onClick(){
        # Call game stop timer
        # TO DO
        @pauseScreen.applyOn(win)
    }

    undoButton=Button.new(image:pathAssets + "Button/undo.png", width: screen.width*0.1,height: screen.height*0.07)
    undoButton.setMarginBottom(10)
    undoButton.onClick(){
      # Call game undo
      # TO DO
    }

    redoButton=Button.new(image:pathAssets + "Button/redo.png", width: screen.width*0.1,height: screen.height*0.07)
    redoButton.setMarginBottom(10)
    redoButton.onClick(){
      # Call game redo
      # TO DO
    }


    #  ======== Help Response Box
    @helpResponseUi = Text.new(label:"")
    @helpResponseUi.style="italic"
    @helpResponseUi.weight="normal"
    @helpResponseUi.color="red"
    @helpResponseUi.size=15
    @helpResponseUi.apply
    @helpResponseUi.setWrap(true)
    @helpResponseUi.setBackground(1,1,1,1)
    @helpResponseUi.setBackgroundSize(screen.width*0.3,screen.height*0.4)

    help=Button.new(label:"help", width: screen.width*0.1,height: screen.height*0.08)
    help.onClick(){
      # Display the help message
      # TO DO
      @helpDisplayed = true
    }

    helpMore=Button.new(image:pathAssets + "Button/add.png", width: screen.width*0.1,height: screen.height*0.08)
    helpMore.onClick(){
      @helpDisplayed = true
    }



    check=Button.new(label:"check", width: screen.width*0.1,height: screen.height*0.08)
    check.onClick(){
      # Display the help message
      # TO DO
      @helpDisplayed = true
    }
    # Display layout

    undoRedoBox = Gtk::Box.new(:horizontal)
    undoRedoBox.pack_start(undoButton.gtkObject, expand: true, fill: false, padding: 0)
    undoRedoBox.pack_start(pause.gtkObject, expand: true, fill: false, padding: 0)
    undoRedoBox.pack_start(redoButton.gtkObject, expand: true, fill: false, padding: 0)

    guessBox = Gtk::Box.new(:horizontal)
    guessBox.pack_start(newGuess.gtkObject, expand: true, fill: false, padding: 10)
    guessBox.pack_start(removeGuess.gtkObject, expand: true, fill: false, padding: 10)
    guessBox.pack_start(validateGuess.gtkObject, expand: true, fill: false, padding: 10)


    helpBox=Gtk::Box.new(:horizontal)
    helpBox.pack_start(help.gtkObject, expand: true, fill: false, padding: 0)
    helpBox.pack_start(helpMore.gtkObject, expand: true, fill: false, padding: 0)

    helpCheckBox=Gtk::Box.new(:horizontal)
    helpCheckBox.pack_start(check.gtkObject, expand: true, fill: false, padding: 0)
    helpCheckBox.pack_start(helpBox, expand: true, fill: false, padding: 0)


    globalBox = Gtk::Box.new(:vertical)
    globalBox.width_request=(screen.width*0.3)
    globalBox.pack_start(@chronoUi.gtkObject, expand: true, fill: false, padding: 10)
    globalBox.pack_start(guess.gtkObject, expand: true, fill: false, padding: 50)
    globalBox.pack_start(guessBox,expand: true, fill: false, padding: 10)

    globalBox.pack_start(helpCheckBox, expand: true, fill: false, padding: 10)


    globalBoxH = Gtk::Box.new(:horizontal).add(globalBox)

    globalAli  = Gtk::Alignment.new(0.5, 0, 0, 0).add(globalBoxH)
    helpCRAli  = Gtk::Alignment.new(0.5, 0, 0, 1 ).add(@helpResponseUi.gtkObject)

    leftBox = Gtk::Box.new(:vertical).add(undoRedoBox)
    leftBox.width_request=(screen.width*0.5)
    leftBox.height_request=(screen.height)
    leftBox.add(@gridUi.gtkObject.set_margin_left(40))
    leftBoxA  = Gtk::Alignment.new(0.5, 0, 0, 0).add(leftBox)

    @gtkObject.attach(globalAli,3,4,1,2)
    @gtkObject.attach(helpCRAli,2,4,2,3)
    @gtkObject.attach(leftBoxA, 0, 1, 0, 3)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)

  end

  ##
  # run gameScreen
  #
  def run
    Thread.new {
      while @time < 1000
        @chronoUi.updateLabel(@time+=1)
        sleep(1)
      end
    }
  end

end
