require 'package'

class C_ares < Package
  description 'c-ares is a C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.13.0'
  source_url 'https://c-ares.haxx.se/download/c-ares-1.13.0.tar.gz'
  source_sha256 '03f708f1b14a26ab26c38abd51137640cb444d3ec72380b21b20f1a8d2861da7'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
