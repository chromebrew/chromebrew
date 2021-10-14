require 'package'

class Py3_magic < Package
  description 'Magic is a python wrapper for libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  @_ver = '0.4.24'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ahupp/python-magic.git'
  git_hashtag @_ver

  depends_on 'filecmd'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
