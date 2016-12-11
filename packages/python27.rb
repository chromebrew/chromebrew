require 'package'

class Python27 < Package
  version '2.7.12-1'
  source_url 'https://dl.dropboxusercontent.com/u/14799278/crew/Python-2.7.12-SSLFIX.tar.gz' # software source tarball url
  source_sha1 '27a91c877773c5440f65d35d05c0bf398d0ce540'                  # source tarball sha1 sum

  depends_on 'bz2'
  depends_on 'ncurses'
  depends_on 'openssl_devel'

  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure --prefix=/usr/local CPPFLAGS=\"-I/usr/local/include -I/usr/local/include/ncurses\" LDFLAGS=\"-L/usr/local/lib\" CFLAGS=\" -fPIC\""
    system "make"                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
    system "wget https://bootstrap.pypa.io/get-pip.py"
    system "The sudo bit here is for python-pip to be installed"
    system "sudo python get-pip.py"
  end
end
