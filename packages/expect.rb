require 'package'

class Expect < Package
  description 'Expect is a tool for automating interactive applications such as telnet, ftp, passwd, fsck, rlogin, tip, etc.'
  homepage 'http://expect.sourceforge.net/'
  version '5.45-1'
  source_url 'http://prdownloads.sourceforge.net/expect/expect5.45.tar.gz'
  source_sha1 'e634992cab35b7c6931e1f21fbb8f74d464bd496'

  depends_on "tcl"

  def self.build
    system "./configure", "--prefix=/usr/local"
    system "make"
    system "find . -name '*.so' -print | xargs strip -S"
    system "strip expect"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make test"
  end
end
