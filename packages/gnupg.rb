require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.1.22'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.22.tar.bz2'
  source_sha256 '46716faf9e1b92cfca86609f3bfffbf5bb4b6804df90dc853ff7061cfcfb4ad7'

  depends_on 'bz2'
  depends_on 'automake'
  depends_on 'libgpgerror'
  depends_on 'libgcrypt'
  depends_on 'libassuan'
  depends_on 'libksba'
  depends_on 'npth'
  depends_on 'gettext'

  def self.build
    system "./autogen.sh"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
