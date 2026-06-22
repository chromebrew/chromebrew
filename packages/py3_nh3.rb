# Adapted from Arch Linux python-nh3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-nh3

require 'buildsystems/pip'

class Py3_nh3 < Pip
  description 'Ammonia HTML sanitizer Python binding'
  homepage 'https://pypi.org/project/nh3/'
  version '0.3.6'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06eccb94ce943cbe80898ad429498c9c6429ee35093e240d5aff7077bbf44836',
     armv7l: '06eccb94ce943cbe80898ad429498c9c6429ee35093e240d5aff7077bbf44836',
       i686: 'adbd752fcae483838eae4b6771c3864fdcc9a920c7243432b16c80bb838bd09c',
     x86_64: '4f7aee81bae17e56a221875cf03e513b4d767c1dd1e12583b02e8278b4fc6523'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_maturin' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
