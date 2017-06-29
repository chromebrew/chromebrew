require 'package'

class Expect < Package
  description 'Expect is a tool for automating interactive applications such as telnet, ftp, passwd, fsck, rlogin, tip, etc.'
  homepage 'http://expect.sourceforge.net/'
  version '5.45-1'
  source_url 'http://prdownloads.sourceforge.net/expect/expect5.45.tar.gz'
  source_sha256 'b28dca90428a3b30e650525cdc16255d76bb6ccd65d448be53e620d95d5cc040'

  depends_on "tcl"

  def self.build
    system "./configure", "--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make test"
  end
end
