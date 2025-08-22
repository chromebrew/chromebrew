# Adapted from Arch Linux serd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/serd/trunk/PKGBUILD

require 'buildsystems/meson'

class Serd < Meson
  description 'Lightweight C library for RDF syntax supporting reading/ writing Turtle and NTriples.'
  homepage 'https://drobilla.net/software/serd/'
  version '0.32.4'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/drobilla/serd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38d85583c498c541096f98d42f26aec73f895224c693698232d3b93855fe73fe',
     armv7l: '38d85583c498c541096f98d42f26aec73f895224c693698232d3b93855fe73fe',
       i686: 'c560548694dea202ef382be32b0cf6543821131c2099ef02f1897928343ae331',
     x86_64: 'b96b2b4fe1f3200c2c6482300e1b35105f6c9783acd7aace3ab51dcd83cd7f65'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  meson_options '-Ddocs=disabled \
               -Dtests=disabled'
end
