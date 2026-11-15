# Adapted from Arch Linux zix PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/zix/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/meson'

class Zix < Meson
  description 'A lightweight C99 portability and data structure library'
  homepage 'https://gitlab.com/drobilla/zix'
  version '0.8.2'
  license '0BSD OR ISC'
  compatibility 'all'
  source_url 'https://gitlab.com/drobilla/zix.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd510c18cda3426e390228875b16e204a219dd33c477b58a39cb9db05650c5596',
     armv7l: 'd510c18cda3426e390228875b16e204a219dd33c477b58a39cb9db05650c5596',
       i686: '8fb137540fdf409b3ba5c6489a29b28eece34b981ad817317b7796b059488e51',
     x86_64: '667dbd03ec466f96d9e33000f613e5a1cab6bee4a454954ae36d403113d3290a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
