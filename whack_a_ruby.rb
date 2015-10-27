require 'gosu'

class WhackARuby < Gosu::Window

  WINDOW_WIDTH = 1000
  WINDOW_HEIGHT = 600

  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption  = "Whack that goddamn Ruby."
    @ruby_image   = Gosu::Image.new('./assets/images/ruby.png')
    @x            = 200
    @y            = 200
    @velocity_x   = 5
    @velocity_y   = 5
    @width        = 50
    @height       = 43
    @visible      = 0
    @hammer_image = Gosu::Image.new('./assets/images/hammer.png')
    @hit          = 0
  end

  private

  attr_accessor :x, :y, :velocity_x, :velocity_y, :visible
  attr_reader :ruby_image, :hammer_image, :width, :height

  def draw
   show_ruby unless visible <= 0
   show_hammer
  end

  def show_ruby
    ruby_image.draw(centre_point(x, width), centre_point(y, height), 1) 
  end

  def show_hammer
    hammer_image.draw(mouse_x - 40, mouse_y - 10, 1)
  end

  def centre_point(axis, measurement)
    axis - measurement / 2
  end

  def show_or_hide
    self.visible -= 1
    self.visible = 30 if visible < -10 && rand < 0.01
  end

  def update
    move_horizontally
    move_vertically
    adjust_horizontal_trajectory
    adjust_vertically_trajectory
    show_or_hide
  end

  def move_horizontally
    self.x += velocity_x
  end

  def move_vertically
    self.y += velocity_y
  end

  def adjust_horizontal_trajectory
    self.velocity_x *= -1 if past_horizontal_boundary?
  end

  def adjust_vertically_trajectory
    self.velocity_y *= -1 if past_vertical_boundary?
  end

  def past_horizontal_boundary?
    x + width / 2 > WINDOW_WIDTH || x - width / 2 < 0
  end

  def past_vertical_boundary?
    y + height / 2 > WINDOW_HEIGHT || y - height / 2 < 0
  end
end

window = WhackARuby.new
window.show
