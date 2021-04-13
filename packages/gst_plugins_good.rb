require 'package'

class Gst_plugins_good < Package
  description 'Multimedia graph framework - good plugins'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.18.4'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-#{@_ver}.tar.xz"
  source_sha256 'b6e50e3a9bbcd56ee6ec71c33aa8332cc9c926b0c1fae995aac8b3040ebe39b0'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gst_plugins_good-1.18.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gst_plugins_good-1.18.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gst_plugins_good-1.18.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gst_plugins_good-1.18.4-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c6bd8050a3c0f1b314c710a325211955179befb161ad265c6aeea8aec1e4f262',
     armv7l: 'c6bd8050a3c0f1b314c710a325211955179befb161ad265c6aeea8aec1e4f262',
       i686: '9d81667abfe65600e5b248de3c2de29ce6eb7f1e352929015c033809423324ea',
     x86_64: '1ce70592cf499cda3a46f519db2ba479e0e8ca56acf43d44366b884d59b73487'
  })

  # L = Logical Dependency, R = Runtime Dependency
  depends_on 'libjpeg' => :build
  depends_on 'nasm' => :build
  depends_on 'gst_plugins_base' # L
  depends_on 'aalib' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gst_plugins_base' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'jack' # R
  depends_on 'libavc1394' # R
  depends_on 'libcaca' # R
  depends_on 'libdv' # R
  depends_on 'libgudev' # R
  depends_on 'libiec61883' # R
  depends_on 'libmp3lame' # R
  depends_on 'libpng' # R
  depends_on 'libraw1394' # R
  depends_on 'libsoup2' # R
  depends_on 'libvpx' # R
  depends_on 'libx11' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'mpg123' # R
  depends_on 'orc' # R
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'speex' # R
  depends_on 'taglib' # R
  depends_on 'v4l_utils' # R
  depends_on 'wavpack' # R

  def self.build
    system "meson #{CREW_MESON_FNO_LTO_OPTIONS} \
      -Ddoc=disabled \
      -Drpicamsrc=disabled \
      -Dgobject-cast-checks=disabled \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
