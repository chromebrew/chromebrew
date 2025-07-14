require 'buildsystems/meson'

class Gstreamer < Meson
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  version '1.27.1'
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/gstreamer/gstreamer.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a363b918c6761ae8eff6215b94dc92367532fa45d4d93b76b6d8edad6c951f07',
     armv7l: 'a363b918c6761ae8eff6215b94dc92367532fa45d4d93b76b6d8edad6c951f07',
     x86_64: '0b71f08d892e3c9a39364284882cfaadea9637433802265fadaa8dd502835f0e'
  })

  depends_on 'alsa_lib' # R
  depends_on 'bzip2' # R
  depends_on 'ca_certificates' => :build
  depends_on 'cairo' # R
  depends_on 'chromaprint' # R
  depends_on 'curl' # R
  depends_on 'elfutils' # R
  depends_on 'faac' # R
  depends_on 'faad2' # R
  depends_on 'ffmpeg' # R
  depends_on 'flac' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnutls' # R
  depends_on 'graphene' # R
  depends_on 'gsl' => :build
  depends_on 'gsm' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'intel_media_sdk' if ARCH.eql?('x86_64') # R
  depends_on 'json_glib' # R
  depends_on 'lcms' # R
  depends_on 'libaom' # R
  depends_on 'libass' # R
  depends_on 'libavc1394' # R
  depends_on 'libcap'
  depends_on 'libcap' # R
  depends_on 'libdrm' # R
  depends_on 'libdv' # R
  depends_on 'libfdk_aac' # R
  depends_on 'libglvnd' # R
  depends_on 'libgudev' # R
  depends_on 'libiec61883' # R
  depends_on 'libjpeg_turbo'
  depends_on 'libjpeg_turbo' # R
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
  depends_on 'libxtst' # R
  depends_on 'libxv' # R
  depends_on 'lilv' # R
  depends_on 'mesa' # R
  depends_on 'neon' # R
  depends_on 'nettle' # R
  depends_on 'openal' # R
  depends_on 'openexr' # R
  depends_on 'openh264' # R
  depends_on 'openjpeg' # R
  depends_on 'openssl' # R
  depends_on 'opusfile' => :build
  depends_on 'opus' # R
  depends_on 'pango' # R
  depends_on 'pulseaudio' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'qt5_base' => :build # otherwise this becomes circular
  depends_on 'qt5_declarative' => :build # otherwise this becomes circular
  depends_on 'rtmpdump' # R
  depends_on 'sbc' # R
  depends_on 'speex' # R
  depends_on 'srt' # R
  depends_on 'svt_av1' # R
  depends_on 'v4l_utils' # R
  depends_on 'wavpack' # R
  depends_on 'wayland' # R
  depends_on 'zlib' # R
  depends_on 'zvbi' # R
  depends_on 'abseil_cpp' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R

  # no_lto
  conflicts_ok # conflicts with libglvnd
  gnome

  def self.prebuild
    system "#{CREW_PREFIX}/bin/update-ca-certificates --fresh --certsconf #{CREW_PREFIX}/etc/ca-certificates.conf"
  end

  meson_options "#{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
    -Ddoc=disabled \
    -Dexamples=disabled \
    -Dgpl=enabled \
    -Dgtk_doc=disabled \
    -Dintrospection=disabled"
end
