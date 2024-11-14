require 'package'

class Geoip < Package
  description 'GeoIP Legacy C API.'
  homepage 'https://dev.maxmind.com/geoip/legacy/'
  version '1.6.12'
  license 'LGPL-2.1, GPL-2 and MaxMind2'
  compatibility 'all'
  source_url 'https://github.com/maxmind/geoip-api-c/releases/download/v1.6.12/GeoIP-1.6.12.tar.gz'
  source_sha256 '1dfb748003c5e4b7fd56ba8c4cd786633d5d6f409547584f6910398389636f80'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'fb107ce557d6fe3b876f7f19578e434b6387d23dd46e4b1718ba5039eddd1106',
     armv7l: 'fb107ce557d6fe3b876f7f19578e434b6387d23dd46e4b1718ba5039eddd1106',
       i686: '8909827726c7496d79cd73da7a0ff59f91568d017848953e7c53565f51608bd5',
     x86_64: '11776aa232c6a14d2e1d0409dfdaa2eaa917320f2ebdf02a0e14fbd86447ae9c'
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/GeoIP"
    # Version 1 - GeoLite Legacy (see https://dev.maxmind.com/geoip/legacy/geolite/)
    system 'curl -#LO http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz'
    system 'curl -#LO http://geolite.maxmind.com/download/geoip/database/GeoIPv6.dat.gz'
    system 'curl -#LO http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
    system 'curl -#LO http://geolite.maxmind.com/download/geoip/database/GeoLiteCityv6-beta/GeoLiteCityv6.dat.gz'
    system 'curl -#LO http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz'
    system 'curl -#LO http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNumv6.dat.gz'
    system 'gunzip Geo*.gz'
    system "cp Geo*.dat #{CREW_DEST_PREFIX}/share/GeoIP/"
    # Version 2 - GeoLite2 for future use (see https://dev.maxmind.com/geoip/geoip2/geolite2/)
    # system 'curl -#LO http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz'
    # system 'curl -#LO http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz'
    # system 'curl -#LO http://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN.tar.gz'
    # system 'tar xvf GeoLite2-City.tar.gz'
    # system 'tar xvf GeoLite2-Country.tar.gz'
    # system 'tar xvf GeoLite2-ASN.tar.gz'
    # system "cp GeoLite2-*/GeoLite2-*.mmdb #{CREW_DEST_PREFIX}/share/GeoIP/"
  end
end
