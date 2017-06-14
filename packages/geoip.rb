require 'package'

class Geoip < Package
  description 'GeoIP Legacy C API.'
  homepage 'https://github.com/maxmind/geoip-api-c/'
  version '1.6.9'
  source_url 'https://github.com/maxmind/geoip-api-c/releases/download/v1.6.9/GeoIP-1.6.9.tar.gz'
  source_sha1 'ac0deb2309c14d5763e82fa4139de1f3193ab6b1'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
