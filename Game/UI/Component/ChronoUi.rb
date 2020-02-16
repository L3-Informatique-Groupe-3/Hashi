# @Author: Despres Maxence <checkam>
# @Date:   15-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: ChronoUi.rb
# @Last modified by:   checkam
# @Last modified time: 16-Feb-2020



require File.dirname(__FILE__) + "/Text"

##
# ===== Presentation
#  	ChronoUi is a herite class of Text to display a chrono
# 	* +@see Text+
# ===== Methods
# 	updateLabel - Change the display text of this ChronoUi
# 	parce - Transform a time in second in an array with hours, minutes, seconds
# -------------------
class ChronoUi < Text
	attr_reader :time

	##
  # The class' constructor.
  #
  # ===== Attributes
  # * +time+ - initialize time in seconds
  #
  #-------------------------------------------------
	def initialize(time)
    super(label:"%02dh %02dm %02ds" % parce(time))
    @font="Arial"
    @color="black"
    @weight="normal"
    @style="normal"
		setBackground(1, 1, 1, 1)
		apply
	end

	##
	# Change the display text of this ChronoUi
	# @see Text#updateLabel
	# ===== Attributes
	# * +time+ - an integer in second to display with this format : %02dh %02dm %02ds
	# ------------------
  def updateLabel(time)
	  super("%02dh %02dm %02ds" % parce(time))
  end

	##
	# 	Transform a time in second in an array with hours, minutes, seconds
	#
	# ===== Attributes
	# 	* +time+ - time represents time in seconds of this ChronoUi
	# ------------------
	def parce(time)
	  s, m = time % 60, time / 60
	  h = m / 60
	  m = m % 60
		[h, m, s]
	end

end
