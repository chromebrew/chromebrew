require 'package'

class Lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'http://lz4.github.io/lz4/'
  version '1.8.0'
  source_url 'https://github.com/lz4/lz4/archive/v1.8.0.tar.gz'
  source_sha256 '2ca482ea7a9bb103603108b5a7510b7592b90158c151ff50a28f1ca8389fccf6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd3deb5400244b13666355ab9cfd6049dc432705a867633bdf9ae80903f64cd23',
     armv7l: 'd3deb5400244b13666355ab9cfd6049dc432705a867633bdf9ae80903f64cd23',
       i686: '6094dc22fe259ac989b6a1595f3de6ccc50a0a17eaadf446cee049b48746b490',
     x86_64: 'd03b3e792586b53bd57e586e1ffc06465ffc3db90d3fe685bf7ffaff0af480ae',
  })

  def self.build
    system "make", "BUILD_STATIC=no"
  end

  def self.install
    system "make", "BUILD_STATIC=no", "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", "install"
  end
end
