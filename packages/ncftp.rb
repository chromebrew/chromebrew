require 'package'

class Ncftp < Package
  description 'NcFTP Client (also known as just NcFTP) is a set of FREE application programs implementing the File Transfer Protocol (FTP).'
  homepage 'http://ncftp.com/ncftp/'
  version '3.2.6'
  source_url 'ftp://ftp.ncftp.com/ncftp/ncftp-3.2.6-src.tar.gz'
  source_sha1 'e2351802b40db18d6cbab2537a9644cd858b934d'

  depends_on 'buildessential'

  def self.build
    system "./configure"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end         
end
