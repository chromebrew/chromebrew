require 'buildsystems/meson'

class Gstreamer < Meson
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  version '1.28.1'
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/gstreamer/gstreamer.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a69a2e38955364b72226072f10275fa41b6dc22a8a5f97320a0b8201e85d44fc',
     armv7l: 'a69a2e38955364b72226072f10275fa41b6dc22a8a5f97320a0b8201e85d44fc',
     x86_64: '4fac6c28487630defd3daf9a86b70393cf59651117197ec6f059e48b51c9eb1a'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'bzip2' => :library
  depends_on 'ca_certificates' => :build
  depends_on 'cairo' => :library
  depends_on 'chromaprint' => :library
  depends_on 'curl' => :library
  depends_on 'elfutils' => :library
  depends_on 'faac' => :library
  depends_on 'faad2' => :library
  depends_on 'ffmpeg' => :logical
  depends_on 'flac' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gnutls' => :library
  depends_on 'graphene' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'intel_media_sdk' => :library if ARCH.eql?('x86_64')
  depends_on 'json_glib' => :library
  depends_on 'lcms' => :library
  depends_on 'libaom' => :library
  depends_on 'libass' => :library
  depends_on 'libavc1394' => :library
  depends_on 'libcap' => :library
  depends_on 'libdrm' => :library
  depends_on 'libdv' => :library
  depends_on 'libfdk_aac' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libgudev' => :library
  depends_on 'libiec61883' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libmodplug' => :library
  depends_on 'libmp3lame' => :library
  depends_on 'libogg' => :library
  depends_on 'libopencoreamr' => :library
  depends_on 'libpng' => :library
  depends_on 'libraw1394' => :library
  depends_on 'librsvg' => :library
  depends_on 'libsndfile' => :library
  depends_on 'libtheora' => :library
  depends_on 'libunwind' => :library
  depends_on 'libusb' => :library
  depends_on 'libva' => :library
  depends_on 'libvorbis' => :library
  depends_on 'libwebp' => :library
  depends_on 'libx11' => :library
  depends_on 'libx264' => :library
  depends_on 'libx265' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxdamage' => :library
  depends_on 'libxext' => :library
  depends_on 'libxfixes' => :library
  depends_on 'libxi' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxtst' => :library
  depends_on 'libxv' => :library
  depends_on 'lilv' => :library
  depends_on 'mesa' => :library
  depends_on 'neon' => :library
  depends_on 'nettle' => :library
  depends_on 'openal' => :library
  depends_on 'openexr' => :library
  depends_on 'openh264' => :library
  depends_on 'openjpeg' => :library
  depends_on 'openssl' => :library
  depends_on 'opus' => :library
  depends_on 'opusfile' => :build
  depends_on 'pango' => :library
  depends_on 'pulseaudio' => :logical
  depends_on 'py3_gitlint' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'qt5_base' => :library
  depends_on 'qt5_declarative' => :library
  depends_on 'rtmpdump' => :library
  depends_on 'sbc' => :library
  depends_on 'speex' => :library
  depends_on 'srt' => :library
  depends_on 'svt_av1' => :library
  depends_on 'v4l_utils' => :library
  depends_on 'wavpack' => :library
  depends_on 'wayland' => :library
  depends_on 'webrtc_audio_processing' => :library
  depends_on 'zlib' => :library
  depends_on 'zvbi' => :library

  # no_lto
  conflicts_with 'libglvnd'
  gnome

  def self.prebuild
    system "#{CREW_PREFIX}/bin/update-ca-certificates --fresh --certsconf #{CREW_PREFIX}/etc/ca-certificates.conf"
  end

  meson_options "#{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
    -Ddoc=disabled \
    -Dexamples=disabled \
    -Dgpl=enabled \
    -Dgtk_doc=disabled \
    -Dintrospection=disabled \
    -Dtests=disabled"
end
