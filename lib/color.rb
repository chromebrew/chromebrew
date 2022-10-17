# Colorization for strings
class String
  @@use_color = $stdout.isatty

  # ANSI color codes
  @@color_codes = {
        black: 30,
          red: 31,
        green: 32,
       orange: 33,
         blue: 34,
       purple: 35,
         cyan: 36,
    lightgray: 37,

    # colors with bold varient available
           gray: { normal: 90, bold: 30 },
       lightred: { normal: 91, bold: 31 },
     lightgreen: { normal: 92, bold: 32 },
         yellow: { normal: 93, bold: 33 },
      lightblue: { normal: 94, bold: 34 },
    lightpurple: { normal: 95, bold: 35 },
      lightcyan: { normal: 96, bold: 36 },
          white: { normal: 97, bold: 37 }
  }

  class << self
    # create a getter/setter method for @@use_color
    # like attr_accessor, but attr_accessor works on instance variables only
    def use_color=(use_color)
      @@use_color = use_color
    end

    def use_color
      return @@use_color
    end
  end

  def colorize(color_code, shade)
    return @@use_color ? "\e[#{shade};#{color_code}m#{self}\e[0m" : self
  end

  # create method for each color
  @@color_codes.each_pair do |name, code|
    define_method(name) do |*opts|
      bold_avail = code.is_a?(Hash)

      if bold_avail
        # use bold varient by default (if available),
        # specify :no_bold to use normal varient
        use_bold   = !opts.include?(:no_bold)
        color_code = code[use_bold ? :bold : :normal]
      else
        use_bold   = false
        color_code = code
      end

      return colorize(color_code, use_bold ? 1 : 0)
    end
  end
end