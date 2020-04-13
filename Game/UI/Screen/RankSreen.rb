# @Author: Noemie Farizon <NoemieFarizon>
# @Date:   9-Mar-2020
# @Email:  noemie.farizon.etu@univ-lemans.fr
# @Filename: RankScreen.rb
# @Last modified by:   checkam

require 'gtk3'
require_relative "./Screen"
require_relative "../../Core/Ranked/Ranked"
require_relative "../../Core/Ranked/RankedSave"

class RankScreen < Screen
    @gtkObject
    @prevSelection

    def initialize(win,uiManager)
        super(win,"/../../../Assets/Backgrounds/fond-naturel.png")

        @win = win
        @uiManager = uiManager
        @prevSelection = nil

        screen=Gdk::Screen.default
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"
        @buttonSize = screen.height * 0.13

        screenTitle=Titre.new(label:"Mode Classé", width:screen.width*0.2, height:screen.height*0.05)

        # Levels creation
        lvlBox = Gtk::Grid.new
        (1..2).each { |row|
            (1..5).each { |col|
                levelNumber = (row - 1) * 5 + col

                lvlInsideBox = Gtk::Grid.new
                lvlText = Text.new(label: "Niveau " + levelNumber.to_s, width: screen.width*0.1,height: screen.height*0.15, padding: 0)
                lvlText.setBackground(0.9,0.9,0.9,1)

                lvlStartButton = Button.new(image: pathAssets + "Button/play.png", imageFocus: pathAssets + "Button/playFocus.png", width: @buttonSize,height: @buttonSize, padding: 0)
                lvlStartButton.resizeImage(@buttonSize * 0.7,@buttonSize * 0.7)
                lvlStartButton.resizeImageFocus(@buttonSize * 0.7,@buttonSize * 0.7)
                lvlStartButton.onClick(){
                    getNextScreen(levelNumber).call
                }

                lvlShowRankButton = Button.new(image: pathAssets + "Button/cup.png", imageFocus: pathAssets + "Button/cupFocus.png", width: @buttonSize,height: @buttonSize, padding: 0)
                lvlShowRankButton.resizeImage(@buttonSize,@buttonSize)
                lvlShowRankButton.resizeImageFocus(@buttonSize,@buttonSize)
                lvlShowRankButton.onClick(){
                    @vp.each { |child|
                        @vp.remove(child)
                    }
                    @vp.add(createRankList(levelNumber, lvlShowRankButton))
                    @vp.show_all
                }
                if(@prevSelection == nil)
                    @prevSelection = lvlShowRankButton
                end

                lvlInsideBox.attach(lvlText.gtkObject, 0, 0, 2, 1)
                lvlInsideBox.attach(lvlStartButton.gtkObject, 0, 1, 1, 1)
                lvlInsideBox.attach(lvlShowRankButton.gtkObject, 1, 1, 1, 1)
                lvlInsideBox.set_column_spacing(3)
                lvlInsideBox.override_background_color(:normal,Gdk::RGBA.new(0.9,0.9,0.9,1))

                lvlBox.attach(lvlInsideBox, col - 1, row - 1, 1, 1)
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


        # Scroll Bar score + List creation
        scroll = Gtk::ScrolledWindow.new
        @vp = Gtk::Viewport.new #Implement scrollable
        @vp.add(createRankList(1, @prevSelection))
        scroll.add_with_viewport(@vp)
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

    private

    def createRankList(level, showRankButton)
        rank = Ranked.access()
        infos = rank.loadGame(level)[2]
        screen=Gdk::Screen.default
        pathAssets=File.dirname(__FILE__) + "/../../../Assets/"

        # Update List
        listScore = Gtk::Grid.new
        listScore.set_column_spacing(1)
        if(infos.size > 0)
            infos.each_index { |i|
                timeToShow = Time.new(0) + infos[i][2]

                rankText = Text.new(label: (i+1).to_s, width:screen.width*0.08, height:screen.height*0.1,padding: 0)
                nicknameText = Text.new(label: infos[i][1], width:screen.width*0.08, height:screen.height*0.1,padding: 0)
                timeText = Text.new(label: timeToShow.min.to_s + ":" + timeToShow.sec.to_s, width:screen.width*0.08, height:screen.height*0.1,padding: 0)

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
        else
            nothingText = Text.new(label: "Pas de classement pour le niveau " + level.to_s, width:screen.width*0.23, height:screen.height*0.54,padding: 0)
            nothingText.setWrap(true)
            listScore.attach(nothingText.gtkObject, 0, 0, 3, 1)
            listScore.override_background_color(:normal,Gdk::RGBA.new(1,1,1,1))
        end

        # Update Button
        if(@prevSelection != nil)
            @prevSelection.setImage(pathAssets + "Button/cup.png", width: @buttonSize, height: @buttonSize)
            @prevSelection = showRankButton
        end
        @prevSelection.setImage(pathAssets + "Button/cupFocus.png", width: @buttonSize, height: @buttonSize)

        return listScore
    end

    def getNextScreen(levelNumber)
        file = RankedSave.getFilePath(levelNumber)
        return lambda {
            @uiManager.rankedLevel = levelNumber
            @uiManager.victoryScreenType = :ranked
            rank = Ranked.access()
            if(RankedSave.hasSave(file))
                LoadSaveScreen.new(
                    window: @win,
                    uiManager: @uiManager,
                    loadButtonAction: lambda {
                        game = RankedSave.loadSave(file)
                        gameScreen = GameScreen.new(@win,game,@uiManager, lambda { @uiManager.rankScreen.applyOn(@win) },saveAction: lambda{
                            RankedSave.save(file, game)
                            @uiManager.victoryScreenType = :normal
                        }, victoryAction: lambda{RankedSave.delete(file)} )
                        game.resume
                        gameScreen.applyOn(@win)
                    },
                    restartButtonAction: lambda {
                        game = RankedSave.loadSave(file)
                        game.restart
                        gameScreen = GameScreen.new(@win,game,@uiManager, lambda { @uiManager.rankScreen.applyOn(@win) },saveAction: lambda{
                            RankedSave.save(file, game)
                            @uiManager.victoryScreenType = :normal
                        }, victoryAction: lambda{RankedSave.delete(file)} )
                        gameScreen.applyOn(@win)
                    },
                    backButtonAction: lambda { self.applyOn(@win) }
                ).applyOn(@win)
            else
                map = rank.loadGame(levelNumber)[0]
                game = Party.new(map)
                gameScreen = GameScreen.new(@win,game,@uiManager, lambda { @uiManager.rankScreen.applyOn(@win) },saveAction: lambda{
                    RankedSave.save(file, game)
                    @uiManager.victoryScreenType = :normal
                }, victoryAction: lambda{RankedSave.delete(file)} )
                gameScreen.applyOn(@win)
            end
        }
    end
end
