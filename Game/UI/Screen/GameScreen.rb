# @Author: Despres Maxence <checkam>
# @Date:   15-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   checkam
# @Last modified time: 05-Apr-2020



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
#   @saveAction - action for save the game
#
# ===== Methods
#
#   new initialization method
#   run start to show chronoUi
#   resume resume the game and chrono
#   restart retart the game
class GameScreen < Screen
  @game
  @gridUi
  @gtkObject
  @helpResponseUi
  @chronoUi
  @saveAction

  attr_reader :gridUi, :saveAction

  ##
	# The class' constructor.
	#
	# ===== Attributes
  # * +win+ -
	# * +game+ -
  # * +cellAssets+ -
  # * +victoryScreen+ -
  # * +showVictoryScreen+ -
  # -----------------------------------
  def initialize(win,game,uiManager, backAction,saveAction:nil,victoryAction:nil)
    super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

    @win = win
    @game = game
    @victoryAction = victoryAction
    @uiManager = uiManager
    cellAssets=CellAssets.new(@game.getRows, @game.getCols)
    @gridUi=GridUi.new(cellAssets,@game, self)
    @gtkObject = Gtk::Table.new(4,4)
    @backAction = backAction
    @saveAction = saveAction

    screen=Gdk::Screen.default
    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3
    pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

    guess=Text.new(label:"Hypothèse",width:screen.width*0.2, height:screen.height*0.08)
    guess.setBackground(1,1,1,1)

    newGuess=Button.new(image:pathAssets + "Button/add.png", width: screen.width*0.1,height: screen.height*0.08)
    newGuess.resizeImage(40,40)
    newGuess.onClick(){
      # Create new game guess
      @game.newHypothesis
      @gridUi.refresh
    }

    validateGuess=Button.new(image:pathAssets + "Button/validate.png", width: screen.width*0.1,height: screen.height*0.08)
    validateGuess.resizeImage(40,40)
    validateGuess.onClick(){
      # Validate game guess
      @game.validateHypothesis
      @gridUi.refresh
    }

    removeGuess=Button.new(image:pathAssets + "Button/cancel.png", width: screen.width*0.1,height: screen.height*0.08)
    removeGuess.resizeImage(40,40)
    removeGuess.onClick(){
      # Remove game guess
      @game.refuteHypothesis
      @gridUi.refresh
    }

    @chronoUi=ChronoUi.new(@game.getTimer)
    @pauseScreen = PauseScreen.new(win, self, uiManager, @backAction, saveAction: saveAction)
    #  ======== Pause
    pause=Button.new(image:pathAssets + "Button/pause.png", width: screen.width*0.1,height: screen.height*0.07)
    pause.setMarginBottom(10)
    pause.resizeImage(40,40)
    pause.onClick(){
        @game.pause
        @pauseScreen.applyOn(win)
    }

    undoButton=Button.new(image:pathAssets + "Button/undo.png", width: screen.width*0.1,height: screen.height*0.07)
    undoButton.setMarginBottom(10)
    undoButton.resizeImage(40,40)
    undoButton.onClick(){
      @game.undo
      @gridUi.refresh
    }

    redoButton=Button.new(image:pathAssets + "Button/redo.png", width: screen.width*0.1,height: screen.height*0.07)
    redoButton.resizeImage(40,40)
    redoButton.setMarginBottom(10)
    redoButton.onClick(){
      @game.redo
      @gridUi.refresh
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

    help=Button.new(label:"Aide", width: screen.width*0.1,height: screen.height*0.08, size: 20)
    help.onClick(){
      coordHelp = @game.getHelp

      if(coordHelp.empty?)
        @helpResponseUi.updateLabel(@game.getHelpPlus)
      else
        @helpResponseUi.updateLabel("")
        # Display the help message
        @gridUi.getCellUi(coordHelp[0],coordHelp[1]).select
      end

    }

    helpMore=Button.new(label: "Aide +", width: screen.width*0.1,height: screen.height*0.08, size: 20)
    helpMore.onClick(){
      @helpResponseUi.updateLabel(@game.getHelpPlus)
    }



    check=Button.new(label:"Vérifier erreur", width: screen.width*0.1,height: screen.height*0.08, size: 20)
    check.setWrap(true)
    check.onClick(){
      # Display the help message
      @helpResponseUi.updateLabel("Il y a "  + @game.check.to_s + " erreur(s).")
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

    helpCheckBox=Gtk::Box.new(:horizontal)
    helpCheckBox.pack_start(check.gtkObject, expand: false, fill: false, padding: 10)
    helpCheckBox.pack_start(help.gtkObject, expand: true, fill: false, padding: 10)
    helpCheckBox.pack_start(helpMore.gtkObject, expand: true, fill: false, padding: 10)


    globalBox = Gtk::Box.new(:vertical)
    globalBox.width_request=(screen.width*0.3)
    globalBox.pack_start(@chronoUi.gtkObject, expand: true, fill: false, padding: 10)
    globalBox.pack_start(guess.gtkObject, expand: true, fill: false, padding: 50)
    globalBox.pack_start(guessBox,expand: true, fill: false, padding: 10)

    globalBoxH = Gtk::Box.new(:horizontal).add(globalBox)
    globalAli  = Gtk::Alignment.new(0.5, 0, 0, 0).add(globalBoxH)


    helpBoxGlobal = Gtk::Box.new(:vertical).add(helpCheckBox)
    helpBoxGlobal.pack_start(@helpResponseUi.gtkObject, expand: true, fill: false, padding: 10)
    helpCRAli = Gtk::Alignment.new(0.5, 0, 0, 1 ).add(helpBoxGlobal)

    leftBox = Gtk::Box.new(:vertical).add(undoRedoBox)
    leftBox.width_request=(screen.width*0.5)
    leftBox.height_request=(screen.height)
    leftBox.pack_start(@gridUi.gtkObject.set_margin_left(40), expand: true, fill: false, padding: 0)
    leftBoxA  = Gtk::Alignment.new(0.5, 0, 0, 0).add(leftBox)

    @gtkObject.attach(globalAli,3,4,1,2)
    @gtkObject.attach(helpCRAli,2,4,2,3)
    @gtkObject.attach(leftBoxA, 0, 1, 0, 3)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
    run
  end

  ##
  # run gameScreen
  #
  def run
    Thread.new {
        while 1
          @chronoUi.updateLabel(@game.getTimer)
          sleep 1
        end
    }
  end

  def showVictoryScreen
    @victoryAction.call if @victoryAction != nil
    if(@uiManager.victoryScreenType == :normal)
      @victoryScreen = VictoryScreen.new(@win, @game, @uiManager, @backAction)
    else
      @victoryScreen = VictoryRankedScreen.new(@win, @game, @uiManager)
    end
    @victoryScreen.applyOn(@win)
  end

  def resume
    @game.resume
  end

  def restart
    @game.restart
    @gridUi.refresh
  end
end
