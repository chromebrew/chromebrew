require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.2.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dee64e23149aed705b1a7d18b9598f331ea4c3d4e2062527de27cbf4f768b6ee',
     armv7l: 'dee64e23149aed705b1a7d18b9598f331ea4c3d4e2062527de27cbf4f768b6ee',
       i686: 'ea82b451d5e312aee6f63e9d1a32359ec1f15e64e1f5b5b79c3f7ede16b2d827',
     x86_64: '5de114f29d0ad9b7a708952022225a7852efdc5b9211fec03d6a172b0c2967c2'
  })

  depends_on 'python3' => :build

  no_source_build
end
