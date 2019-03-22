require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.8.1'
  source_url 'https://www.libssh2.org/download/libssh2-1.8.1.tar.gz'
  source_sha256 '40b517f35b1bb869d0075b15125c7a015557f53a5a3a6a8bffb89b69fd70f159'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd8fae766d77818ef95ae8a993bda0c03730d773cfb8392ceaaf6c8697206409c',
     armv7l: 'd8fae766d77818ef95ae8a993bda0c03730d773cfb8392ceaaf6c8697206409c',
       i686: 'ccdea94d6dcc0bdd27b364cd99f53e9aba6f90f0b8272a5f3856bf2a9a32beb6',
     x86_64: '1025b413f30c5ac27bfa340e41cb437bf19311e72b95030f64020e25be4cda31',
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
