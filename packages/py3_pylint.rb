# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.9-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d5f26511bf8f2d24db843c3e0db747dbb5138e1fb0bd71bafb6ed00b63fcc0e',
     armv7l: '5d5f26511bf8f2d24db843c3e0db747dbb5138e1fb0bd71bafb6ed00b63fcc0e',
       i686: '6ebb84d65e4614e75829c9a69eca5156a61abbfa5fb942ce710375c802f34223',
     x86_64: 'cc6d571b151c8a7b93870a643b5ba13febba7d1f277dd78aa15fe43540d5d5ee'
  })

  depends_on 'python3' => :logical

  no_source_build
end
