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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/58.2.0_armv7l/py3_setuptools-58.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/58.2.0_armv7l/py3_setuptools-58.2.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/58.2.0_x86_64/py3_setuptools-58.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c14dc8751ba9d9afd6d6bd8e1b71208044d96cdc67e76031a9682f318b6e68df',
     armv7l: 'c14dc8751ba9d9afd6d6bd8e1b71208044d96cdc67e76031a9682f318b6e68df',
     x86_64: 'e3b12a6ae7564f25d964f2f68dee55a07e3a93c950d88f7bc2d952eb15167af1'
  })

  depends_on 'py3_packaging'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
