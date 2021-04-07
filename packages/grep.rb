# Adapted from Arch Linux grep PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/grep/trunk/PKGBUILD

require 'package'

class Grep < Package
  description 'A string search utility'
  homepage 'https://www.gnu.org/software/grep/'
  version '3.6-2'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/grep/grep-3.6.tar.xz'
  source_sha256 '667e15e8afe189e93f9f21a7cd3a7b3f776202f417330b248c2ad4f997d9373e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/grep-3.6-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/grep-3.6-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/grep-3.6-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/grep-3.6-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '668f794614cab844c7e29d4970ea5c1ab0ff15d822dff5c806efd769d81d9097',
     armv7l: '668f794614cab844c7e29d4970ea5c1ab0ff15d822dff5c806efd769d81d9097',
       i686: '25070365f43b5204c58e1830fbf3651a3163013d0c034f27c22bb086d6210032',
     x86_64: 'e232de82d2e313efe7e14f10620471ed25f54ccfb5eeffebde8defead9c20acf'
  })

  depends_on 'pcre'

  def self.build
    system "env CFLAGS='-flto' CXXFLAGS='-flto' \
      LDFLAGS='-flto -Wl,-z,defs -Wl,--no-as-needed -ldl -Wl,--as-needed' \
      CPPFLAGS=-DHAVE_DYNAMIC_LIBPCRE \
      ./configure #{CREW_OPTIONS} \
      --without-included-regex"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
