require 'package'

class Npth < Package
  description 'nPth is a library to provide the GNU Pth API and thus a non-preemptive threads implementation.'
  homepage 'https://www.gnupg.org/related_software/npth/index.html'
  version '1.3'
  source_url 'https://www.gnupg.org/ftp/gcrypt/npth/npth-1.3.tar.bz2'
  source_sha256 'bca81940436aed0734eb8d0ff8b179e04cc8c087f5625204419f5f45d736a82a'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
