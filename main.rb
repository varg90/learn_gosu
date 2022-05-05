require 'gosu'
require_relative 'player'

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
    meow if id == Gosu::KbE
  end

  def button_up(id)
    if [Gosu::KbLeft, Gosu::GpLeft, Gosu::KbRight, Gosu::GpRight].include?(id)
      @player.stop_move
    end
  end

  def update
    if self.button_down?(Gosu::KbLeft) || self.button_down?(Gosu::GpLeft)
      @player.move(:left)
    end
    if self.button_down?(Gosu::KbRight) || self.button_down?(Gosu::GpRight)
      @player.move(:right)
    end
    if self.button_down?(Gosu::KbUp) || self.button_down?(Gosu::GpUp)
      @player.move(:up)
    end
    if self.button_down?(Gosu::KbDown) || self.button_down?(Gosu::GpDown)
      @player.move(:down)
    end
  end

  def draw
    @player.draw
  end

  private

  def prepare_scene
    self.caption = 'The MeowMeow Redemption'

    @player = Player.new(400, 300)

    @background_music = Gosu::Song.new(sound_file('purring', format: 'mp3'))
    @background_music.play
  end

  def image_file(filename, format: 'png')
    "./images/#{filename}.#{format}"
  end

  def sound_file(filename, format: 'wav')
    "./sounds/#{filename}.#{format}"
  end

  def meow
    Gosu::Sample.new(sound_file("meow_#{rand(1..8)}")).play
  end
end

Game.new.show
