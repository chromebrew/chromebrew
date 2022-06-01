require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  @_ver = '2.4.110'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/drm.git'
  git_hashtag "libdrm-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.110_armv7l/libdrm-2.4.110-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.110_armv7l/libdrm-2.4.110-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.110_i686/libdrm-2.4.110-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.110_x86_64/libdrm-2.4.110-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '17358ed1f87950f483410a3079757d77c7d62f8893571b61e4b93a24e0f50b9a',
     armv7l: '17358ed1f87950f483410a3079757d77c7d62f8893571b61e4b93a24e0f50b9a',
       i686: 'b9dff811d3f6a7fc04e2abb259d1e3f1f5486b1609d21e2cd11f5d31435f472e',
     x86_64: '64ff40876627b172d3d3a92d641e38bffebb4363a52cb1dbc281f09afa0863a1'
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
