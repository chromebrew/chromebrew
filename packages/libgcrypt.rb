require 'package'

class Libgcrypt < Package
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.9.3'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.9.3.tar.bz2'
  source_sha256 '97ebe4f94e2f7e35b752194ce15a0f3c66324e0ff6af26659bbfb5ff2ec328fd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.9.3_armv7l/libgcrypt-1.9.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.9.3_armv7l/libgcrypt-1.9.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.9.3_i686/libgcrypt-1.9.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.9.3_x86_64/libgcrypt-1.9.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1e2b42394624c35f94278ee7f9c70aa544c7c40dedd49b396e3e2a72d2e6e6bc',
     armv7l: '1e2b42394624c35f94278ee7f9c70aa544c7c40dedd49b396e3e2a72d2e6e6bc',
       i686: 'c072efaef5595c6f3ef7c57ce9573a8c9d79f2e7fa937425f4bb3a4098e12cd5',
     x86_64: '3945f3464bd06d41db1be4ad4f59242490bfa897856c9e395f25b5d9f1f1bc75'
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
