# @Author: Despres Maxence <checkam>
# @Date:   14-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   makc
# @Last modified time: 12-Mar-2020





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
	@coreCell
	@textUi
	@imageBuf

	attr_reader :gtkObject, :x, :y
	attr_reader :coreCell

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
	def initialize(parent, x, y, cellAssets, cell)
		@x = x
		@y = y
		@parent = parent
		@cellAssets = cellAssets
		@gtkObject = Gtk::EventBox.new
		@gtkTable = Gtk::Table.new(1,1)
		@gtkObject.add(@gtkTable)
		@coreCell = cell
		if cell.state == :isle
			applyText(cell.bridgeNumber.to_s)
		end
		@imageBox = Gtk::Box.new(:vertical)
		@gtkTable.attach(@imageBox,0,1,0,1)
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
	# 	change asset to selected cell
	# -------------------------
	def select
		case @coreCell.state
				when :bridge
					normalAsset = @cellAssets.cellAssetSelected(:empty)
					case @coreCell.type
							when :empty
									normalAsset = @cellAssets.cellAssetSelected(:empty)
							when :simple
									if(@coreCell.direction == :vertical)
											normalAsset = @cellAssets.cellAssetSelected(:bridge)[:vertical][:simple]
									else
											normalAsset = @cellAssets.cellAssetSelected(:bridge)[:horizontal][:simple]
									end
							when :double
									if(@coreCell.direction == :vertical)
											normalAsset = @cellAssets.cellAssetSelected(:bridge)[:vertical][:double]
									else
											normalAsset = @cellAssets.cellAssetSelected(:bridge)[:horizontal][:double]
									end
						end
						if(@coreCell.isAlterable?)
							applyAsset(normalAsset)
						else
							applyAsset(normalAsset)
						end
						when :isle
								normalAsset = @cellAssets.cellAssetSelected(:isle)
						when :obstacle
								normalAsset = @cellAssets.cellAssetSelected(:empty)
			end
			applyAsset(normalAsset)
	end

	##
	# set cellUi asset to empty cell
	# -------------------------
	def normal
			case @coreCell.state
					when :bridge
						normalAsset = @cellAssets.cellAsset(:empty)
						case @coreCell.type
								when :empty
										normalAsset = @cellAssets.cellAsset(:empty)
								when :simple
										if(@coreCell.direction == :vertical)
												normalAsset = @cellAssets.cellAsset(:bridge)[:vertical][:simple]
										else
												normalAsset = @cellAssets.cellAsset(:bridge)[:horizontal][:simple]
										end
								when :double
										if(@coreCell.direction == :vertical)
												normalAsset = @cellAssets.cellAsset(:bridge)[:vertical][:double]
										else
												normalAsset = @cellAssets.cellAsset(:bridge)[:horizontal][:double]
										end
							end
							if(@coreCell.isAlterable?)
								applyAsset(normalAsset)
							else
								applyAsset(normalAsset)
							end
					when :isle
							normalAsset = @cellAssets.cellAsset(:isle)
					when :obstacle
							normalAsset = @cellAssets.cellAsset(:empty)
				end
				applyAsset(normalAsset)
				self.show
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
		asset.applyOn(@imageBox)
	end

	def applyText(text)
		@textUi = Text.new(label:text)
		@gtkTable.attach(@textUi.gtkObject,0,1,0,1)
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

	def getCoreCell
		@coreCell
	end

end
