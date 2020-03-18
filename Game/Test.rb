# @Author: Despres Maxence <makc>
# @Date:   09-Mar-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Last modified by:   makc
# @Last modified time: 10-Mar-2020
# @Author: Despres Maxence <checkam>
# @Date:   16-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: TestUi.rb
# @Last modified by:   makc
# @Last modified time: 10-Mar-2020

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
    puts "LOAD : " + file
		require file
	}
end


require "gtk3"
require_all("Core")
require_all("UI")


class Test
  	##
  	# The class' constructor.
  	#
  	# -----------------------------------
  	def initialize
  		@win = Gtk::Window.new.fullscreen

  		@win.title = "Hashi"

  		@win.signal_connect('destroy') {
  			Gtk.main_quitopp
				exit
  		}
  		@win.override_background_color(:normal,Gdk::RGBA.new(0.1, 0.6, 1, 1))
  		@win.show_all

  	end

    def run
      Thread.new {
        # Generation des textures
        cellAssets=CellAssets.new(9, 9)

        @game = Party.new("9x9:2c3-1-1c3a-b-a3d3b4d4-aa-a3a3dd5a-2a3a--b1-a3b3cc6dd4b3a--a-1a3a2c1a-a1a2c2c3c3c2")

        # Generation des ecrans de jeu
        @gameScreen=GameScreen.new(@win,@game,cellAssets)
        @gameScreen.applyOn(@win)
        @gameScreen.run
      }
    end
end

test = Test.new
test.run
Gtk.main
