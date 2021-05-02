require 'package'

class Py3_pip < Package
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  @_ver = '21.0.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.0.1_armv7l/py3_pip-21.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.0.1_armv7l/py3_pip-21.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.0.1_i686/py3_pip-21.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.0.1_x86_64/py3_pip-21.0.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ce0f563a1f9a8fdd16c9d44263d42206742d8fbbc705f5a2a11973c234a96ac0',
     armv7l: 'ce0f563a1f9a8fdd16c9d44263d42206742d8fbbc705f5a2a11973c234a96ac0',
       i686: 'd782d6d8cf6a857ee31e07a304dd4d07223f30f3e2812e29deb4d1a7962cad51',
     x86_64: '729a9958cae998936dc3ca300feb7c10eb8d56f74b524913cc84cb1cf6bbe553'
  })

  depends_on 'python3'
  depends_on 'py3_setuptools'
  depends_on 'py3_wheel'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"

    # Make pip3 the default pip
    # FileUtils.ln_s "pip3", "#{CREW_DEST_PREFIX}/bin/pip" # This automatically happens
  end
end
