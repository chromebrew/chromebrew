require 'package'

class Py3_fasteners < Package
  description 'Fasteners provides useful locks for python programs.'
  homepage 'https://github.com/harlowja/fasteners/'
  @_ver = '0.15'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/harlowja/fasteners.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.15_armv7l/py3_fasteners-0.15-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.15_armv7l/py3_fasteners-0.15-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.15_x86_64/py3_fasteners-0.15-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '847f56cbe17a28de5bd78fcf9d69ea5db05fd011e035b70c28051444216460e4',
     armv7l: '847f56cbe17a28de5bd78fcf9d69ea5db05fd011e035b70c28051444216460e4',
     x86_64: 'cd2fdf2690b0acd28063048c4653f887237da16e44ea756f33af18916cbb0cd6'
  })

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
