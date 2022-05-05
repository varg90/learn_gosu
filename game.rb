require 'gosu'

class Game < Gosu::Window
  SCREEN_WIDTH = 800
  SCREEN_HEIGHT = 600

  def initialize(
    width = SCREEN_WIDTH,
    height = SCREEN_HEIGHT,
    fullscreen = false
  )
    super
    self.caption = 'The MeowMeow Redemption'
    @image = Gosu::Image.from_text('AAA!', 100)
    @background_music = Gosu::Song.new('./sounds/purring.mp3')
    @background_music.play
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    if id == Gosu::KbM
      if @background_music.paused?
        @background_music.play
      else
        @background_music.pause
      end
    end
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

Game.new.show
