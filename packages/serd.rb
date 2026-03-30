# Adapted from Arch Linux serd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/serd/trunk/PKGBUILD

require 'buildsystems/meson'

class Serd < Meson
  description 'Lightweight C library for RDF syntax supporting reading/ writing Turtle and NTriples.'
  homepage 'https://drobilla.net/software/serd/'
  version '0.32.8'
  license 'ISC'
  compatibility 'all'
  source_url 'https://gitlab.com/drobilla/serd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '368a3a655818230edb8f564242462c6bd0340ea9e24f23fc5cf67a49b7a6c87b',
     armv7l: '368a3a655818230edb8f564242462c6bd0340ea9e24f23fc5cf67a49b7a6c87b',
       i686: '73d41609a03ed831a3c64ddef6fd8da8fa71e3bc05291619b37c3aae2ab2f10c',
     x86_64: '2602bd3a9fdedb39a0a710d02cc81cbb4462ccd900d9a66af59d2d0c73911657'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library

  meson_options '-Ddocs=disabled \
               -Dtests=disabled'
end
