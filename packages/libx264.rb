require 'package'

class Libx264 < Package
  version '20170524-2245-stable'
  source_url 'http://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20170524-2245-stable.tar.bz2'
  source_sha1 'e2e34a6bb7724ebf7b06b8607eb173966b5e0e25'

  depends_on 'yasm'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
