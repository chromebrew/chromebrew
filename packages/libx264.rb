require 'package'

class Libx264 < Package
  version '20170528-2245-stable'
  source_url 'http://ftp.videolan.org/pub/videolan/x264/snapshots/last_stable_x264.tar.bz2'
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
