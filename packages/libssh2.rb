require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.9.0-2'
  compatibility 'all'
  source_url 'https://www.libssh2.org/download/libssh2-1.9.0.tar.gz'
  source_sha256 'd5fb8bd563305fd1074dda90bd053fb2d29fc4bce048d182f96eaa466dfadafd'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'bdada70629d2c0e8dd021c0d6ddbed2c255e4ed675a4f46b7e7dd87c366f45c0',
      armv7l: 'bdada70629d2c0e8dd021c0d6ddbed2c255e4ed675a4f46b7e7dd87c366f45c0',
        i686: 'a07e1633070e0774db5c45eb9d45ae3aca0c906661d042f5ebf3c5c2281f513e',
      x86_64: '686ca66e0392c6a4d4906d8ab468df00950f0c7dcbcdcd886fdb0dba1c49ce12',
  })

  def self.patch
    system 'sed', '-i', '/TESTS =/s, mansyntax.sh,,g', 'tests/Makefile.in'
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --with-libz"

    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
