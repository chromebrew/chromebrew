require 'package'

class Py3_sqlalchemy < Package
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  @_ver = '0.5.7'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/sqlalchemy.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
