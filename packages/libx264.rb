require 'package'

class Libx264 < Package
  description 'x264 is a free software library and application for encoding video streams into the H.264/MPEG-4 AVC compression format.'
  homepage 'http://www.videolan.org/developers/x264.html'
  version '20170604-2245-stable'
  source_url 'http://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20170604-2245-stable.tar.bz2'
  source_sha256 '42fa7cc6af0af36e4a8286ce724e6d20de0967d9017640883e955b4b6d3690ac'

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
