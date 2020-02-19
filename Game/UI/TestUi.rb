# @Author: Despres Maxence <checkam>
# @Date:   16-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: TestUi.rb
# @Last modified by:   checkam
# @Last modified time: 19-Feb-2020

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
    puts "LOAD : " + file
		require file
	}
end


require "gtk3"
require_all(".")


class TestUi
  	##
  	# The class' constructor.
  	#
  	# -----------------------------------
  	def initialize
  		@win = Gtk::Window.new.fullscreen

  		@win.title = "Hashi"

  		@win.signal_connect('destroy') {
  			Gtk.main_quit
				exit
  		}
  		@win.override_background_color(:normal,Gdk::RGBA.new(0.1, 0.6, 1, 1))
  		@win.show_all

  	end

    def run
      Thread.new {
        # Generation des textures
        cellAssets=CellAssets.new(11, 11)

        # Generation des ecrans de jeu
        @gameScreen=GameScreen.new(self,nil,cellAssets)
        @gameScreen.applyOn(@win)
        @gameScreen.run
      }
    end
end

test = TestUi.new
test.run
Gtk.main
