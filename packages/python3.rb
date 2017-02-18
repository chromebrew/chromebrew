require 'package'

class Python3 < Package
  version '3.6.0'
  source_url 'https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz' # software source tarball url
  source_sha1 '120d536ee14a3153fc2435838c0f27c2e25cd29c'                     # source tarball sha1 sum

  depends_on 'bz2'
  depends_on 'ncurses'
  depends_on 'openssl'

  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure --prefix=/usr/local CPPFLAGS=\"-I/usr/local/include -I/usr/local/include/ncurses\" LDFLAGS=\"-L/usr/local/lib\" CFLAGS=\" -fPIC\""
    system "make"                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
