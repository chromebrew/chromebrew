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

  depends_on 'py3_et_xmlfile'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
