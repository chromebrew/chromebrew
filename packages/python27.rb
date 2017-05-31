require 'package'

class Python27 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.13-1'
  source_url 'https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz'
  source_sha1 '18a8f30a0356c751b8d0ea6f76e764cab13ee046'

  depends_on 'bz2'
  depends_on 'ncurses'
  depends_on 'openssl'

  def self.build
    system "./configure --prefix=/usr/local CPPFLAGS=\"-I/usr/local/include -I/usr/local/include/ncurses\" LDFLAGS=\"-L/usr/local/lib\" CFLAGS=\" -fPIC\" --with-ensurepip=install"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
