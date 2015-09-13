require 'package'

class Python27 < Package
  version '2.7.10'
  
  binary_url({
    armv7l: 'https://www.dropbox.com/s/q5a93ntbv8qyieb/python2.tar.gz?dl=0'
  })
  binary_sha1({
    armv7l: 'd1d1534b169766fc250d22fdf8c3b54db5e9f1f1'
  })
  
  source_url 'https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz'     # software source tarball url
  source_sha1 'ee5a50c5562e7448f037d35fdedc18d95c748b9e'          	# source tarball sha1 sum
  
  depends_on 'bz2'
  depends_on 'ncurses'
  depends_on 'buildessential' #until binary for i686 and x86_64 are provided

  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure --prefix=/usr/local CPPFLAGS=\"-I/usr/local/include -I/usr/local/include/ncurses\" LDFLAGS=\"-L/usr/local/lib\" CFLAGS=\" -fPIC\""
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
