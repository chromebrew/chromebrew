# Adapted from Arch Linux tevent PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tevent/trunk/PKGBUILD

require 'package'

class Tevent < Package
  description 'Event system based on the talloc memory management library'
  homepage 'https://tevent.samba.org/'
  version '0.10.2'
  license 'LGPL'
  compatibility 'all'
  source_url "https://samba.org/ftp/tevent/tevent-#{version}.tar.gz"
  source_sha256 'f8427822e5b2878fb8b28d6f50d96848734f3f3130612fb574fdd2d2148a6696'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tevent-0.10.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tevent-0.10.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tevent-0.10.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tevent-0.10.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2a34abbf8f8619fec618d0f08e692d61065c8fcc5ef37cf7a1bf64415709ea4f',
     armv7l: '2a34abbf8f8619fec618d0f08e692d61065c8fcc5ef37cf7a1bf64415709ea4f',
       i686: '112a2a38a8be799e12f6de9691607f4de08e2a6da39359dd37470fb0456d8788',
     x86_64: 'd7a762d732c98a074eabfc1367e7ce0330511a8713a4cea36c262d62c31c89f0'
  })

  depends_on 'libbsd'
  depends_on 'libxcrypt'
  depends_on 'talloc'

  def self.build
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --bundled-libraries=NONE \
      --builtin-libraries=replace"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
