require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'http://www.nongnu.org/libunwind/'
  version '1.2'
  source_url 'http://download.savannah.gnu.org/releases/libunwind/libunwind-1.2.tar.gz'
  source_sha1 'a33e52d7ecd18b9375508369b566eeb2cc6eec3b'

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
