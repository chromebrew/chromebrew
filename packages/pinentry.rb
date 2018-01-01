require 'package'

class Pinentry < Package
  description "A collection of passphrase entry dialogs which is required for almost all usages of GnuPG"
  homepage 'https://gnupg.org/software/pinentry/index.html'
  version '1.1.0'
  source_url 'https://gnupg.org/ftp/gcrypt/pinentry/pinentry-1.1.0.tar.bz2'
  source_sha256 '68076686fa724a290ea49cdf0d1c0c1500907d1b759a3bcbfbec0293e8f56570'

  depends_on 'gnupg'
  depends_on 'libcap'
  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
