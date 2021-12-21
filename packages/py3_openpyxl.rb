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
    aarch64: 'e70be570e3807951e701e406ab02d2bb3f64319865b7efed69596ab8862167b4',
     armv7l: 'e70be570e3807951e701e406ab02d2bb3f64319865b7efed69596ab8862167b4',
       i686: '35aab68a6ddf51ac15082186193fd683bf8665ebf981f3a48363f923951d2ea8',
     x86_64: '85c8c8c7c2ce33b1d062ac8c4c80e3e92b469ff3463df0ee31abe365e44cc61a'
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
