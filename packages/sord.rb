# Adapted from Arch Linux sord PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/sord/trunk/PKGBUILD

require 'buildsystems/meson'

class Sord < Meson
  description 'A lightweight C library for storing RDF data in memory'
  homepage 'https://drobilla.net/software/sord/'
  version '0.16.20'
  license 'ISC'
  compatibility 'all'
  source_url 'https://gitlab.com/drobilla/sord.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4dceccc727b85b7a0bb7ca396068136191a18127441ed722928e34471c884a1c',
     armv7l: '4dceccc727b85b7a0bb7ca396068136191a18127441ed722928e34471c884a1c',
       i686: 'fd691f1028ba28f0b5a26863ef6e5c0a62d3d50970656d9d0d6adfdee87752e6',
     x86_64: '178d27e5a53980a357cd18b5f9b20c28c31c6504863d2b99baea46bb30c3108d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'pcre2' # R
  depends_on 'serd' # R
  depends_on 'zix' # R

  meson_options '-Ddocs=disabled \
               -Dtests=disabled'
end
