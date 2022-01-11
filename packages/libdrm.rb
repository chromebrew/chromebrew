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
    aarch64: '3661c7f7e58a7f9ce46545b32a26d917d77fbed1a23f0c266710a5acfb9710a1',
     armv7l: '3661c7f7e58a7f9ce46545b32a26d917d77fbed1a23f0c266710a5acfb9710a1',
       i686: '52183d84631bb78959238f9ffeb3695ea95b90089f7e0c6b1a80157c66ad810e',
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
