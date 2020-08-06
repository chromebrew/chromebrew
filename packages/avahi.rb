require 'package'

class Avahi < Package
  description 'Avahi is a system which facilitates service discovery on a local network via the mDNS/DNS-SD protocol suite.'
  homepage 'http://www.avahi.org/'
  version '0.8'
  compatibility 'all'
  source_url 'https://github.com/lathiat/avahi/releases/download/v0.8/avahi-0.8.tar.gz'
  source_sha256 '060309d7a333d38d951bc27598c677af1796934dbd98e1024e7ad8de798fedda'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f16034a97b70af23483fdbe9d498fce189c51bcc1eacdc79f6f4e0e8f97a87b9',
     armv7l: 'f16034a97b70af23483fdbe9d498fce189c51bcc1eacdc79f6f4e0e8f97a87b9',
       i686: '890033e6bb8f16878b4835839e1191ca7e58e0a104fc373957ee5288789f3622',
     x86_64: 'ed4fcf10b5e53ab00559daa71c7f01894ee5baeb482b826a96badb88894a6f00',
  })

  depends_on 'gtk3'
  depends_on 'libdaemon'
  depends_on 'libevent'
  depends_on 'mono'
  depends_on 'qtbase'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-distro=none --disable-python --disable-xmltoman"
    system "sed -i '695d' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
