require 'package'

class Py3_dbfread < Package
  description 'DBFread reads DBF Files with Python.'
  homepage 'https://dbfread.readthedocs.io/'
  @_ver = '2.0.7'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/olemb/dbfread.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7_armv7l/py3_dbfread-2.0.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7_armv7l/py3_dbfread-2.0.7-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7_x86_64/py3_dbfread-2.0.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3e249ab1b461e7eb1f29fcb37c2ca22284c5f19c59aeeebf3ecc90b5f3e42db6',
     armv7l: '3e249ab1b461e7eb1f29fcb37c2ca22284c5f19c59aeeebf3ecc90b5f3e42db6',
     x86_64: '7ca187db27a24dcec9416523dc6e1801e9126a61b55cf47980711e23d245eac0'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
