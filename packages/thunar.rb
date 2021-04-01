require 'package'

class Thunar < Package
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  @_ver = '4.16.1'
  version @_ver + '-1'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/thunar/4.16/thunar-#{@_ver}.tar.bz2"
  source_sha256 'da2d17d2cb69eb33768690b714cc232ed367cbd71eb9543aaa2a805d05dc3ce1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-4.16.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-4.16.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-4.16.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-4.16.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f72859ef9d34c9f53b027e3ff4f939d53dfd02e2e14fa1ccba7272857dff6846',
     armv7l: 'f72859ef9d34c9f53b027e3ff4f939d53dfd02e2e14fa1ccba7272857dff6846',
       i686: 'a9968a493f18165318d3c1580e7aef64af66872290eb9f80d3164b3a1d4f06bd',
     x86_64: 'a07083925abfeb69f6e960869a61da8039b8afa0a79c9601f312cdb750ccfb86',
  })

  depends_on 'exo'
  depends_on 'libexif'
  depends_on 'libgudev'
  depends_on 'libnotify'
  depends_on 'xfce4_panel'
  depends_on 'desktop_file_utilities'
  depends_on 'hicolor_icon_theme'
  depends_on 'xdg_base'
  depends_on 'gui_setup'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
            ./configure #{CREW_OPTIONS} \
              --enable-gio-unix
              --enable-gudev
              --enable-exif
              --enable-pcre
              --disable-static
              --enable-notifications"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @file <<~EOF
      WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-wayland-0}
      GDK_BACKEND=${GDK_BACKEND:-wayland}
      exec #{CREW_PREFIX}/bin/#{CREW_BUILD}-thunar "$@"
    EOF
    File.write("#{CREW_DEST_PREFIX}/bin/Thunar", @file)
    File.chmod(0755, "#{CREW_DEST_PREFIX}/bin/Thunar")
    # FileUtils.ln_sf "#{CREW_PREFIX}/bin/#{CREW_BUILD}-thunar", "#{CREW_DEST_PREFIX}/bin/Thunar"
  end
end
