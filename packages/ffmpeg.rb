require 'package'

class Ffmpeg < Package
  description 'A complete, cross-platform solution to record, convert and stream audio and video.'
  homepage 'https://ffmpeg.org/'
  @_ver = '4.3.2'
  version @_ver
  compatibility 'all'
  source_url "https://ffmpeg.org/releases/ffmpeg-#{@_ver}.tar.xz"
  source_sha256 '46e4e64f1dd0233cbc0934b9f1c0da676008cad34725113fb7f802cfa84ccddb'

  depends_on 'ld_default' => :build
  depends_on 'libopencoreamr'
  depends_on 'libvoamrwbenc'
  depends_on 'chromaprint'
  depends_on 'libavc1394'
  depends_on 'libfdk_aac'
  depends_on 'libmp3lame'
  depends_on 'pulseaudio'
  depends_on 'libdc1394'
  depends_on 'libfrei0r'
  depends_on 'libtheora'
  depends_on 'libvorbis'
  depends_on 'xorg_lib'
  depends_on 'openjpeg'
  depends_on 'rtmpdump'
  depends_on 'libvdpau'
  depends_on 'libopus'
  depends_on 'librsvg'
  depends_on 'libsoxr'
  depends_on 'libwebp'
  depends_on 'libx264'
  depends_on 'libx265'
  depends_on 'libxvid'
  depends_on 'vidstab'
  depends_on 'wavpack'
  depends_on 'libdrm'
  depends_on 'libssh'
  depends_on 'gnutls'
  depends_on 'libass'
  depends_on 'libdrm'
  depends_on 'libvpx'
  depends_on 'openal'
  depends_on 'zeromq'
  depends_on 'dav1d'
  depends_on 'libva'
  depends_on 'intel_media_driver' if `grep -c 'GenuineIntel' /proc/cpuinfo`.to_i > 0
  depends_on 'speex'
  depends_on 'nasm' => :build
  depends_on 'zvbi'

  def self.build
    system "env TMPDIR=#{CREW_BREW_DIR} \
            CFLAGS='-pipe -flto=auto -fuse-ld=gold' \
            CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
            LDFLAGS='-flto=auto' \
            ./configure \
            #{CREW_OPTIONS.sub('--build=x86_64-cros-linux-gnu --host=x86_64-cros-linux-gnu --target=x86_64-cros-linux-gnu', '')}
            --enable-libopencore-amrnb \
            --enable-libopencore-amrwb \
            --enable-libvo-amrwbenc \
            --enable-libfontconfig \
            --enable-chromaprint \
            --enable-libopenjpeg \
            --enable-libfreetype \
            --enable-fontconfig \
            --enable-libfdk-aac \
            --enable-libfribidi \
            --enable-libmp3lame \
            --enable-libvidstab \
            --enable-libwavpack \
            --enable-libdc1394  \
            --enable-libtheora  \
            --enable-libvorbis  \
            --enable-libdav1d   \
            --enable-version3   \
            --enable-libpulse   \
            --enable-libspeex   \
            --enable-libopus    \
            --enable-librtmp    \
            --enable-libsoxr    \
            --enable-libwebp    \
            --enable-libx264    \
            --enable-libx265    \
            --enable-libxml2    \
            --enable-libxvid    \
            --enable-libzvbi    \
            --enable-nonfree    \
            --enable-libdrm     \
            --enable-libssh     \
            --enable-libvpx     \
            --enable-libzmq     \
            --enable-openal     \
            --enable-shared     \
            --disable-debug     \
            --enable-frei0r     \
            --enable-gnutls     \
            --enable-libass     \
            --arch=#{ARCH}      \
            --enable-gray       \
            --enable-gpl"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
