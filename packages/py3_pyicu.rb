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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.4_x86_64/py3_pyicu-2.7.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '113ab0d2742d1bd74f63a3f7047c0f6693ee5304631694c5927c820e20ca5022',
     armv7l: '113ab0d2742d1bd74f63a3f7047c0f6693ee5304631694c5927c820e20ca5022',
     x86_64: '81692fdc014a1a17b08e4d2268ebb2d8868cdfba157b7d0950e64fda07f53211'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
