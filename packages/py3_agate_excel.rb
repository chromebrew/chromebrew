require 'package'

class Py3_agate_excel < Package
  description 'Agate-excel read support for Excel files (xls and xlsx) to agate.'
  homepage 'https://agate-excel.readthedocs.io/'
  @_ver = '0.2.5'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-excel.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5_armv7l/py3_agate_excel-0.2.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5_armv7l/py3_agate_excel-0.2.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5_i686/py3_agate_excel-0.2.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5_x86_64/py3_agate_excel-0.2.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '41de1c7c3185ed212896b7470621f59b0cb04155333fc018fb614074bffd3934',
     armv7l: '41de1c7c3185ed212896b7470621f59b0cb04155333fc018fb614074bffd3934',
       i686: 'ca6813a59858a88a959eddca2662252583554862cf9c439b612bb8ca56c4ab27',
     x86_64: 'ff3e5e5ad5b1d2e38d5b40c59a64ef566ef0542d47556d7b6a60a358790cec6e'
  })

  depends_on 'py3_xlrd'
  depends_on 'py3_openpyxl'
  depends_on 'py3_olefile'
  depends_on 'py3_agate'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
