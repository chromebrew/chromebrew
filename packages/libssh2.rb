require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.10.0'
  compatibility 'all'
  license 'BSD'
  source_url 'https://www.libssh2.org/download/libssh2-1.10.0.tar.gz'
  source_sha256 '2d64e90f3ded394b91d3a2e774ca203a4179f69aebee03003e5a6fa621e41d51'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh2/1.10.0_armv7l/libssh2-1.10.0-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh2/1.10.0_armv7l/libssh2-1.10.0-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh2/1.10.0_i686/libssh2-1.10.0-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh2/1.10.0_x86_64/libssh2-1.10.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c31d6ee0243ce8b131d559c996a4d5d856a9ad4dfe412eb3b99af364d71157f5',
      armv7l: 'c31d6ee0243ce8b131d559c996a4d5d856a9ad4dfe412eb3b99af364d71157f5',
        i686: '6b65af8a14f9d2dfdcd8ee4006bd1c9ae35932108f0d9536394ce668c870cc30',
      x86_64: 'fc86a278cfc296e49716bc02e25119504be4ee451e5d12da9d9941e1a3bc2eb9'
  })

  def self.patch
    system "sed -i 's:/TESTS =/s:mansyntax.sh:g' tests/Makefile.in"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --with-libz"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
