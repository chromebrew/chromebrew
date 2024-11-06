require 'buildsystems/pip'

class Py3_openpyxl < Pip
  description 'Openpyxl is a Python library to read/write Excel 2010 xlsx/xlsm files.'
  homepage 'https://openpyxl.readthedocs.io/'
  version "3.1.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff56fb200471e39c63bda91fe7dc3f7cf5eca2b1ecf7b0c10afec0b4c68a1426',
     armv7l: 'ff56fb200471e39c63bda91fe7dc3f7cf5eca2b1ecf7b0c10afec0b4c68a1426',
       i686: '29007adf878bf7820e22796898a8082724d45d2128d3d9776d15188fbc393a0a',
     x86_64: 'e1736dc1e37be377360ead7a38ec07c821dfda8a6a073cacf5a9033713658b1c'
  })

  depends_on 'py3_et_xmlfile'
  depends_on 'python3' => :build

  no_source_build
end
