# @Author: Despres Maxence <checkam>
# @Date:   14-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   checkam
# @Last modified time: 16-Feb-2020



##
# ===== Presentation
#   SelectionUi is a class that show a selection of cell
#
# ===== Variables
#
#   @selected is an array of all selected cell
#   @modified is an array
#
# ===== Methods
#
#   new 		-		initialization method
#   update 	-		update the selected cell
# 	select 	- 	call select on all cell of an array
# 	unselect- 	call unselect on all cell of an array
# 	show 		-	 	Show selection
#
class SelectionUi
	@selected
	@modified

	##
  # The class' constructor.
  #
  #-------------------------------------------------
	def initialize
		@selected = Array.new
		@modified = Array.new
	end

	##
	#  Update the selected cell
	#
	# ===== Attributes
	# * +newSelection+ - array of all the new selection of cell
	#
	#------
	def update(newSelection)

		unselected = @selected.reject { |cell| #
			newSelection.include?(cell)
		}
		unselect(unselected)

		newlySelected = newSelection.reject { |cell|
			@selected.include?(cell)
		}
		select(newlySelected)

		@selected = newSelection

	end

	##
  # Call unselect on all cell of an array
  #
  # ===== Attributes
  # * +arr+ - array of all cell to unselect
  #
  #-------------------------------------------------
	def unselect(arr)
		arr.each { |cell|
			@modified << cell
			cell.unselect
		}
	end

	##
  # Call select on all cell of an array
  #
  # ===== Attributes
  # * +arr+ - array of all cell to select
  #
  #-------------------------------------------------
	def select(arr)
		arr.each { |cell|
			@modified << cell
			cell.select
		}
	end

	##
  # Show selection
  #
  #-------------------------------------------------
	def show
		@modified.each(&:show)
		@modified = []
	end
end
