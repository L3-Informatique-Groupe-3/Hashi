# @Author: Despres Maxence <makc>
# @Date:   09-Mar-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Last modified by:   checkam
# @Last modified time: 03-Apr-2020
# @Author: Despres Maxence <checkam>
# @Date:   16-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: TestUi.rb
# @Last modified by:   checkam
# @Last modified time: 03-Apr-2020

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
  			Gtk.main_quit
  		}
  		@win.override_background_color(:normal,Gdk::RGBA.new(0.1, 0.6, 1, 1))
  		@win.show_all

			ui = UiManager.new(@win)

  	end

end

test = Test.new
Gtk.main
