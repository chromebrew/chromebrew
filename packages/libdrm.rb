require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  @_ver = '2.4.112'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/drm.git'
  git_hashtag "libdrm-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.112_armv7l/libdrm-2.4.112-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.112_armv7l/libdrm-2.4.112-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.112_i686/libdrm-2.4.112-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.112_x86_64/libdrm-2.4.112-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '80aaba199fd6f8c788e07cb1dc1d77b77318d810d7d7593a24d7d422d927b798',
     armv7l: '80aaba199fd6f8c788e07cb1dc1d77b77318d810d7d7593a24d7d422d927b798',
       i686: '280ee9624f654a35e16f77a053488e13d9b1f2e7f51b1c060abb286636c76749',
     x86_64: '6f0aca30b18bd101dcc1e38d888e2c734b260291a9d2d19076dd540919ed0cdd'
  })

  depends_on 'libpciaccess' # R
  depends_on 'xorg_lib' => :build
  depends_on 'eudev' => :build
  depends_on 'libxslt' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dfreedreno-kgsl=true \
      -Damdgpu=true \
      -Dradeon=true \
      -Dnouveau=true \
      -Dintel=true \
      -Dvmwgfx=true \
      -Dvc4=true \
      -Dfreedreno=true \
      -Detnaviv=true \
      -Dexynos=true \
      -Dudev=true \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
