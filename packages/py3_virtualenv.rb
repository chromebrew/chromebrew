require 'package'

class Py3_virtualenv < Package
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  @_ver = '20.0.27'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/virtualenv.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.0.27_armv7l/py3_virtualenv-20.0.27-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.0.27_armv7l/py3_virtualenv-20.0.27-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.0.27_x86_64/py3_virtualenv-20.0.27-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '03e01c5dde9ad6ae1b6e07ec39f928cf7840fba64263569400b61c969915bc3f',
     armv7l: '03e01c5dde9ad6ae1b6e07ec39f928cf7840fba64263569400b61c969915bc3f',
     x86_64: '907e4a92284aea8eee071b823e86803d96ef191793521343ed06cfdc4bc8eae8'
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
