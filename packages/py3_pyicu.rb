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
    aarch64: '415b5709280c94e764f2ab42cfd89f2c33c39413253cb287b1ec897a0745cc6a',
     armv7l: '415b5709280c94e764f2ab42cfd89f2c33c39413253cb287b1ec897a0745cc6a',
       i686: 'f063c881ca7a432f1b2d1d23a117cec5a616dc340c1fe0ff0b936948260acf91',
     x86_64: 'ee5f21f9258cb515ad8d07ecff4c86522ccd63685c951198baa54427a86ddeb5'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
