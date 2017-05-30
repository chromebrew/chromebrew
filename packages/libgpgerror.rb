require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.26'
  source_url 'ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.26.tar.bz2'
  source_sha1 '9a926e7ee6309e539313443555535d49a2a5c9f1'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
