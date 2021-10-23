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
    aarch64: 'f20936a2c058d90854f117304e9155255719aa6d1f0ac75fa40dca5b992d36d4',
     armv7l: 'f20936a2c058d90854f117304e9155255719aa6d1f0ac75fa40dca5b992d36d4',
       i686: '8859aad5f8e24cfb544387eea628845959dce5fe7c26886a649e5914ac868aff',
     x86_64: '43b50ab8ad0761d7d95dbd73b90f717c3a01899fc532e1d1de9cfb5c1d54b68c'
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
