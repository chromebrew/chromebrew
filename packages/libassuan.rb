require 'package'

class Libassuan < Package
  version '2.4.3'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.4.3.tar.bz2'
  source_sha1 '27391cf4a820b5350ea789c30661830c9a271518'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
