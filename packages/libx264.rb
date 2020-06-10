require 'package'

class Libx264 < Package
  description 'x264 is a free software library and application for encoding video streams into the H.264/MPEG-4 AVC compression format.'
  homepage 'http://www.videolan.org/developers/x264.html'
  version '20171118-2245-stable'
  compatibility 'all'
  source_url 'http://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20171118-2245-stable.tar.bz2'
  source_sha256 '22f29bbeba7087d9a92e0a50837e22c5729ba46b6c03392f149cae6ca3fa01ad'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-20171118-2245-stable-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-20171118-2245-stable-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-20171118-2245-stable-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-20171118-2245-stable-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a0790759e5686aa91e43b64ab0f5c64ee9dfc6b01e62af3dfb1a095976130939',
     armv7l: 'a0790759e5686aa91e43b64ab0f5c64ee9dfc6b01e62af3dfb1a095976130939',
       i686: '59488d66a03c91546359f616898a96c362113aa6af939dd9344d0c10cc2e39c0',
     x86_64: '32b6a7a5f9557b066e633beeb3f3ff748dd90a2bef14ead31e292f984e5d226c',
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
