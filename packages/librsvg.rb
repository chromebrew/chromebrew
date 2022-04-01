require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.50.3-1'
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/librsvg/2.50/librsvg-2.50.3.tar.xz'
  source_sha256 'a4298a98e3a95fdd73c858c17d4dd018525fb09dbb13bbd668a0c2243989e958'


  depends_on 'harfbuzz'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'harfbuzz' => :build
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
  depends_on 'py3_six' => :build
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
end
