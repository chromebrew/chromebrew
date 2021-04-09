require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.11.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/intel/libva/archive/refs/tags/#{@_ver}.tar.gz"
  source_sha256 'ee2bd79bad5e2404143f089360685f5da63a32dd551b54ccd61d2d49c041178a'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.11.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.11.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.11.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.11.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4af41d8c10b335f1b00bbfa9c4afcea07bbb0b7d00acd3a18a0c007592302a4a',
     armv7l: '4af41d8c10b335f1b00bbfa9c4afcea07bbb0b7d00acd3a18a0c007592302a4a',
       i686: '49938688385785511cca5cdd3d5354a0e1a227538fd7a1dfec4588dbd9af90b5',
     x86_64: 'fcdd6886cfacef1a4e3e31448bf469f78233993a1376c1c4255314d7355c1eed'
  })

  depends_on 'libdrm'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'mesa'
  depends_on 'wayland'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --default-library=both \
    -Db_lto=true \
    -Db_pie=true \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
