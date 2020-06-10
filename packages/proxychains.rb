require 'package'

class Proxychains < Package
  description 'a tool that forces any TCP connection made by any given application to follow through proxy like TOR or any other SOCKS4, SOCKS5 or HTTP(S) proxy.'
  homepage 'https://github.com/haad/proxychains'
  version '4.2.0'
  compatibility 'all'
  source_url 'https://github.com/haad/proxychains/archive/proxychains-4.2.0.tar.gz'
  source_sha256 '225284e5553fb062d09ed425d2815387eda9c1c0d6e2bc24ea95393a71601619'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/proxychains-4.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/proxychains-4.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/proxychains-4.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/proxychains-4.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '570e3bbbc4ef4429d409c65b1bb434b8fa5178f62c156c7f40390ffa7560ad63',
     armv7l: '570e3bbbc4ef4429d409c65b1bb434b8fa5178f62c156c7f40390ffa7560ad63',
       i686: 'c91eac05feaf24420161f659b9bfea4d9caba0ffb8710945b2e483187aa259f3',
     x86_64: 'f5de3f217b624363140f63e68bf188ff8b8de93f18b3af946b51a62a8c0c3271',
  })
  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "install -Dm644 src/proxychains.conf #{CREW_DEST_PREFIX}/$HOME/.proxychains/proxychains.conf"
    system "install -Dm644 src/proxychains.conf #{CREW_DEST_PREFIX}/etc/proxychains.conf"
    system "mkdir -p HOME/.proxychains && cp src/proxychains.conf $HOME/.proxychains"
    system "install -Dm755 src/proxyresolv #{CREW_DEST_PREFIX}/bin/proxyresolv"
  end
end
