require 'gosu'

class WhackARuby < Gosu::Window

  def initialize
    super 1000,600
    self.caption = "Whack that goddamn Ruby."
  end
end

window = WhackARuby.new
window.show
