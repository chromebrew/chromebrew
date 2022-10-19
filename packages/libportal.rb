require 'package'

class Libportal < Package
  description 'libportal provides GIO-style async APIs for most Flatpak portals.'
  homepage 'https://github.com/flatpak/libportal'
  version '0.6'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/flatpak/libportal/archive/refs/tags/0.6.tar.gz'
  source_sha256 '8ad326c4f53b7433645dc86d994fef0292bee8adda0fe67db9288ace19250a9c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libportal/0.6_armv7l/libportal-0.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libportal/0.6_armv7l/libportal-0.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libportal/0.6_i686/libportal-0.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libportal/0.6_x86_64/libportal-0.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ffcc479aa9f1f35c7a1eed561747c47b2f31ddd3759f493f20eb6e28fb4b758f',
     armv7l: 'ffcc479aa9f1f35c7a1eed561747c47b2f31ddd3759f493f20eb6e28fb4b758f',
       i686: 'e79d01cac8cbbc184c3841b3f36140cc7fc3b456f2b29603abf5340d43cdd877',
     x86_64: 'f822756f637dc88f311b75b4cff26e2ad7ccf4b22232712c2072aac64bb4a286'
  })

  depends_on 'gobject_introspection'
  depends_on 'gtk4'
  depends_on 'glib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dbackends=gtk4 \
    -Ddocs=false \
    -Dportal-tests=false \
    -Dtests=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
