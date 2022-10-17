require 'package'

class Meson_v1 < Package
  @_buildsystems_meson_version = '1.0.0'

  def self.meson_options(options = '')
    return (@meson_options = options if options)
  end

  def self.check?(bool = true)
    return (@check = bool)
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
            #{@meson_options} builddir"
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
