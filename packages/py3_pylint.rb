# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "3.3.3-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fee964a331a8fbb9199caf2c45a91625fa5bfdc33a23b3cf92874831272d36a7',
     armv7l: 'fee964a331a8fbb9199caf2c45a91625fa5bfdc33a23b3cf92874831272d36a7',
       i686: 'fcf73c2542b8a00f872eb4aaccd9b9a480afbd24bf8c2766ac3e96f41b22fc0b',
     x86_64: 'cf712d37bd0bb247a56f99662399a0e6dc1efb6b5795585f71fd959dda77e776'
  })

  depends_on 'python3' # R

  no_source_build
end
