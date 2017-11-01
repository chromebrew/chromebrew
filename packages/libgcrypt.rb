require 'package'

class Libgcrypt < Package
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.8.1-1'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.1.tar.bz2'
  source_sha256 '7a2875f8b1ae0301732e878c0cca2c9664ff09ef71408f085c50e332656a78b3'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libgpgerror'

  def self.build
    case ARCH
    when 'aarch64'
      system 'export gcry_cv_gcc_arm_platform_as_ok=no'
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
