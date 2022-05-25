require 'package'

class Avahi < Package
  description 'Avahi is a system which facilitates service discovery on a local network via the mDNS/DNS-SD protocol suite.'
  homepage 'http://www.avahi.org/'
  version '0.8-4'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/lathiat/avahi/releases/download/v0.8/avahi-0.8.tar.gz'
  source_sha256 '060309d7a333d38d951bc27598c677af1796934dbd98e1024e7ad8de798fedda'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avahi/0.8-4_armv7l/avahi-0.8-4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avahi/0.8-4_armv7l/avahi-0.8-4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avahi/0.8-4_i686/avahi-0.8-4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avahi/0.8-4_x86_64/avahi-0.8-4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '44967482fa6955e784d164cbfa534d54c3498705c71a12748fdfc4dc865ea8b6',
     armv7l: '44967482fa6955e784d164cbfa534d54c3498705c71a12748fdfc4dc865ea8b6',
       i686: '913d8179d378520eea8b1788d5261cd6fc9f31936dc4f123a3212e6fba7dc1fb',
     x86_64: '7eebce85f0689787cbc42121b9f0052a7b9153f92a8cbbba233badf6dba9a839'
  })

  depends_on 'dbus' # R
  depends_on 'glib' # R
  depends_on 'libcap' => :build
  depends_on 'libdaemon' # R
  depends_on 'libevent' # R

  def self.build
    system "./configure \
      #{CREW_OPTIONS} \
      --with-dbus-sys=#{CREW_PREFIX}/share/dbus-1 \
      --with-distro=none \
      --disable-mono \
      --disable-monodoc \
      --disable-gtk \
      --disable-gtk3 \
      --disable-qt3 \
      --disable-qt4 \
      --disable-qt5 \
      --disable-python \
      --disable-xmltoman"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
