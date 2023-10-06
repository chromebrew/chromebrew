require 'buildsystems/python'

class Py3_agate_excel < Python
  description 'Agate-excel read support for Excel files (xls and xlsx) to agate.'
  homepage 'https://agate-excel.readthedocs.io/'
  @_ver = '0.2.5'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-excel.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5-py3.12_armv7l/py3_agate_excel-0.2.5-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5-py3.12_armv7l/py3_agate_excel-0.2.5-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5-py3.12_i686/py3_agate_excel-0.2.5-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5-py3.12_x86_64/py3_agate_excel-0.2.5-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4f804ad7c84de28dfad5c481c1dd132cc75e3b0b8e8278f67e9568864ffd4c0c',
     armv7l: '4f804ad7c84de28dfad5c481c1dd132cc75e3b0b8e8278f67e9568864ffd4c0c',
       i686: '6a342a02b18fe5d55a8d3e84ee1c56bfdf4f48b218966413f23b80919afd9c9e',
     x86_64: '659068f5cfaaa2fb56a5cdaa06a49d7479e806a7c3a4420ab80fa6c78c3463e4'
  })

  depends_on 'py3_xlrd'
  depends_on 'py3_openpyxl'
  depends_on 'py3_olefile'
  depends_on 'py3_agate'
  depends_on 'python3' => :build
end
