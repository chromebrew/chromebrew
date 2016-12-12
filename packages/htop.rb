require 'package'

class Htop < Package
  version '2.0.2'
  source_url 'http://hisham.hm/htop/releases/2.0.2/htop-2.0.2.tar.gz' # software source tarball url
  source_sha1 '201f793f13dce2448e36047079875b9bd5bba75a'

  depends_on 'buildessential'
  depends_on 'ncurses'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure --disable-unicode"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
