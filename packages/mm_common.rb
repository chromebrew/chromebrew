require 'package'

class Mm_common < Package
  description 'Common build files of the C++ bindings'
  homepage 'http://www.gtkmm.org/'
  @_ver = '1.0.4'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/GNOME/mm-common/archive/#{@_ver}.tar.gz"
  source_sha256 'a4120f37145805dd45695bc8b33c9c466eea6f91bdc5a8a5197276ae7d9f42e0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.4_armv7l/mm_common-1.0.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.4_armv7l/mm_common-1.0.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.4_i686/mm_common-1.0.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.4_x86_64/mm_common-1.0.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9d932933fd7d8c705d4917baaf64e16a6204da03c7b99b2a927ce867b3486c5d',
     armv7l: '9d932933fd7d8c705d4917baaf64e16a6204da03c7b99b2a927ce867b3486c5d',
       i686: 'ba1b1dfcc78d3a51af070ac6fc47453ed6c89276becf9e41e1defd551bbcb9c6',
     x86_64: '7b3e6e1f8ea7df0ead6b3320a69bd6e7c9999d0542bb83b33cd58fcdcf044cdb'
  })

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Duse-network=true \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
