# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.8-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '323d56ed1ae9edb14c0bdc6c53e40824b7c3131981b70b09594d18a71f0e6659',
     armv7l: '323d56ed1ae9edb14c0bdc6c53e40824b7c3131981b70b09594d18a71f0e6659',
       i686: '3288424215315b493b81d0b9195e4875c7f3de61ef77544179e379d679ae9ff1',
     x86_64: '6ee4977881a083a40d6c9d8af5ff9b2c54731a1e4a30492f4cc1214a18c1eb80'
  })

  depends_on 'python3' => :logical

  no_source_build
end
