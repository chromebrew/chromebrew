require 'package'

class Py3_dbfread < Package
  description 'DBFread reads DBF Files with Python.'
  homepage 'https://dbfread.readthedocs.io/'
  @_ver = '2.0.7'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/olemb/dbfread.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-1_armv7l/py3_dbfread-2.0.7-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-1_armv7l/py3_dbfread-2.0.7-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-1_i686/py3_dbfread-2.0.7-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-1_x86_64/py3_dbfread-2.0.7-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '734751de592809ba5cc9feecec3a80de989b30f65af292895b59d58469336245',
     armv7l: '734751de592809ba5cc9feecec3a80de989b30f65af292895b59d58469336245',
       i686: '74c5cb16c4471b471b458e7153dda56e81a6fc5105deb33b8c692cd8a5954aed',
     x86_64: '24fb4358e053b0fc159d0a3179ac1e4803ffdfef261254fd7ec8fbad5de981ab'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
