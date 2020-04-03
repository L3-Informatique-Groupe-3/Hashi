# @Author: Despres Maxence <checkam>
# @Date:   10-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: CellAsset.rb
# @Last modified by:   checkam
# @Last modified time: 03-Apr-2020



require File.dirname(__FILE__) + "/Asset"
require File.dirname(__FILE__) + "/../Constants"

##
# ===== Presentation
# CellAsset is a herite class of Asset needed for load assets just for cells
#
#	@buffer		image
# @nRows 		number of rows of grid
# @nCols		number of cols of grid
#
# ===== Methods
#
# resize 		-  	@see Asset#resize
#
class CellAsset < Asset
	@buffer
	@nRows
	@nCols

	##
	# The class' constructor.
	#
	# ===== Attributes
  # * +file+ 	- 	path of image
	# * +nRows+ - 	number of rows of grid
  # * +nCols+ -		number of cols of grid
  #
  # -----------------------------------
	def initialize(file,nRows, nCols)
		@nRows=nRows
		@nCols=nCols
		super(file)
		resize
	end

	##
	# 	@see Asset#resize
	#
	def resize
			screen = Gdk::Screen.default
			m1=((screen.width*0.7 ) / (@nCols+1))
			m2=((screen.height*0.90) / (@nRows+1))
			mf= m1 < m2 ? m1 : m2
			super(mf,mf)
		end
end
