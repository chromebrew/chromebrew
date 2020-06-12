require 'package'

class Libemf < Package
  description 'libEMF is a C/C++ library which provides a drawing toolkit based on ECMA-234.'
  homepage 'http://libemf.sourceforge.net/'
  version '1.0.9'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/libemf/libemf/1.0.9/libemf-1.0.9.tar.gz'
  source_sha256 'dcc1f7dc09597a7e20fa808fbef03f0c5cbdd99d65a4fddd981d7f1dd6e28b81'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libemf-1.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libemf-1.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libemf-1.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libemf-1.0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd0823f3f19a891c6dcd66ea7c39f6c8deaefb487e6f14beb9b6045a82a8683b1',
     armv7l: 'd0823f3f19a891c6dcd66ea7c39f6c8deaefb487e6f14beb9b6045a82a8683b1',
       i686: '98db956a86f7c3508f01c259d9129b2a4fbb592eb2ed3a65898a4882f6b5b136',
     x86_64: '3dd865953891dbdeaf295828b096f1bf5d90661519a4f8b564a460668a4949ee',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
