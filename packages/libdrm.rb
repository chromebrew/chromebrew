require 'buildsystems/meson'

class Libdrm < Meson
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.120'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/mesa/drm.git'
  git_hashtag "libdrm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c91745b09ab0be5a92704565cbbc16bff8a2397d9d7638349a0b2bb90d1c346',
     armv7l: '1c91745b09ab0be5a92704565cbbc16bff8a2397d9d7638349a0b2bb90d1c346',
     x86_64: 'd6ba50ad22ddfdf576fc544a8e164a68fa8e543c13bea9bc654231b00db0a975'
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
