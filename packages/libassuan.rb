require 'package'

class Libassuan < Package
  description 'Libassuan is a small library implementing the so-called Assuan protocol.'
  homepage 'https://www.gnupg.org/related_software/libassuan/index.html'
  version '2.4.3'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.4.3.tar.bz2'
  source_sha256 '22843a3bdb256f59be49842abf24da76700354293a066d82ade8134bb5aa2b71'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
