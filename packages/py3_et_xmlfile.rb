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
    aarch64: 'b6faedae37bf59fb354f2357f3e0026d7713ecb100acbe7ff91696fdd18d7f5e',
     armv7l: 'b6faedae37bf59fb354f2357f3e0026d7713ecb100acbe7ff91696fdd18d7f5e',
       i686: '044288d9761cf7ac68c317fbe2707668ed0e4a8b03de5e87b9f6a7738de31bfe',
     x86_64: 'f9ac03492d0c0d951dbd17b83611905748a9b06a18e119f40c52d8af81837fd6'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
