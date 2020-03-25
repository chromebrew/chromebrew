require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.37'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.37.tar.bz2'
  source_sha256 'b32d6ff72a73cf79797f7f2d039e95e9c6f92f0c1450215410840ab62aea9763'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
