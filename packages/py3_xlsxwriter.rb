require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.2.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f3d00b7b99d4c7bcfb877e692119fd6ee631297ecc2d539fa4eced8299a3880',
     armv7l: '5f3d00b7b99d4c7bcfb877e692119fd6ee631297ecc2d539fa4eced8299a3880',
       i686: '5aa8b33da9c21be042c8a1becc18ef4cab7f39f278278ec3253f2b0bebb571bc',
     x86_64: 'e401a859a40a32a3dcd0f73616dc28ce7dc7e95b4690fa3dfa2fd8082411955d'
  })

  depends_on 'python3' => :build

  no_source_build
end
