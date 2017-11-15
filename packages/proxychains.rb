require 'package'

class Proxychains < Package
  description 'a tool that forces any TCP connection made by any given application to follow through proxy like TOR or any other SOCKS4, SOCKS5 or HTTP(S) proxy.'
  homepage 'https://github.com/haad/proxychains'
  version '4.2.0'
  source_url 'https://github.com/haad/proxychains/archive/proxychains-4.2.0.tar.gz'
  source_sha256 '225284e5553fb062d09ed425d2815387eda9c1c0d6e2bc24ea95393a71601619'
  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "install -Dm644 src/proxychains.conf #{CREW_DEST_PREFIX}/$HOME/.proxychains/proxychains.conf"
    system "install -Dm644 src/proxychains.conf #{CREW_DEST_PREFIX}/etc/proxychains.conf"
    system "mkdir -p HOME/.proxychains && cp src/proxychains.conf $HOME/.proxychains"
    system "install -Dm755 src/proxyresolv #{CREW_DEST_PREFIX}/bin/proxyresolv"
  end
end
