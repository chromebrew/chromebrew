require 'package'

class Avahi < Package
  description 'Avahi is a system which facilitates service discovery on a local network via the mDNS/DNS-SD protocol suite.'
  homepage 'http://www.avahi.org/'
  version '0.8-2'
  compatibility 'all'
  source_url 'https://github.com/lathiat/avahi/releases/download/v0.8/avahi-0.8.tar.gz'
  source_sha256 '060309d7a333d38d951bc27598c677af1796934dbd98e1024e7ad8de798fedda'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/avahi-0.8-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f37472d2cacfb5bcb342209d43938ac578dfa37de30662d8b73a74d386a60d83',
     armv7l: 'f37472d2cacfb5bcb342209d43938ac578dfa37de30662d8b73a74d386a60d83',
       i686: '2e77803a7d2dca48ad76c0ee08544008ea330ec1824db4600766a2f968a3ced5',
     x86_64: 'de20f11d7e0d269f7940a0b75cd9647e55ccaac1bb49a05b383b16561318a6af'
  })

  depends_on 'gtk3'
  depends_on 'libdaemon'
  depends_on 'libevent'
  depends_on 'mono' => :build
  depends_on 'qtbase'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --with-dbus-sys=#{CREW_PREFIX}/share/dbus-1 \
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
