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
    aarch64: '2de9e306a8fad2d5b8195ee0f5e565dc94e8077276789e847cfcfd43a898c092',
     armv7l: '2de9e306a8fad2d5b8195ee0f5e565dc94e8077276789e847cfcfd43a898c092',
     x86_64: '2f8bf25102126b735994f349cb61d80ba9fd847def680903dac18fabe5c47e1a'
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
