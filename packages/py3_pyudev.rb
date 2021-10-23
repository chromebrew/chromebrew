require 'package'

class Py3_pyudev < Package
  description 'Pyudev provides Python bindings for udev.'
  homepage 'https://pyudev.readthedocs.io/'
  @_ver = '0.22'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/pyudev/pyudev.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22_armv7l/py3_pyudev-0.22-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22_armv7l/py3_pyudev-0.22-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22-1_i686/py3_pyudev-0.22-1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22-1_x86_64/py3_pyudev-0.22-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd3595f1225885de8ccbdca03a0a4e6a3be3745d48869fa0e65bbaf152a8bacaa',
     armv7l: 'd3595f1225885de8ccbdca03a0a4e6a3be3745d48869fa0e65bbaf152a8bacaa',
    i686: 'aedfca10bb198931e3b1939e189e6d1d07936fdb293f28394153f0d7af4f0650',
  x86_64: 'cbc9f78154a63520f54095bcbb441e13fe294005e4d7c483a10c50d32f47bd92'
  })

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
