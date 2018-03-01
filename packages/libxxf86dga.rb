require 'package'

class Libxxf86dga < Package
  description 'X.org the client library for the XFree86-DGA extension'
  homepage 'http://www.x.org'
  version '1.1'
  source_url 'https://www.x.org/archive/individual/lib/libXxf86dga-1.1.tar.gz'
  source_sha256 'b3b7eab9b0b55d41526a5abf9a0b4e104cf2114e6b8adf7c7807b92e848c7d73'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86dga-1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86dga-1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86dga-1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86dga-1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9b1dceb66e38c7d3cbba0ef6f7c915faaa621603468de3247ff29bb63ddb4c36',
     armv7l: '9b1dceb66e38c7d3cbba0ef6f7c915faaa621603468de3247ff29bb63ddb4c36',
       i686: 'dcc91190359b1e3612b0802e497efd60d1a6ab097b761e45573cfbde99699431',
     x86_64: '35aa2f2e5f8f4a93bb271cb6c4cb0d50dccfdd9d521f45e9bfdb2368b98bdbb2',
  })

  depends_on 'xf86dgaproto'
  depends_on 'libxext'
  depends_on 'libx11'
   
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end