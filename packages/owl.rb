require 'package'

class Owl < Package
  description 'Owl Lisp is a functional dialect of the Scheme programming language.'
  homepage 'https://haltp.org/n/owl'
  version '0.1.14'
  compatibility 'all'
  source_url 'https://github.com/aoh/owl-lisp/archive/v0.1.14.tar.gz'
  source_sha256 '4d9982da3582456d1e769e25a7d0b2daefe859c45e262c8f56f794114f9a29a0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/owl-0.1.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/owl-0.1.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/owl-0.1.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/owl-0.1.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '305978182d9826979fdd56b7085cdcf0cc24cc6c234a96d7c513756f55028bc0',
     armv7l: '305978182d9826979fdd56b7085cdcf0cc24cc6c234a96d7c513756f55028bc0',
       i686: '0af189fa0385b41f86f024863a97d89cae96bcf7b1b8b408a0bd2b0db476cbe1',
     x86_64: 'f902a68ce2f16363477ab0f5aaf11b93fd8d1b236c08ea66dab4cb063ce209f0',
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
