require 'package'

class Libffi < Package
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.3'
  compatibility 'all'
  source_url 'https://sourceware.org/pub/libffi/libffi-3.3.tar.gz'
  source_sha256 '72fba7922703ddfa7a028d513ac15a85c8d54c8d67f55fa5a4802885dc652056'


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
