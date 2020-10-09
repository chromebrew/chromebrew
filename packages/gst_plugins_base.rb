require 'package'

class Gst_plugins_base < Package
  description 'An essential, exemplary set of elements for GStreamer'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-plugins-base.html'
  version '1.18.0'
  compatibility 'all'
  source_url 'https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.18.0.tar.xz'
  source_sha256 '762abdd1a950809a1cea62fff7f86b5f7d6bd5f6841e3e585c700b823cdb7897'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.18.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.18.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.18.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.18.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a53d2597a9779c17677a600ac0cd669a8ce3079ac62ab87627880f2148fab970',
     armv7l: 'a53d2597a9779c17677a600ac0cd669a8ce3079ac62ab87627880f2148fab970',
       i686: 'b2ac2d8f40199531e304c35659ecbd48107297072114967011feb8b12a48ebba',
     x86_64: 'f2ea971bba4cf271d4f36b7eb743065cc53ce00973afebb1076d996ff4e04170',
  })

  depends_on 'gstreamer'
  depends_on 'libtheora'
  depends_on 'glib'
  depends_on 'pango'
  depends_on 'libopus'
  depends_on 'libogg'
  depends_on 'libvisual'
  depends_on 'libpng'
  depends_on 'graphene'
  depends_on 'alsa_lib'
  depends_on 'libxshmfence'
  depends_on 'libxcomposite'
  depends_on 'libxv'
  depends_on 'libglu'
  depends_on 'libgudev'
  depends_on 'gdk_pixbuf'

  def self.build
    # Use lld to enable compatibility with ChromeOS libraries
    #ENV['CFLAGS'] = "-fuse-ld=lld"
    #ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "meson",
    "--prefix=#{CREW_PREFIX}",
    "--libdir=#{CREW_LIB_PREFIX}",
    "-Dgst_debug=false",
    "-Dexamples=disabled",
    "build"
    system "ninja -C build" 
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end

  def self.check
    # system "make", "check" # All the GL tests fail, as an X terminal is not running.
  end
end
