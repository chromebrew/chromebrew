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
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.0_i686/py3_cffi-1.15.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.0_x86_64/py3_cffi-1.15.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '368000042881c818921a56925b9ae04608bb2ab4c73ac7859458b292ba6a74aa',
     armv7l: '368000042881c818921a56925b9ae04608bb2ab4c73ac7859458b292ba6a74aa',
       i686: 'd8f9d3c0b03d08ef708208628bf0c4d0d3e2042f02df51ad8d7c28d65305b3e7',
     x86_64: 'e74a52a45def243f8a3893f71649f3782353b7ac283db636d9e44a2c8e3c2f90'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
