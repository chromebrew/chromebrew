require 'package'

class Py3_libevdev < Package
  description 'Libevdev is a Python wrapper around the libevdev C library.'
  homepage 'https://python-libevdev.readthedocs.io/'
  @_ver = '0.9'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://https://gitlab.freedesktop.org/libevdev/python-libevdev.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
