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
       i686: '0d908de0cbc90eba633f515046d6d6c0ee95dd2da508717deb80462da17be7b9',
     x86_64: 'cc5e792715020743a0510269b2063f2d93ee3b781563dde0b445f56f4b6b258d'
  })

  depends_on 'py3_xlrd'
  depends_on 'py3_openpyxl'
  depends_on 'py3_olefile'
  depends_on 'py3_agate'
  depends_on 'python3' => :build

  no_source_build
end
