require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.22.6'
  version "#{@_ver}-1"
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/gstreamer/gstreamer.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.22.6-1_armv7l/gstreamer-1.22.6-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.22.6-1_armv7l/gstreamer-1.22.6-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.22.6-1_x86_64/gstreamer-1.22.6-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fbed6340d85a3568fc8fa0a0e39f04eb242f3b6ac1877b0f75f2e7811ac6e6c5',
     armv7l: 'fbed6340d85a3568fc8fa0a0e39f04eb242f3b6ac1877b0f75f2e7811ac6e6c5',
     x86_64: 'ce17105122937d227adf2d1ec286fd87a1284bc9b95fca4ffd0348155905d812'
  })

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'bz2' # R
  depends_on 'ca_certificates' => :build
  depends_on 'cairo' # R
  depends_on 'chromaprint' # R
  depends_on 'curl' # R
  depends_on 'elfutils' # R
  depends_on 'ffmpeg' # R
  depends_on 'flac' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'gobject_introspection' # R
  depends_on 'graphene' # R
  depends_on 'gsl' => :build
  depends_on 'gsm' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'intel_media_sdk' if ARCH.eql?('x86_64') # R
  depends_on 'jack' # R
  depends_on 'json_glib' # R
  depends_on 'lcms' # R
  depends_on 'libaom' # R
  depends_on 'libass' # R
  depends_on 'libavc1394' # R
  depends_on 'libcap'
  depends_on 'libcap' # R
  depends_on 'libde265' # R
  depends_on 'libdrm' # R
  depends_on 'libdv' # R
  depends_on 'libfdk_aac' # R
  depends_on 'libffi' # R
  depends_on 'libglvnd' # R
  depends_on 'libgudev' # R
  depends_on 'libiec61883' # R
  depends_on 'libjpeg'
  depends_on 'libjpeg' # R
  depends_on 'libmodplug' # R
  depends_on 'libmp3lame' # R
  depends_on 'libogg' # R
  depends_on 'libopencoreamr' # R
  depends_on 'libpng' # R
  depends_on 'libraw1394' # R
  depends_on 'librsvg' # R
  depends_on 'libsndfile' # R
  depends_on 'libtheora' # R
  depends_on 'libunwind'
  depends_on 'libunwind' # R
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
  depends_on 'libxi' # R
  depends_on 'libxml2' # R
  depends_on 'libxv' # R
  depends_on 'lilv' # R
  depends_on 'mesa' # R
  depends_on 'neon' # R
  depends_on 'nettle' # R
  depends_on 'openal' # R
  depends_on 'openjpeg' # R
  depends_on 'openssl' # R
  depends_on 'opus' # R
  depends_on 'opusfile' => :build
  depends_on 'pango' # R
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'pygobject' # R
  depends_on 'python3' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'rtmpdump' # R
  depends_on 'sbc' # R
  depends_on 'serd' # R
  depends_on 'sord' # R
  depends_on 'speex' # R
  depends_on 'sratom' # R
  depends_on 'srt' # R
  depends_on 'svt_av1' # R
  depends_on 'v4l_utils' # R
  depends_on 'wavpack' # R
  depends_on 'wayland' # R
  depends_on 'webrtc_audio_processing' # R
  depends_on 'zlibpkg' # R
  depends_on 'zvbi' # R
  depends_on 'faac' # R
  depends_on 'faad2' # R
  depends_on 'ilmbase' # R
  depends_on 'openexr' # R
  depends_on 'openh264' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R

  no_lto

  # conflicts_ok # conflicts with orc, gst_plugins_{base,bad}

  def self.prebuild
    system "#{CREW_PREFIX}/bin/update-ca-certificates --fresh --certsconf #{CREW_PREFIX}/etc/ca-certificates.conf"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      -Dgpl=enabled \
      -Dtests=disabled \
      builddir"
    system 'meson configure --no-pager builddir'
    @counter = 1
    @counter_max = 20
    loop do
      break if Kernel.system "mold -run #{CREW_NINJA} -C builddir"

      puts "Make iteration #{@counter} of #{@counter_max}...".orange

      @counter += 1
      break if @counter > @counter_max
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.check
    # system 'make', 'check' # The 'gst/gsttracerrecord' test fails.
  end
end
