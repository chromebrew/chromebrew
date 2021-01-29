require 'package'

class Gst_plugins_base < Package
  description 'An essential, exemplary set of elements for GStreamer'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-plugins-base.html'
  @_ver = '1.18.3'
  version @_ver
  compatibility 'all'
  source_url "https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-#{@_ver}.tar.xz"
  source_sha256 'dbfa20283848f0347a223dd8523dfb62e09e5220b21b1d157a8b0c8b67ba9f52'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.18.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.18.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.18.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.18.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'a74c3d06cc2b1b573eee605d5a8ef130260321a3df0e062789bbb40f64b0b3ae',
      armv7l: 'a74c3d06cc2b1b573eee605d5a8ef130260321a3df0e062789bbb40f64b0b3ae',
        i686: '16ab2127284b14a75b5fda4e00640fd10d79e98f8bf2806e62d5b0c47a933853',
      x86_64: '8417eb837eb1af2ad6d1bdebd6f79b4466628d80140ec6b38d0880a1f89e723e',
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
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dgst_debug=false \
    -Dexamples=disabled \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    # system 'make', 'check' # All the GL tests fail, as an X terminal is not running.
  end
end
