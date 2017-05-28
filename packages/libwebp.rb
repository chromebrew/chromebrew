require 'package'

class Libwebp < Package
  version '0.6.0'
  source_url 'https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-0.6.0.tar.gz'
  source_sha1 '156d24fff454bfccd1f44434e226a10d9eb38186'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
