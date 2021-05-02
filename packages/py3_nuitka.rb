require 'package'

class Py3_nuitka < Package
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  @_ver = '0.6.14.5'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
