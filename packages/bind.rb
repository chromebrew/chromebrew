require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.12.1-p2'
  source_url 'https://www.isc.org/downloads/file/bind-9-12-1-p2/?version=tar-gz'
  source_sha256 '0de7c3453461e2f0505ac634b984f8e7afa1952cf7fc972cbefbcc169edf2d29'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.1-p2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.1-p2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.1-p2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.1-p2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f2822175252af8487a38831585e5d5dfc8f4c5e40645681fcc4ca41df10fded',
     armv7l: '8f2822175252af8487a38831585e5d5dfc8f4c5e40645681fcc4ca41df10fded',
       i686: 'e9f2a68b7ed4d5c39bb42044c2dc5f68c78d5e5749bcf384d32bb26a178a527e',
     x86_64: '78691fbd7abba5a0802a88f9caaef1efdc0845f7b92b80887fd72a1b01c743b6',
  })

  depends_on 'openssl'
  depends_on 'libcap'
  depends_on 'libseccomp'
  depends_on 'readline'

  def self.build
    system "BUILD_CC=gcc ./configure \
                --with-randomdev=no \
                --with-ecdsa=yes \
                --with-gost=yes \
                --with-seccomp \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
