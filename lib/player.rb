require 'gosu'
require_relative 'animation'
require_relative 'helpers'

class Player
  include Helpers

  PLAYER_WIDTH = 32
  PLAYER_HEIGHT = 48
  STEP = 5.0

  def initialize(x, y)
    @run_frames =
      Gosu::Image.load_tiles image_file('knight/move'),
                             PLAYER_WIDTH,
                             PLAYER_HEIGHT
    @attack_frames =
      Gosu::Image.load_tiles image_file('knight/attack'),
                             66,
                             PLAYER_HEIGHT
    @x, @y = x, y

    @move = Animation.new(@run_frames[0..7], nil, 0.2)
    @attack = Animation.new(@attack_frames[0..3], @run_frames[0], 0.2)

    @movements = { left: -STEP, right: STEP, up: -STEP, down: STEP }

    @moving = false
    @attacking = false
    @meowing = false
    @facing = :right
  end

  def draw
    @x_direction = @facing == :right ? 1 : -1
    if @attacking
      @attack.start.draw @x, @y, 1, @x_direction
    else
      movement = @moving ? @move.start : @move.stop
      movement.draw @x, @y, 1, @x_direction
    end
  end

  def move(direction)
    if %i[up down].include?(direction)
      @y += @movements[direction]
      @y %= Game::SCREEN_HEIGHT
    else
      @x += @movements[direction]
      @x %= Game::SCREEN_WIDTH

      unless @facing == direction
        sign = @movements[direction] / STEP
        @x += sign - sign * PLAYER_WIDTH
      end

      @facing = direction
    end

    @moving = true unless @moving
  end

  def stop_move
    @moving = false if @moving
  end

  def attack
    @attacking = true unless @attacking
    meow
  end

  def stop_attack
    if @attacking
      @attacking = false
      @meowing = false
    end
  end

  def meow
    return if @meowing
    Gosu::Sample.new(sound_file("meow_#{rand(1..8)}")).play
    @meowing = true
  end
end
