# Adapted from Arch Linux lilv PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lilv/trunk/PKGBUILD

require 'buildsystems/meson'

class Lilv < Meson
  description 'A C library interface to the LV2 plug-in standard'
  homepage 'https://drobilla.net/software/lilv/'
  @_ver = '0.24.20'
  version "#{@_ver}-py3.12"
  license 'isc'
  compatibility 'all'
  source_url 'https://github.com/lv2/lilv.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lilv/0.24.20-py3.12_armv7l/lilv-0.24.20-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lilv/0.24.20-py3.12_armv7l/lilv-0.24.20-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lilv/0.24.20-py3.12_i686/lilv-0.24.20-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lilv/0.24.20-py3.12_x86_64/lilv-0.24.20-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ecbb826b1648be16f71b5c8a453c8f07a7cef24d3e4f9b529344ded90c8955b1',
     armv7l: 'ecbb826b1648be16f71b5c8a453c8f07a7cef24d3e4f9b529344ded90c8955b1',
       i686: 'dbd331cef323b3942d518413bf18a00f23995f906a945e179964c00928db10ae',
     x86_64: 'a5526bf19b7dad498788d3b90906619634cd2bbd0ff22e779bd790ff6a5c1c06'
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
