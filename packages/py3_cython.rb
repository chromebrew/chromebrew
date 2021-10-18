require 'package'

class Py3_cython < Package
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  @_ver = '0.29.24'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/cython/cython.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_armv7l/py3_cython-0.29.24-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_armv7l/py3_cython-0.29.24-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_x86_64/py3_cython-0.29.24-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c745cef9419f350142ab65cef8ff72cd5830abc69ba2d22b3b4e25722b897265',
     armv7l: 'c745cef9419f350142ab65cef8ff72cd5830abc69ba2d22b3b4e25722b897265',
     x86_64: '91c98f487829261223a8c0547df33bde48c5884ba32e31461aa9c1a57e199c1e'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
