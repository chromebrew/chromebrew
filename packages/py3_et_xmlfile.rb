require 'package'

class Py3_et_xmlfile < Package
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://openpyxl.readthedocs.io/'
  @_ver = '1.1.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/3d/5d/0413a31d184a20c763ad741cc7852a659bf15094c24840c5bdd1754765cd/et_xmlfile-1.1.0.tar.gz'
  source_sha256 '8eb9e2bc2f8c97e37a2dc85a09ecdcdec9d8a396530a6d5a33b30b9a92da0c5c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1.0_armv7l/py3_et_xmlfile-1.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1.0_armv7l/py3_et_xmlfile-1.1.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1.0_i686/py3_et_xmlfile-1.1.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1.0_x86_64/py3_et_xmlfile-1.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4f20b5f32abf23d002282bfde1fc304e8015cdde77aff582ef67f5bc1ac7fe02',
     armv7l: '4f20b5f32abf23d002282bfde1fc304e8015cdde77aff582ef67f5bc1ac7fe02',
       i686: 'cfdb38417d94479885c2bfc9faa8602108ce89408b92e98be7298472b6b7f76e',
     x86_64: 'ad6b3cf9dae323257024e7d33ebda6bf7986f66ef69f4f4fd063d993f44997b3'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
