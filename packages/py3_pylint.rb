# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.3-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17149f50cd34f219c461ac012637a7cb1a62c421414266c67f2f75ec7e9b6140',
     armv7l: '17149f50cd34f219c461ac012637a7cb1a62c421414266c67f2f75ec7e9b6140',
       i686: '1d18511d0b15b2583d961396e58e6b0c02b5ca14de4c577add2db8f9baa96e63',
     x86_64: 'd90fe1292a59d34904dd48a9ad7639fef85e863902f2818122fe28c401f768be'
  })

  depends_on 'python3' # R

  no_source_build
end
