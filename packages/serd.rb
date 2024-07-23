# Adapted from Arch Linux serd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/serd/trunk/PKGBUILD

require 'buildsystems/meson'

class Serd < Meson
  description 'Lightweight C library for RDF syntax supporting reading/ writing Turtle and NTriples.'
  homepage 'https://drobilla.net/software/serd/'
  version '0.30.16'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/drobilla/serd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7517865bbfacf435e720a96a370691fdda49d6310488685470be3e490ae9997f',
     armv7l: '7517865bbfacf435e720a96a370691fdda49d6310488685470be3e490ae9997f',
       i686: '796328150dad2ed094d157880e6061639406a8d05a2e02713c42b98576cd8e3e',
     x86_64: 'f847accbd3ea06c142673e91d6f7b773ec5b0d70842c63da571aea5741676e4a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  meson_options '-Ddocs=disabled \
               -Dtests=disabled'
end
