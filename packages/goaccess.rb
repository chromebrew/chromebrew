require 'package'

class Goaccess < Package
  description 'GoAccess is an open source real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser.'
  homepage 'https://goaccess.io/'
  version '1.2'
  compatibility 'all'
  source_url 'http://tar.goaccess.io/goaccess-1.2.tar.gz'
  source_sha256 '6ba9f66540ea58fc2c17f175265f9ed76d74a8432eeac1182b74ebf4f2cd3414'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/goaccess-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/goaccess-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/goaccess-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/goaccess-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0c132b27f777f1e1dc14803e511bcc39878e3d95c6505340b82a1d51574e2b7e',
     armv7l: '0c132b27f777f1e1dc14803e511bcc39878e3d95c6505340b82a1d51574e2b7e',
       i686: 'aac33dd81eea11108a7c54cd07abb284c54e4aa8117234409c72d775f3b6f5f8',
     x86_64: 'df1335f8f222662081b60bae63b43549988b410f92cc3e1d4012c13ea4833769',
  })

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
