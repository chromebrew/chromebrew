require 'buildsystems/pip'

class Py3_agate_excel < Pip
  description 'Agate-excel read support for Excel files (xls and xlsx) to agate.'
  homepage 'https://agate-excel.readthedocs.io/'
  version "0.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac077af3004a6ecc0d36b8e732dddfceee36700195dc110f86fe0dccd1e02417',
     armv7l: 'ac077af3004a6ecc0d36b8e732dddfceee36700195dc110f86fe0dccd1e02417',
       i686: '62585f8d4a1b348204f58c02e99473a704da64ec70501e7ac2b348d7b22c4d1a',
     x86_64: 'da99c33ad28d62deb879cf41bd686f54106252e3e3565cc5eab23a3c8a0bafaf'
  })

  depends_on 'py3_xlrd'
  depends_on 'py3_openpyxl'
  depends_on 'py3_olefile'
  depends_on 'py3_agate'
  depends_on 'python3' => :build

  no_source_build
end
