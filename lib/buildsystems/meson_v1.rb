require 'package'

class Meson_v1 < Package
  @_buildsystems_meson_version = '1.0.0'

  def self.meson_options (options = nil)
    if options
      @meson_options = options
    end
    @meson_options
  end

  def self.check? (bool)
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

  if @check == true
    def self.check
      system 'samu -C builddir test'
    end
  end
end
