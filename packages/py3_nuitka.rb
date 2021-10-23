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
    aarch64: 'a0868e9cd881b420f587193831e8d441bfac4bb552048247a8719071a470b26a',
     armv7l: 'a0868e9cd881b420f587193831e8d441bfac4bb552048247a8719071a470b26a',
       i686: '7eed5251cd2331a0366ab2241202014221764d68bee5f82c4354b7881ed1ee1f',
     x86_64: 'feda666619d2f2b0070c8f43b387aad871f80ebb82fafdc26867b97ad10a4324'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
