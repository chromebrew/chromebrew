require 'package'

class Gst_plugins_bad < Package
  description 'Multimedia graph framework - bad plugins'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.18.4'
  version @_ver
  license 'LGPL-2'
  compatibility 'all'
  source_url "https://github.com/GStreamer/gst-plugins-bad/archive/#{@_ver}.tar.gz"
  source_sha256 '30178ddcabcf71faccca8808f402a6e02394dfe3f821e2abe7a1b397f01eeaed'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gst_plugins_bad-1.18.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gst_plugins_bad-1.18.4-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gst_plugins_bad-1.18.4-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gst_plugins_bad-1.18.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd730e940fa02c687cf4a3a1ff7b9a2d6fa2a295525aa409fc63e589956a71b40',
     armv7l: 'd730e940fa02c687cf4a3a1ff7b9a2d6fa2a295525aa409fc63e589956a71b40',
       i686: 'ac42eaad61b8e7de0764ee7620eb95582c6d2b6a4451834de9d0245aaef5308d',
     x86_64: 'a1ea51c581260ea4da46238533ec0a4e17d58b08e63800d5addbd4fed5500de2'
  })

  depends_on 'cairo'
  depends_on 'chromaprint' => :build
  depends_on 'faad2'
  depends_on 'glib'
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'lcms'
  depends_on 'libass'
  depends_on 'libdca' => :build
  depends_on 'libdrm'
  depends_on 'libdvdnav'
  depends_on 'libdvdread'
  depends_on 'libfdk_aac'
  depends_on 'libgudev'
  depends_on 'libmms'
  depends_on 'librsvg'
  depends_on 'libsndfile'
  depends_on 'libusb'
  depends_on 'libva'
  depends_on 'libvdpau'
  depends_on 'libwebp'
  depends_on 'libx11'
  depends_on 'mjpegtools'
  depends_on 'openal'
  depends_on 'openjpeg'
  depends_on 'orc'
  depends_on 'pango'
  depends_on 'wayland'

  def self.build
    system "meson \
      #{CREW_MESON_OPTIONS} \
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
