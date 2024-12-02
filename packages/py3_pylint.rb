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
    aarch64: 'fee964a331a8fbb9199caf2c45a91625fa5bfdc33a23b3cf92874831272d36a7',
     armv7l: 'fee964a331a8fbb9199caf2c45a91625fa5bfdc33a23b3cf92874831272d36a7',
       i686: 'e048cb0ae02caf394d86bb4f971ea6d993df174261402173b204f00d61762682',
     x86_64: '3f7df9cd622507675f28403cc4f0079fe6808df751ba6fb07d4469f9b2dd33f2'
  })

  depends_on 'python3' # R

  no_source_build
end
