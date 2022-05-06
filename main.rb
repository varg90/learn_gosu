require 'gosu'
require_relative 'lib/player'
require_relative 'lib/helpers'

class Game < Gosu::Window
  include Helpers

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
  end

  def button_up(id)
    if @keys.values_at(:left, :right, :up, :down).flatten.include?(id)
      @player.stop_move
    end
    if id == @keys[:interact]
      @player.stop_attack
    end
  end

  def update
    @player.move(:left) if pressed?(:left)
    @player.move(:right) if pressed?(:right)
    @player.move(:up) if pressed?(:up)
    @player.move(:down) if pressed?(:down)
    if pressed?(:interact)
      @player.attack
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
end

Game.new.show
