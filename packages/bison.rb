require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.5.3'
  source_url 'https://ftpmirror.gnu.org/gnu/bison/bison-3.5.3.tar.xz'
  source_sha256 '2bf85b5f88a5f2fa8069aed2a2dfc3a9f8d15a97e59c713e3906e5fdd982a7c4'

  binary_url ({
  })
  binary_sha256 ({
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
