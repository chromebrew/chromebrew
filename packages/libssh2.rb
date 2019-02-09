require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.8.1'
  source_url 'https://www.libssh2.org/download/libssh2-1.8.1.tar.gz'
  source_sha256 '40b517f35b1bb869d0075b15125c7a015557f53a5a3a6a8bffb89b69fd70f159'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.patch
    system 'sed', '-i', '/TESTS =/s, mansyntax.sh,,g', 'tests/Makefile.in'
  end

  def self.build
    system './configure',
           '--with-libz',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
