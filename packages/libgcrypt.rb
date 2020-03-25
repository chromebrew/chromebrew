require 'package'

class Libgcrypt < Package
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.8.5'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.5.tar.bz2'
  source_sha256 '3b4a2a94cb637eff5bdebbcaf46f4d95c4f25206f459809339cdada0eb577ac3'

  binary_url ({
  })
  binary_sha256 ({
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
