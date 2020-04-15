# @Author: Despres Maxence <checkam>
# @Date:   10-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: Asset.rb
# @Last modified by:   checkam
# @Last modified time: 16-Feb-2020



##
# ===== Presentation
# Asset is an abstract class needed to create and use all of the images from the game.
#
#	@buffer - image
#	@width	- size in pixel
#	@height	- size in pixel
#
# ===== Methods
#
# resize 		- 		modifies the buffer to make it fit a certain size.
# applyOn		-			puts an image on a widget.
class Asset
	@buffer
	@width
	@height

	# :nodoc:
	attr_reader :buffer
	# :startdoc:

	##
	# The class' constructor.
	#
	# ===== Attributes
	# * +file+ - A file that will give its value to the buffer variable.
	#
	def initialize(file)
		@buffer= GdkPixbuf::Pixbuf.new(file: file)
	end

	##
	# ===== Presentation
	# The resize method modifies the buffer to make it fit a certain size.
	#
	# ===== Attributes
	# * +width+, +height+ - The new size for the buffer.
	#
	def resize(width,height)
		@buffer=@buffer.scale(width, height, :bilinear)
	end

	##
	# ===== Presentation
	# The applyOn method puts an image on a widget.
	#
	# ===== Atrributes
	# * +widget+ - The widget we will put the image onto.
	def applyOn(widget)
		widget.each { |child|
			widget.remove(child)
		}
		widget.add(Gtk::Image.new(pixbuf: @buffer))
		widget.show_all
	end

end
