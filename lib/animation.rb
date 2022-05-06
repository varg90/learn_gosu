require 'gosu'

class Animation
  def initialize(active_frames, stop_frames = nil, time_in_secs)
    @active_frames = active_frames
    @stop_frames = stop_frames || [active_frames[0]]
    @time = time_in_secs * 300
  end

  def start
    @active_frames[Gosu.milliseconds / @time % @active_frames.size]
  end

  def stop
    @stop_frames[Gosu.milliseconds / @time % @stop_frames.size]
  end
end
