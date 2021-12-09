require 'package'

class Py3_nuitka < Package
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  @_ver = '0.6.17.2'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.17.2_armv7l/py3_nuitka-0.6.17.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.17.2_armv7l/py3_nuitka-0.6.17.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.17.2_i686/py3_nuitka-0.6.17.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.17.2_x86_64/py3_nuitka-0.6.17.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e7b1cf49bba389bb9d4022e33f142dce6cb8238640ab66215e5f87320a2efc24',
     armv7l: 'e7b1cf49bba389bb9d4022e33f142dce6cb8238640ab66215e5f87320a2efc24',
       i686: 'ac254fd32d7b2cb3e258e8a5abcc0b3424de67f90cc6802f393042108f2e0d06',
     x86_64: 'd9f3030fa1f7bea0b9daac1dd2ae6fd2e7cd4cd469ee30ecd70f167c705206c7'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
