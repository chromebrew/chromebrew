require 'package'

class Npth < Package
  description 'nPth is a library to provide the GNU Pth API and thus a non-preemptive threads implementation.'
  homepage 'https://www.gnupg.org/related_software/npth/index.html'
  version '1.3'
  source_url 'https://www.gnupg.org/ftp/gcrypt/npth/npth-1.3.tar.bz2'
  source_sha1 '1b21507cfa3f58bdd19ef2f6800ab4cb67729972'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
