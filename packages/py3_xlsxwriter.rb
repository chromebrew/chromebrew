require 'package'

class Py3_xlsxwriter < Package
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  @_ver = '1.4.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/jmcnamara/XlsxWriter.git'
  git_hashtag "RELEASE_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/1.4.2_armv7l/py3_xlsxwriter-1.4.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/1.4.2_armv7l/py3_xlsxwriter-1.4.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/1.4.2_i686/py3_xlsxwriter-1.4.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/1.4.2_x86_64/py3_xlsxwriter-1.4.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '67a7065af7e6db0cdb160244f851486ae7f6ef3f5ccc1902dba3d7abd1585186',
     armv7l: '67a7065af7e6db0cdb160244f851486ae7f6ef3f5ccc1902dba3d7abd1585186',
       i686: '5c161cbdc107feb5c804dd2c481c77ae2f83649764c7de37272386a33973f943',
     x86_64: 'f639eb481f72295de011fd1578422a8124562516543cc3e7897e10f85addcc9e'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
