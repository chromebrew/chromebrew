require 'package'

class Py3_agate_excel < Package
  description 'Agate-excel read support for Excel files (xls and xlsx) to agate.'
  homepage 'https://agate-excel.readthedocs.io/'
  @_ver = '0.2.5'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-excel.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5-py3.11_armv7l/py3_agate_excel-0.2.5-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5-py3.11_armv7l/py3_agate_excel-0.2.5-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5-py3.11_i686/py3_agate_excel-0.2.5-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5-py3.11_x86_64/py3_agate_excel-0.2.5-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '389a36a7040e969507dd55a12c533e4e337a909b382c5abb392b62c7c183a487',
     armv7l: '389a36a7040e969507dd55a12c533e4e337a909b382c5abb392b62c7c183a487',
       i686: '4402560ce780e696f7ebe8a738000354ed8a7cb7cac55ac3f52ec18a401d3ac0',
     x86_64: '08fd4f7b280e95e82bd762875f295e3bf7d5b5b713ec95662e8392e93dca4128'
  })

  depends_on 'py3_xlrd'
  depends_on 'py3_openpyxl'
  depends_on 'py3_olefile'
  depends_on 'py3_agate'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
