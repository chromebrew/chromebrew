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
     x86_64: '5de114f29d0ad9b7a708952022225a7852efdc5b9211fec03d6a172b0c2967c2'
  })

  depends_on 'python3' => :build

  no_source_build
end
