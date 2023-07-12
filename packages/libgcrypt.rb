require 'package'

class Libgcrypt < Package
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.10.2'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
  source_sha256 '3b9c02a004b68c256add99701de00b383accccf37177e0d6c58289664cce0c03'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.10.2_armv7l/libgcrypt-1.10.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.10.2_armv7l/libgcrypt-1.10.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.10.2_i686/libgcrypt-1.10.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcrypt/1.10.2_x86_64/libgcrypt-1.10.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4a7f16099bf865c0e3b2bc470266a33cf5c46a6121e1bbc5de7e96c3abbc9b12',
     armv7l: '4a7f16099bf865c0e3b2bc470266a33cf5c46a6121e1bbc5de7e96c3abbc9b12',
       i686: '247572f3c656877817ba8d5629a437f0b953fca156fb4ee1fb66f04a805e7fe9',
     x86_64: 'de7d42ceb16ba890d0d906136fd83881c2bd51297ceb9a50d2addf2097114b6f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libgpgerror' # R

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
