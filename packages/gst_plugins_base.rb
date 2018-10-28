require 'package'

class Gst_plugins_base < Package
  description 'An essential, exemplary set of elements for GStreamer'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-plugins-base.html'
  version '1.14.4'
  source_url 'https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.14.4.tar.xz'
  source_sha256 'ca6139490e48863e7706d870ff4e8ac9f417b56f3b9e4b3ce490c13b09a77461'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.14.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: 'f858e5ccb578bcff6db1cdd143727b8feec5cf153d0b438af4925827e6fabcc1',
  })

  depends_on 'gstreamer'
  depends_on 'mesa'
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
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-experimental',
           '--disable-examples'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # system "make", "check" # All the GL tests fail, as an X terminal is not running.
  end
end
