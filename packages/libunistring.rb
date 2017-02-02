require 'package'

class Libunistring < Package
  version '0.9.7'
  source_url 'http://ftp.gnu.org/gnu/libunistring/libunistring-0.9.7.tar.xz'
  source_sha1 '7d92687a50fea7702e8052486dfa25ffc361c9f3'

  depends_on "glibc"

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
