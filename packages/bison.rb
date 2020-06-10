require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.5.3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/bison/bison-3.5.3.tar.xz'
  source_sha256 '2bf85b5f88a5f2fa8069aed2a2dfc3a9f8d15a97e59c713e3906e5fdd982a7c4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.5.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.5.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.5.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.5.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1ff70ed7db74cadbb20d0e17a6d631bd256caf3549c0932c347eba3edf1f2a53',
     armv7l: '1ff70ed7db74cadbb20d0e17a6d631bd256caf3549c0932c347eba3edf1f2a53',
       i686: '091fc0b760316ca632cce4240b1fa910c1528a953d1328d5edb5e05239a8e875',
     x86_64: '1e810c55fec98830af9089b773150efdc5a1d9a9380bf885b4ae6bf8261111d9',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make check'
  end
end
