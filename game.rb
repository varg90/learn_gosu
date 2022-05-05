require 'gosu'

class EvacuationPlan < Gosu::Window
  SCREEN_WIDTH = 800
  SCREEN_HEIGHT = 600

  def initialize(
    width = SCREEN_WIDTH,
    height = SCREEN_HEIGHT,
    fullscreen = false
  )
    super
    self.caption = 'Evacuation plan'
    @image = Gosu::Image.from_text('AAA!', 100)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def update
    @x = SCREEN_WIDTH / 2 - @image.width / 2 + Math.sin(5 * Time.now.to_f) * 150
    @y =
      SCREEN_HEIGHT / 2 - @image.height / 2 - Math.cos(5 * Time.now.to_f) * 150
  end

  def draw
    @image.draw @x, @y, 0, 1, 1, 0xff_fffffa
  end
end

EvacuationPlan.new.show
