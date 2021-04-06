# Adapted from Arch Linux grep PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/grep/trunk/PKGBUILD

require 'package'

class Grep < Package
  description 'A string search utility'
  homepage 'https://www.gnu.org/software/grep/'
  version '3.6-1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/grep/grep-3.6.tar.xz'
  source_sha256 '667e15e8afe189e93f9f21a7cd3a7b3f776202f417330b248c2ad4f997d9373e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/grep-3.6-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/grep-3.6-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/grep-3.6-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/grep-3.6-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '15c5b97f4a77e1253220a259670d674a19e470db88a0148d79dfd6b48a74ccfa',
     armv7l: '15c5b97f4a77e1253220a259670d674a19e470db88a0148d79dfd6b48a74ccfa',
       i686: 'c732e8f7ce7e218553628203356d031d5a022d7a718ffa7b5529344edacead9b',
     x86_64: 'bcb9d3d7f541fbd54170b9479a48ecb0c567a0e946a6733e1817f17f813e9260'
  })

  depends_on 'pcre'

  def self.build
    system "env CFLAGS='-flto' CXXFLAGS='-flto' LDFLAGS='-flto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
