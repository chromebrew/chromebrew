require 'package'

class Goaccess < Package
  description 'GoAccess is an open source real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser.'
  homepage 'https://goaccess.io/'
  version '1.1.1'
  source_url 'http://tar.goaccess.io/goaccess-1.1.1.tar.gz'
  source_sha1 '8f79d90ea3e423f85aadf45528340a6547ab83f0'

  depends_on 'openssl'
  depends_on 'geoip'
  depends_on 'ncurses'

  def self.build
    system './configure \
              --enable-geoip \
              --enable-utf8 \
              --with-getline \
              --with-openssl'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
