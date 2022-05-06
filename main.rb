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
    set_controls
  end

  def button_down(id)
    close if id == @keys[:exit]
    if id == @keys[:mute]
      if @background_music.paused?
        @background_music.play
      else
        @background_music.pause
      end
    end
    meow if id == @keys[:interact]
  end

  def button_up(id)
    if @keys.values_at(:left, :right, :up, :down).flatten.include?(id)
      @player.stop_move
    end
  end

  def update
    @player.move(:left) if pressed?(:left)
    @player.move(:right) if pressed?(:right)
    @player.move(:up) if pressed?(:up)
    @player.move(:down) if pressed?(:down)
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

  def set_controls
    @keys = {
      left: [Gosu::KbLeft, Gosu::KbA],
      right: [Gosu::KbRight, Gosu::KbD],
      up: [Gosu::KbUp, Gosu::KbW],
      down: [Gosu::KbDown, Gosu::KbS],
      exit: Gosu::KbEscape,
      mute: Gosu::KbM,
      interact: Gosu::KbE
    }
  end

  def pressed?(button)
    gosu_keys = @keys[button]
    if gosu_keys.is_a?(Array)
      gosu_keys.select { |key| button_down?(key) }.any?
    else
      button_down?(gosu_keys)
    end
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
