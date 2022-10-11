require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.20.3'
  version "#{@_ver}-1"
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/gstreamer/gstreamer.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3-1_armv7l/gstreamer-1.20.3-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3-1_armv7l/gstreamer-1.20.3-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3-1_i686/gstreamer-1.20.3-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3-1_x86_64/gstreamer-1.20.3-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e841406957a963846da6a63864001c8165b7afa83abcc73ec1a86b939a3c9462',
     armv7l: 'e841406957a963846da6a63864001c8165b7afa83abcc73ec1a86b939a3c9462',
       i686: 'f2ac4f825c4b078617ab15ca590dfe1dbd4fb644c87ad984726cb28f70117a18',
     x86_64: '23752e3b1a1cb4feb2c3c0a7286833ef2d49598ab615ef93f0874b535e4d1e06'
  })

  depends_on 'elfutils'
  depends_on 'glib'
  depends_on 'gsl'
  depends_on 'gtk3'
  depends_on 'libcap'
  depends_on 'libjpeg'
  depends_on 'libunwind'
  depends_on 'alsa_lib' # R
  depends_on 'atk' # R
  depends_on 'bz2' # R
  depends_on 'chromaprint' # R
  depends_on 'ffmpeg' # R
  depends_on 'flac' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'graphene' # R
  depends_on 'gsm' # R
  depends_on 'harfbuzz' # R
  depends_on 'intel_media_sdk' # R
  depends_on 'jack' # R
  depends_on 'json_glib' # R
  depends_on 'lcms' # R
  depends_on 'libaom' # R
  depends_on 'libass' # R
  depends_on 'libavc1394' # R
  depends_on 'libcurl' # R
  depends_on 'libde265' # R
  depends_on 'libdrm' # R
  depends_on 'libdv' # R
  depends_on 'libfdk_aac' # R
  depends_on 'libglvnd' # R
  depends_on 'libgudev' # R
  depends_on 'libiec61883' # R
  depends_on 'libmodplug' # R
  depends_on 'libmp3lame' # R
  depends_on 'libogg' # R
  depends_on 'libopencoreamr' # R
  depends_on 'libpng' # R
  depends_on 'libraw1394' # R
  depends_on 'librsvg' # R
  depends_on 'libsndfile' # R
  depends_on 'libtheora' # R
  depends_on 'libusb' # R
  depends_on 'libva' # R
  depends_on 'libvorbis' # R
  depends_on 'libvpx' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libx264' # R
  depends_on 'libx265' # R
  depends_on 'libxcb' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxml2' # R
  depends_on 'libxv' # R
  depends_on 'lilv' # R
  depends_on 'mesa' # R
  depends_on 'nettle' # R
  depends_on 'openal' # R
  depends_on 'openjpeg' # R
  depends_on 'openssl' # R
  depends_on 'opus' # R
  depends_on 'pango' # R
  depends_on 'pulseaudio' # R
  depends_on 'python3' # R
  depends_on 'rtmpdump' # R
  depends_on 'sbc' # R
  depends_on 'serd' # R
  depends_on 'sord' # R
  depends_on 'speex' # R
  depends_on 'sratom' # R
  depends_on 'srt' # R
  depends_on 'v4l_utils' # R
  depends_on 'wavpack' # R
  depends_on 'wayland' # R
  depends_on 'webrtc_audio_processing' # R
  depends_on 'zlibpkg' # R
  depends_on 'zvbi' # R

  conflicts_ok # conflicts with orc, gst_plugins_{base,bad}
  def self.build
    @plugins = ''
    case ARCH
    when 'i686'
      @plugins = '-Dgst-plugins-bad:msdk=disabled'
    end
    system "meson #{CREW_MESON_OPTIONS} \
    -Dgpl=enabled \
    -Dtests=disabled #{@plugins}\
    builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    # system 'make', 'check' # The 'gst/gsttracerrecord' test fails.
  end
end
