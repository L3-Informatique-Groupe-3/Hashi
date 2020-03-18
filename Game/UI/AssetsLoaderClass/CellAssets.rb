# @Author: Despres Maxence <checkam>
# @Date:   11-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: CellAssets.rb
# @Last modified by:   makc
# @Last modified time: 10-Mar-2020



require File.dirname(__FILE__) + "/../AssetsClass/CellAsset"

##
# ===== Presentation
# 	Load all assets for cells
#
# 	@cellAssets - all assets for cells
# 	@cellAssetsSelected  all assets for cells selected
#
# ===== Methods
#  	cellAsset							- 	Return assets of a cell
# 	cellAssetSelected			-		Return assets of a cell selected
#
class CellAssets

	@cellAssets
	@cellAssetsSelected

	##
  # The class' constructor.
  #
  # ===== Attributes
	# * +nRows+ - 	number of rows of grid
  # * +nCols+ -		number of cols of grid
  #
  #-------------------------------------------------
	def initialize(nRows, nCols)
		pathToAssets=File.dirname(__FILE__) + "/../../../Assets/Cells/"

		@cellAssets = {
			empty:  	CellAsset.new(pathToAssets+"empty.png",nRows, nCols),
			bridge: 	{
				vertical:	{
					simple: CellAsset.new(pathToAssets+"a.gif",nRows,nCols),
					double: CellAsset.new(pathToAssets+"b.gif",nRows,nCols),
				},
				horizontal: {
					simple: CellAsset.new(pathToAssets+"c.gif",nRows,nCols),
					double: CellAsset.new(pathToAssets+"d.gif",nRows,nCols),
				},
			},
			isle: CellAsset.new(pathToAssets+"ring.gif",nRows,nCols),
		}

		@cellAssetsSelected = {
			empty:  	CellAsset.new(pathToAssets+"emptySelected.png",nRows, nCols),
			bridge: 	{
				vertical:	{
					simple: CellAsset.new(pathToAssets+"a.gif",nRows,nCols),
					double: CellAsset.new(pathToAssets+"b.gif",nRows,nCols),
				},
				horizontal: {
					simple: CellAsset.new(pathToAssets+"c.gif",nRows,nCols),
					double: CellAsset.new(pathToAssets+"d.gif",nRows,nCols),
				},
			},
			isle: CellAsset.new(pathToAssets+"ringSelected.gif",nRows,nCols),
		}
	end

	##
	# Return assets of a cell
	# ===== Attributes
	# 	state - state wanted
	#
	def cellAsset(state=:empty)
			@cellAssets[state]
	end

	##
	# Return assets of a cell selected
	# ===== Attributes
	# 	state - state wanted
	#
	def cellAssetSelected(state)
			@cellAssetsSelected[state]
	end


end
