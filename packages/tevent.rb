# Adapted from Arch Linux tevent PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tevent/trunk/PKGBUILD

require 'package'

class Tevent < Package
  description 'Event system based on the talloc memory management library'
  homepage 'https://tevent.samba.org/'
  version '0.13.0'
  license 'LGPL'
  compatibility 'all'
  source_url "https://samba.org/ftp/tevent/tevent-#{version}.tar.gz"
  source_sha256 'b9437a917fa55344361beb64ec9e0042e99cae8879882a62dd38f6abe2371d0c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.13.0_armv7l/tevent-0.13.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.13.0_armv7l/tevent-0.13.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.13.0_i686/tevent-0.13.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.13.0_x86_64/tevent-0.13.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6882e33fce796b68aea820e56f502a0fbca16b366bcdeedced2b0d11a1e2bc96',
     armv7l: '6882e33fce796b68aea820e56f502a0fbca16b366bcdeedced2b0d11a1e2bc96',
       i686: '6b144a691f72dbc6161dcc6c3a90080aa5a980ae53fe0db79b5365a716fcd780',
     x86_64: '8f7afd3c02a9f6832c0bdae29b9ab629b5aa205433bd0f9f4fbbb617dffa62e9'
  })

  depends_on 'libbsd'
  depends_on 'libxcrypt'
  depends_on 'talloc'
  depends_on 'cmocka' => :build

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
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
