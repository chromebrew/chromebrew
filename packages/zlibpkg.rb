require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'http://www.zlib.net/'
  version '1.2.11-1'
  source_url 'http://www.zlib.net/zlib-1.2.11.tar.gz'
  source_sha1 'e6d119755acdf9104d7ba236b1242696940ed6dd'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # remove static library since there is no configuration option to not create it.
    system "rm", "#{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/libz.a"

    # strip library
    system "strip -S #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/libz.so.*"
  end

  def self.check
    system "make check"
  end
end
