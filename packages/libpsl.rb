require 'package'

class Libpsl < Package
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  @_ver = '0.21.1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/rockdaboot/libpsl/releases/download/#{@_ver}/libpsl-#{@_ver}.tar.lz"
  source_sha256 '644375d557bb3b84c485df2dae98ee388fe1e11fb75230004e4b8623b3b833a9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.21.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.21.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.21.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.21.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9b8376e9c1b5e65363e0c4a7ad61721930e07dbaa032c76455723186d6268d47',
     armv7l: '9b8376e9c1b5e65363e0c4a7ad61721930e07dbaa032c76455723186d6268d47',
       i686: 'c5d298373d73a26ecd8559254f00286f14e129a09dbe13f94252356a332fc172',
     x86_64: 'e8c7a5c5f46be4ff1158d5d643a3efa14fcf008f4f6af906703612b907c9e725'
  })

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Ddocs=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
