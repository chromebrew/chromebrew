require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'http://www.nongnu.org/libunwind/'
  version '1.2.1'
  source_url 'http://download.savannah.gnu.org/releases/libunwind/libunwind-1.2.1.tar.gz'
  source_sha256 '3f3ecb90e28cbe53fba7a4a27ccce7aad188d3210bb1964a923a731a27a75acb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f28d8580c8e95da338b4d7cf9864db21b08701fc3d3def6281df9f87f9725fa8',
     armv7l: 'f28d8580c8e95da338b4d7cf9864db21b08701fc3d3def6281df9f87f9725fa8',
       i686: '8ddb0b3298926128c2b2ced10a805a99787bacd4cb2abc8db756f19c2cc386a2',
     x86_64: '4a1df3e64f54af93da5339c2dc9ea56ed976e4743dec36fd6f09a0edf7ed5e2e',
  })

  depends_on 'buildessential' => :build
  depends_on 'openssl' => :build
  depends_on 'xzutils' => :build

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
