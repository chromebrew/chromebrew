require 'package'

class Geoip < Package
  description 'GeoIP Legacy C API.'
  homepage 'https://github.com/maxmind/geoip-api-c/'
  version '1.6.11-1'
  source_url 'https://github.com/maxmind/geoip-api-c/releases/download/v1.6.11/GeoIP-1.6.11.tar.gz'
  source_sha256 'b0e5a92200b5ab540d118983f7b7191caf4faf1ae879c44afa3ff2a2abcdb0f5'

  def self.build
    system './configure', "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
