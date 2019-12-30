require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.4.2'
  source_url 'https://ftpmirror.gnu.org/gnu/bison/bison-3.4.2.tar.xz'
  source_sha256 '27d05534699735dc69e86add5b808d6cb35900ad3fd63fa82e3eb644336abfa0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5e075d35935386c9f2e05c520ed10b2c0d5d453337f5d4cd6a663dcaaa675250',
     armv7l: '5e075d35935386c9f2e05c520ed10b2c0d5d453337f5d4cd6a663dcaaa675250',
       i686: '6a114d5b271549af936db512fabd910ae2329fcfd2373a83ce47f8c2232e3aae',
     x86_64: 'd020a319652c3c70c3530c35b6fc9aba85d25be25fe40c160cb8cc8a87112a31',
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
