require 'package'

class Libpciaccess < Package
  description 'Generic PCI access library'
  homepage 'https://x.org'
  version '0.13-0'
  source_url 'https://www.x.org/archive/individual/lib/libpciaccess-0.13.tar.gz'
  source_sha256 'afdfe55b23be710751b630073127febef498af35d4a58944fccbef860315f72c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpciaccess-0.13-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpciaccess-0.13-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpciaccess-0.13-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpciaccess-0.13-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b650dc3cfc9022c9d991d6ff473db7665b218ec651a322f4607e63c55eb7edec',
     armv7l: 'b650dc3cfc9022c9d991d6ff473db7665b218ec651a322f4607e63c55eb7edec',
       i686: 'ab39a8afdd654ece0501efff152b379816831cf8f950afd1308cc18389b2137c',
     x86_64: '879a01f506b6dcd404419520d814281dc732d07945ecce5089c1fe97113b20f7',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
