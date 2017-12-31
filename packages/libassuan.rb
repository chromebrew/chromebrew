require 'package'

class Libassuan < Package
  description 'Libassuan is a small library implementing the so-called Assuan protocol.'
  homepage 'https://www.gnupg.org/related_software/libassuan/index.html'
  version '2.5.1'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.1.tar.bz2'
  source_sha256 '47f96c37b4f2aac289f0bc1bacfa8bd8b4b209a488d3d15e2229cb6cc9b26449'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
