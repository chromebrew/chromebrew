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
    aarch64: '636812109d443d73982afd6e9508e1d63a2941bc1c378aee41d72d77c4c50106',
     armv7l: '636812109d443d73982afd6e9508e1d63a2941bc1c378aee41d72d77c4c50106',
       i686: '4a9fcbb90f321fe6e47c6183d4848b0f80069a7f74a23f83e431a591e4e446d1',
     x86_64: '7a4c43dbc98fd7ed19a80917c3b654f3e09e5e3b0136eac91fdd611f06788d33'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
