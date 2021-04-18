require 'package'

class Gst_plugins_base < Package
  description 'An essential, exemplary set of elements for GStreamer'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-plugins-base.html'
  @_ver = '1.18.4'
  version @_ver
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'
  source_url "https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-#{@_ver}.tar.xz"
  source_sha256 '29e53229a84d01d722f6f6db13087231cdf6113dd85c25746b9b58c3d68e8323'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gst_plugins_base-1.18.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gst_plugins_base-1.18.4-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gst_plugins_base-1.18.4-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gst_plugins_base-1.18.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6fc2e6d6b63ab3c869a4d136f9eeb85f4334a0fb271fea43829e7f20a83a6d29',
     armv7l: '6fc2e6d6b63ab3c869a4d136f9eeb85f4334a0fb271fea43829e7f20a83a6d29',
       i686: '87a676cce612d50d26ce80f1a22c8c4c82caae930f5153d05e9332019418e172',
     x86_64: '91f0cc7eab04f890592a0675cf8c7e59f163f1e6543c850778c17af134de9a05'
  })

  depends_on 'alsa_lib'
  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'graphene'
  depends_on 'gstreamer'
  depends_on 'libdrm'
  depends_on 'libglu'
  depends_on 'libgudev'
  depends_on 'libjpeg'
  depends_on 'libogg'
  depends_on 'libpng'
  depends_on 'libtheora'
  depends_on 'libvisual'
  depends_on 'libvorbis'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxcomposite'
  depends_on 'libxext'
  depends_on 'libxshmfence'
  depends_on 'libxv'
  depends_on 'mesa'
  depends_on 'opus'
  depends_on 'pango'
  depends_on 'wayland'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dgst_debug=false \
    -Dexamples=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    # system 'make', 'check' # All the GL tests fail, as an X terminal is not running.
  end
end
