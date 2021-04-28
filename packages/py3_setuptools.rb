require 'package'

class Py3_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '56.0.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://files.pythonhosted.org/packages/f6/e9/19af16328705915233299f6f1f02db95899fb00c75ac9da4757aa1e5d1de/setuptools-#{@_ver}.tar.gz"
  source_sha256 '08a1c0f99455307c48690f00d5c2ac2c1ccfab04df00454fef854ec145b81302'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/56.0.0_armv7l/py3_setuptools-56.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/56.0.0_armv7l/py3_setuptools-56.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/56.0.0_i686/py3_setuptools-56.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/56.0.0_x86_64/py3_setuptools-56.0.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cde5ae8e09778d2572b52c27ea041e2d8ab6ba5a820e5761cf079e774e8e4711',
     armv7l: 'cde5ae8e09778d2572b52c27ea041e2d8ab6ba5a820e5761cf079e774e8e4711',
       i686: '8688b51233a4008fc8dc3a19f4f38c6b687e3fbb118ff9aaa0cc092701ce538e',
     x86_64: '2187bee0484f7486ef5f18fbc93c7d8235b6d3985c58eadd6aabf59341720096'
  })

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
