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
    prepare_scene
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
    Gosu::Sample.new(sound_file("meow_#{rand(1..8)}")).play if id == Gosu::KbE
  end

  def update
    if self.button_down?(Gosu::KbLeft)
      if @x_direction == :right
        @x -= 5
      else
        @x_direction = :right
        @x -= @player.width
      end
    end
    if self.button_down?(Gosu::KbRight)
      if @x_direction == :left
        @x += 5
      else
        @x_direction = :left
        @x += @player.width
      end
    end
    @y -= 5 if self.button_down?(Gosu::KbUp)
    @y += 5 if self.button_down?(Gosu::KbDown)
  end

  def draw
    @player.draw @x, @y, 1, x_scale_by_direction
  end

  private

  def prepare_scene
    self.caption = 'The MeowMeow Redemption'

    @player = Gosu::Image.new(image_file('sample'))

    @background_music = Gosu::Song.new(sound_file('purring', format: 'mp3'))
    @background_music.play

    @x_direction = :right
    @x = SCREEN_WIDTH / 2 - @player.width / 2
    @y = SCREEN_HEIGHT / 2 - @player.height / 2
  end

  def image_file(filename, format: 'png')
    "./images/#{filename}.#{format}"
  end

  def sound_file(filename, format: 'wav')
    "./sounds/#{filename}.#{format}"
  end

  def x_scale_by_direction
    @x_direction == :right ? 1 : -1
  end
end

Game.new.show
