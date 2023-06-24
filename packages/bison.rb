require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'https://www.gnu.org/software/bison/'
  version '3.8.2'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/bison/bison-#{version}.tar.lz"
  source_sha256 'fdf98bfe82abb04a34d4356753f7748dbbd2ef1221b1f202852a2b5ce0f78534'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bison/3.8.2_armv7l/bison-3.8.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bison/3.8.2_armv7l/bison-3.8.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bison/3.8.2_i686/bison-3.8.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bison/3.8.2_x86_64/bison-3.8.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8f1ac3143e216a054c56a4dcb23d58078c7dbccdc67f86b1d4a8169fb4f0d43b',
     armv7l: '8f1ac3143e216a054c56a4dcb23d58078c7dbccdc67f86b1d4a8169fb4f0d43b',
       i686: '026e8c897e6f8c5bc1d30d17f0f5612d5d0b99e8e5cf77e16cecaf646716a755',
     x86_64: 'e671fd14e25757fd0fc45d65443ff55d13df428e34e80fc2f642d86aa5a9df14'
  })

  depends_on 'gettext'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    puts 'Notice: Bison checks take a very long time.'.yellow
    system 'make', 'check'
  end
end
