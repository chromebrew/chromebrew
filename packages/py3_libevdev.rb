require 'package'

class Py3_libevdev < Package
  description 'Libevdev is a Python wrapper around the libevdev C library.'
  homepage 'https://python-libevdev.readthedocs.io/'
  @_ver = '0.9'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/libevdev/python-libevdev.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9_armv7l/py3_libevdev-0.9-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9_armv7l/py3_libevdev-0.9-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9_x86_64/py3_libevdev-0.9-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '423bfba6a3ebcb077a42d62df039a03f7495bbe82e69d54bee23917274a0b82e',
     armv7l: '423bfba6a3ebcb077a42d62df039a03f7495bbe82e69d54bee23917274a0b82e',
     x86_64: '637430a7df660a2be0c0681ad08c26f7e746f145fa6c1aa2de7ea1256179d6ce'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
