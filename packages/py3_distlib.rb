require 'package'

class Py3_distlib < Package
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  @_ver = '0.3.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://bitbucket.org/pypa/distlib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2_armv7l/py3_distlib-0.3.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2_armv7l/py3_distlib-0.3.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2_i686/py3_distlib-0.3.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2_x86_64/py3_distlib-0.3.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e68ff5d19d0e91e128b40feaba73ee092a2b086f06583b8f2a9c4604b5e31790',
     armv7l: 'e68ff5d19d0e91e128b40feaba73ee092a2b086f06583b8f2a9c4604b5e31790',
       i686: '526956a79711bda6a25e86cf0a387cf8e2c9f52ba3ff9a10536f52c85c4ab489',
     x86_64: '174bad9d25111143d4a67fd6979dbef6a3395b4cff41c7e09a83402563b80137'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
