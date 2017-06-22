require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.1.2'
  source_url 'http://rsync.samba.org/ftp/rsync/src/rsync-3.1.2.tar.gz'
  source_sha1 '0d4c7fb7fe3fc80eeff922a7c1d81df11dbb8a1a'

  depends_on 'buildessential'
  depends_on 'perl' => :build
  
  def self.build
    system "./configure"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end         
end
