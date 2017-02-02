require 'package'

class Libksba < Package
  version '1.3.5'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.3.5.tar.bz2'
  source_sha1 'a98385734a0c3f5b713198e8d6e6e4aeb0b76fde'

  depends_on 'npth'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
