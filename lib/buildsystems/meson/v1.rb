require 'package'

class Meson_v1 < Package
  @_buildsystems_meson_version = '1.0.0'

  def self.meson_options (options = '')
    if options
      @meson_options = options
    end
    return @meson_options
  end

  def self.check? (bool = false)
    @check = bool
    return @check
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
            #{@meson_options} builddir"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  if @check
    def self.check
      system 'samu -C builddir test'
    end
  end
end
