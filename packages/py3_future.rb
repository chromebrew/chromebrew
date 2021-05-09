require 'package'

class Py3_future < Package
  description 'Future provides clean single-source support for Python 3 and 2.'
  homepage 'https://python-future.org/'
  @_ver = '0.18.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PythonCharmers/python-future.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
