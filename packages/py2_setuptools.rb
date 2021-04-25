require 'package'

class Py2_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '44.1.1' # Newest python2 supported version as of 2021-04-24
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://files.pythonhosted.org/packages/b2/40/4e00501c204b457f10fe410da0c97537214b2265247bc9a5bc6edd55b9e4/setuptools-#{@_ver}.zip"
  source_sha256 'c67aa55db532a0dadc4d2e20ba9961cbd3ccc84d544e9029699822542b5a476b'

  depends_on 'python2'

  def self.build
    system "python2 setup.py build #{PY2_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python2 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
