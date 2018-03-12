require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'http://www.nongnu.org/libunwind/'
  version '1.2.1-0'
  source_url 'http://download.savannah.gnu.org/releases/libunwind/libunwind-1.2.1.tar.gz'
  source_sha256 '3f3ecb90e28cbe53fba7a4a27ccce7aad188d3210bb1964a923a731a27a75acb'


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
