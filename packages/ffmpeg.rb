require 'package'

class Ffmpeg < Package
  description 'A complete, cross-platform solution to record, convert and stream audio and video.'
  homepage 'https://ffmpeg.org/'
  version '4.2.1'
  compatibility 'all'
  source_url 'https://ffmpeg.org/releases/ffmpeg-4.2.1.tar.xz'
  source_sha256 'cec7c87e9b60d174509e263ac4011b522385fd0775292e1670ecc1180c9bb6d4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '55b40e675db77e1e807d189438c82f3fc1113c737de8c49deeccb1416c931885',
     armv7l: '55b40e675db77e1e807d189438c82f3fc1113c737de8c49deeccb1416c931885',
       i686: 'f73db0e5b238ee23dad1ef7d9c3183df4659f97cb5a5b57d21726b5575d8f488',
     x86_64: 'da2c292468285d298b2fe589f7789d894b582aa88b4eb28aa81713a5c9a59d27',
  })

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
    system 'env',
           "TMPDIR=#{CREW_BREW_DIR}",
           './configure',
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-libopencore-amrnb',
           '--enable-libopencore-amrwb',
           "--prefix=#{CREW_PREFIX}",
           '--enable-libvo-amrwbenc',
           '--enable-libfontconfig',
           '--enable-chromaprint',
           '--enable-libopenjpeg',
           '--enable-libfreetype',
           '--enable-fontconfig',
           '--enable-libfdk-aac',
           '--enable-libfribidi',
           '--enable-libmp3lame',
           '--enable-libvidstab',
           '--enable-libwavpack',
           '--enable-libdc1394',
           '--enable-libtheora',
           '--enable-libvorbis',
           '--enable-libdav1d',
           '--enable-version3',
           '--enable-libpulse',
           '--enable-libspeex',
           '--enable-libopus',
           '--enable-librtmp',
           '--enable-libsoxr',
           '--enable-libwebp',
           '--enable-libx264',
           '--enable-libx265',
           '--enable-libxml2',
           '--enable-libxvid',
           '--enable-libzvbi',
           '--enable-nonfree',
           '--enable-libdrm',
           '--enable-libssh',
           '--enable-libvpx',
           '--enable-libzmq',
           '--enable-openal',
           '--enable-shared',
           '--disable-debug',
           '--enable-frei0r',
           '--enable-gnutls',
           '--enable-libass',
           "--arch=#{ARCH}",
           '--enable-gray',
           '--enable-gpl'
  end

  def self.install
    # Use the gold linker.
    old_ld = `ld_default g`.chomp
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Restore the original linker.
    system 'ld_default', "#{old_ld}"
  end
end
