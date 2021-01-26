require 'package'

class Atkmm < Package
  description 'Atkmm is the official C++ interface for the ATK accessibility toolkit library.'
  homepage 'https://www.gtkmm.org/'
  version '2.28.1'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/atkmm/2.28/atkmm-2.28.1.tar.xz'
  source_sha256 '116876604770641a450e39c1f50302884848ce9cc48d43c5dc8e8efc31f31bad'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/atkmm-2.28.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/atkmm-2.28.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/atkmm-2.28.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/atkmm-2.28.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '0f959c7e95bee71b46cb1b90902d0e7556d0914e56e1a4e7654c95166307dd8d',
      armv7l: '0f959c7e95bee71b46cb1b90902d0e7556d0914e56e1a4e7654c95166307dd8d',
        i686: '1b400ecf33d5dcbceaffee8608a06c155fcd57d118262569136552c1f11c96bc',
      x86_64: '2aee40b687e3c021894d9d98719655de5bc703f5d397b4ee2f452accc45915cd',
  })

  depends_on 'atk'
  depends_on 'glibmm'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --default-library=both \
    -Dbuild-documentation=false \
    -Dbuild-demos=false \
    -Dbuild-tests=false \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
