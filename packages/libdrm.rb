require 'buildsystems/meson'

class Libdrm < Meson
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org/wiki/'
  version '2.4.134'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mesa/drm.git'
  git_hashtag "libdrm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7cbe970751f964480c7cf2ba0ce9c5ff00f34ca0fa5a73b5bac67f4cd5fe95f2',
     armv7l: '7cbe970751f964480c7cf2ba0ce9c5ff00f34ca0fa5a73b5bac67f4cd5fe95f2',
     x86_64: 'd97ba3bebe269a34042edffea5216e50ec6bc35549b529ce67c46f0e8cea6daa'
  })

  depends_on 'cairo' # R
  depends_on 'eudev' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libpciaccess' => :library
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
