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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/59.5.0_armv7l/py3_setuptools-59.5.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/59.5.0_armv7l/py3_setuptools-59.5.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/59.5.0_i686/py3_setuptools-59.5.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/59.5.0_x86_64/py3_setuptools-59.5.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f644f5549c1f40b4f6fa05daafa1c4e19671c03173d516d3f5799b6333c81908',
     armv7l: 'f644f5549c1f40b4f6fa05daafa1c4e19671c03173d516d3f5799b6333c81908',
       i686: '2b70b52d7363a08c7a35af71487b20fb5e24ffde198e66c5d5751c66685870f8',
     x86_64: '938174f3720e8ce4cefa6867741c2e7998d6930f4bedfb8d3a310cc11e9ed837'
  })

  depends_on 'py3_packaging'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
