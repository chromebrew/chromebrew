require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.1.2'
  source_url 'http://rsync.samba.org/ftp/rsync/src/rsync-3.1.2.tar.gz' # software source tarball url  
  source_sha1 '0d4c7fb7fe3fc80eeff922a7c1d81df11dbb8a1a'

  depends_on 'buildessential'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
