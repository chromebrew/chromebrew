require 'package'

class Py3_dbfread < Package
  description 'DBFread reads DBF Files with Python.'
  homepage 'https://dbfread.readthedocs.io/'
  @_ver = '2.0.7'
  version @_ver + '-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/olemb/dbfread.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
