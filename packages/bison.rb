require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.0.4-1'
  source_url 'http://mirror.keystealth.org/gnu/bison/bison-3.0.4.tar.xz'
  source_sha256 'a72428c7917bdf9fa93cb8181c971b6e22834125848cf1d03ce10b1bb0716fe1'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/bison-3.0.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/bison-3.0.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/bison-3.0.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/bison-3.0.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ede13d714d13f2d43f82aa31b14cda1f898dcffa220103bb2b25011433cbafb8',
     armv7l: 'ede13d714d13f2d43f82aa31b14cda1f898dcffa220103bb2b25011433cbafb8',
       i686: '295fd33c5b6b28fc78816f8f85a2f755ff398a846d15dec4bea72b7d1fcc037c',
     x86_64: '68b57034c1e3bf65fdc55e4fb5d29e2a83178e855d909df77be261d8436e033a',
  })

  depends_on 'diffutils' => :build
  depends_on 'm4' => :build
  depends_on 'perl' => :build
  # `make check` requires flex, but it causes dependency loop.  so, commenting it out.
  # depends_on 'flex' => :build

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
