require 'package'

class Py3_tox < Package
  description 'Toml is a Python Library for Tom\'s Obvious, Minimal Language.'
  homepage 'https://tox.readthedocs.io/'
  @_ver = '3.13.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tox-dev/tox.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.13.2_armv7l/py3_tox-3.13.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.13.2_armv7l/py3_tox-3.13.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.13.2_i686/py3_tox-3.13.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.13.2_x86_64/py3_tox-3.13.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '19f3b62f19149e5e952fa280628eaef7a787414bf2fa828bbad30e5f0bf7f0c8',
     armv7l: '19f3b62f19149e5e952fa280628eaef7a787414bf2fa828bbad30e5f0bf7f0c8',
       i686: 'b396ba791ab6828f30e15b27067bf58b5de20fe0cac6dc072fbfe4d8febe5836',
     x86_64: 'e43bf863121a5761105569e0bf515d873c779625ea82240d3a6254d29bc35436'
  })

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
