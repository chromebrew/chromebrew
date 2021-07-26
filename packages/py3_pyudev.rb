require 'package'

class Py3_pyudev < Package
  description 'Pyudev provides Python bindings for udev.'
  homepage 'https://pyudev.readthedocs.io/'
  @_ver = '0.22'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/pyudev/pyudev.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22_armv7l/py3_pyudev-0.22-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22_armv7l/py3_pyudev-0.22-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22_x86_64/py3_pyudev-0.22-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd3595f1225885de8ccbdca03a0a4e6a3be3745d48869fa0e65bbaf152a8bacaa',
     armv7l: 'd3595f1225885de8ccbdca03a0a4e6a3be3745d48869fa0e65bbaf152a8bacaa',
     x86_64: 'b3e8f6b7149108bf039a29a7a6ed1c19199396c68a3f08d5817128c726af198b'
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
