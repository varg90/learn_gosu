require 'gosu'
require_relative 'animation'

class Player
  PLAYER_WIDTH = 32
  PLAYER_HEIGHT = 32
  STEP = 5.0

  def initialize(x, y)
    @run_frames =
      Gosu::Image.load_tiles './images/sprite.png', PLAYER_WIDTH, PLAYER_HEIGHT
    @x, @y = x, y

    @move = Animation.new(@run_frames[40..48], 0.2)

    @movements = { left: -STEP, right: STEP, up: -STEP, down: STEP }

    @moving = false
    @facing = :right
  end

  def draw
    action = @moving ? @move.start : @move.stop
    @x_direction = @facing == :right ? 1 : -1
    action.draw @x, @y, 1, @x_direction
  end

  def move(direction)
    if [:up, :down].include?(direction)
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
end
