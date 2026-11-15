# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.1.4-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f961dc530f9531a01c57e7fbc67aa093f734f7b1139b96e236d8aaff3e6d1bf',
     armv7l: '3f961dc530f9531a01c57e7fbc67aa093f734f7b1139b96e236d8aaff3e6d1bf',
       i686: '98cc3b8f6baa205feeb295a8135e065e6fafac73252a8d89c380b2f5c7232281',
     x86_64: '63d7788e9c32a1efa4c546113bf29b0fa0c12ad0b6d8ae1f66402e2f0f5c6530'
  })

  depends_on 'python3' => :logical

  no_source_build
end
