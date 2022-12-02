require 'package'

class Py3_xlrd < Package
  description 'XLRD is a library to extract data from Microsoft Excel (tm) spreadsheet files.'
  homepage 'https://xlrd.readthedocs.io/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/python-excel/xlrd.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-py3.11_armv7l/py3_xlrd-2.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-py3.11_armv7l/py3_xlrd-2.0.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-py3.11_i686/py3_xlrd-2.0.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-py3.11_x86_64/py3_xlrd-2.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1e221d3e49befd5b271887be44b7e4bd8c946c2e1cba5b4a6c0370b0e67d69c3',
     armv7l: '1e221d3e49befd5b271887be44b7e4bd8c946c2e1cba5b4a6c0370b0e67d69c3',
       i686: '9d2f7fbbcc6d0db1823eb3c0b45dab58807775ba76a7ad7dbf26fc493f9b34a6',
     x86_64: 'ddeb2ca4c1e6b8ef5e45d240b2e8f7425a04d5bcba534868dd083950f8edc819'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
