require 'package'

class Openssl < Package
  version '1.0.2j'

#  chromeos wget can't do proper ssl negotiation with this server
#  source_url 'https://www.openssl.org/source/openssl-1.0.2j.tar.gz'
#  so use their ftp server.  
  source_url 'ftp://openssl.org/source/openssl-1.0.2j.tar.gz'
  source_sha1 'bdfbdb416942f666865fa48fe13c2d0e588df54f'

  depends_on 'perl'

  def self.build
	system "./config","--prefix=/usr/local","shared","zlib-dynamic"
	system "make depend"
  end

  def self.install
    system "make"
    system "sudo make install"
  end

end
