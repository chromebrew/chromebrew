require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.0.5'
  source_url 'https://ftpmirror.gnu.org/bison/bison-3.0.5.tar.xz'
  source_sha256 '075cef2e814642e30e10e8155e93022e4a91ca38a65aa1d5467d4e969f97f338'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '661825323f1c88079f308e6baa2f0ae9c1b2c2df4eb03569c1d3caca38062e72',
     armv7l: '661825323f1c88079f308e6baa2f0ae9c1b2c2df4eb03569c1d3caca38062e72',
       i686: '227aaece8c162ab5c0038cfcade06e8ca0a447c9bd971c72d5bab91401f2e35b',
     x86_64: 'a52ecdcbba822b740e1c5c76537f9536eccc63d7f70f14190f3f235c4c21eb18',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check"
  end
end
