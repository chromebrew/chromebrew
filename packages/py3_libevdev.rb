require 'package'

class Py3_libevdev < Package
  description 'Libevdev is a Python wrapper around the libevdev C library.'
  homepage 'https://python-libevdev.readthedocs.io/'
  @_ver = '0.9'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/libevdev/python-libevdev.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9-1_armv7l/py3_libevdev-0.9-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9-1_armv7l/py3_libevdev-0.9-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9-1_i686/py3_libevdev-0.9-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9-1_x86_64/py3_libevdev-0.9-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8f57269d7b2b08a581f322c575c4de804ca04e01998403fd8f1b205c151b7096',
     armv7l: '8f57269d7b2b08a581f322c575c4de804ca04e01998403fd8f1b205c151b7096',
       i686: 'ffde85bd37c9df90d8a9a3e748b4a6bc61483f923e793605bb164c6bdbdef4aa',
     x86_64: '8774479ffe7ee4b6eb1f017ac7167f05463af20860f008d238aadadbf3e390b1'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
