require 'package'

class Ffmpeg < Package
  description 'A complete, cross-platform solution to record, convert and stream audio and video.'
  homepage 'https://ffmpeg.org/'
  version '4.1'
  source_url 'https://ffmpeg.org/releases/ffmpeg-4.1.tar.xz'
  source_sha256 'a38ec4d026efb58506a99ad5cd23d5a9793b4bf415f2c4c2e9c1bb444acd1994'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd480cd8f729607f54029425d63adde1c67b83fb14fe815887354aa9077bb48d3',
     armv7l: 'd480cd8f729607f54029425d63adde1c67b83fb14fe815887354aa9077bb48d3',
       i686: '1b22147d3cc89bcd4fae816495f38a74556f5b45aaaf107ca77e09d56980ceda',
     x86_64: '84dd40e9f141b6fe15915e0e3ff9a42450281d82d69b11da2d86a403fc27ce48',
  })

  depends_on 'gnutls'
  depends_on 'libass'
  depends_on 'libfdkaac'
  depends_on 'libfrei0r'
  depends_on 'libmp3lame'
  depends_on 'libopencoreamr'
  depends_on 'libopus'
  depends_on 'libsoxr'
  depends_on 'libtheora'
  depends_on 'libvoamrwbenc'
  depends_on 'libvorbis'
  depends_on 'libwebp'
  depends_on 'libx264'
  depends_on 'libx265'
  depends_on 'libxvid'
  depends_on 'openjpeg'
  depends_on 'rtmpdump'
  depends_on 'speex'
  depends_on 'vidstab'

  def self.build
    system "TMPDIR=#{CREW_BREW_DIR} ./configure \
             --prefix=#{CREW_PREFIX} \
             --libdir=#{CREW_LIB_PREFIX} \
             --arch=#{ARCH} \
             --enable-gpl \
             --enable-nonfree \
             --enable-version3 \
             --enable-shared \
             --disable-debug \
             --disable-ffplay \
             --disable-indev=sndio \
             --disable-outdev=sndio \
             --enable-fontconfig \
             --enable-frei0r \
             --enable-gnutls \
             --enable-gray \
             --enable-libass \
             --enable-libfdk-aac \
             --enable-libfontconfig \
             --enable-libfreetype \
             --enable-libfribidi \
             --enable-libmp3lame \
             --enable-libopencore-amrnb \
             --enable-libopencore-amrwb \
             --enable-libopenjpeg \
             --enable-libopus \
             --enable-librtmp \
             --enable-libsoxr \
             --enable-libspeex \
             --enable-libtheora \
             --enable-libvidstab \
             --enable-libvo-amrwbenc \
             --enable-libvorbis \
             --enable-libwebp \
             --enable-libx264 \
             --enable-libx265 \
             --enable-libxvid"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
