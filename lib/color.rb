# Colorization for strings
class String
  @@use_color = $stdout.isatty

  # ANSI color codes
  @@color_codes = {
        black: { normal: 30, background: 40 },
          red: { normal: 31, background: 41 },
        green: { normal: 32, background: 42 },
       orange: { normal: 33, background: 43 },
         blue: { normal: 34, background: 44 },
       purple: { normal: 35, background: 45 },
         cyan: { normal: 36, background: 46 },
    lightgray: { normal: 37, background: 47 },

           # colors with bold varient available
           gray: { normal: 90, background: 100, bold: 30 },
       lightred: { normal: 91, background: 101, bold: 31 },
     lightgreen: { normal: 92, background: 102, bold: 32 },
         yellow: { normal: 93, background: 103, bold: 33 },
      lightblue: { normal: 94, background: 104, bold: 34 },
    lightpurple: { normal: 95, background: 105, bold: 35 },
      lightcyan: { normal: 96, background: 106, bold: 36 },
          white: { normal: 97, background: 107, bold: 37 }
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
      bold_avail = code.keys?(:bold)

      if bold_avail
        # use bold varient by default (if available),
        # specify :no_bold to use normal varient
        use_bold   = !opts.include?(:no_bold)
        color_code = code[use_bold ? :bold : :normal]
      elsif opts.include?(:background)
        use_bold   = false
        color_code = code[:background]
      else
        use_bold   = false
        color_code = code
      end

      return colorize(color_code, use_bold ? 1 : 0)
    end
  end
end
