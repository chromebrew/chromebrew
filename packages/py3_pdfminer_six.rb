require 'package'

class Py3_pdfminer_six < Package
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  @_ver = '20201018'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pdfminer/pdfminer.six.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018-1_armv7l/py3_pdfminer_six-20201018-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018-1_armv7l/py3_pdfminer_six-20201018-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018-1_i686/py3_pdfminer_six-20201018-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018-1_x86_64/py3_pdfminer_six-20201018-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '77d7e27ebb8f8b4a8e90f15ea626d0e62c68af8c15103ed99c444b7f0003f237',
     armv7l: '77d7e27ebb8f8b4a8e90f15ea626d0e62c68af8c15103ed99c444b7f0003f237',
       i686: '7fdb846a171a677ecf661951e3d89432d263b8302003b46b1f24b820443b8328',
     x86_64: 'bd96db5bf397b6cf89cf7628bba9ecfd2c17413979dadb7772e351db2990ad82'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
