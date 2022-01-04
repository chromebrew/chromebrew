require 'package'

class Libgcrypt < Package
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.9.4'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
  source_sha256 'ea849c83a72454e3ed4267697e8ca03390aee972ab421e7df69dfe42b65caaf7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.9.4_armv7l/libgcrypt-1.9.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.9.4_armv7l/libgcrypt-1.9.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.9.4_i686/libgcrypt-1.9.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.9.4_x86_64/libgcrypt-1.9.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c9b2becd32471b6d23c65b513685bf58bd1e5f453b6ab49dd5ebe33959fb2354',
     armv7l: 'c9b2becd32471b6d23c65b513685bf58bd1e5f453b6ab49dd5ebe33959fb2354',
       i686: '9d9dea2c93f63e7ab36f6423c873ece51ce2cd3558da61e266e463cda38413c5',
     x86_64: '83e047dd1591ec41c67d707517f5fd0b31492e15b282345e31ca563689ec8df9'
  })

  depends_on 'libgpgerror'

  def self.patch
    system 'filefix'
  end

  def self.build
    case ARCH
    when 'aarch64'
      system "gcry_cv_gcc_arm_platform_as_ok=no ./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS} \
      --enable-static \
      --enable-shared \
      --disable-asm"
    else
      system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS} \
        --enable-static \
        --enable-shared"
    end
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
