# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.5-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1258aaf50085b26069e4aab9479a1bd0d1ef65009a8b54a005dfa8d5f0e6366',
     armv7l: 'c1258aaf50085b26069e4aab9479a1bd0d1ef65009a8b54a005dfa8d5f0e6366',
       i686: '2ae582db6dae5aca583dbb7be15b280a708f10204f64fdaf4b1d0b018025bb94',
     x86_64: 'e3113f848fea518c87b861e15e78b469f81fe383274b641686c0d7c0e21457b0'
  })

  depends_on 'python3' => :logical

  no_source_build
end
