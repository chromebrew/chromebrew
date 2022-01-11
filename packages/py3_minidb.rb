require 'package'

class Py3_minidb < Package
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'http://thp.io/2010/minidb/'
  @_ver = '2.0.5'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/thp/minidb.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5_armv7l/py3_minidb-2.0.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5_armv7l/py3_minidb-2.0.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5_i686/py3_minidb-2.0.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5_x86_64/py3_minidb-2.0.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7bf3d7fcf5e0d7e868504f2cb79f0f033e372da97fa9c67aacbaa71d433b149c',
     armv7l: '7bf3d7fcf5e0d7e868504f2cb79f0f033e372da97fa9c67aacbaa71d433b149c',
       i686: '4141447a1c6edfc9e942140d037783affd0fb590e8147260ba56e222115fa6fc',
     x86_64: '21ec8faa80892e6792e66d027a0a92027715f47686cbf4d3c178090d50a73e3b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
