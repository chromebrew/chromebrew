require 'package'

class Avahi < Package
  description 'Avahi is a system which facilitates service discovery on a local network via the mDNS/DNS-SD protocol suite.'
  homepage 'http://www.avahi.org/'
  version '0.8-1'
  compatibility 'all'
  source_url 'https://github.com/lathiat/avahi/releases/download/v0.8/avahi-0.8.tar.gz'
  source_sha256 '060309d7a333d38d951bc27598c677af1796934dbd98e1024e7ad8de798fedda'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '63dc17aedb4b78b919cc5f7cd0b6750173ce42fd0c2c5a134fa26d082d214a4f',
      armv7l: '63dc17aedb4b78b919cc5f7cd0b6750173ce42fd0c2c5a134fa26d082d214a4f',
        i686: '78fba762d54fa7ba3dece48de92b625cbec4b27327a8e3a9c9c73d785cf96a0a',
      x86_64: '69565bde70da558b2b058acf2a4b4e861ba2732176aa7f637ba4e9330722ad00',
  })

  depends_on 'gtk3'
  depends_on 'libdaemon'
  depends_on 'libevent'
  depends_on 'mono' => :build
  depends_on 'qtbase'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
    ./configure \
    #{CREW_OPTIONS} \
    --with-distro=none \
    --disable-python \
    --disable-xmltoman"
    system "sed -i '695d' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
