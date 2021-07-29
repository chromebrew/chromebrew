require 'package'

class Py3_pyte < Package
  description 'PyTE is a Simple VTXXX-compatible terminal emulator.'
  homepage 'https://github.com/selectel/pyte/'
  @_ver = '0.8.0'
  version @_ver
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/selectel/pyte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0_armv7l/py3_pyte-0.8.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0_armv7l/py3_pyte-0.8.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0_i686/py3_pyte-0.8.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0_x86_64/py3_pyte-0.8.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'db517d40a541ba10577ef864500d67b0799df7734e2f2c06d6475957a849d42b',
     armv7l: 'db517d40a541ba10577ef864500d67b0799df7734e2f2c06d6475957a849d42b',
       i686: '9749d97615fb44aeee633d1989ad64c72a6b61450d537fe8b716bd2fc6cad6c4',
     x86_64: '696b32d304152582824182624049ff495a9fc2557204e785cc89749e12bb3fd5'
  })

  depends_on 'py3_wcwidth'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
