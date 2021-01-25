# Colorization for strings
class String
  @use_color = STDOUT.isatty

  class << self
    attr_accessor :use_color
  end

  def colorize(color_code, shade)
    if self.class.use_color
      return "\e[#{shade};#{color_code}m#{self}\e[0m"
    else
      return self
    end
  end

  def black
    colorize(30, 0)
  end

  def red
    colorize(31, 0)
  end

  def green
    colorize(32, 0)
  end

  def orange
    colorize(33, 0)
  end

  def blue
    colorize(34, 0)
  end

  def purple
    colorize(35, 0)
  end

  def cyan
    colorize(36, 0)
  end

  def lightgray
    colorize(37, 0)
  end

  def gray
    colorize(30, 1)
  end

  def lightred
    colorize(31, 1)
  end

  def lightgreen
    colorize(32, 1)
  end

  def yellow
    colorize(33, 1)
  end

  def lightblue
    colorize(34, 1)
  end

  def lightpurple
    colorize(35, 1)
  end

  def lightcyan
    colorize(36, 1)
  end

  def white
    colorize(37, 1)
  end
end
