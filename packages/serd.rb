# Adapted from Arch Linux serd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/serd/trunk/PKGBUILD

require 'buildsystems/meson'

class Serd < Meson
  description 'Lightweight C library for RDF syntax supporting reading/ writing Turtle and NTriples.'
  homepage 'https://drobilla.net/software/serd/'
  version '0.32.10'
  license 'ISC'
  compatibility 'all'
  source_url 'https://gitlab.com/drobilla/serd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '867ff2ee7e81661b20dbc1eabf90729e22c99ded136f8df4174a025f83260013',
     armv7l: '867ff2ee7e81661b20dbc1eabf90729e22c99ded136f8df4174a025f83260013',
       i686: '90054e6fe6aaa1cfee1bdf90ad240bc98f265a3ceb0155e9730a8920183ae26c',
     x86_64: '274b67b8ecbcb74b61b8dcd6c98919f87ee48a8c7312dec56821c3cfeed2c55d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Ddocs=disabled \
               -Dtests=disabled'
end
