require 'package'

class Libx264 < Package
  description 'x264 is a free software library and application for encoding video streams into the H.264/MPEG-4 AVC compression format.'
  homepage 'http://www.videolan.org/developers/x264.html'
  version '20170604-2245-stable'
  source_url 'http://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20170604-2245-stable.tar.bz2'
  source_sha256 '42fa7cc6af0af36e4a8286ce724e6d20de0967d9017640883e955b4b6d3690ac'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-20170604-2245-stable-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-20170604-2245-stable-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-20170604-2245-stable-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-20170604-2245-stable-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4aa17ddc683247df0a313a3731fa50c9695fe92f755d024368c79991a2b832ae',
     armv7l: '4aa17ddc683247df0a313a3731fa50c9695fe92f755d024368c79991a2b832ae',
       i686: '68fa4d06c473ce45499b4ce9d57e4adf85a53ba3d42464a9449d7feea4682c05',
     x86_64: '74c95e2d82fd09cdab5fe9688285a76018563ade0dafca83900858fe14b5430d',
  })

  depends_on 'yasm'

  def self.build
    system "./configure \
            --enable-shared \
            --enable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
