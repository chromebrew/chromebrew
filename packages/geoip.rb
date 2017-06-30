require 'package'

class Geoip < Package
  description 'GeoIP Legacy C API.'
  homepage 'https://github.com/maxmind/geoip-api-c/'
  version '1.6.9'
  source_url 'https://github.com/maxmind/geoip-api-c/releases/download/v1.6.9/GeoIP-1.6.9.tar.gz'
  source_sha256 '4b446491843de67c1af9b887da17a3e5939e0aeed4826923a5f4bf09d845096f'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
