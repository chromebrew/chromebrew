require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.27'
  source_url 'ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.27.tar.bz2'
  source_sha256 '4f93aac6fecb7da2b92871bb9ee33032be6a87b174f54abf8ddf0911a22d29d2'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
