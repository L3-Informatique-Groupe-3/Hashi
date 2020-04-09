# @Author: Despres Maxence <checkam>
# @Date:   15-Feb-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: ChronoUi.rb
# @Last modified by:   checkam
# @Last modified time: 18-Mar-2020



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
    super(label:"%02dh %02dm %02ds" % [time.hour, time.min, time.sec])
    @font="Arial"
    @color="black"
    @weight="normal"
    @style="normal"
		screen=Gdk::Screen.default
		setBackground(1,1,1,1)
		setBackgroundSize(screen.width*0.2,screen.height*0.08)
		apply
	end

	##
	# Change the display text of this ChronoUi
	# @see Text#updateLabel
	# ===== Attributes
	# * +time+ - an integer in second to display with this format : %02dh %02dm %02ds
	# ------------------
  def updateLabel(time)
	  super("%02dh %02dm %02ds"  % [time.hour, time.min, time.sec]	)
  end

end
