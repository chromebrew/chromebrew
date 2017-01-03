require 'package'

class Scrollz < Package
  version '2.3'
  source_url 'http://www.scrollz.info/download/ScrollZ-2.3.tar.gz' # Software source tarball url  
  source_sha1 '991e6acfdf95d84ca159a37336c2d45a624d432f'

  depends_on 'buildessential'
  depends_on 'ncurses'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure" 
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
