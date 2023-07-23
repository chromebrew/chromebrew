require 'package'

class Py2_pip < Package
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version '20.3.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_pip/20.3.4_armv7l/py2_pip-20.3.4-chromeos-armv7l.tar.xzz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_pip/20.3.4_armv7l/py2_pip-20.3.4-chromeos-armv7l.tar.xzz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_pip/20.3.4_i686/py2_pip-20.3.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_pip/20.3.4_x86_64/py2_pip-20.3.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '62d2b9126951628f2fd54bdfa3edcd67e6da21a60a42671e3523ed9ed87c734b',
     armv7l: '62d2b9126951628f2fd54bdfa3edcd67e6da21a60a42671e3523ed9ed87c734b',
       i686: '9dc11923ee4148311cb82442524700716044addacae4794b6fb2e31b56667d47',
     x86_64: 'e7ac1be2c32e23267f7df461b64716976e928308b61bd1991d51ce0a1166a294'
  })

  depends_on 'python2'
  depends_on 'py2_setuptools'
  depends_on 'py2_wheel'

  def self.build
    system "python2 setup.py build #{PY2_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python2 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"

    # Don't make pip2 the default pip
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/pip"
  end
end
