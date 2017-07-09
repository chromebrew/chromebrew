require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.10.5-p3'
  source_url 'https://www.isc.org/downloads/file/9-10-5-p3/?version=tar-gz'
  source_sha256 '8d7e96b5b0bbac7b900d4c4bbb82e0956b4e509433c5fa392bb72a929b96606a'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/bind-9.10.5-p3-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/bind-9.10.5-p3-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/bind-9.10.5-p3-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/bind-9.10.5-p3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5d0ffc0fdfadccb9f838730797e645c249444abb077e5b3d05ad8f0a8241924f',
     armv7l: '5d0ffc0fdfadccb9f838730797e645c249444abb077e5b3d05ad8f0a8241924f',
       i686: '8d52384957c720b527650357ad3e5fd3732fbcae2083613c68993b913f603855',
     x86_64: '3ca89eb998a259f393920174ac2bd1427465101eeb2a9cc8dcb5a880bbe0e4e0',
  })

  depends_on "buildessential"
  depends_on "openssl"
  depends_on "libcap"
  depends_on "readline"
  depends_on "diffutils"

  def self.build
    system "BUILD_CC=gcc ./configure --with-randomdev=no --with-ecdsa=yes --with-gost=yes --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
