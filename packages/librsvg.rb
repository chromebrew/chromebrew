require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.50.3-1'
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/librsvg/2.50/librsvg-2.50.3.tar.xz'
  source_sha256 'a4298a98e3a95fdd73c858c17d4dd018525fb09dbb13bbd668a0c2243989e958'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.3-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '40d0ff493b29670a4375a7fc35c236cdc44c249a6658bbc49ea54a435868d729',
     armv7l: '40d0ff493b29670a4375a7fc35c236cdc44c249a6658bbc49ea54a435868d729',
       i686: 'c3f61459db1d6007d9a17537ec9297967b176e7cca3ddb711113253bf731b24f',
     x86_64: 'dccf2e623cfb6da4c6995a3b0ad0fe8563a0126ed1e6fd4ecd8764ce15101245'
  })

  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'freetype_sub'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'harfbuzz'
  depends_on 'libcroco'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'pango'
  depends_on 'rust' => :build
  depends_on 'six' => :build
  depends_on 'vala' => :build

  def self.build
    # Following rustup modification as per https://github.com/rust-lang/rustup/issues/1167#issuecomment-367061388
    system 'rustup install stable --profile minimal || (rm -frv ~/.rustup/toolchains/* && rustup install stable --profile minimal)'
    system 'rustup default stable'
    system "env CFLAGS='-pipe -flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto' \
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
    if File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")
      system 'gdk-pixbuf-query-loaders',
             '--update-cache'
    end
end
