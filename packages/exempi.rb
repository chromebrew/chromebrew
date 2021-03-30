# Adapted from Arch Linux exempi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/exempi/trunk/PKGBUILD

require 'package'

class Exempi < Package
  description 'A library to parse XMP metadata'
  homepage 'https://libopenraw.freedesktop.org/wiki/Exempi'
  version '2.5.2'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/libopenraw/exempi/-/archive/#{version}/exempi-#{version}.tar.bz2"
  source_sha256 'dff105f53bdd971e633b7fcb3bcfb22276716228a9e6063c1fd241a8542b9cec'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/exempi-2.5.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/exempi-2.5.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/exempi-2.5.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/exempi-2.5.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9f9699c46f95394aaaf6b116f7984c6dbfdbcd258698624baace212458391e67',
     armv7l: '9f9699c46f95394aaaf6b116f7984c6dbfdbcd258698624baace212458391e67',
       i686: 'bc0706d7dc3acc174fbb38e98bf50a88039b8bb10bd601f5d99bc63ef2c4ac6a',
     x86_64: '37746a7eb30fd9de6779d1f5426adba4f961c720415f20ff374ff3a700a7f523'
  })

  depends_on 'boost' => :build
  depends_on 'autoconf_archive' => :build

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    system "install -Dm644 COPYING #{CREW_DEST_DIR}/usr/share/licenses/exempi/LICENSE"
  end
end
