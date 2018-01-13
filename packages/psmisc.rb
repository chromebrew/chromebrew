require 'package'

class Psmisc < Package
  description 'PSmisc is a set of some small useful utilities that use the proc filesystem.'
  homepage 'http://psmisc.sourceforge.net/'
  version '23.1'
  source_url 'http://downloads.sourceforge.net/project/psmisc/psmisc/psmisc-23.1.tar.xz'
  source_sha256 '2e84d474cf75dfbe3ecdacfb797bbfab71a35c7c2639d1b9f6d5f18b2149ba30'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make CFLAGS=' -I#{CREW_PREFIX}/include/ncurses'"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
