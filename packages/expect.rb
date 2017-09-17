require 'package'

class Expect < Package
  description 'Expect is a tool for automating interactive applications such as telnet, ftp, passwd, fsck, rlogin, tip, etc.'
  homepage 'http://expect.sourceforge.net/'
  version '5.45-2'
  source_url 'http://prdownloads.sourceforge.net/expect/expect5.45.tar.gz'
  source_sha256 'b28dca90428a3b30e650525cdc16255d76bb6ccd65d448be53e620d95d5cc040'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '50c9d4f9b030d97f5e11f514d6109b7a4ed1f5e978b5f42c3c3b41f94f437bff',
     armv7l: '50c9d4f9b030d97f5e11f514d6109b7a4ed1f5e978b5f42c3c3b41f94f437bff',
       i686: '5c10c93fbdcf5a6d8a1708ec4aea9b6daf12abebc5af23d2e3aaec6f051e2364',
     x86_64: '65e9a83c45df552a9cb18f1ad3aced6169cef15eb4c7dc0535f39da22ac40f06',
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
