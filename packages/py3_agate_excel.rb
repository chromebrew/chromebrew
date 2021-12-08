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
    aarch64: '8f3fc1398cf3fa11b71b7daf87b435f81ae7f4fcc8dee907175744c930db06db',
     armv7l: '8f3fc1398cf3fa11b71b7daf87b435f81ae7f4fcc8dee907175744c930db06db',
       i686: '2ac4d6a29c4aceed7fb10ae42f417279fc3dfe39eb2ebee718e8ed1622818b14',
     x86_64: '87dd31f3678007f4b19088cd6e88e1d3b0237cc7f45202704c5f7908bc428c9e'
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
