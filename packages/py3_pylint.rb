# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.0-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5207125daa68a9bafbb57643fa10e59591a8baf11a4fbfbbfa721b86d8d8008d',
     armv7l: '5207125daa68a9bafbb57643fa10e59591a8baf11a4fbfbbfa721b86d8d8008d',
       i686: '2bd3deef106e27873a7ecd5db899d64263c803c91d6b0e3cb157520dcdf6cf2c',
     x86_64: 'f3d1f838bb4e58624850d35961aad4033a67d066ea9b642d45ea4457faa34223'
  })

  depends_on 'python3' # R

  no_source_build
end
