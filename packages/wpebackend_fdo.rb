require 'package'

class Wpebackend_fdo < Package
  description 'Freedesktop.org backend for WPE WebKit'
  homepage 'https://wpewebkit.org'
  version '1.14.0'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://github.com/Igalia/WPEBackend-fdo/releases/download/#{version}/wpebackend-fdo-#{version}.tar.xz"
  source_sha256 'e75b0cb2c7145448416e8696013d8883f675c66c11ed750e06865efec5809155'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wpebackend_fdo/1.14.0_armv7l/wpebackend_fdo-1.14.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wpebackend_fdo/1.14.0_armv7l/wpebackend_fdo-1.14.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wpebackend_fdo/1.14.0_i686/wpebackend_fdo-1.14.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wpebackend_fdo/1.14.0_x86_64/wpebackend_fdo-1.14.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8bf04acd2a0086a4dfd8376829577d00de7366cd4304383d65bf2226d05449de',
     armv7l: '8bf04acd2a0086a4dfd8376829577d00de7366cd4304383d65bf2226d05449de',
       i686: 'fb3fc5fdccd6f30b40860574f098d194e3c6b67dd5ee116784ecadacbda4bd83',
     x86_64: '2f878e911a8b013af12f05680f5c894b1e23b5c04301a8d936ff55993387a6c4'
  })

  depends_on 'libwpe'
  depends_on 'wayland'
  depends_on 'libepoxy'
  depends_on 'mesa' => :build
  depends_on 'wayland_protocols' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
