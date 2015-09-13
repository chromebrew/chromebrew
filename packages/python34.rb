require 'package'

class Python34 < Package
  version '3.4.3'
  
  binary_url({
    armv7l: 'https://www.dropbox.com/s/56mjrz57u053q5e/python3.tar.gz?dl=0'
  })
  binary_sha1({
    armv7l: 'b6143af3ff7b937177e9f31009c3b56fe024d7dd'
  })
  
  depends_on 'buildessential' #until binary for i686 and x86_64 are provided
  
  source_url 'https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tar.xz'     # software source tarball url
  source_sha1 '7ca5cd664598bea96eec105aa6453223bb6b4456'          	# source tarball sha1 sum
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
