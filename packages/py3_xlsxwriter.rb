require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.2.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dee64e23149aed705b1a7d18b9598f331ea4c3d4e2062527de27cbf4f768b6ee',
     armv7l: 'dee64e23149aed705b1a7d18b9598f331ea4c3d4e2062527de27cbf4f768b6ee',
       i686: '1fa9b1b6abda531fa322b03c40f0d0aa203c929f6f248975fe4b054c4f4c2847',
     x86_64: '973f4ec27cbe2d80c65298d6257dc888c99f7a3537e6e6d3064ac2ba534771fc'
  })

  depends_on 'python3' => :build

  no_source_build
end
