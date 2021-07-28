require 'package'

class Py3_openpyxl < Package
  description 'Openpyxl is a Python library to read/write Excel 2010 xlsx/xlsm files.'
  homepage 'https://openpyxl.readthedocs.io/'
  @_ver = '3.0.7'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/f1/7d/fb475cd963bd9d244f95a90c98f518f5c834fefe749f25f9f479ca2d8a51/openpyxl-3.0.7.tar.gz'
  source_sha256 '6456a3b472e1ef0facb1129f3c6ef00713cebf62e736cd7a75bcc3247432f251'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.7_armv7l/py3_openpyxl-3.0.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.7_armv7l/py3_openpyxl-3.0.7-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.0.7_x86_64/py3_openpyxl-3.0.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '67f3562fdfa8fc22850b8cb128678f4bf508704e5b2eea838e29952084b74202',
     armv7l: '67f3562fdfa8fc22850b8cb128678f4bf508704e5b2eea838e29952084b74202',
     x86_64: '7fc82dee675d67baafa0458367c844c5493bf9c167ef229e40d940fc55420703'
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
