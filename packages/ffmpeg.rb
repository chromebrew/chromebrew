require 'package'

class Ffmpeg < Package
  description 'A complete, cross-platform solution to record, convert and stream audio and video.'
  homepage 'https://ffmpeg.org/'
  version '3.3.3-1'
  source_url 'https://ffmpeg.org/releases/ffmpeg-3.3.3.tar.xz'
  source_sha256 'd2a9002cdc6b533b59728827186c044ad02ba64841f1b7cd6c21779875453a1e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-3.3.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-3.3.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-3.3.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-3.3.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4748d900703d05d05fdb584b534ffd6ea1b5ecad3a78187804d23af3254dd87e',
     armv7l: '4748d900703d05d05fdb584b534ffd6ea1b5ecad3a78187804d23af3254dd87e',
       i686: 'a85f9c79aaefe5b80bf59c2067c6a9b16b5c96edc604c49d33c3d5ac9ffb3a0d',
     x86_64: '8e78f2b9f7bd47a7f9f04e157bf441a8a7c54d5c32833b20d38ac9d10300e43e',
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
