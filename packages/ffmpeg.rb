require 'package'

class Ffmpeg < Package
  description 'A complete, cross-platform solution to record, convert and stream audio and video.'
  homepage 'https://ffmpeg.org/'
  version '4.1-1'
  source_url 'https://ffmpeg.org/releases/ffmpeg-4.1.tar.xz'
  source_sha256 'a38ec4d026efb58506a99ad5cd23d5a9793b4bf415f2c4c2e9c1bb444acd1994'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libopencoreamr'
  depends_on 'libvoamrwbenc'
  depends_on 'libmp3lame'
  depends_on 'libfrei0r'
  depends_on 'libtheora'
  depends_on 'libvorbis'
  depends_on 'xorg_lib'
  depends_on 'openjpeg'
  depends_on 'rtmpdump'
  depends_on 'libvdpau'
  depends_on 'vidstab'
  depends_on 'libopus'
  depends_on 'libsoxr'
  depends_on 'libwebp'
  depends_on 'libx264'
  depends_on 'libx265'
  depends_on 'libxvid'
  depends_on 'libdrm'
  depends_on 'gnutls'
  depends_on 'libass'
  depends_on 'libva'
  depends_on 'speex'
  depends_on 'nasm' => :build

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
           '--enable-libopenjpeg',
           '--enable-libfreetype',
           '--enable-libvidstab',
           '--enable-libfribidi',
           '--enable-libmp3lame',
           '--enable-fontconfig',
           '--enable-libtheora',
           '--enable-libvorbis',
           '--enable-version3',
           '--enable-libspeex',
           '--enable-libopus',
           '--enable-librtmp',
           '--enable-libsoxr',
           '--enable-libwebp',
           '--enable-libx264',
           '--enable-libx265',
           '--enable-libxvid',
           '--enable-shared',
           '--disable-debug',
           '--enable-frei0r',
           '--enable-gnutls',
           '--enable-libass',
           "--arch=#{ARCH}',
           '--enable-gray',
           '--enable-gpl'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
