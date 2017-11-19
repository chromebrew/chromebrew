require 'package'

class Libx264 < Package
  description 'x264 is a free software library and application for encoding video streams into the H.264/MPEG-4 AVC compression format.'
  homepage 'http://www.videolan.org/developers/x264.html'
  version '20171118-2245-stable'
  source_url 'http://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20171118-2245-stable.tar.bz2'
  source_sha256 '22f29bbeba7087d9a92e0a50837e22c5729ba46b6c03392f149cae6ca3fa01ad'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'yasm' => :build

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --enable-shared \
            --enable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
