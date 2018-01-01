require 'package'

class Gpgme < Package
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '1.10.0'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.10.0.tar.bz2'
  source_sha256 '1a8fed1197c3b99c35f403066bb344a26224d292afc048cfdfc4ccd5690a0693'

  binary_url ({
  })
  binary_sha256 ({
  })

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
