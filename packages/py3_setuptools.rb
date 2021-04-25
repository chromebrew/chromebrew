require 'package'

class Py3_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '56.0.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://files.pythonhosted.org/packages/f6/e9/19af16328705915233299f6f1f02db95899fb00c75ac9da4757aa1e5d1de/setuptools-#{@_ver}.tar.gz"
  source_sha256 '08a1c0f99455307c48690f00d5c2ac2c1ccfab04df00454fef854ec145b81302'

  depends_on 'python3'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
