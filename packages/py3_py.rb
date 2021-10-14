require 'package'

class Py3_py < Package
  description 'Py is a library with cross-python path, ini-parsing, io, code, log facilities.'
  homepage 'https://py.readthedocs.io/'
  @_ver = '1.10.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/py.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
