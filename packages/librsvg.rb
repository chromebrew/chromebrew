require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.50.3'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/librsvg/2.50/librsvg-2.50.3.tar.xz'
  source_sha256 'a4298a98e3a95fdd73c858c17d4dd018525fb09dbb13bbd668a0c2243989e958'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '308cf9f89ed04934bf1e1c7e492b51bf57d5adbb023d4830e4fb2122d8fd796d',
     armv7l: '308cf9f89ed04934bf1e1c7e492b51bf57d5adbb023d4830e4fb2122d8fd796d',
       i686: '7b4b1fa2ec312b13267b7b1100e65f5e5da783c7dd2f973deb09382005b35c1f',
     x86_64: '3879b9088e910dc7bd3fa2499ac247a20edbcbd8f90dd76f4975c7993f8b49cd'
  })

  depends_on 'cairo'
  depends_on 'gobject_introspection'
  depends_on 'freetype_sub'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'libcroco'
  depends_on 'pango'
  depends_on 'rust' => :build
  depends_on 'glib'
  depends_on 'vala' => :build
  depends_on 'six' => :build

  def self.build
    # Following rustup modification as per https://github.com/rust-lang/rustup/issues/1167#issuecomment-367061388
    system 'rustup install stable --profile minimal || (rm -frv ~/.rustup/toolchains/* && rustup install stable --profile minimal)'
    system 'rustup default stable'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
      --mandir=#{CREW_MAN_PREFIX} \
      --build=#{CREW_BUILD} \
      --host=#{CREW_BUILD} \
      --target=#{CREW_BUILD} \
      --enable-introspection=yes \
      --enable-vala=yes \
      --disable-static \
      --enable-pixbuf-loader \
      --disable-tools"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end

  def self.postinstall
    # gdk_pixbuf should be setting the correct env variables
    system 'gdk-pixbuf-query-loaders'
  end
end
