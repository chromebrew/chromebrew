require 'package'

class Avahi < Package
  description 'Avahi is a system which facilitates service discovery on a local network via the mDNS/DNS-SD protocol suite.'
  homepage 'http://www.avahi.org/'
  version '0.8-3'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/lathiat/avahi/releases/download/v0.8/avahi-0.8.tar.gz'
  source_sha256 '060309d7a333d38d951bc27598c677af1796934dbd98e1024e7ad8de798fedda'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/avahi-0.8-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/avahi-0.8-3-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/avahi-0.8-3-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/avahi-0.8-3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1a2f3f2f1963ff4843ecf2212eaca985368d26ef532f953a68020c1518db0dcf',
     armv7l: '1a2f3f2f1963ff4843ecf2212eaca985368d26ef532f953a68020c1518db0dcf',
       i686: 'ca7e9694328710e7b14c22b5d0dd488363303cabca6d7e2ef5f82f484f56d666',
     x86_64: 'a9b2f76d80af5ebd527cff54f928437f454824b7e5eda102fa7d1c568bb73063'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'dbus'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'harfbuzz'
  depends_on 'libcap'
  depends_on 'libdaemon'
  depends_on 'libevent'
  depends_on 'libjpeg'
  depends_on 'mono' => :build
  depends_on 'pango'
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
