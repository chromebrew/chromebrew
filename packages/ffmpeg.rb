require 'package'

class Ffmpeg < Package
  description 'A complete, cross-platform solution to record, convert and stream audio and video.'
  homepage 'https://ffmpeg.org/'
  version '4.1.4'
  source_url 'https://ffmpeg.org/releases/ffmpeg-4.1.4.tar.xz'
  source_sha256 'f1f049a82fcfbf156564e73a3935d7e750891fab2abf302e735104fd4050a7e1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '185c183888292e2d7093a142abbfdccd6968de441672fd4648ca14d592dac906',
     armv7l: '185c183888292e2d7093a142abbfdccd6968de441672fd4648ca14d592dac906',
       i686: 'bfd0823311a54a727de88b9b335f8ff4ed1ed29ceb99fa9f92166ca467db2727',
     x86_64: '12b4d5665988c1fce74e92b3f67562a850092b5ee0c4e7bd2ac7e37a007b0b16',
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
  depends_on 'libvpx'
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
           '--enable-libvpx',
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
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
