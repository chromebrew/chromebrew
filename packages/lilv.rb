# Adapted from Arch Linux lilv PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lilv/trunk/PKGBUILD

require 'buildsystems/meson'

class Lilv < Meson
  description 'A C library interface to the LV2 plug-in standard'
  homepage 'https://drobilla.net/software/lilv/'
  @_ver = '0.24.20'
  version "#{@_ver}-#{CREW_PY_VER}"
  license 'isc'
  compatibility 'all'
  source_url 'https://github.com/lv2/lilv.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ada5368cf318ffaf417ed2a3ad79ad3981fe8a2b360e4f53cae6f709493c2351',
     armv7l: 'ada5368cf318ffaf417ed2a3ad79ad3981fe8a2b360e4f53cae6f709493c2351',
       i686: '676dd2b3f734beac11dd153cc6aa5dc45834579727cbf9a44203ded0ac739b77',
     x86_64: 'd8afc26bb659d79ad2821eba2e60ddf71504f7da5e357ca47ea4cef3fffcf4d9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libsndfile' # R
  depends_on 'lv2' # L
  depends_on 'python3' => :build
  depends_on 'serd' # R
  depends_on 'sord' # R
  depends_on 'sratom' # R

  meson_options '-Ddocs=disabled \
               -Dtests=disabled'
end
