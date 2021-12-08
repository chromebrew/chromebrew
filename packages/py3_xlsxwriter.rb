require 'package'

class Py3_xlsxwriter < Package
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  @_ver = '3.0.1'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/jmcnamara/XlsxWriter.git'
  git_hashtag "RELEASE_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1_armv7l/py3_xlsxwriter-3.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1_armv7l/py3_xlsxwriter-3.0.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1_i686/py3_xlsxwriter-3.0.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1_x86_64/py3_xlsxwriter-3.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e872536c962010db9e695ba08b83587475c4e4984149f53e95a50c1db2c44398',
     armv7l: 'e872536c962010db9e695ba08b83587475c4e4984149f53e95a50c1db2c44398',
       i686: '4ff2460fbb8f1d414052fce50cf1a1b52cf34aa27f1a72eba82d481df1f9a9b4',
     x86_64: 'c5f837a9db310e08046b4dfed65859c883eb4070990ea44f179cb3ccde371382'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
