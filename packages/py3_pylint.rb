# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "3.3.5-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '256bc5d607b54c52ae7774c82333fba6a8ceced5c13413a68d6c793265a10e5d',
     armv7l: '256bc5d607b54c52ae7774c82333fba6a8ceced5c13413a68d6c793265a10e5d',
       i686: '3fda1f464bde55e9ad336ee0633f388671e5389f341b4abc045e8c9f652e595f',
     x86_64: '16c51dfc3b31012b63669194d87e662f3b73a069f25a3ee12b034008125d56da'
  })

  depends_on 'python3' # R

  no_source_build
end
