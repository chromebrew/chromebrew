require 'package'

class Ffmpeg < Package
  description 'A complete, cross-platform solution to record, convert and stream audio and video.'
  homepage 'https://ffmpeg.org/'
  version '4.1.3'
  source_url 'https://ffmpeg.org/releases/ffmpeg-4.1.3.tar.xz'
  source_sha256 '0c3020452880581a8face91595b239198078645e7d7184273b8bcc7758beb63d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ef37a9baa19fa8f6a1f5a7e37f71dbcbc931e53dd2c9bd4cac0d1971536b9d44',
     armv7l: 'ef37a9baa19fa8f6a1f5a7e37f71dbcbc931e53dd2c9bd4cac0d1971536b9d44',
       i686: 'bf9377f810525fd10befceb044dbe4693c269ccc457820f4bd2f75bbb0aab51d',
     x86_64: 'c7b7a20ec40f89e5881aaa45beca98c933f07669f4aa1b57eba222bce4f89240',
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
           "--arch=#{ARCH}",
           '--enable-gray',
           '--enable-gpl'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
