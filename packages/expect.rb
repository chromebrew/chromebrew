require 'package'

class Expect < Package
  version '5.45'
  source_url 'http://prdownloads.sourceforge.net/expect/expect5.45.tar.gz'
  source_sha1 'e634992cab35b7c6931e1f21fbb8f74d464bd496'

  depends_on "tcl"

  def self.build
    system "./configure", "--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
