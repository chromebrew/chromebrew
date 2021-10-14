require 'package'

class Py3_cython < Package
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  @_ver = '0.29.24'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/cython/cython.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
