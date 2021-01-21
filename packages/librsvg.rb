require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.50.1-1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/librsvg/2.50/librsvg-2.50.1.tar.xz'
  source_sha256 '9bd9799322e06cf5db19b9f7afb728edac6efcf0110baafc44f0f96f45df9a09'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.50.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6510c6c5ca8ac79da202138bc80e753080348a39b68b954050c46b5499ffdff2',
     armv7l: '6510c6c5ca8ac79da202138bc80e753080348a39b68b954050c46b5499ffdff2',
       i686: 'a6edd6fe4b6beaf820da1f3e64efd74327340a7c003a150fbebc496a57195485',
     x86_64: '9976b8ba14f11f6855b88c6e96a4f2eec64401af803c1e38ef1614899195abdb',
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
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--mandir=#{CREW_MAN_PREFIX}",
      "--build=#{CREW_BUILD}",
      "--host=#{CREW_BUILD}",
      "--target=#{CREW_BUILD}",
      "--enable-introspection=yes",
      "--enable-vala=yes",
      "--disable-static",
      "--enable-pixbuf-loader",
      "--disable-tools"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
