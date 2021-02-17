require 'package'

class Gst_plugins_good < Package
  description 'Multimedia graph framework - good plugins'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.18.3'
  version @_ver
  compatibility 'all'
  source_url "https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-#{@_ver}.tar.xz"
  source_sha256 '9b3b8e05d4d6073bf929fb33e2d8f74dd81ff21fa5b50c3273c78dfa2ab9c5cb'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_good-1.18.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_good-1.18.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_good-1.18.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_good-1.18.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7d76162d9f654da6bf2a9fd0207c8299d06a067a1c6f1dc9cf5b05c5d1d7df40',
     armv7l: '7d76162d9f654da6bf2a9fd0207c8299d06a067a1c6f1dc9cf5b05c5d1d7df40',
       i686: 'a6a0fe5c64329539e12ce5d163503255621f735e66fd0c8b99758858760c1178',
     x86_64: '8d90148635f3be03ff8086e93dce7bcebc76c218c1fc71db9d07fed0f5c4acdf'
  })

  depends_on 'pulseaudio'
  depends_on 'libsoup'
  depends_on 'gst_plugins_base'
  depends_on 'wavpack'
  depends_on 'aalib'
  depends_on 'taglib'
  depends_on 'libdv'
  depends_on 'libvpx'
  depends_on 'jack' => ':build'
  depends_on 'gtk3' => ':build'
  depends_on 'nasm' => ':build'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
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
