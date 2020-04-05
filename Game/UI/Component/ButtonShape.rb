# @Author: Despres Maxence <checkam>
# @Date:   27-Mar-2020
# @Email:  maxence.despres.etu@univ-lemans.fr
# @Filename: ButtonShape.rb
# @Last modified by:   checkam
# @Last modified time: 05-Apr-2020



class ButtonShape

  attr_reader :gtkObject

  def initialize(shape: nil, width: nil, height: nil )
    @shape = Asset.new(shape)
    if width && height
      @shape.resize(width,height)
    end
    @gtkEvent = Gtk::EventBox.new
    @gtkObject=Gtk::Table.new(4,4)
    @shape.applyOn(@gtkEvent)
    @action = nil
    @gtkObject.attach(@gtkEvent,0,4,0,4)
    @n_channel = @shape.buffer.n_channels
    @rowstride = @shape.buffer.rowstride
    @tabPixel = @shape.buffer.pixels
  end

  def onClick(block=nil)
    @gtkEvent.signal_connect("button_release_event") { |_, event|
      isClick(event.x.truncate,event.y.truncate)
    }
  end

  def isClick(x,y)
    @pixel = y * @rowstride + x * @n_channel
    if @tabPixel[@pixel+3] == 255
      @action.call
    end
     return @tabPixel[@pixel+3] == 255
  end

  def setAction(action)
    @action = action
  end

end
