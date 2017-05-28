require 'package'

class Libx264 < Package
  version '20170528-2245-stable'
  source_url 'http://ftp.videolan.org/pub/videolan/x264/snapshots/last_stable_x264.tar.bz2'
  source_sha1 '5ce46323b25cba7b5c7c960be327eeecc8b8395b'

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
