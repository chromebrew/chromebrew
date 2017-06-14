require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.1.21'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.21.tar.bz2'
  source_sha1 '1852c066bc21893bc52026ead78edf50fdf15e13'

  depends_on 'bz2'
  depends_on 'automake'
  depends_on 'libgpgerror'
  depends_on 'libgcrypt'
  depends_on 'libassuan'
  depends_on 'libksba'
  depends_on 'npth'

  def self.build
    system "./autogen.sh"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
