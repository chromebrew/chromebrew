require 'package'

class Gtkmm3 < Package
  description 'The Gtkmm3 package provides a C++ interface to GTK+ 3.'
  homepage 'https://www.gtkmm.org/'
  version '3.24.3'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtkmm/3.24/gtkmm-3.24.3.tar.xz'
  source_sha256 '60497c4f7f354c3bd2557485f0254f8b7b4cf4bebc9fee0be26a77744eacd435'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.24.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.24.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.24.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.24.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'd296af5a49ecf3c541c9bd572a362fad38725878a4b40aa162d78218d1e241fa',
      armv7l: 'd296af5a49ecf3c541c9bd572a362fad38725878a4b40aa162d78218d1e241fa',
        i686: 'd10e9165ad434e818c47bb72c1e6eda5f619fdd946b43d114363919ccc0b0d5a',
      x86_64: '9122aca97e3de40447e8fe3d0c3c88194b0f2ad885c4b3957db947fdce3d79c4',
  })

  depends_on 'atkmm'
  depends_on 'gtk3'
  depends_on 'pangomm'
  
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
