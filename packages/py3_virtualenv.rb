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
    aarch64: 'fdfab3694a748e3cfaf44d870ae0753bdfcd552d7a2e9a59fb1de8dfe8a2802a',
     armv7l: 'fdfab3694a748e3cfaf44d870ae0753bdfcd552d7a2e9a59fb1de8dfe8a2802a',
       i686: '568621b1a43f4f937aa3256d1cc2a348d38871c53690cda86bae166ae055f28c',
     x86_64: '4a431791eb24c2da06401d75d8064ca9f75c4cbfaff84dec3bd7217eeca69ea9'
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
