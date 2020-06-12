require 'package'

class Libgcrypt < Package
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.8.5'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.5.tar.bz2'
  source_sha256 '3b4a2a94cb637eff5bdebbcaf46f4d95c4f25206f459809339cdada0eb577ac3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94018f0c7542235ef7fba73a4fbcd67e415f1c5f9cc6116fa2075638c472448c',
     armv7l: '94018f0c7542235ef7fba73a4fbcd67e415f1c5f9cc6116fa2075638c472448c',
       i686: '7c7a857f964a2af40a45ae63d1241e40f03bbf917e609febd222e095db22c80e',
     x86_64: '6c0cbecc94b4cd9615844e45733a0ef92f197ec6ab7a41d1733a19d168db3a3f',
  })

  depends_on 'libgpgerror'

  def self.build
    case ARCH
    when 'aarch64'
      ENV['gcry_cv_gcc_arm_platform_as_ok'] = 'no'
      system './configure',
        "--prefix=#{CREW_PREFIX}",
        "--libdir=#{CREW_LIB_PREFIX}",
        '--disable-asm'
    else
      system './configure',
        "--prefix=#{CREW_PREFIX}",
        "--libdir=#{CREW_LIB_PREFIX}"
    end
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
