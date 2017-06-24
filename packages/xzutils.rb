require 'package'

class Xzutils < Package
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.2.3-2'
  source_url 'http://tukaani.org/xz/xz-5.2.3.tar.gz'
  source_sha1 '529638eec3597e429cc54c74551ac0a89169e841'

  def self.build
    system "./configure", "--prefix=/usr/local", "--libdir=#{CREW_LIB_PREFIX}",
      "--disable-docs", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"

    # strip debug symbol from library
    system "strip -S #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/liblzma.so.*"
  end

  def self.check
    system "make", "check"
  end
end
