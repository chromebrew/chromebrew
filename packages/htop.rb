require 'package'

class Htop < Package
  version '1.0.3'
  source_url 'http://hisham.hm/htop/releases/1.0.3/htop-1.0.3.tar.gz' # software source tarball url
  source_sha1 '261492274ff4e741e72db1ae904af5766fc14ef4'

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
