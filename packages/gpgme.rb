require 'package'

class Gpgme < Package
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '1.8.0'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.8.0.tar.bz2'
  source_sha256 '596097257c2ce22e747741f8ff3d7e24f6e26231fa198a41b2a072e62d1e5d33'

  depends_on "libgpgerror"
  depends_on "libassuan"

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
