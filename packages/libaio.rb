require 'package'

class Libaio < Package
  description 'Linux-native asynchronous I/O access library'
  homepage 'https://pagure.io/libaio'
  version '0.3.110-2'
  compatibility 'all'
  source_url 'http://libaio.sourcearchive.com/downloads/0.3.110-2/libaio_0.3.110.orig.tar.gz'
  source_sha256 'e019028e631725729376250e32b473012f7cb68e1f7275bfc1bbcdd0f8745f7e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libaio-0.3.110-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libaio-0.3.110-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libaio-0.3.110-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libaio-0.3.110-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '956d7421b3451c6c26b6ea9059e2940037aa29ca50be4197155d7d126186e67d',
     armv7l: '956d7421b3451c6c26b6ea9059e2940037aa29ca50be4197155d7d126186e67d',
       i686: 'f2418104d7535791ca17e47c51a4360248def84b0d1cc08555574a85a50c0ca1',
     x86_64: 'd2c211c05ff415f52f37102217726ba2e9b272daf178a63f0f612c9c2d4ebba5',
  })

  def self.build
    system "sed -i 's,prefix=/usr,prefix=#{CREW_DEST_PREFIX},' Makefile"
    system "sed -i 's,libdir=\$(prefix)/lib,libdir=#{CREW_DEST_LIB_PREFIX},' Makefile"
    system "make"
  end

  def self.install
    system "make install"
  end
end
