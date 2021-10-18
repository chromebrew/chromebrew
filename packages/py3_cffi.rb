require 'package'

class Py3_cffi < Package
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  @_ver = '1.15.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/00/9e/92de7e1217ccc3d5f352ba21e52398372525765b2e0c4530e6eb2ba9282a/cffi-1.15.0.tar.gz'
  source_sha256 '920f0d66a896c2d99f0adbb391f990a84091179542c205fa53ce5787aff87954'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.0_armv7l/py3_cffi-1.15.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.0_armv7l/py3_cffi-1.15.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.0_x86_64/py3_cffi-1.15.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '262ba47fd9c537d67a47ff1960123d1e103f7dff9212d0d397870b3f7ffe5a2e',
     armv7l: '262ba47fd9c537d67a47ff1960123d1e103f7dff9212d0d397870b3f7ffe5a2e',
     x86_64: '14962629743c54cf9ccf97cb8f3d4b1561a817c91f55e01d1ae7908a306d488a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
