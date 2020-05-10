require 'package'

class Gst_plugins_base < Package
  description 'An essential, exemplary set of elements for GStreamer'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-plugins-base.html'
  version '1.16.0'
  compatibility 'all'
  source_url 'https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.16.0.tar.xz'
  source_sha256 '4093aa7b51e28fb24dfd603893fead8d1b7782f088b05ed0f22a21ef176fb5ae'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_base-1.16.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b46852219eace8316a2eaffdf322e167273c91a11d25c5fec9b1a43c5661b04b',
     armv7l: 'b46852219eace8316a2eaffdf322e167273c91a11d25c5fec9b1a43c5661b04b',
       i686: 'a14548969b4cccd4136b048cd7cfd7aa92958280e3fccdb3685b2f8beb8a5d3b',
     x86_64: '874b7bad0bf9149e7aa3f5524c0ecb858ef5278d836927b0a168284ecbe552a3',
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
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--disable-examples',
           '--with-plugins'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # system "make", "check" # All the GL tests fail, as an X terminal is not running.
  end
end
