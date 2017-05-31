require 'package'

class Ncftp < Package
  description 'NcFTP Client (also known as just NcFTP) is a set of FREE application programs implementing the File Transfer Protocol (FTP).'
  homepage 'http://ncftp.com/ncftp/'
  version '3.2.6'
  source_url 'ftp://ftp.ncftp.com/ncftp/ncftp-3.2.6-src.tar.gz' # Software source tarball url  
  source_sha1 'e2351802b40db18d6cbab2537a9644cd858b934d'

  depends_on 'buildessential'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure" 
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
