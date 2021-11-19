require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  @_ver = '2.4.108'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/drm.git'
  git_hashtag "libdrm-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.108_armv7l/libdrm-2.4.108-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.108_armv7l/libdrm-2.4.108-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.108_i686/libdrm-2.4.108-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.108_x86_64/libdrm-2.4.108-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b6365349d8e1bcbec7f943c744c5595ac0cfa3e00e4196efed9fa79c307a6cfa',
     armv7l: 'b6365349d8e1bcbec7f943c744c5595ac0cfa3e00e4196efed9fa79c307a6cfa',
       i686: '974294e7d4d43554d1af048ed197d5ce52873a256c6b09c00364fffda4767031',
     x86_64: '0e2520f4dff148baab2c9f8649093e6422c1596613c755662d1b9bdcb0fb8c16'
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
      -Dlibkms=true \
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
