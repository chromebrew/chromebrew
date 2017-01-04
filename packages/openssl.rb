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
	system "make" #depend
  end

  def self.install
    system "sudo make DESTDIR=/usr/local/ssl install"
    system 'cd /usr/local/ssl && \                                # make sure cert.pem exists
    	    sudo wget http://curl.haxx.se/ca/cacert.pem && \
    	    sudo mv cacert.pem cert.pem'                                # && \
    	    #ln -s /usr/local/ssl/bin/openssl /usr/local/bin/openssl'    # override the system version (in case of a version mismatch)
                                                                  	# the caveat here is /usr/local/bin should come before /usr/bin in $PATH (the default)
  end

end
