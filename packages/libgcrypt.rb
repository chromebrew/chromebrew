require 'package'

class Libgcrypt < Package
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.9.4'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.9.4.tar.bz2'
  source_sha256 'ea849c83a72454e3ed4267697e8ca03390aee972ab421e7df69dfe42b65caaf7'

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

  def self.check
    system 'make', 'check'
  end
end
