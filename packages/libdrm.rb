require 'buildsystems/meson'

class Libdrm < Meson
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org/wiki/'
  version '2.4.129'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mesa/drm.git'
  git_hashtag "libdrm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd0288ac1d183f2a0843dc3a7b02fb2cf502479c7aafb600712f95bdd895277d1',
     armv7l: 'd0288ac1d183f2a0843dc3a7b02fb2cf502479c7aafb600712f95bdd895277d1',
     x86_64: 'b75974174c512ef5956640fb43566319ab1a4bba8c6dfd41520449ff764e9d93'
  })

  depends_on 'cairo' # R
  depends_on 'eudev' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libpciaccess' # R
  depends_on 'libxslt' => :build

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
