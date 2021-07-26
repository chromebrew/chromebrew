require 'package'

class Py3_pyicu < Package
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  @_ver = '2.7.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.pyicu.org/main/pyicu.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.3_armv7l/py3_pyicu-2.7.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.3_armv7l/py3_pyicu-2.7.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.3_x86_64/py3_pyicu-2.7.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c33368edcac29c591da25ada3005349ebc86a1013b821df6e459af2c08715dac',
     armv7l: 'c33368edcac29c591da25ada3005349ebc86a1013b821df6e459af2c08715dac',
     x86_64: '8243a2b5e225bc1001fa0392887ea122f47b01644f2e7b0cf68e5b355f6ab4c7'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
