require 'package'

class Libxrender < Package
  description 'X Rendering Extension client library.'
  homepage 'http://www.x.org'
  version '0.9.10'
  source_url 'https://www.x.org/releases/individual/lib/libXrender-0.9.10.tar.gz'
  source_sha256 '770527cce42500790433df84ec3521e8bf095dfe5079454a92236494ab296adf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxrender-0.9.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxrender-0.9.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxrender-0.9.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxrender-0.9.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '302d54a2e3501ae6372cc41fd4f3db01f80d36ca133f2f20b63d99a368a60fd2',
     armv7l: '302d54a2e3501ae6372cc41fd4f3db01f80d36ca133f2f20b63d99a368a60fd2',
       i686: 'ccfc71a3d277ceda7392415c7aaa85df0aa89e738e7238d03700fbd5a8f9b6ac',
     x86_64: 'c696771f631a598591a1f26ad714271ffc6d516d5cba119c17e06574e8bd6ec7',
  })

  depends_on 'pkgconfig' => :build
  depends_on 'renderproto'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
