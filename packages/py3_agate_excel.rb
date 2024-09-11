require 'buildsystems/pip'

class Py3_agate_excel < Pip
  description 'Agate-excel read support for Excel files (xls and xlsx) to agate.'
  homepage 'https://agate-excel.readthedocs.io/'
  version '0.4.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe8a32c5875cb8503bd4dc8d4d56ad68d9646cec89c27c2fdebe3c80faa9bb01',
     armv7l: 'fe8a32c5875cb8503bd4dc8d4d56ad68d9646cec89c27c2fdebe3c80faa9bb01',
       i686: 'ab4a9555ba41c669b1011ee66659cd4f76d35a7627cc3c4ff4bc7dec13991a6b',
     x86_64: 'da99c33ad28d62deb879cf41bd686f54106252e3e3565cc5eab23a3c8a0bafaf'
  })

  depends_on 'py3_xlrd'
  depends_on 'py3_openpyxl'
  depends_on 'py3_olefile'
  depends_on 'py3_agate'
  depends_on 'python3' => :build

  no_source_build
end
