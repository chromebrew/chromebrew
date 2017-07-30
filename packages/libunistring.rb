require 'package'

class Libunistring < Package
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '0.9.7-1'
  source_url 'http://ftp.gnu.org/gnu/libunistring/libunistring-0.9.7.tar.xz'
  source_sha256 '2e3764512aaf2ce598af5a38818c0ea23dedf1ff5460070d1b6cee5c3336e797'

  depends_on 'glibc'

  def self.build
    system "./configure", "--disable-static", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
