# Adapted from Arch Linux serd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/serd/trunk/PKGBUILD

require 'buildsystems/meson'

class Serd < Meson
  description 'Lightweight C library for RDF syntax supporting reading/ writing Turtle and NTriples.'
  homepage 'https://drobilla.net/software/serd/'
  version '0.32.6'
  license 'ISC'
  compatibility 'all'
  source_url 'https://gitlab.com/drobilla/serd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d1831972011cc46c6b3cf637b3c1c54ef94faa759347fe2164bbb71a0325222',
     armv7l: '6d1831972011cc46c6b3cf637b3c1c54ef94faa759347fe2164bbb71a0325222',
       i686: '2f796221760aa569a9ad8a3b427922be7a28d9ad94eed2f2691e0650d6e25d36',
     x86_64: '6634f452021fb6a61a7c1b6a0df5eeea85c7dea06ec9c97bd2779097f875bc0c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  meson_options '-Ddocs=disabled \
               -Dtests=disabled'
end
