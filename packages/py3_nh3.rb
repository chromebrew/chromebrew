# Adapted from Arch Linux python-nh3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-nh3

require 'buildsystems/pip'

class Py3_nh3 < Pip
  description 'Ammonia HTML sanitizer Python binding'
  homepage 'https://pypi.org/project/nh3/'
  version '0.3.3'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd9b3f72b016c40f96e1322ea963b3bfcd74173f39fb9931c845d17395ca2b076',
     armv7l: 'd9b3f72b016c40f96e1322ea963b3bfcd74173f39fb9931c845d17395ca2b076',
       i686: '92da95d9fa12925f8e114bb1226eee912783bbad4bc2f16d841cca07de7fce79',
     x86_64: 'f92b9d9315a2359e7011ddac014ca4b06260f9fa8328f8eb870da0b0f1a3178f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
