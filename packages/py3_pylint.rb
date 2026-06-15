# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.6-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd01391c9cd87878cdf54a9ab4b928b6ae481abbd22b7e4be977b8a5ed8d61179',
     armv7l: 'd01391c9cd87878cdf54a9ab4b928b6ae481abbd22b7e4be977b8a5ed8d61179',
       i686: 'ce2bca84ac552bf625e9249688004d1592f00c1002a4f25d145d9967dc72bb69',
     x86_64: '5e08dc43666c93b183fa8332c00244cee90c2a48df8808e6dd0c279d5610b524'
  })

  depends_on 'python3' => :logical

  no_source_build
end
