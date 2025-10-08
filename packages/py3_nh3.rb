# Adapted from Arch Linux python-nh3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-nh3

require 'buildsystems/pip'

class Py3_nh3 < Pip
  description 'Ammonia HTML sanitizer Python binding'
  homepage 'https://pypi.org/project/nh3/'
  version '0.3.1'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df5a1a7c69b0f19b9b65817f6fbcda9d65b5771d70eb9fb9cb9d704868f26384',
     armv7l: 'df5a1a7c69b0f19b9b65817f6fbcda9d65b5771d70eb9fb9cb9d704868f26384',
       i686: 'd03bebd649309bacba2373a40f0cbcd3b63fa420781cf11d73d1300ae029bc08',
     x86_64: '0cd67270d618483f4aeb5e59d4e8e5fcf8b2d1b3e2567174db5672dc30708ec8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
