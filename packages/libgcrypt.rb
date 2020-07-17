require 'package'

class Libgcrypt < Package
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.8.6'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.6.tar.bz2'
  source_sha256 '0cba2700617b99fc33864a0c16b1fa7fdf9781d9ed3509f5d767178e5fd7b975'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgcrypt-1.8.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1536f3b492773f7145d3f68893e4a4b0f0b6f3c64ac1141d563c243146836988',
     armv7l: '1536f3b492773f7145d3f68893e4a4b0f0b6f3c64ac1141d563c243146836988',
       i686: 'd569a14b5ecf2b62895a121e7cd271af4d103375a1f086359d7b5ba7b5dff930',
     x86_64: '50794006ecb92d0e54be1a27a56f0e11be173dee3d98623b46f737541104b1a1',
  })

  depends_on 'libgpgerror'

  def self.build
    case ARCH
    when 'aarch64'
      ENV['gcry_cv_gcc_arm_platform_as_ok'] = 'no'
      system "./configure #{CREW_OPTIONS} --disable-asm"
    else
      system "./configure #{CREW_OPTIONS}"
    end
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
