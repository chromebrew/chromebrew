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
    aarch64: '040ceafb5449c0e72cf685a65211d2b72038a7b1a513f70ef3ebdadd738002d0',
     armv7l: '040ceafb5449c0e72cf685a65211d2b72038a7b1a513f70ef3ebdadd738002d0',
       i686: '035abe78241ed23c654199acbe3c319b1f741ffe7f8e6bfcbf5da48c5801dd98',
     x86_64: 'f7182329ed8289f9a1ffafed7781ccdfba0dd532ad7c751300c240d68756e3f7'
  })

  depends_on 'python3' # R

  no_source_build
end
