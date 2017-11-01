require 'package'

class Libpcap < Package
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'http://www.tcpdump.org/'
  version '1.8.1'
  source_url 'http://www.tcpdump.org/release/libpcap-1.8.1.tar.gz'
  source_sha256 '673dbc69fdc3f5a86fb5759ab19899039a8e5e6c631749e48dcd9c6f0c83541e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '57f0b495ced6405ba67eca89c903b20149f5bf215b8c6b1af4310fb844b28d3e',
     armv7l: '57f0b495ced6405ba67eca89c903b20149f5bf215b8c6b1af4310fb844b28d3e',
       i686: '383a5f4aa5b2c0149389901ec7e55411eb1c374e72763861380407e638683a42',
     x86_64: '99f2ef9fdc4b6fc1bb3eb60909f30c285973e17c7830f57ee7d4421f819c7d4f',
  })

  depends_on "buildessential"
  depends_on "bison"
  depends_on "flex"

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
