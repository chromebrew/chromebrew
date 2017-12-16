require 'package'

class Libunistring < Package
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '0.9.8'
  source_url 'https://ftp.gnu.org/gnu/libunistring/libunistring-0.9.8.tar.xz'
  source_sha256 '7b9338cf52706facb2e18587dceda2fbc4a2a3519efa1e15a3f2a68193942f80'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glibc'

  def self.build
    system "./configure", "--disable-static", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
