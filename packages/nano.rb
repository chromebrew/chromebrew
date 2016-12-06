require 'package'

class Nano < Package
  version '2.7.1'
  source_url 'https://www.nano-editor.org/dist/v2.7/nano-2.7.1.tar.xz' # software source tarball url  
  source_sha1 '6a06d2c396a98a256722659fd22ace3d04d4c9f5'

  depends_on 'buildessential'
  depends_on 'ncurses' 
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure CPPFLAGS=\"-I/usr/local/include/ncurses\""
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
