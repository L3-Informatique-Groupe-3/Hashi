# @Author: Despres Maxence <checkam>
# @Date:   14-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   checkam
# @Last modified time: 16-Feb-2020





require File.dirname(__FILE__) + "/Click"


##
# ===== Presentation
#   CellUi is a class to display a cell
#
# ===== Variables
#
# 	@x 						X Coordinate
# 	@y 						Y Coordinate
# 	@parent				parent widget
# 	@gtkObject 		gtk object used to display on parent widget
# 	@cellAssets 	instance of CellAssets
#
# ===== Methods
#
#   new 										initialization method
#   leftClicked							called when the cell is left clicked
#   unLeftClicked						called when the cell is un left clicked
#   dragLeftClicked					called when drag this cell
#   coreCell								get core cell at x, y in grid
#   select									change asset to selected cell
#   normal									set cellUi asset to empty cell
# 	unselect								unselect is same as normal function
#   sameState
# 	dragable?								Test if a cell is dragable
# 	applyAsset							apply asset select on this cellUi
# 	show										display this cell
# 	coords									return cell coords
#
class CellUi
	@x
	@y
	@parent
	@gtkObject
	@cellAssets

	attr_reader :gtkObject, :x, :y, :variation

	##
	# The class' constructor.
	#
	# ===== Attributes
  # * +parent+ -
	# * +x+ - X Coordinate
  # * +y+ - Y Coordinate
  # * +cellAssets+ - instance of CellAssets
	#
  # -----------------------------------
	def initialize(parent, x, y, cellAssets)
		@x = x
		@y = y
		@parent = parent
		@cellAssets = cellAssets
		@gtkObject = Gtk::EventBox.new
		normal()

		@gtkObject.signal_connect("button_press_event") { |_, event|
			if event.button==Click::LEFT
				if Gdk::EventType::BUTTON2_PRESS==event.event_type
					@parent.beginDrag(self, event.button)
				end
				@parent.beginDrag(self, event.button)
				Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
			end
		}

		@gtkObject.signal_connect("enter_notify_event") { |_, event|
			@gtkObject.window.set_cursor(Click::CURSORIN) unless @gtkObject.window == nil
			if @parent.draged?
				@parent.selection(self)
			else
				@parent.hover(self)
			end
		}
	  @gtkObject.signal_connect("leave_notify_event") { |widget, event|
	    @gtkObject.window.set_cursor(Click::CURSOROUT) unless @gtkObject.window == nil
	  }
	end

	##
	# called when the cell is left clicked
	# -------------------------
	def leftClicked
		# TO DO
	end

	##
	# called when the cell is un left clicked
	# -------------------------
	def unLeftClicked
		# TO DO
	end

	##
	# called when drag this cell
	# -------------------------
	def dragLeftClicked
		# TO DO
	end

	##
	# get core cell at @x @y in grid
	# -------------------------
	def coreCell
		# TO DO
	end

	##
	# 	change asset to selected cell
	# -------------------------
	def select
		selectedAsset = @cellAssets.cellAssetSelected(:empty)
		applyAsset(selectedAsset)
	end

	##
	# set cellUi asset to empty cell
	# -------------------------
	def normal
		normalAsset = @cellAssets.cellAsset(:empty)
		applyAsset(normalAsset)
	end

	alias :unselect :normal # unselect is same as normal function

	def sameState?(cell)
		# TO DO
	end
	##
	# Test if a cell is dragable
	# -----------------------
	def dragable?
		# TO DO
	end

	##
	# apply asset select on this cellUi
	# -----------------------
	def applyAsset(asset)
		asset.applyOn(@gtkObject)
	end
	##
	# 	Display this cell
	#-----------------------
	def show
		@gtkObject.show
	end

	##
	# 	Return cell coords
	#-----------------------
	def coords
		[@x,@y]
	end

end
