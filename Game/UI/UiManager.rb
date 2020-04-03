# @Author: Despres Maxence <checkam>
# @Date:   03-Apr-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: UiManager.rb
# @Last modified by:   checkam
# @Last modified time: 03-Apr-2020


class UiManager

  attr_reader :cellAssets, :aventureScreen, :rankScreen, :libreScreen, :mainmenu

  def initialize(win)

    @win = win

    # Generation des ecrans de jeu

    @aventureScreen=AdventureScreen.new(@win,self)
    @rankScreen=RankScreen.new(@win,self)
    @libreScreen=MenuScreen.new(
        window: @win,
        title: "Libre",
        button1: "Facile",
        button2: "Moyen",
        button3: "Difficile",
        buttonAction1: lambda {
            game = Party.new("9x9:2c3-1-1c3a-b-a3d3b4d4-aa-a3a3dd5a-2a3a--b1-a3b3cc6dd4b3a--a-1a3a2c1a-a1a2c2c3c3c2")
            gameScreen = GameScreen.new(@win,game,self)
            gameScreen.applyOn(@win)
            gameScreen.run
        },
        buttonAction2: lambda {
            game = Party.new("9x9:2c3-1-1c3a-b-a3d3b4d4-aa-a3a3dd5a-2a3a--b1-a3b3cc6dd4b3a--a-1a3a2c1a-a1a2c2c3c3c2")
            gameScreen = GameScreen.new(@win,game,self)
            gameScreen.applyOn(@win)
            gameScreen.run
         },
        buttonAction3: lambda {
            game = Party.new("13x13:2aa2a2a2aa1--c2aa2a2aa4bb42c-3a2aa1c--dc2-d1aa2a4aa4cc-4a3bb2c--c2c-c3bb5b7b2ccc-cc--c-d--cc2a4c1a4a7bb4c--d2a2c-d--c2aa6a1cc-5b4c---d--c2-c-dc1aa4aa2c-c-d1-1aa2aa2-2a3-")
            gameScreen = GameScreen.new(@win,game,self)
            gameScreen.applyOn(@win)
            gameScreen.run
        },
        uiManager: self,
        haveBackButton: true,
      )

    @mainmenu = MenuScreen.new(
      window: @win,
      title: "Menu Principal",
      button1: "Aventure",
      button2: "Libre",
      button3: "Classé",
      buttonAction1: lambda { @aventureScreen.applyOn(@win) },
      buttonAction2: lambda {	@libreScreen.applyOn(@win) },
      buttonAction3: lambda { @rankScreen.applyOn(@win) },
      uiManager: self,
    )

    @mainmenu.applyOn(@win)

  end

end
