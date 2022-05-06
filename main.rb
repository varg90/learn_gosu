require 'gosu'
require_relative 'lib/player'
require_relative 'lib/helpers'
require_relative 'lib/explosion'

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

    if id == Gosu::MsLeft
      @explosions << Explosion.new(@explode_animation, mouse_x, mouse_y)
    end
  end

  def button_up(id)
    if @keys.values_at(:left, :right, :up, :down).flatten.include?(id)
      @player.stop_move
    end
    @player.stop_attack if id == @keys[:interact]
  end

  def update
    @player.move(:left) if pressed?(:left)
    @player.move(:right) if pressed?(:right)
    @player.move(:up) if pressed?(:up)
    @player.move(:down) if pressed?(:down)
    @player.attack if pressed?(:interact)

    @explosions.reject!(&:done?)
    @explosions.map(&:update)
  end

  def draw
    @background.draw(0, 0, 0)
    @player.draw
    @explosions.map(&:draw)
  end

  def needs_cursor?
    true
  end

  private

  def prepare_scene
    self.caption = 'The MeowMeow Redemption'

    @background = Gosu::Image.new(image_path('background', format: 'jpg'))

    @player = Player.new(400, 300)

    @background_music = Gosu::Song.new(sound_path('purring', format: 'mp3'))
    @background_music.play

    @explode_animation =
      Gosu::Image.load_tiles(image_path('explosion'), 128, 128)
    @explosions = []
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
