require 'package'                                                 # include package class file

class Screen < Package                                               # name the package and make it a Package class instance
  version '4.3.1'                                                   # software version
  source_url 'ftp://ftp.gnu.org/gnu/screen/screen-4.3.1.tar.gz'     # software source tarball url
  source_sha1 'a524761504e28480517e338b20c852f2ab100c93'          # source tarball sha1 sum
  
  depends_on 'ncurses'                                            # software dependencies
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure --prefix=/usr/local"
    system "make"  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end                                                             # during installation
end
