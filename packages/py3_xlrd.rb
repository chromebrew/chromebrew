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
    aarch64: 'f9d41e808578b7f42b9a32d5f454043f5660873299d8eda683f5d4791442e511',
     armv7l: 'f9d41e808578b7f42b9a32d5f454043f5660873299d8eda683f5d4791442e511',
       i686: '3d4506bdadc47b5c6f55745d0e549faa518e84549e941e8a506f753a78451893',
     x86_64: '83a5c2cf465dc5c80ca2a384cf01723341def568d97844162897bcb852973309'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
