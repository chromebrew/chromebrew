require 'package'

class Libffi < Package
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.2.1-2'
  source_url 'ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz'
  source_sha256 'd06ebb8e1d9a22d19e38d63fdb83954253f39bedc5d46232a05645685722ca37'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic", "--disable-debug", "--disable-dependency-tracking"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # system "make check"         # DejaGNU required
  end
end
