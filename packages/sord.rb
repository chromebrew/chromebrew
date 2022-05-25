# Adapted from Arch Linux sord PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/sord/trunk/PKGBUILD

require 'buildsystems/meson'

class Sord < Meson
  description 'A lightweight C library for storing RDF data in memory'
  homepage 'https://drobilla.net/software/sord/'
  version '0.16.14'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/drobilla/sord.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sord/0.16.14_armv7l/sord-0.16.14-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sord/0.16.14_armv7l/sord-0.16.14-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sord/0.16.14_i686/sord-0.16.14-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sord/0.16.14_x86_64/sord-0.16.14-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c9667c90d72b3604b7ecda2fc66ea57e2d2d3bf0b8593b195d5286c9170bf19f',
     armv7l: 'c9667c90d72b3604b7ecda2fc66ea57e2d2d3bf0b8593b195d5286c9170bf19f',
       i686: '44c32a9b15f9cc90e5b70e11d26880efa75ce577cfa602b465047dffbe069a7c',
     x86_64: '260e36fbe792e2ee149ee8c0de2e97459b446ce4a1c3b34f334fb4ef25f45da2'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'pcre' # R
  depends_on 'serd' # R

  meson_options '-Ddocs=disabled \
               -Dtests=disabled'
end
