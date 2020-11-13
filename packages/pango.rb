require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.47.0-1'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.47/pango-1.47.0.tar.xz'
  source_sha256 '730db8652fc43188e03218c3374db9d152351f51fc7011b9acae6d0a6c92c367'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.47.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.47.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.47.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.47.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c26d89cc7502639d43ada8a4717d202fc5db1b4a8bc208aeadb2c7848acc59f1',
     armv7l: 'c26d89cc7502639d43ada8a4717d202fc5db1b4a8bc208aeadb2c7848acc59f1',
       i686: '33679c61e144354936291ffa70f14e176c94cf5220ae46837ef02d6bbd6448fa',
     x86_64: '55ae812a7a393501b0347103ba17ec656fce99f817d6ee4688ccd2c5a8c22254',
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
