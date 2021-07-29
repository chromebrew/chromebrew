require 'package'

class Py3_minidb < Package
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'http://thp.io/2010/minidb/'
  @_ver = '2.0.4'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/thp/minidb.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.4_armv7l/py3_minidb-2.0.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.4_armv7l/py3_minidb-2.0.4-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.4_x86_64/py3_minidb-2.0.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f24b36350a476fb5b19cd6b80539a56bdb55dbfe6b06457033f5c4e2a3a6a2ab',
     armv7l: 'f24b36350a476fb5b19cd6b80539a56bdb55dbfe6b06457033f5c4e2a3a6a2ab',
     x86_64: 'a25902253e19f270ead0504e21ba738415c1a116fb3a7dd2a8d18897522d8681'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
