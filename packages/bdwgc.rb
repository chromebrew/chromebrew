require 'package'

class Bdwgc < Package
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collector'
  homepage 'https://github.com/ivmai/bdwgc'
  version '7.6.6'
  source_url 'https://github.com/ivmai/bdwgc/archive/v7.6.6.tar.gz'
  source_sha256 '6797540e2b51f48ea1c8409066063b686ffd330b578f568811d3fe5b7ab33749'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'edc9e4eb0aaa9171c5b604c0871c6438b1d70e7292b8c7add132240c6d99a499',
     armv7l: 'edc9e4eb0aaa9171c5b604c0871c6438b1d70e7292b8c7add132240c6d99a499',
       i686: '0c676e26d105b79a5d9ecacf5f32243ae10be04b72b1b02bf516511f49179824',
     x86_64: '68478976c635ab5948a15e04ad3c5ca4e2f41b96cfff433d32526928bb99a5b8',
  })

  depends_on 'libatomic_ops'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
