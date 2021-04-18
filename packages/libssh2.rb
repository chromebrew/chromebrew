require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  @_ver = '1.9.0'
  version @_ver + '-3'
  license 'BSD'
  compatibility 'all'
  source_url "https://www.libssh2.org/download/libssh2-#{@_ver}.tar.gz"
  source_sha256 'd5fb8bd563305fd1074dda90bd053fb2d29fc4bce048d182f96eaa466dfadafd'

  binary_url ({
     aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libssh2-1.9.0-3-chromeos-armv7l.tar.xz',
      armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libssh2-1.9.0-3-chromeos-armv7l.tar.xz',
        i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/libssh2-1.9.0-3-chromeos-i686.tar.xz',
      x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/libssh2-1.9.0-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'a8b26892821ee9fae80de1c93d3f33171826e81849977227654d0ab91067ec25',
      armv7l: 'a8b26892821ee9fae80de1c93d3f33171826e81849977227654d0ab91067ec25',
        i686: '8004bd36ae1af0c9a2897881ad279f774b8dd72bf67b33f5e8ed7d792f36ba0b',
      x86_64: 'aa7e4634d65400f17ab064ce8b9cd43703d3dd9393426e1155ea8627876cda8b',
  })

  def self.patch
    system 'sed', '-i', '/TESTS =/s, mansyntax.sh,,g', 'tests/Makefile.in'
  end

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
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
