require 'package'

class Py3_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '59.5.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e6/e2/f2bfdf364e016f7a464db709ea40d1101c4c5a463dd7019dae0a42dbd1c6/setuptools-59.5.0.tar.gz'
  source_sha256 'd144f85102f999444d06f9c0e8c737fd0194f10f2f7e5fdb77573f6e2fa4fad0'

  depends_on 'py3_packaging'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
