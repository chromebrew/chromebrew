require 'package'

class Py3_xlrd < Package
  description 'XLRD is a library to extract data from Microsoft Excel (tm) spreadsheet files.'
  homepage 'https://xlrd.readthedocs.io/'
  @_ver = '2.0.1'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/python-excel/xlrd.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1_armv7l/py3_xlrd-2.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1_armv7l/py3_xlrd-2.0.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1_x86_64/py3_xlrd-2.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9a7800b3ac478d8108485b785bbc0815db92d43d5d2df645f6b145442a70d48c',
     armv7l: '9a7800b3ac478d8108485b785bbc0815db92d43d5d2df645f6b145442a70d48c',
     x86_64: '8ad7b6d53bd416c6cda2e7d3a18dc842029bc9c43ca14225484117b575280a8b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
