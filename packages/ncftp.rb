require 'package'

class Ncftp < Package
  description 'NcFTP Client (also known as just NcFTP) is a set of FREE application programs implementing the File Transfer Protocol (FTP).'
  homepage 'http://ncftp.com/ncftp/'
  version '3.2.6'
  source_url 'ftp://ftp.ncftp.com/ncftp/ncftp-3.2.6-src.tar.gz'
  source_sha256 '129e5954850290da98af012559e6743de193de0012e972ff939df9b604f81c23'

  depends_on 'buildessential'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
