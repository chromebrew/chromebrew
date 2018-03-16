require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'http://www.nongnu.org/libunwind/'
  version '1.2.1-0'
  source_url 'http://download.savannah.gnu.org/releases/libunwind/libunwind-1.2.1.tar.gz'
  source_sha256 '3f3ecb90e28cbe53fba7a4a27ccce7aad188d3210bb1964a923a731a27a75acb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.2.1-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.2.1-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.2.1-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.2.1-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ad248bc364a305c449d684ba65649f0c952a0e9dcf7742411f7918346ba6ed20',
     armv7l: 'ad248bc364a305c449d684ba65649f0c952a0e9dcf7742411f7918346ba6ed20',
       i686: '5a5730f583590483fbac1c4a64970db358449767d2858ad01d13f1f33f3f4d86',
     x86_64: 'd439b332a4a18ee2a49d0877409c71f28d49f539e31aec87feb6247ad4c22e41',
  })

  depends_on 'buildessential' => :build
  depends_on 'openssl' => :build
  depends_on 'xzutils' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
