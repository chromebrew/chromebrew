require 'package'

class Goaccess < Package
  description 'GoAccess is an open source real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser.'
  homepage 'https://goaccess.io/'
  version '1.2-1'
  license 'MIT'
  compatibility 'all'
  source_url 'http://tar.goaccess.io/goaccess-1.2.tar.gz'
  source_sha256 '6ba9f66540ea58fc2c17f175265f9ed76d74a8432eeac1182b74ebf4f2cd3414'

  depends_on 'openssl'
  depends_on 'geoip'
  depends_on 'ncursesw'

  def self.build
    system './configure \
              --enable-geoip=legacy \
              --enable-utf8 \
              --with-getline \
              --with-openssl'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
