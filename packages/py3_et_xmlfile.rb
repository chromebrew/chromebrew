require 'package'

class Py3_et_xmlfile < Package
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://openpyxl.readthedocs.io/'
  @_ver = '1.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/3d/5d/0413a31d184a20c763ad741cc7852a659bf15094c24840c5bdd1754765cd/et_xmlfile-1.1.0.tar.gz'
  source_sha256 '8eb9e2bc2f8c97e37a2dc85a09ecdcdec9d8a396530a6d5a33b30b9a92da0c5c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1_armv7l/py3_et_xmlfile-1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1_armv7l/py3_et_xmlfile-1.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1_x86_64/py3_et_xmlfile-1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '20c7507f597d3397368033a826c93334259e36003ac557737971f1ba98afcd00',
     armv7l: '20c7507f597d3397368033a826c93334259e36003ac557737971f1ba98afcd00',
     x86_64: 'c64e6a5ce0288dd472903911e1bd21f760ba451cbb3c4c3bace140a3ae20b519'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
