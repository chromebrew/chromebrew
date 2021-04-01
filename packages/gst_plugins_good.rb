require 'package'

class Gst_plugins_good < Package
  description 'Multimedia graph framework - good plugins'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.18.4'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-#{@_ver}.tar.xz"
  source_sha256 'b6e50e3a9bbcd56ee6ec71c33aa8332cc9c926b0c1fae995aac8b3040ebe39b0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_good-1.18.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_good-1.18.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_good-1.18.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_good-1.18.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e0fdc371c57de6ec9ce08478f3ed37d11c6c9b732266b2a07e53a5da38a4038e',
     armv7l: 'e0fdc371c57de6ec9ce08478f3ed37d11c6c9b732266b2a07e53a5da38a4038e',
       i686: '820d158973841c3e18ef1150b99586787f6fc95f4b18ce9c447a29da75270015',
     x86_64: 'a4efb5f9552bcd9e6fcc5405f0c41209a9efc8c34404eb043d259d4cf2284cd5'
  })

  depends_on 'aalib'
  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'gtk3'
  depends_on 'jack'
  depends_on 'libdv'
  depends_on 'libgudev'
  depends_on 'libjpeg'
  depends_on 'libmp3lame'
  depends_on 'libpng'
  depends_on 'libsoup'
  depends_on 'libsoup2'
  depends_on 'libvpx'
  depends_on 'libx11'
  depends_on 'libxdamage'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'nasm' => :build
  depends_on 'orc'
  depends_on 'pipewire'
  depends_on 'pulseaudio'
  depends_on 'speex'
  depends_on 'taglib'
  depends_on 'v4l_utils'
  depends_on 'wavpack'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Ddoc=disabled \
      -Drpicamsrc=disabled \
      -Dgobject-cast-checks=disabled \
      builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
