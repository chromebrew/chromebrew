require 'package'

class Py3_greenlet < Package
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  @_ver = '1.1.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-greenlet/greenlet.git'
  git_hashtag @_ver

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
