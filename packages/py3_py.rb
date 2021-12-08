require 'package'

class Py3_py < Package
  description 'Py is a library with cross-python path, ini-parsing, io, code, log facilities.'
  homepage 'https://py.readthedocs.io/'
  @_ver = '1.10.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_armv7l/py3_py-1.10.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_armv7l/py3_py-1.10.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_i686/py3_py-1.10.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_x86_64/py3_py-1.10.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '99bc10e10ff6dae52fcc1865c397a812b476cc8f2593576180b76e41aeb857db',
     armv7l: '99bc10e10ff6dae52fcc1865c397a812b476cc8f2593576180b76e41aeb857db',
       i686: 'd2e51388ffca680ac1d5b5dd4d4ed3889cdf386d8272b867852be2c48427e2a9',
     x86_64: '335654f047aad9a13d9b82650c7fb55d892e42e56f6987a3963d85bf8b72d619'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
