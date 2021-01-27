require 'package'

class Igt_gpu_tools < Package
  description 'Tools for development and testing of the Intel DRM driver'
  homepage 'https://gitlab.freedesktop.org/drm/igt-gpu-tools'
  version '1.25'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/releases/individual/app/igt-gpu-tools-1.25.tar.xz'
  source_sha256 '40454d8f0484ea2477862007398a08eef78a6c252c4defce1c934548593fdd11'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/igt_gpu_tools-1.25-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/igt_gpu_tools-1.25-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/igt_gpu_tools-1.25-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/igt_gpu_tools-1.25-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '51336627a5f9bb5a662785bbf5dff89a9be2b61b76a8c1312802ba2d1321539a',
      armv7l: '51336627a5f9bb5a662785bbf5dff89a9be2b61b76a8c1312802ba2d1321539a',
        i686: '367feaaf23ac996aef045a1749c4ade02297270cb2cfef325e132d965ffcb675',
      x86_64: '83df59cfaf3e9c45f268b752ff3e7df823f367744a72d2b09c53ecc13f467ec4',
  })

  depends_on 'libdrm'
  depends_on 'libpciaccess'
  depends_on 'cairo'
  depends_on 'libxrandr'
  depends_on 'procps'
  depends_on 'libkmod'
  depends_on 'libxv'
  depends_on 'libunwind'
  depends_on 'peg'
  depends_on 'swig' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'util_macros' => ':build'
  depends_on 'xorg_proto' => ':build'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dc_link_args='-fuse-ld=lld' \
    -Db_asneeded=false \
    -Ddocs=disabled \
    -Dtests=disabled \
    -Doping=disabled \
    -Drunner=disabled \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end
  
  def self.install
      system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
