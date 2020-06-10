require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.9.0'
  compatibility 'all'
  source_url 'https://www.libssh2.org/download/libssh2-1.9.0.tar.gz'
  source_sha256 'd5fb8bd563305fd1074dda90bd053fb2d29fc4bce048d182f96eaa466dfadafd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '497e146e4d769aa85b0d547889784d7552e2aadbbaa448df5bbe9515cd94c182',
     armv7l: '497e146e4d769aa85b0d547889784d7552e2aadbbaa448df5bbe9515cd94c182',
       i686: 'dd2172bf82e3ffc1cfd06463108a36de55ba5e4bc2eb283852b54a737e087fe4',
     x86_64: 'd02623da747ecc95acdba69a056220ef579b01dae82a0cbfec2aa96c2ea8e914',
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
