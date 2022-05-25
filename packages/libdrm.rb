require 'buildsystems/meson'

class Libdrm < Meson
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.116'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/mesa/drm.git'
  git_hashtag "libdrm-#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.116_armv7l/libdrm-2.4.116-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.116_armv7l/libdrm-2.4.116-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.116_x86_64/libdrm-2.4.116-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f5f75bff60d7739e53866bdb3b35bbd68917d1912de501675130b158d9842b8e',
     armv7l: 'f5f75bff60d7739e53866bdb3b35bbd68917d1912de501675130b158d9842b8e',
     x86_64: 'bc42f499f47df7990980215594125ed6909a85965708aaa03abe817743a063ce'
  })

  depends_on 'cairo' # R
  depends_on 'libpciaccess' # R
  depends_on 'eudev' => :build
  depends_on 'libxslt' => :build
  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  meson_options '-Dfreedreno-kgsl=true \
      -Damdgpu=enabled \
      -Dradeon=enabled \
      -Dnouveau=enabled \
      -Dintel=auto \
      -Dvmwgfx=enabled \
      -Dvc4=auto \
      -Dfreedreno=enabled \
      -Detnaviv=auto \
      -Dexynos=auto \
      -Dtests=false \
      -Dudev=true'
end
