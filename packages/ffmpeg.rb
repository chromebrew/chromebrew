require 'package'

class Ffmpeg < Package
  description 'A complete, cross-platform solution to record, convert and stream audio and video.'
  homepage 'https://ffmpeg.org/'
  version '4.0'
  source_url 'https://ffmpeg.org/releases/ffmpeg-4.0.tar.xz'
  source_sha256 'ed945daf40b124e77a685893cc025d086f638bc703183460aff49508edb3a43f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bd6d8edae2aa12f149e7d514e56378fa18bd427f610ce3e4d9bf68884a3c8dc7',
     armv7l: 'bd6d8edae2aa12f149e7d514e56378fa18bd427f610ce3e4d9bf68884a3c8dc7',
       i686: '34dfd0ed8773bde7066f4454cec9316ed02753ca84a9303bfd958924df415f08',
     x86_64: '84811eca1f3f2b47537e8c9bfe3f0611247e6797cd1e64797bd5d68a9bcf1ea6',
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
