require 'package'

class Bdwgc < Package
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collecto'
  homepage 'https://github.com/ivmai/bdwgc'
  version '7.6.2-1'
  source_url 'https://github.com/ivmai/bdwgc/releases/download/v7.6.2/gc-7.6.2.tar.gz'
  source_sha256 'bd112005563d787675163b5afff02c364fc8deb13a99c03f4e80fdf6608ad41e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4efb53da6a7755b5f29badf95618bc40642505ae04fab659d7f63dab533b79af',
     armv7l: '4efb53da6a7755b5f29badf95618bc40642505ae04fab659d7f63dab533b79af',
       i686: '0b99de0c290eb01e859ac762146266966e92fc39a07ed2968490fc8796125953',
     x86_64: 'a3df6a1250d94d92b3974c35b7d709e5362acec7379800ca3f09d3b0e492c2e3',
  })

  depends_on 'libatomic_ops'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
