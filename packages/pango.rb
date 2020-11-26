require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.48.0'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/pango/1.48/pango-1.48.0.tar.xz'
  source_sha256 '391f26f3341c2d7053e0fb26a956bd42360dadd825efe7088b1e9340a65e74e6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8cc6037637143f2e7d1eb8d3b5fa5abd451dc74ecc120512ff30032eebb5f2c4',
     armv7l: '8cc6037637143f2e7d1eb8d3b5fa5abd451dc74ecc120512ff30032eebb5f2c4',
       i686: '5fe040473e9d5ba8232d7bfb241da9ae9596c149179acad88217bd6654979e07',
     x86_64: '6c358d8a4470691613e6ca728861b95de40fb0ff0bcdf7225de95b59957f3416',
  })

  depends_on 'harfbuzz'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gobject_introspection'   # add this package to build gtk+, avoid compilation error
  depends_on 'libxrender'
  depends_on 'fribidi' # Gets built inside install automatically.
  depends_on 'six'
  depends_on 'llvm' => ':build'

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "meson #{CREW_MESON_OPTIONS} -Dinstall-tests=false builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
