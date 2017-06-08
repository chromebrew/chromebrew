require 'package'

class Libx264 < Package
  description 'x264 is a free software library and application for encoding video streams into the H.264/MPEG-4 AVC compression format.'
  homepage 'http://www.videolan.org/developers/x264.html'
  version '20170604-2245-stable'
  source_url 'http://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20170604-2245-stable.tar.bz2'
  source_sha1 '8003044b45010b1b4b40ac3dd8be98d80c888ece'

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
