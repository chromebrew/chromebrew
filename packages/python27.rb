require 'package'

class Python27 < Package
  version '2.7.8'
  source_url 'https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz'     # software source tarball url
  source_sha1 '511960dd78451a06c9df76509635aeec05b2051a'          	# source tarball sha1 sum
  
  depends_on 'bz2'
  depends_on 'ncurses'

  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure --prefix=/usr/local CPPFLAGS=\"-I/usr/local/include -I/usr/local/include/ncurses\" LDFLAGS=\"-L/usr/local/lib\" CFLAGS=\" -fPIC\""
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
