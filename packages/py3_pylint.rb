# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "3.3.6-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8eeef7770101439a05bd1effe6f14d624799d0f0a8d5b27a9eaa0b53d22c257',
     armv7l: 'd8eeef7770101439a05bd1effe6f14d624799d0f0a8d5b27a9eaa0b53d22c257',
       i686: '035abe78241ed23c654199acbe3c319b1f741ffe7f8e6bfcbf5da48c5801dd98',
     x86_64: '88e5206f27426ecbca2832bf3719cbb762837c5a728ddf9b2cd233030b80d06c'
  })

  depends_on 'python3' # R

  no_source_build
end
