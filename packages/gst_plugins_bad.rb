require 'package'

class Gst_plugins_bad < Package
  description 'Multimedia graph framework - bad plugins'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.18.3'
  version @_ver
  source_url "https://github.com/GStreamer/gst-plugins-bad/archive/#{@_ver}.tar.gz"
  source_sha256 '3e8b145850ade47e9fe09632c4b7bddfe35d2c53f5c6055183cfc62276010f46'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_bad-1.18.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_bad-1.18.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_bad-1.18.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_plugins_bad-1.18.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '310fe14e7ac0ec26cd16c48a43f840ee7fa05fcb81a18801b34d2bfade6c8c1f',
     armv7l: '310fe14e7ac0ec26cd16c48a43f840ee7fa05fcb81a18801b34d2bfade6c8c1f',
       i686: 'ff4c9c6f78cf2ac14b08cce80837b8b8fdc562b347fcc0754db966c02e424313',
     x86_64: '676663870c05079b5df3fc94071cb0e4bbcd16a0087e9916a241a5db262943fd'
  })

  depends_on 'gst_plugins_base'
  depends_on 'orc'
  depends_on 'libdrm'
  depends_on 'libx11'
  depends_on 'libgudev'
  depends_on 'libusb'
  depends_on 'libvdpau'
  depends_on 'mjpegtools' => ':build'
  depends_on 'chromaprint' => ':build'
  depends_on 'libmms' => ':build'
  depends_on 'faad2' => ':build'
  depends_on 'libdca' => ':build'
  depends_on 'libdvdnav' => ':build'

  def self.build
    system "meson \
      #{CREW_MESON_LTO_OPTIONS} \
      -Ddirectfb=disabled \
      -Ddoc=disabled \
      -Dflite=disabled \
      -Dgsm=disabled \
      -Diqa=disabled \
      -Dmagicleap=disabled \
      -Dmsdk=disabled \
      -Dopenh264=disabled \
      -Dopenmpt=disabled \
      -Dopenni2=disabled \
      -Dopensles=disabled \
      -Dtinyalsa=disabled \
      -Dvoaacenc=disabled \
      -Dvoamrwbenc=disabled \
      -Dwasapi2=disabled \
      -Dwasapi=disabled \
      -Dgobject-cast-checks=disabled \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
