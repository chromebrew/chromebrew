require 'package'

class Openssl < Package
  version '1.0.2j'

<<<<<<< HEAD
#  chromeos wget can't do proper ssl negotiation with this server
#  source_url 'https://www.openssl.org/source/openssl-1.0.2j.tar.gz'
#  so use their ftp server.  
=======
>>>>>>> upstream/master
  source_url 'ftp://openssl.org/source/openssl-1.0.2j.tar.gz'
  source_sha1 'bdfbdb416942f666865fa48fe13c2d0e588df54f'

  depends_on 'perl'

  def self.build
<<<<<<< HEAD
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
=======
    system "./config", "--prefix=/usr/local", "--openssldir=/etc/ssl", "shared", "zlib-dynamic"
    system "make"
  end

  def self.install
    system "make", "INSTALL_PREFIX=#{CREW_DEST_DIR}", "install"

    # remove all files pretended to install /etc/ssl (use system's /etc/ssl as is)
    system "rm", "-rf", "#{CREW_DEST_DIR}/etc"
>>>>>>> upstream/master
  end

end
