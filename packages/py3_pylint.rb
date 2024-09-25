# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version '3.3.1-py3.12'
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3de1c4ae10f62383163858c7557c257f374c28125d7cd1938126dd727e78d3f7',
     armv7l: '3de1c4ae10f62383163858c7557c257f374c28125d7cd1938126dd727e78d3f7',
       i686: '8a0b1be4b0af39f02061e60594994254f77cfa728d448194325b7b3410e1f8ce',
     x86_64: '4cf7e167f5dc12e0815406e41a3b3b14233539b6d97144f726a9c325eeee30d8'
  })

  depends_on 'python3' # R

  no_source_build
end
