require 'package'

class Py3_tox < Package
  description 'Toml is a Python Library for Tom\'s Obvious, Minimal Language.'
  homepage 'https://tox.readthedocs.io/'
  @_ver = '3.13.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tox-dev/tox.git'
  git_hashtag @_ver

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
