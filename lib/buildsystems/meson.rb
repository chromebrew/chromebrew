require 'package'

class Meson < Package
  def self.meson_options(options = '')
    return (@meson_options = options if options)
  end

  def self.check?(bool = true)
    return (@check = bool)
  end

  def self.build
    puts "Additional meson_options being used: #{@meson_options.nil? || @meson_options.empty? ? '<no meson_options>' : @meson_options}".orange
    @crew_meson_options = no_lto ? CREW_MESON_FNO_LTO_OPTIONS : CREW_MESON_OPTIONS
    if CREW_LINKER == 'mold'
      system "mold -run meson setup #{@crew_meson_options} #{@meson_options} builddir"
    else
      system "meson setup #{@crew_meson_options} #{@meson_options} builddir"
    end
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  if @check
    def self.check
      system "#{CREW_NINJA} -C builddir test"
    end
  end
end
