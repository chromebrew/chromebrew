require 'package'

class Rsync < Package
  version '3.1.1'
  source_url 'http://rsync.samba.org/ftp/rsync/src/rsync-3.1.1.tar.gz' # software source tarball url  
  source_sha1 'c84faba04f721d393feccfa0476bfeed9b5b5250'

  depends_on 'buildessential'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
