require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.9.0-1'
  compatibility 'all'
  source_url 'https://www.libssh2.org/download/libssh2-1.9.0.tar.gz'
  source_sha256 'd5fb8bd563305fd1074dda90bd053fb2d29fc4bce048d182f96eaa466dfadafd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'da6c1206dbf05ca327afb69311f4938ec09c2d2552edc1f12b78fa5048550bff',
     armv7l: 'da6c1206dbf05ca327afb69311f4938ec09c2d2552edc1f12b78fa5048550bff',
       i686: 'aaf97c46b8e2f4fdd5b603e27735898d1aa166d20ee79387b0040f6160c12ba6',
     x86_64: '658605c62a5444a0665b4ef72f3d705512c4ca72a58505e40fbe1718db3ed7bd',
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

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
