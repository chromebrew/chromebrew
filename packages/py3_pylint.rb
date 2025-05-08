# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "3.3.7-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df3a625dfec36aabeb8ffd4c3e46dc904178f3f55187ce0acfb6478241312278',
     armv7l: 'df3a625dfec36aabeb8ffd4c3e46dc904178f3f55187ce0acfb6478241312278',
       i686: '242aa0b591850a43e5c38ea55f9bb9eb6b272e617856f81746460b9053adb105',
     x86_64: '0b3aa90c5b149eca432c11a3ffe83ea3d266af6b7a5c612add62db2622f791e9'
  })

  depends_on 'python3' # R

  no_source_build
end
