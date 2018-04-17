require 'package'

class Weston < Package
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  version '3.0.91'
  source_url 'https://github.com/wayland-project/weston/archive/3.0.91.tar.gz'
  source_sha256 'a27eecd9dd9a18131292d33eba37f35369ede5f3b0688154244e3238b27f854a'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/weston-3.0.91-chromeos-x86_64.tar.xz',
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/weston-3.0.91-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/weston-3.0.91-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/weston-3.0.91-chromeos-i686.tar.xz',
  })
  binary_sha256 ({
     x86_64: '6ce064ae0d5b4282858d436d24e902f2f690d2bb7f1acca576013c201c4b9c42',
    aarch64: '07fd4523ff123b53271ac100d5b2bee8edd40a1e11026cbfc19ab2671179f7f4',
     armv7l: '07fd4523ff123b53271ac100d5b2bee8edd40a1e11026cbfc19ab2671179f7f4',
       i686: '1bf7ac234043bfad8877e0eea7f58ca20487d1464a865e2ab12e877404ebe8e1',
  })

  depends_on 'harfbuzz'
  depends_on 'libxcursor'
  depends_on 'libinput'
  depends_on 'libxkbcommon'
  depends_on 'libwayland'
  depends_on 'wayland_protocols'
  depends_on 'libjpeg'
  depends_on 'libunwind'
    
  depends_on 'pango'
  depends_on 'dbus'

    
  def self.build
    system "./autogen.sh"  
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-weston-launch"    
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
