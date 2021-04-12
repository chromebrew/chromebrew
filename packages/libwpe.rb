require 'package'

class Libwpe < Package
  description 'General-purpose library for WPE WebKit'
  homepage 'https://wpewebkit.org'
  @_ver = '1.10.0'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url "https://github.com/WebPlatformForEmbedded/libwpe/releases/download/#{@_ver}/libwpe-#{@_ver}.tar.xz"
  source_sha256 '2415e270d45e3595ed4052bc105f733744dc2d3677e12ff4a831e5029841084d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.10.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.10.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.10.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.10.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '44c64f96d2051025c83162c7a556400156eb8657fb4965a1da8f3d6919e44d47',
     armv7l: '44c64f96d2051025c83162c7a556400156eb8657fb4965a1da8f3d6919e44d47',
       i686: '4f376503f92ed5e655fcef91ec6518fb147250a352f59b941f52797eadadcfdc',
     x86_64: 'f7bf29748a591772836b70aa213e1c8dc67236c7ea3f2ea72717bfe928a39d69'
  })

  depends_on 'libxkbcommon'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
