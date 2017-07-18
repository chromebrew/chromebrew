require 'package'

class Randrproto < Package
  description ''
  homepage ''
  version '1.5.0'
  source_url 'https://www.x.org/archive/individual/proto/randrproto-1.5.0.tar.gz'
  source_sha256 '8f8a716d6daa6ba05df97d513960d35a39e040600bf04b313633f11679006fab'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
