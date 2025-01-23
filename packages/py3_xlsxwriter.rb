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
    aarch64: '5f3d00b7b99d4c7bcfb877e692119fd6ee631297ecc2d539fa4eced8299a3880',
     armv7l: '5f3d00b7b99d4c7bcfb877e692119fd6ee631297ecc2d539fa4eced8299a3880',
       i686: 'ea82b451d5e312aee6f63e9d1a32359ec1f15e64e1f5b5b79c3f7ede16b2d827',
     x86_64: '5de114f29d0ad9b7a708952022225a7852efdc5b9211fec03d6a172b0c2967c2'
  })

  depends_on 'python3' => :build

  no_source_build
end
