# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "3.3.2-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1a3b084d56442508f2c4d6324f61bea5d2172ff2f9738ce7d29a9055e7a0e0ed',
     armv7l: '1a3b084d56442508f2c4d6324f61bea5d2172ff2f9738ce7d29a9055e7a0e0ed',
       i686: 'e048cb0ae02caf394d86bb4f971ea6d993df174261402173b204f00d61762682',
     x86_64: '1b595084ebd7d9a9fb2a9be9653b04937cfa988691ce00be3ef8614e34863161'
  })

  depends_on 'python3' # R

  no_source_build
end
