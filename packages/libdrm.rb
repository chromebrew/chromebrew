require 'buildsystems/meson'

class Libdrm < Meson
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org/wiki/'
  version '2.4.125'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mesa/drm.git'
  git_hashtag "libdrm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1aa5a712083e22855d10bced36108a8b889822ae30892325473f77bf6f696097',
     armv7l: '1aa5a712083e22855d10bced36108a8b889822ae30892325473f77bf6f696097',
     x86_64: '9497a56d0180c74ce217e0654dbecced4d62930d2a53461f4f116d755520164b'
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
