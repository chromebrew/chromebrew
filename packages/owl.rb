require 'package'

class Owl < Package
  description 'Owl Lisp is a functional dialect of the Scheme programming language.'
  homepage 'https://haltp.org/n/owl'
  version '0.1.14'
  source_url 'https://github.com/aoh/owl-lisp/archive/v0.1.14.tar.gz'
  source_sha256 '4d9982da3582456d1e769e25a7d0b2daefe859c45e262c8f56f794114f9a29a0'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
