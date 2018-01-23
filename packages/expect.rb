require 'package'

class Expect < Package
  description 'Expect is a tool for automating interactive applications such as telnet, ftp, passwd, fsck, rlogin, tip, etc.'
  homepage 'http://expect.sourceforge.net/'
  version '5.45.3'
  source_url 'https://prdownloads.sourceforge.net/expect/expect5.45.3.tar.gz'
  source_sha256 'c520717b7195944a69ce1492ec82ca0ac3f3baf060804e6c5ee6d505ea512be9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '62d74b1673b77c7ec9ebc9ca88409950bcba3bf69c2251de69c776986a7f4269',
     armv7l: '62d74b1673b77c7ec9ebc9ca88409950bcba3bf69c2251de69c776986a7f4269',
       i686: '25588652046f6ade84afa13ad04e8fd7e156e3272b7f7bdbd53e7a1a967fd2fd',
     x86_64: '7f87f7cb4e9248bc0920c110b40f4fe26864b3db8f9d51f907aa7bdda39dc56b',
  })

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
