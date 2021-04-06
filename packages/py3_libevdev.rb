require 'package'

class Py3_libevdev < Package
  description 'Python libevdev provides python bindings for libevdev.'
  homepage 'https://python-libevdev.readthedocs.io/'
  version '0.9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/libevdev/python-libevdev/-/archive/0.9/python-libevdev-0.9.tar.bz2'
  source_sha256 '49fdccd8870f124fd560752c0735865b314f6d7959ade039c7b3523d47203af2'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
