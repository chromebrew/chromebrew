require 'package'

class Gpgme < Package
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '1.9.0'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.9.0.tar.bz2'
  source_sha256 '1b29fedb8bfad775e70eafac5b0590621683b2d9869db994568e6401f4034ceb'

  depends_on 'libgpgerror'
  depends_on 'libassuan'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
