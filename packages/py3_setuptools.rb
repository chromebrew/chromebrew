require 'package'

class Py3_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '58.2.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/1e/5c/3d7b3d91a86d71faf5038c5d259ed36b5d05b7804648e2c43251d574a6e6/setuptools-58.2.0.tar.gz'
  source_sha256 '2c55bdb85d5bb460bd2e3b12052b677879cffcf46c0c688f2e5bf51d36001145'

  binary_url({
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/58.2.0_x86_64/py3_setuptools-58.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
     x86_64: '6b8d6a3275c9fc16113a82dba1208bc5b29e2a5950be7f1e386cb1312294a6d1'
  })

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
