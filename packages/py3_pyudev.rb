require 'package'

class Py3_pyudev < Package
  description 'Libevdev is a Python wrapper around the libevdev C library.'
  homepage 'https://pyudev.readthedocs.io/'
  @_ver = '0.22'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/libevdev/python-libevdev.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
