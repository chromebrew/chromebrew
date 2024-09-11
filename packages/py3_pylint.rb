# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version '3.2.7-py3.12'
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5427199ef27273a7d7fda7acec030cc06037d129b0fc4d6406099adbb0250c22',
     armv7l: '5427199ef27273a7d7fda7acec030cc06037d129b0fc4d6406099adbb0250c22',
       i686: '2226f031fbef2de47276ce8ed22c6542651607bfe5c3b3f6015a5d4616373b59',
     x86_64: '6efbdc4fbff4b28696f953f88d396e522470ce5c51737cea3d7d0aeaa305d702'
  })

  depends_on 'python3' # R

  no_source_build
end
