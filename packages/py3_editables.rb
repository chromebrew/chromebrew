require 'buildsystems/pip'

class Py3_editables < Pip
  description 'A Python library for creating "editable wheels"'
  homepage 'https://editables.readthedocs.io'
  @_ver = '0.5'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_editables/0.5-py3.12_armv7l/py3_editables-0.5-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_editables/0.5-py3.12_armv7l/py3_editables-0.5-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_editables/0.5-py3.12_i686/py3_editables-0.5-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_editables/0.5-py3.12_x86_64/py3_editables-0.5-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4f2654a244dac36cad73d2ede43ffe489c0e3e76cd239148a78429b2b10d0bdd',
     armv7l: '4f2654a244dac36cad73d2ede43ffe489c0e3e76cd239148a78429b2b10d0bdd',
       i686: 'a1203b71c4a62e7643d3d8c70005212af6dc583d530ffcf5d1d53fee8ae276ae',
     x86_64: 'a76e0d0321fc616a379ea3ac99b53c395a67a4d47b44ee3b2b891228a0e78bf5'
  })

  depends_on 'python3' => :build
end
