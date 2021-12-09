require 'package'

class Py3_pyicu < Package
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  @_ver = '2.7.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.pyicu.org/main/pyicu.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.4_armv7l/py3_pyicu-2.7.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.4_armv7l/py3_pyicu-2.7.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.4_i686/py3_pyicu-2.7.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.4_x86_64/py3_pyicu-2.7.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '55e7d497efb527c6062625712badc3d96231af45198be87044896d5d607cfca8',
     armv7l: '55e7d497efb527c6062625712badc3d96231af45198be87044896d5d607cfca8',
       i686: '7660fbca6f2b3e7bc1bdea1f469667a45a29f3586089bebb62a354d997d194c7',
     x86_64: '1185201e529b2566f7cf5167cae6b61717c82a77a6a1353b19d8dd39d912e629'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
