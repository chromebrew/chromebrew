require 'package'

class Mg < Package
  description 'mg is the portable version of the mg editor from OpenBSD'
  homepage 'https://devio.us/~bcallah/mg/'
  version '20170917'
  source_url 'https://devio.us/~bcallah/mg/mg-20170917.tar.gz'
  source_sha256 'def9237a89ec6a14241abaf12714bc5fcb3b0e2f8d9d466ff7561628d35b7ff1'

  depends_on 'ncurses'

  def self.build
    system "CFLAGS=-I/usr/local/include/ncurses make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
