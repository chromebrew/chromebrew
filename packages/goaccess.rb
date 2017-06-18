require 'package'

class Goaccess < Package
  description 'GoAccess is an open source real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser.'
  homepage 'https://goaccess.io/'
  version '1.2'
  source_url 'http://tar.goaccess.io/goaccess-1.2.tar.gz'
  source_sha1 '4c12796ff5afd14f359b1f638fc51c4007db1e3c'

  depends_on 'openssl'
  depends_on 'geoip'
  depends_on 'ncurses'

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
