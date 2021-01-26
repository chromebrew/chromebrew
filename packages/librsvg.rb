require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.50.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/librsvg/2.50/librsvg-2.50.2.tar.xz'
  source_sha256 '6211f271ce4cd44a7318190d36712e9cea384a933d3e3570004edeb210a056d3'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '4ae81db4da7f1a37c0be24d6539326726364d4226b2ca43c583aac4b8a62af4c',
      armv7l: '4ae81db4da7f1a37c0be24d6539326726364d4226b2ca43c583aac4b8a62af4c',
        i686: '84acfe19e47585b1698cb1cd4ba9f4a8a6ccf45007baccaedf72a94e8bf91b52',
      x86_64: '54a837bd7569101d7ef3151d8832729a8f5bdadd00ded2bc34f67b9df85247ef',
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
    system "rustup install stable --profile minimal || (rm -frv ~/.rustup/toolchains/* && rustup install stable --profile minimal)"
    system "rustup default stable"
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
    system "gdk-pixbuf-query-loaders"
  end
end
