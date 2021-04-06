require 'package'

class Libdazzle < Package
  description 'The libdazzle library is a companion library to GObject and Gtk+.'
  homepage 'https://gitlab.gnome.org/GNOME/libdazzle/'
  version '3.40.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libdazzle/-/archive/#{version}/libdazzle-#{version}.tar.bz2"
  source_sha256 'a31f80a3134332d9621d46d74276788ba22e55d1197edab07182ea6be8468989'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdazzle-3.40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdazzle-3.40.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdazzle-3.40.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdazzle-3.40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c11c683320703431a0ead7f365e25e5fb7db17933967d0c23a7c12c62b269c86',
     armv7l: 'c11c683320703431a0ead7f365e25e5fb7db17933967d0c23a7c12c62b269c86',
       i686: 'cd1ad492b66fe8e6c52c7a67d51b117237f2b9395edfa282e63095cf916ed6dd',
     x86_64: '132e15b726324b2d08b450637d2a7435f8dd6b471fb2218b368835fe43c05fca'
  })

  depends_on 'atk'
  depends_on 'at_spi2_atk'
  depends_on 'at_spi2_core'
  depends_on 'cairo'
  depends_on 'dbus'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'graphite'
  depends_on 'gtk3'
  depends_on 'harfbuzz'
  depends_on 'libdeflate'
  depends_on 'libdrm'
  depends_on 'libepoxy'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libunwind'
  depends_on 'libwebp'
  depends_on 'libx11'
  depends_on 'libxau'
  depends_on 'libxcb'
  depends_on 'libxcomposite'
  depends_on 'libxcursor'
  depends_on 'libxdamage'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxi'
  depends_on 'libxinerama'
  depends_on 'libxkbcommon'
  depends_on 'libxrandr'
  depends_on 'libxrender'
  depends_on 'libxshmfence'
  depends_on 'libxxf86vm'
  depends_on 'mesa'
  depends_on 'pango'
  depends_on 'pcre'
  depends_on 'pixman'
  depends_on 'util_linux'
  depends_on 'vala' => :build
  depends_on 'wayland'

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
