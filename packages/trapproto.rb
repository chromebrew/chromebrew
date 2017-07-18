require 'package'

class Trapproto < Package
  description ''
  homepage ''
  version '3.4.3'
  source_url 'https://www.x.org/archive/individual/proto/trapproto-3.4.3.tar.gz'
  source_sha256 'abfb930b5703b5a6ebafe84d0246bd8c6b099ca4a4eab06d1dc0776a8a9b87c1'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
