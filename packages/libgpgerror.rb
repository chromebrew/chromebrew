require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.26'
  source_url 'ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.26.tar.bz2'
  source_sha256 '4c4bcbc90116932e3acd37b37812d8653b1b189c1904985898e860af818aee69'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
