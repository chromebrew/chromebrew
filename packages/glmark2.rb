# Adapted from Arch Linux glmark2 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=glmark2

require 'package'

class Glmark2 < Package
  description 'OpenGL ES 2.0 benchmark'
  homepage 'https://github.com/glmark2/glmark2'
  version '2021.12-9057c05'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/glmark2/glmark2/archive/9057c056b6e72d156c0bc7e4b52658e155760222.zip'
  source_sha256 'fd37e6360f03f8ffcd236eb39ee1cb42c487edd0418441c22e375ec5e499297d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glmark2/2021.12-9057c05_armv7l/glmark2-2021.12-9057c05-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glmark2/2021.12-9057c05_armv7l/glmark2-2021.12-9057c05-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glmark2/2021.12-9057c05_i686/glmark2-2021.12-9057c05-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glmark2/2021.12-9057c05_x86_64/glmark2-2021.12-9057c05-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6faaae26b628926374967d5a9b77e0e137af8403608c3a2eb191807b140a2418',
     armv7l: '6faaae26b628926374967d5a9b77e0e137af8403608c3a2eb191807b140a2418',
       i686: 'e1104ae684d7257691eb2c19e556e2547edd8ba464e58634105aeb62a35cb57c',
     x86_64: '8343d0404f69f2b1e064fdd7d8c4675bd2600b8d30cbb6cdaae99f207a6594e3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libdrm'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'wayland'

  def self.build
    system "meson \
      #{CREW_MESON_OPTIONS} \
      -Dflavors=drm-gl,drm-glesv2,wayland-gl,wayland-glesv2,x11-gl,x11-glesv2 \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
