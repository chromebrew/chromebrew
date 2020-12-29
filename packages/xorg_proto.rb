require 'package'

class Xorg_proto < Package
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2020.1-1'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2020.1.tar.bz2'
  source_sha256 '54a153f139035a376c075845dd058049177212da94d7a9707cf9468367b699d2'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '3de61490afe9c9b45ad23abf007109b942e196aed3299f90da7ff6429400b687',
      armv7l: '3de61490afe9c9b45ad23abf007109b942e196aed3299f90da7ff6429400b687',
        i686: '521ca4cca07304bf9c18e050a98ad9fde912b1ecc6c5cf13aa223b969c617d09',
      x86_64: '1ab0f6074972bafa33e78e945958b70c7886c0abff146bc8a020bfc499c7e14f',
  })

  depends_on 'llvm' => ':build'
  
  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dc_args='-fuse-ld=lld' \
      builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end
  
  def self.install
   system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
