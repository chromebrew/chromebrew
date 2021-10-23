require 'package'

class Py3_xlrd < Package
  description 'XLRD is a library to extract data from Microsoft Excel (tm) spreadsheet files.'
  homepage 'https://xlrd.readthedocs.io/'
  @_ver = '2.0.1'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/python-excel/xlrd.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-1_armv7l/py3_xlrd-2.0.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-1_armv7l/py3_xlrd-2.0.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-1_i686/py3_xlrd-2.0.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-1_x86_64/py3_xlrd-2.0.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '350b111a86f5de043bffd94f97d6a7869d538fbbd04a34c5be681eac3327fa93',
     armv7l: '350b111a86f5de043bffd94f97d6a7869d538fbbd04a34c5be681eac3327fa93',
       i686: '2fb364149a699491a54b398447bf38bcab9584f589ca0b8f401e9d920c972959',
     x86_64: '8d0a9449d22ae810f8902d061b33da4cf5ae680d961ccf85b369e9f12ebd9f50'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
