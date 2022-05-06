require 'gosu'

module Helpers
  def image_file(filename, format: 'png')
    File.join(File.dirname(__FILE__), "../media/images/#{filename}.#{format}")
  end

  def sound_file(filename, format: 'wav')
    File.join(File.dirname(__FILE__), "../media/sounds/#{filename}.#{format}")
  end

  def pressed?(button)
    gosu_keys = @keys[button]
    if gosu_keys.is_a?(Array)
      gosu_keys.select { |key| Gosu.button_down?(key) }.any?
    else
      Gosu.button_down?(gosu_keys)
    end
  end
end
