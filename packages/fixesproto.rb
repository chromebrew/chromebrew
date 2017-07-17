require 'package'

class Fixesproto < Package
  description ''
  homepage ''
  version '5.0'
  source_url 'https://www.x.org/archive/individual/proto/fixesproto-5.0.tar.gz'
  source_sha256 '67865a0e3cdc7dec1fd676f0927f7011ad4036c18eb320a2b41dbd56282f33b8'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
