require 'package'

class Xzutils < Package
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.2.3-2'
  source_url 'http://tukaani.org/xz/xz-5.2.3.tar.gz'
  source_sha256 '71928b357d0a09a12a4b4c5fafca8c31c19b0e7d3b8ebb19622e96f26dbf28cb'

  def self.build
    system "./configure", "--prefix=/usr/local", "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-docs", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
