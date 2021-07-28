require 'package'

class Py3_agate_excel < Package
  description 'Agate-excel read support for Excel files (xls and xlsx) to agate.'
  homepage 'https://agate-excel.readthedocs.io/'
  @_ver = '0.2.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-excel.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.4_armv7l/py3_agate_excel-0.2.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.4_armv7l/py3_agate_excel-0.2.4-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_excel/0.2.4_x86_64/py3_agate_excel-0.2.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a72b3a80ddc035fe6fbfd87acf6c934bebd0a936aafe289859a481a5e2a6bfea',
     armv7l: 'a72b3a80ddc035fe6fbfd87acf6c934bebd0a936aafe289859a481a5e2a6bfea',
     x86_64: '37ef4427689227433ef857e568df871be6d25fd0cce8b62c4b54f1af537ceca5'
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
