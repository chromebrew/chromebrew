# Adapted from Arch Linux exempi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/exempi/trunk/PKGBUILD

require 'package'

class Exempi < Package
  description 'A library to parse XMP metadata'
  homepage 'https://libopenraw.freedesktop.org/wiki/Exempi'
  @_ver = '2.5.2'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/libopenraw/exempi/-/archive/#{@_ver}/exempi-#{@_ver}.tar.bz2"
  source_sha256 'dff105f53bdd971e633b7fcb3bcfb22276716228a9e6063c1fd241a8542b9cec'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.5.2-1_armv7l/exempi-2.5.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.5.2-1_armv7l/exempi-2.5.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.5.2-1_i686/exempi-2.5.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.5.2-1_x86_64/exempi-2.5.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '551b3b9ea9078d1ace55df7014d34863ce4708e273cc336ce165775dc6e34c30',
     armv7l: '551b3b9ea9078d1ace55df7014d34863ce4708e273cc336ce165775dc6e34c30',
       i686: '5bb4594a18f52103b41d6a9be9c9729d485b68e302cf3ac5afbbb5a150f58384',
     x86_64: 'fd2cb5b92e6b19a1897ace6d32cb608748d963776011923e41c2580061bbd46c'
  })

  depends_on 'boost' => :build
  depends_on 'autoconf_archive' => :build

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
