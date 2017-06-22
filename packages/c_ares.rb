require 'package'

class C_ares < Package
  description 'c-ares is a C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.13.0'
  source_url 'https://c-ares.haxx.se/download/c-ares-1.13.0.tar.gz'
  source_sha1 'dde50284cc3d505fb2463ff6276e61d5531b1d68'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
