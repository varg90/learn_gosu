require 'gosu'

class Animation
  def initialize(frames, time_in_secs)
    @run_frames = frames
    @time = time_in_secs * 300
  end

  def start
    @run_frames[Gosu::milliseconds / @time % @run_frames.size]
  end

  def stop
    @run_frames[0]
  end
end
