# Adapted from Arch Linux sratom PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/sratom/trunk/PKGBUILD

require 'buildsystems/meson'

class Sratom < Meson
  description 'An LV2 Atom RDF serialisation library'
  homepage 'https://drobilla.net/software/sratom/'
  version '0.6.22'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/lv2/sratom.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7ffd00a8851a65841f227148a6af77ca72f30c434265ee56f0c4975f76ed860',
     armv7l: 'd7ffd00a8851a65841f227148a6af77ca72f30c434265ee56f0c4975f76ed860',
       i686: '312d3a59096ec6b717205294bcf052295b2d9aee7e9d96d23fa3b8317b5ab256',
     x86_64: '79f5aa34f37ae47f5a191229a575c50dbac271ce963dc67e1a7d45292963f8f0'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'lv2' # R
  depends_on 'serd' => :library
  depends_on 'sord' => :library

  meson_options '-Ddocs=disabled -Dtests=disabled'
end
