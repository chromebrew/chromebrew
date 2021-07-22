require 'package'

class Py3_minidb < Package
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'http://thp.io/2010/minidb/'
  @_ver = '2.0.4'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/thp/minidb.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
