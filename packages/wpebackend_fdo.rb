require 'package'

class Wpebackend_fdo < Package
  description 'Freedesktop.org backend for WPE WebKit'
  homepage 'https://wpewebkit.org'
  @_ver = '1.8.4'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url "https://github.com/Igalia/WPEBackend-fdo/releases/download/#{@_ver}/wpebackend-fdo-#{@_ver}.tar.xz"
  source_sha256 'def59bed5e8cdabb65ffa76ee2eef349fba7b42a75dac80f3da5954b17f4074a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wpebackend_fdo/1.8.4_armv7l/wpebackend_fdo-1.8.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wpebackend_fdo/1.8.4_armv7l/wpebackend_fdo-1.8.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wpebackend_fdo/1.8.4_i686/wpebackend_fdo-1.8.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wpebackend_fdo/1.8.4_x86_64/wpebackend_fdo-1.8.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fe50fe41d14a69954f6df24f77f4a86ed123c62c07cecbd9e20881b22ec8a4b6',
     armv7l: 'fe50fe41d14a69954f6df24f77f4a86ed123c62c07cecbd9e20881b22ec8a4b6',
       i686: 'df008b94ea6fc3172ba993d5aab760f92659bbdfe022a012d20837cf35a242ab',
     x86_64: '8da6d976164abe12aaea42e61d57dfab772639fffa954305c9b9e59889d09f8d'
  })

  depends_on 'libwpe'
  depends_on 'wayland'
  depends_on 'libepoxy'
  depends_on 'mesa' => :build
  depends_on 'wayland_protocols' => :build

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
