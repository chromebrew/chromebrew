# Adapted from Arch Linux libnfs PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libnfs/trunk/PKGBUILD

require 'package'

class Libnfs < Package
  description 'client library for accessing NFS shares'
  homepage 'https://github.com/sahlberg/libnfs'
  version '4.0.0'
  license 'GPLv2 & BSD'
  compatibility 'all'
  source_url "https://github.com/sahlberg/libnfs/archive/libnfs-#{version}.tar.gz"
  source_sha256 '6ee77e9fe220e2d3e3b1f53cfea04fb319828cc7dbb97dd9df09e46e901d797d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnfs-4.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnfs-4.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnfs-4.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnfs-4.0.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c8aca50954bfbdf85d749655c98d940592cb0f0059375b0142974196a4eb1066',
     armv7l: 'c8aca50954bfbdf85d749655c98d940592cb0f0059375b0142974196a4eb1066',
       i686: 'a0efe68bbed97a19e0708c412b6ffc1ae2aa2d3e34b006e59b432218659d6e33',
     x86_64: '5d51982578b523c791aa1cd4a6903603a41c75d7abfcfbc96aabab0c6fb8adf0'
  })

  def self.build
    system 'autoreconf -vif'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
