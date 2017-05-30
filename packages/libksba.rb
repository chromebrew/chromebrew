require 'package'

class Libksba < Package
  description 'Libksba is a library to make the tasks of working with X.509 certificates, CMS data and related objects more easy.'
  homepage 'https://www.gnupg.org/related_software/libksba/index.html'
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
