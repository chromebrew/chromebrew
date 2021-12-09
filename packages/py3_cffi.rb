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
    aarch64: 'd98d10a7bfc0bbd722e3393b00a56d2295b8d946596d4f2f34d336ad77ac6db0',
     armv7l: 'd98d10a7bfc0bbd722e3393b00a56d2295b8d946596d4f2f34d336ad77ac6db0',
       i686: '2f0edc72092b7964dfd2a4d5d8c28dff88126f0f6f93f6c4d4a7855305c07584',
     x86_64: '871e834b08e282b6324df52853b7313de281fac7ee1e1b9cd0837ed5627a0038'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
