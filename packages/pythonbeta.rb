require 'package'

class PythonBeta < Package
  version '3.6.0b2'
  source_url 'https://www.python.org/ftp/python/3.6.0/Python-3.6.0b2.tgz'     # software source tarball url
  source_sha1 'e8c1bd575a6ccc2a75f79d9d094a6a29d3802f5d'          	# source tarball sha1 sum
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
