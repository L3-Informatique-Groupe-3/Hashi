# @Author: Despres Maxence <checkam>
# @Date:   03-Apr-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: UiManager.rb
# @Last modified by:   checkam
# @Last modified time: 10-Apr-2020


class UiManager
  attr_reader :cellAssets, :adventureScreen, :rankScreen, :libreScreen, :mainmenu, :tutoScreen, :collecScreen, :gamemode
  attr_accessor :victoryScreenType, :rankedLevel

  def initialize(win)

    @win = win

    # Generation des ecrans de jeu
    @victoryScreenType = :normal
    @rankedLevel = 0

    @tutoScreen = TutorialScreen.new(@win, self)
    @collecScreen = TechnicCollection.new(@win, self)

    @adventureScreen=AdventureScreen.new(@win,self)
    @rankScreen=RankScreen.new(@win,self)
    @libreScreen=MenuScreen.new(
        window: @win,
        title: "Libre",
        button1: "Facile",
        button2: "Moyen",
        button3: "Difficile",
        buttonAction1: lambda {
            if(FreeMode.hasSave(:easy))
              getScreenFreeMode(:easy).applyOn(@win)
            else
              game = Party.new(FreeMode.getNewGrid(:easy))
              gameScreen = GameScreen.new(@win,game,self, saveAction: lambda{FreeMode.save(:easy, game)}, victoryAction: lambda{FreeMode.delete(:easy)} )
              gameScreen.applyOn(@win)
            end
        },
        buttonAction2: lambda {
          if(FreeMode.hasSave(:medium))
            getScreenFreeMode(:medium).applyOn(@win)
          else
            game = Party.new(FreeMode.getNewGrid(:medium))
            gameScreen = GameScreen.new(@win,game,self, saveAction: lambda{FreeMode.save(:medium, game)}, victoryAction: lambda{FreeMode.delete(:medium)} )
            gameScreen.applyOn(@win)
          end
         },
        buttonAction3: lambda {
          if(FreeMode.hasSave(:difficult))
            getScreenFreeMode(:difficult).applyOn(@win)
          else
            game = Party.new(FreeMode.getNewGrid(:difficult))
            gameScreen = GameScreen.new(@win,game,self, saveAction: lambda{FreeMode.save(:difficult, game)}, victoryAction: lambda{FreeMode.delete(:difficult)} )
            gameScreen.applyOn(@win)
          end
        },
        uiManager: self,
        haveBackButton: true,
      )

    @tutorialmenu = MenuScreen.new(
      window: @win,
      title: "Didacticiel",
      button1: "Liste de technique",
      button2: "Apprendre a jouer",
      buttonAction1: lambda { @collecScreen.applyOn(@win) },
      buttonAction2: lambda {	@tutoScreen.applyOn(@win) },
      uiManager: self,
      haveBackButton: true,
    )


    @gamemode = MenuScreen.new(
      window: @win,
      title: "Modes de Jeu",
      button1: "Aventure",
      button2: "Libre",
      button3: "Classé",
      buttonAction1: lambda { AdventureSaveScreen.new(@win,self).applyOn(@win) },
      buttonAction2: lambda {	@libreScreen.applyOn(@win) },
      buttonAction3: lambda { @rankScreen.applyOn(@win) },
      uiManager: self,
      haveBackButton: true,
    )

    @mainmenu = MenuScreen.new(
      window: @win,
      title: "Menu Principal",
      button1: "Modes de jeu",
      button2: "Didacticiel",
      button3: "Quitter",
      buttonAction1: lambda { @gamemode.applyOn(@win) },
      buttonAction2: lambda {	@tutorialmenu.applyOn(@win)},
      buttonAction3: lambda {
        @win.destroy
      },
    )


    @mainmenu.applyOn(@win)

  end

  private

  def getScreenFreeMode(mode)
    return LoadSaveScreen.new(
      window: @win,
      uiManager: self,
      loadButtonAction: lambda {
        game = FreeMode.loadSave(mode)
        gameScreen = GameScreen.new(@win,game,self, saveAction: lambda{FreeMode.save(mode, game)}, victoryAction: lambda{FreeMode.delete(mode)} )
        game.resume
        gameScreen.applyOn(@win)
      },
      restartButtonAction: lambda {
        game = FreeMode.loadSave(mode)
        game.restart
        gameScreen = GameScreen.new(@win,game,self, saveAction: lambda{FreeMode.save(mode, game)}, victoryAction: lambda{FreeMode.delete(mode)} )
        gameScreen.applyOn(@win)
      },
      backButtonAction: lambda { @libreScreen.applyOn(@win) }
    )
  end
end
