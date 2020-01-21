require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.5'
  source_url 'https://ftpmirror.gnu.org/gnu/bison/bison-3.5.tar.xz'
  source_sha256 '55e4a023b1b4ad19095a5f8279f0dc048fa29f970759cea83224a6d5e7a3a641'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1a81b867d451925f47e43af13c6b270cae838511d5ae88cdbcdc6b1e95e04489',
     armv7l: '1a81b867d451925f47e43af13c6b270cae838511d5ae88cdbcdc6b1e95e04489',
       i686: 'af29f98f0888cb0d00e53edcacd4084a36e2f81bd119655d4e7a96eb9637b4f5',
     x86_64: 'ac8aa34ea566a028fa22d85b51cbda6fb0436a4608646b6b479707e8826a5009',
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
