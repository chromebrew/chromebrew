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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.5_x86_64/py3_agate_excel-0.2.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '41de1c7c3185ed212896b7470621f59b0cb04155333fc018fb614074bffd3934',
     armv7l: '41de1c7c3185ed212896b7470621f59b0cb04155333fc018fb614074bffd3934',
     x86_64: '2b70388af3662a5715d99925d9533f1f3728e064f33ef4b494633a43ecd67d7f'
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
