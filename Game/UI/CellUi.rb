# @Author: Despres Maxence <checkam>
# @Date:   14-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   checkam
# @Last modified time: 03-Apr-2020





require File.dirname(__FILE__) + "/Click"


##
# ===== Presentation
#   CellUi is a class to display a cell
#
# ===== Variables
#
# 	@x 						X Coordinate
# 	@y 						Y Coordinate
# 	@gridUI				gridUI widget
# 	@gtkObject 		gtk object used to display on gridUI widget
# 	@cellAssets 	instance of CellAssets
#
# ===== Methods
#
#   new 										initialization method
#   getCoreCell								get core cell at x, y in grid
#   select									change asset to selected cell
#   normal									set cellUi asset to empty cell
# 	unselect								unselect is same as normal function
# 	applyAsset							apply asset select on this cellUi
# 	show										display this cell
# 	coords									return cell coords
#
class CellUi
	@x
	@y
	@gridUI
	@gtkObject
	@cellAssets
	@textUi
	@imageBuf

	attr_reader :gtkObject, :x, :y
	attr_reader :coreCell

	##
	# The class' constructor.
	#
	# ===== Attributes
  # * +gridUI+ -
	# * +x+ - X Coordinate
  # * +y+ - Y Coordinate
  # * +cellAssets+ - instance of CellAssets
	#
  # -----------------------------------
	def initialize(gridUI, x, y, cellAssets)
		@x = x
		@y = y
		@gridUI = gridUI
		@cellAssets = cellAssets
		@gtkObject = Gtk::EventBox.new
		@gtkTable = Gtk::Table.new(1,1)
		@gtkObject.add(@gtkTable)
		@imageFinish = Gtk::Box.new(:vertical)
		@gtkTable.attach(@imageFinish,0,1,0,1)
		if getCoreCell.state == :isle
			applyText(getCoreCell.bridgeNumber.to_s)
		end
		@imageBox = Gtk::Box.new(:vertical)
		@gtkTable.attach(@imageBox,0,1,0,1)
		normal()

		@gtkObject.signal_connect("button_press_event") { |_, event|
			if event.button==Click::LEFT
				if Gdk::EventType::BUTTON2_PRESS==event.event_type
					@gridUI.beginDrag(self, event.button)
				end
				@gridUI.beginDrag(self, event.button)
				Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
			end
		}

		@gtkObject.signal_connect("enter_notify_event") { |_, event|
			@gtkObject.window.set_cursor(Click::CURSORIN) unless @gtkObject.window == nil
			if @gridUI.draged?
				@gridUI.selection(self)
			else
				@gridUI.hover(self)
			end
		}
	  @gtkObject.signal_connect("leave_notify_event") { |widget, event|
	    @gtkObject.window.set_cursor(Click::CURSOROUT) unless @gtkObject.window == nil
	  }
	end

	##
	# 	change asset to selected cell
	# -------------------------
	def select
		case getCoreCell.state
			when :bridge
				normalAsset = @cellAssets.cellAssetSelected(:empty)
				case getCoreCell.type
					when :empty
						normalAsset = @cellAssets.cellAssetSelected(:empty)
					when :simple
						if(getCoreCell.direction == :vertical)
							if(getCoreCell.isAlterable?)
								normalAsset = @cellAssets.cellAssetSelected(:bridge)[:vertical][:simple]
							else
								normalAsset = @cellAssets.cellAssetSelected(:bridge)[:vertical][:simple_freeze]
							end
						else
							if(getCoreCell.isAlterable?)
								normalAsset = @cellAssets.cellAssetSelected(:bridge)[:horizontal][:simple]
							else
								normalAsset = @cellAssets.cellAssetSelected(:bridge)[:horizontal][:simple_freeze]
							end
						end
					when :double
						if(getCoreCell.direction == :vertical)
							if(getCoreCell.isAlterable?)
								normalAsset = @cellAssets.cellAssetSelected(:bridge)[:vertical][:double]
							else
								normalAsset = @cellAssets.cellAssetSelected(:bridge)[:vertical][:double_freeze]
							end
						else
							if(getCoreCell.isAlterable?)
								normalAsset = @cellAssets.cellAssetSelected(:bridge)[:horizontal][:double]
							else
								normalAsset = @cellAssets.cellAssetSelected(:bridge)[:horizontal][:double_freeze]
							end
						end
					end
			when :isle
				normalAsset = @cellAssets.cellAssetSelected(:isle)
				if @gridUI.game.isleCellCompleted?(@x,@y) == true
					@cellAssets.cellAssetSelected(:isleFull).applyOn(@imageFinish)
				else
					@cellAssets.cellAssetSelected(:transparent).applyOn(@imageFinish)
				end
			when :obstacle
				normalAsset = @cellAssets.cellAssetSelected(:empty)
		end
		applyAsset(normalAsset)
	end

	##
	# set cellUi asset to empty cell
	# -------------------------
	def normal
			case getCoreCell.state
					when :bridge
						normalAsset = @cellAssets.cellAsset(:empty)
						case getCoreCell.type
							when :empty
								normalAsset = @cellAssets.cellAsset(:empty)
							when :simple
								if(getCoreCell.direction == :vertical)
									if(getCoreCell.isAlterable?)
										normalAsset = @cellAssets.cellAsset(:bridge)[:vertical][:simple]
									else
										normalAsset = @cellAssets.cellAsset(:bridge)[:vertical][:simple_freeze]
									end
								else
									if(getCoreCell.isAlterable?)
										normalAsset = @cellAssets.cellAsset(:bridge)[:horizontal][:simple]
									else
										normalAsset = @cellAssets.cellAsset(:bridge)[:horizontal][:simple_freeze]
									end
								end
							when :double
								if(getCoreCell.direction == :vertical)
									if(getCoreCell.isAlterable?)
										normalAsset = @cellAssets.cellAsset(:bridge)[:vertical][:double]
									else
										normalAsset = @cellAssets.cellAsset(:bridge)[:vertical][:double_freeze]
									end
								else
									if(getCoreCell.isAlterable?)
										normalAsset = @cellAssets.cellAsset(:bridge)[:horizontal][:double]
									else
										normalAsset = @cellAssets.cellAsset(:bridge)[:horizontal][:double_freeze]
									end
								end
							end
					when :isle
							normalAsset = @cellAssets.cellAsset(:isle)
							if @gridUI.game.isleCellCompleted?(@x,@y) == true
								@cellAssets.cellAsset(:isleFull).applyOn(@imageFinish)
							else
								@cellAssets.cellAsset(:transparent).applyOn(@imageFinish)
							end
					when :obstacle
							normalAsset = @cellAssets.cellAsset(:empty)
				end
				applyAsset(normalAsset)
	end

	alias :unselect :normal # unselect is same as normal function
	##
	# apply asset select on this cellUi
	# -----------------------
	def applyAsset(asset)
		asset.applyOn(@imageBox)
	end

	def applyText(text)
		@textUi = Text.new(label:text,padding:0)
		@gtkTable.attach(Gtk::Alignment.new(0.5, 0.5, 0, 0).add(@textUi.gtkObject),0,1,0,1)
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
		@gridUI.getCoreCellAt(@x,@y)
	end

end
