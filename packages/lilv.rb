# Adapted from Arch Linux lilv PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lilv/trunk/PKGBUILD

require 'buildsystems/meson'

class Lilv < Meson
  description 'A C library interface to the LV2 plug-in standard'
  homepage 'https://drobilla.net/software/lilv/'
  version "0.24.20-#{CREW_PY_VER}"
  license 'isc'
  compatibility 'all'
  source_url 'https://github.com/lv2/lilv.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44d5137303bd635b344b91a01dd280cc7da0ff04b14011453b5af74e544f8761',
     armv7l: '44d5137303bd635b344b91a01dd280cc7da0ff04b14011453b5af74e544f8761',
       i686: 'afa02806f28bcb43ab4d40f413bbec0e249012ac6c47ca0f9aa1d977b3c84e91',
     x86_64: 'fefa28b2fcf93f8af004c3e77b283b280ac4e04814e266ae5e19a882b5504682'
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
