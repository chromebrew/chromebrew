require 'package'

class Libgcrypt < Package
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.8.1-1'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.1.tar.bz2'
  source_sha256 '7a2875f8b1ae0301732e878c0cca2c9664ff09ef71408f085c50e332656a78b3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '32e9f0384e87daaec7b030d2a4cb351f7ad62c03ef3f3f2fc26c7d69ba642eb1',
     armv7l: '32e9f0384e87daaec7b030d2a4cb351f7ad62c03ef3f3f2fc26c7d69ba642eb1',
       i686: 'a0661c7e1ce7467adcfbbb2b9bfe4e5522726a0d15d8a37d2ecdea55991e7380',
     x86_64: '448844bb855035f2e5f843f5fa8108e5371b9b9e02bee0b4cf66395388836b4f',
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
