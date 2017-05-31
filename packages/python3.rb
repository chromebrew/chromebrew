require 'package'

class Python3 < Package
  version '3.6.0'
  source_url 'https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz'
  source_sha1 '120d536ee14a3153fc2435838c0f27c2e25cd29c'

  depends_on 'bz2'
  depends_on 'ncurses'
  depends_on 'openssl'

  def self.build
    system "./configure --prefix=/usr/local CPPFLAGS=\"-I/usr/local/include -I/usr/local/include/ncurses\" LDFLAGS=\"-L/usr/local/lib\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
