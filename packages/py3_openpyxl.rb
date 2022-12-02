require 'package'

class Py3_openpyxl < Package
  description 'Openpyxl is a Python library to read/write Excel 2010 xlsx/xlsm files.'
  homepage 'https://openpyxl.readthedocs.io/'
  @_ver = '3.0.9'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/9e/19/c45fb7a40cd46e03e36d60d1db26a50a795fa0b6b8a2a8094f4ac0c71ae5/openpyxl-3.0.9.tar.gz'
  source_sha256 '40f568b9829bf9e446acfffce30250ac1fa39035124d55fc024025c41481c90f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.9-py3.11_armv7l/py3_openpyxl-3.0.9-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.9-py3.11_armv7l/py3_openpyxl-3.0.9-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.9-py3.11_i686/py3_openpyxl-3.0.9-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.9-py3.11_x86_64/py3_openpyxl-3.0.9-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4cfb47bbf8148f88e6b778cecf6f927a005315a72f229db00b48d118f708898c',
     armv7l: '4cfb47bbf8148f88e6b778cecf6f927a005315a72f229db00b48d118f708898c',
       i686: '77972f7f895397c6e595f8cc7d53e3ae69248d331302929481ee00818cc9eb07',
     x86_64: 'd5bab3af11129bd3680b1266d37a8dd12465db9080e63cd2ca874b95e8cccb53'
  })

  depends_on 'py3_et_xmlfile'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
