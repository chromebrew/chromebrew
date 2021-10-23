require 'package'

class Py3_tox < Package
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  @_ver = '3.24.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tox-dev/tox.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4_armv7l/py3_tox-3.24.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4_armv7l/py3_tox-3.24.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4_i686/py3_tox-3.24.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4_x86_64/py3_tox-3.24.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e6cef20883e7bf2bf97af5eda794c4eb16afbe58ab4bd2b4d5fbf8dea7cb75f8',
     armv7l: 'e6cef20883e7bf2bf97af5eda794c4eb16afbe58ab4bd2b4d5fbf8dea7cb75f8',
       i686: '843e4cbaf36e2f4ccdc6daa27f1fe73681ba5dc83d95be3c477d0c084f3686f9',
     x86_64: 'cbe7a9e30156b8371f25439a0a94b05e4cfea660f079a188cdb6cf3da4f99056'
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
