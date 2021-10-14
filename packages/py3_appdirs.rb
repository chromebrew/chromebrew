require 'package'

class Py3_appdirs < Package
  description 'Appdirs is a small Python module for determining appropriate platform-specific directories.'
  homepage 'https://github.com/ActiveState/appdirs/'
  @_ver = '1.4.4'
  version @_ver + '-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ActiveState/appdirs.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
