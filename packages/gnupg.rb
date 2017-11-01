require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.2.1'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.1.tar.bz2'
  source_sha256 '34d70cd65b9c95f3f2f90a9f5c1e0b6a0fe039a8d685e2d66d69c33d1cbf62fb'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'bz2'
  depends_on 'automake'
  depends_on 'libgpgerror'
  depends_on 'libgcrypt'
  depends_on 'libassuan'
  depends_on 'libksba'
  depends_on 'npth'
  depends_on 'gettext'

  def self.build
    system './autogen.sh'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
