require 'package'

class Libdazzle < Package
  description 'The libdazzle library is a companion library to GObject and Gtk+.'
  homepage 'https://gitlab.gnome.org/GNOME/libdazzle/'
  version '3.37.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libdazzle/-/archive/3.37.1/libdazzle-3.37.1.tar.bz2'
  source_sha256 'f786a9c3007011a03c721c3402f86ec69642797f64a4bdaa6f1a9c10628aa0cf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdazzle-3.37.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdazzle-3.37.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdazzle-3.37.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdazzle-3.37.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4c0e49a34616ca9e6eea5c26b0b64016ca9ea0b4ed92ed557500eb9787c9dd5a',
     armv7l: '4c0e49a34616ca9e6eea5c26b0b64016ca9ea0b4ed92ed557500eb9787c9dd5a',
       i686: 'e0bbfadef81daeb2d572e07e9f06a9a019da8dbc2f89f9cb2244894b9668f857',
     x86_64: 'd0305eb7f99c8a516d72f9951ba1ebab75cc0d0954f3e6afa412dbf765c48c71',
  })

  depends_on 'gobject_introspection'
  depends_on 'gtk3'
  depends_on 'vala' => :build

  def self.prebuild
    system "sed -i '179d' meson.build"
    system "sed -i 's,-fstack-protector-strong,-fno-stack-protector,' meson.build"
  end

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --buildtype=release _build"
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
