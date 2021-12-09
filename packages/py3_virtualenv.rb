require 'package'

class Py3_virtualenv < Package
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  @_ver = '20.8.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/virtualenv.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.8.1_armv7l/py3_virtualenv-20.8.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.8.1_armv7l/py3_virtualenv-20.8.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.8.1_i686/py3_virtualenv-20.8.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.8.1_x86_64/py3_virtualenv-20.8.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5bfc890516ced6667bd14ecde826643856e4dafe7134ade017f68d62e7dfca26',
     armv7l: '5bfc890516ced6667bd14ecde826643856e4dafe7134ade017f68d62e7dfca26',
       i686: '81a2f530bc213c8d96275794a63e1b7f8d989d35449c988e92fe243d8ff54b05',
     x86_64: '4a370e357a44ee9fa86930eb6281664a7110602bd8e34bc33aeaf3ca7eadc4fe'
  })

  depends_on 'py3_appdirs'
  depends_on 'py3_distlib'
  depends_on 'py3_six'
  depends_on 'py3_pip'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
