require 'package'

class Libgnome_games_support < Package
  description 'libgnome-games-support is a small library intended for internal use by GNOME Games.'
  homepage 'https://gitlab.gnome.org/GNOME/libgnome-games-support'
  compatibility 'all'
  @_app = File.basename(__FILE__, '.rb').tr('_', '-')
  @_fullver = '1.8.0'
  @_mainver = @_fullver.rpartition('.')[0]
  @_url = "https://download.gnome.org/sources/#{@_app}/#{@_mainver}/#{@_app}-#{@_fullver}"
  version @_fullver
  source_url "#{@_url}.tar.xz"
  source_sha256 `curl -Ls #{@_url}.sha256sum | tail -n1 | cut -d ' ' -f1`.chomp

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgnome_games_support-1.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgnome_games_support-1.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgnome_games_support-1.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgnome_games_support-1.8.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    aarch64: 'a19aa61c3719f84c94394fc3f435ff51d02821e17005f3afd0088a934e0e3fce',
     armv7l: 'a19aa61c3719f84c94394fc3f435ff51d02821e17005f3afd0088a934e0e3fce',
       i686: 'f979572afa1af8325e4c9d480f20bac1574b9278409c4bd80e413a08ba13d610',
     x86_64: '5ecda51e0782e91ebf5454e5f0869260a17f97ae2d48f16d0313d5f4fbdfb21a'
  })

  depends_on 'gtk3'
  depends_on 'libgee'
  depends_on 'clutter'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
