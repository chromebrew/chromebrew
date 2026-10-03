# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.1.2-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4442ef119299e522d72d8e62036e1e6d7285fbc417bc54f30ed34ee0831c219b',
     armv7l: '4442ef119299e522d72d8e62036e1e6d7285fbc417bc54f30ed34ee0831c219b',
       i686: 'bfb8584ec66229577892e18e9baf92885b652c9d8840fb5965b786856cd6bd6f',
     x86_64: '638b9345797be16b53eca4af74d93f9bfad1e97d5238d50272380ff278ce9470'
  })

  depends_on 'python3' => :logical

  no_source_build
end
