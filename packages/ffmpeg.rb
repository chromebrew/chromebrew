require 'package'

class Ffmpeg < Package
  description 'A complete, cross-platform solution to record, convert and stream audio and video.'
  homepage 'https://ffmpeg.org/'
  version '3.3.1'
  source_url 'https://ffmpeg.org/releases/ffmpeg-3.3.1.tar.xz'
  source_sha256 'b702a7fc656ac23e276b8c823a2f646e4e6f6309bb2788435a708e69bea98f2f'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/ffmpeg-3.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/ffmpeg-3.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/ffmpeg-3.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/ffmpeg-3.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4d512ee68b9520b6b81118a5f3e3851ac7572a9f2aaa32f7d002de375750a50e',
     armv7l: '4d512ee68b9520b6b81118a5f3e3851ac7572a9f2aaa32f7d002de375750a50e',
       i686: 'fa149aa20750ab68c532a33dc8c6b5727ed48625bb933509607bcfa36154b9fc',
     x86_64: '43c206bd3f80e1155325949fdd93f77282f3ecfb5292debbf6229582f10098f6',
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
