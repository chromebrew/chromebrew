require 'package'

class Expect < Package
  description 'Expect is a tool for automating interactive applications such as telnet, ftp, passwd, fsck, rlogin, tip, etc.'
  homepage 'http://expect.sourceforge.net/'
  version '5.45.3'
  source_url 'https://prdownloads.sourceforge.net/expect/expect5.45.3.tar.gz'
  source_sha256 'c520717b7195944a69ce1492ec82ca0ac3f3baf060804e6c5ee6d505ea512be9'

  depends_on "tcl"

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make test"
  end
end
