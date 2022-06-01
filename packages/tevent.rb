# Adapted from Arch Linux tevent PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tevent/trunk/PKGBUILD

require 'package'

class Tevent < Package
  description 'Event system based on the talloc memory management library'
  homepage 'https://tevent.samba.org/'
  version '0.11.0'
  license 'LGPL'
  compatibility 'all'
  source_url "https://samba.org/ftp/tevent/tevent-#{version}.tar.gz"
  source_sha256 'ee9a86c8e808aac2fe1e924eaa139ff7f0269d0e8e4fafa850ae5c7489bc82ba'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.11.0_armv7l/tevent-0.11.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.11.0_armv7l/tevent-0.11.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.11.0_i686/tevent-0.11.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.11.0_x86_64/tevent-0.11.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9a72a1bbba9fdb0d298b91b687f2457b216d4b961649d1f8dbacd75a5b1e96ab',
     armv7l: '9a72a1bbba9fdb0d298b91b687f2457b216d4b961649d1f8dbacd75a5b1e96ab',
       i686: 'd1d1947c895da8b5aad1fe8241de4e20d7d5f176adc0b9803151eb426615ed4f',
     x86_64: '3939c1757d7eded3e66c70ba63a00c6cd37390bd1e1ac02da00a33916f13f0af'
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
