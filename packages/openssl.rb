require 'package'

class Openssl < Package
  version '1.0.2j'

  source_url 'ftp://openssl.org/source/openssl-1.0.2j.tar.gz'
  source_sha1 'bdfbdb416942f666865fa48fe13c2d0e588df54f'

  depends_on 'perl'

  def self.build
    system "./config","--prefix=/usr/local","shared","zlib-dynamic"
    system "make"
  end

  def self.install
    system "make", "INSTALL_PREFIX=#{CREW_DEST_DIR}", "install"

    # make sure cert.pem exists
    system "wget", "https://curl.haxx.se/ca/cacert.pem",
        "-O", "#{CREW_DEST_DIR}/usr/local/ssl/cert.pem"
  end

end
