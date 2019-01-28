require 'package'

class Ffmpeg < Package
  description 'A complete, cross-platform solution to record, convert and stream audio and video.'
  homepage 'https://ffmpeg.org/'
  version '4.1-1'
  source_url 'https://ffmpeg.org/releases/ffmpeg-4.1.tar.xz'
  source_sha256 'a38ec4d026efb58506a99ad5cd23d5a9793b4bf415f2c4c2e9c1bb444acd1994'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '07ce108d022f4dd0f42ba99f4ef1739555d15905d3feabc5c62149d752b5871f',
     armv7l: '07ce108d022f4dd0f42ba99f4ef1739555d15905d3feabc5c62149d752b5871f',
       i686: '30bd2fd8d5909cc8799a42ca4f8733a06f63e3fc01dcdef44f8f03bcce91f05e',
     x86_64: '3720e339c273fd6d8913220e08a1c1ba8d25d056803747c8f077818c78d8b287',
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
