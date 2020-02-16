# @Author: Despres Maxence <checkam>
# @Date:   14-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   checkam
# @Last modified time: 16-Feb-2020


require "gtk3"
require File.dirname(__FILE__) + "/CellUi"
require File.dirname(__FILE__) + "/SelectionUi"
require File.dirname(__FILE__) + "/Constants"
require File.dirname(__FILE__) + "/Click"

##
# ===== Presentation
#   GridUi is a class to display the grid 
#
# ===== Variables
#
# 	@gtkObject         the associated gtk object
# 	@cellsUi           a matrix of all the cellsUi
# 	@cellsUiTrans			 a transposition of the matrix
# 	@first             the first cell in an action
# 	@last              the last cell in an action
# 	@currentSelection  a SelectionUi object
# 	@game              instance of the game
# 	@assets						 all cell assets
# 	@click						 state of click
# 	@tracer						 tracer state (true,false)
#
# ===== Methods
#
#   new 										initialization method
#   initGtkGrid							initialize gtk grid with cellsUi matrix
#   toogleTracer						activate or desactivate tracer
#   tracerActive?						return true if tracer is activate else false
#   hover										help to drag
#   coreCellAt							get game cell at row, col
#   leftClicked							called when a left click occur on the grid
#   leftClickedDraged				called when a draged left click occur on the grid
#   undo
# 	redo
# 	beginDrag               start of the selection of drag the cells
# 	endDrag                 reset all drag variables
# 	cellsUiFromFirstToEnd   return a tab of all cellUi Drag
# 	selection               draws a visual selection for the user
# 	realLast                compute the real last cell of the drag selection
# 	draged?                 return boolean true if a drag action is started else false
# 	clickdefined?
# 	refresh                 refresh the display gridUI
class GridUi

	@gtkObject
	@cellsUi
	@cellsUiTrans
	@first
	@last
	@currentSelection
	@game
	@assets
	@click
	@tracer

	attr_reader :gtkObject
	attr_reader :first, :last
	attr_reader :game, :cellsUi

	##
	# creation of a new grid UI
	#
	# ===== Attributes
	# * +cols+ -
	# * +rows+ -
	# * +assets+ -
	# * +parent+ -
	#
	# -----------------------------------
	def initialize(cols, rows, assets, parent)
		nRow = rows
		nCol = cols
		@game = game
		@assets = assets
		@countIndicators = @tracer = true
		# creation of the UI version of the cell
		@cellsUi = (0...nRow).map { |r|
			(0...nCol).map { |c|
				CellUi.new(self, r, c, @assets)
			}
		}
		@cellsUiTrans=@cellsUi.transpose

		# creation of the grid itself
		initGtkGrid()
		@gtkObject.signal_connect("button_release_event") { |_, event|
			if (@click == event.button)
				if event.button == Click::LEFT
					leftClickedDraged()
				end
			end
			endDrag()
		}
		@gtkObject.signal_connect("leave_notify_event") { |widget, event|
			if event.detail.nick != "inferior"
				endDrag()
			end
		}
		@currentSelection = SelectionUi.new
	end

	##
	# initialize gtk grid with cellsUi matrix
	#
	# -----------------------------------
	def initGtkGrid
		realGrid = Gtk::Grid.new
		realGrid.set_column_spacing(Constants::SPACING)
		realGrid.set_row_spacing(Constants::SPACING)
		@cellsUi.each_with_index {|row,i|
			row.each_with_index {|cell,j|
				realGrid.attach(cell.gtkObject, i+1, j+1, 1, 1)
			}
		}
		@gtkObject = Gtk::EventBox.new
		@gtkObject.add(realGrid)
	end

	##
	# Activate or desactivate tracer
	# @return tracer value (boolean)
	# -----------------------------------
	def toogleTracer
		case @tracer
		when true
			@tracer = false
		when false
			@tracer = true
		end
		@tracer
	end

	##
	# Return true if tracer is activate else false
	# -----------------------------------
	def tracerActive?
		@tracer
	end

	##
	# Help to drag
	# -----------------------------------
	def hover(cell)
		return unless tracerActive?
		mode=0	# => 0 or -1
		row = @cellsUi[cell.x]
		col = @cellsUiTrans[cell.y]
		@currentSelection.update(row + col)
		@currentSelection.show
	end

	##
	# Get game cell at row, col
	# -----------------------------------
	def coreCellAt(row, col)
		# TO DO
	end

	##
	# called when a left click occur on the grid
	# -----------------------------------
	def leftClicked
		@first.leftClicked
	end

	##
	# called when a draged left click occur on the grid
	# -----------------------------------
	def leftClickedDraged
		return unless clickdefined?
		return leftClicked unless draged?
		sameStateCoords = []
		sameState = cellsUiFromFirstToEnd.select { |cell|
			cell.sameState?(@first)
		}
		case sameState.length
			when 1
				@first.leftClicked
				cell=@first
				#
			else
				sameState.each { |cell|
					cell.dragLeftClicked
					sameStateCoords << cell.coords
				}
				# @game.addmove([sameStateCoords,"dragLeftClicked"])
		end
	end

	def undo
		# TO DO
	end

	def redo
		# TO DO
	end

	##
	# start of the selection of drag the cells
	# -----------------------------------
	def beginDrag(cell, click)
		return endDrag if draged?
		@first = cell
		@click = click
		selection(cell)
	end

	##
	# Reset all drag variables
	# -----------------------------------
	def endDrag
		@first = @last = nil
		@currentSelection.update([])
		@currentSelection.show()
	end

	##
	# Return a tab of all cellUi Drag
	# -----------------------------------
	def cellsUiFromFirstToEnd
		last = self.realLast
		firstRow, lastRow = [@first.x, last.x].minmax
		firstCol, lastCol = [@first.y, last.y].minmax
		cellsUi = []
		(firstRow..lastRow).each { |row|
			(firstCol..lastCol).each { |col|
				cellsUi << @cellsUi[row][col]
			}
		}
		return cellsUi
	end

	##
	# Draws a visual selection for the user
	# -----------------------------------
	def selection(cell)
		@last = cell
		@currentSelection.update(cellsUiFromFirstToEnd())
		@currentSelection.show()
	end

	##
	# Compute the real last cell of the drag selection
	# @return CellUi
	# -----------------------------------
	def realLast
		dc = (@first.y - @last.y).abs
		dr = (@first.x - @last.x).abs
		if dc < dr # then the selection vertical
			return @cellsUi[@last.x][@first.y]
		else       # the selection is horizontal
			return @cellsUi[@first.x][@last.y]
		end
	end

	##
	# Return boolean true if a drag action is started else false
	#
	# -----------------------------------
	def draged?
		@first != nil
	end


	def clickdefined?
		@last != nil && @first != nil
	end

	##
	# refresh the display gridUI
	#
	# -----------------------------------
	def refresh
		@cellsUi.each { |line|
			line.each { |cell|
				cell.normal
			}
		}
	end

end
