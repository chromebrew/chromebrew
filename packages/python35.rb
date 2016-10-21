require 'package'

class Python35 < Package
  version '3.5.2'
  source_url 'https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz'     # software source tarball url
  source_sha1 '94e838c405ea305ae7b52a34b6ea9a90126541e2'          	# source tarball sha1 sum
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
