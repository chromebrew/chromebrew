require 'package'

class Py3_openpyxl < Package
  description 'Openpyxl is a Python library to read/write Excel 2010 xlsx/xlsm files.'
  homepage 'https://openpyxl.readthedocs.io/'
  @_ver = '3.0.9'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/9e/19/c45fb7a40cd46e03e36d60d1db26a50a795fa0b6b8a2a8094f4ac0c71ae5/openpyxl-3.0.9.tar.gz'
  source_sha256 '40f568b9829bf9e446acfffce30250ac1fa39035124d55fc024025c41481c90f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.9_armv7l/py3_openpyxl-3.0.9-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.9_armv7l/py3_openpyxl-3.0.9-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.9_i686/py3_openpyxl-3.0.9-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.9_x86_64/py3_openpyxl-3.0.9-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd9e3d80f78b94fdfb4c9f17ba042b77f87f68c97910e18941f5ded89f7346950',
     armv7l: 'd9e3d80f78b94fdfb4c9f17ba042b77f87f68c97910e18941f5ded89f7346950',
       i686: '12720a76db4d3925c2ef95a42b2a25adc65b423674fc5e2610ada8690aa3d35a',
     x86_64: '24845aa5c4b4ac44e0cfd7c2ef9a98431f8cfc33ddff64f1d66bba3a2bb4a059'
  })

  depends_on 'py3_et_xmlfile'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
