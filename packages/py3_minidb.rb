require 'package'

class Py3_minidb < Package
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'http://thp.io/2010/minidb/'
  @_ver = '2.0.5'
  version "#{@_ver}-py3.11"
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/thp/minidb.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5-py3.11_armv7l/py3_minidb-2.0.5-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5-py3.11_armv7l/py3_minidb-2.0.5-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5-py3.11_i686/py3_minidb-2.0.5-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5-py3.11_x86_64/py3_minidb-2.0.5-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e2747c1c4aeaaf68be847822aa01b134a42c78a917a731541e2fb568d72d1ecb',
     armv7l: 'e2747c1c4aeaaf68be847822aa01b134a42c78a917a731541e2fb568d72d1ecb',
       i686: 'd7063ff14b25654bb60f9adeff290a6805e2dacec3518a82dfba6792ab81cbbf',
     x86_64: 'fd86795705d4f6c4270a2ed682c2b87903eb00fb3759b78f9cc6190f946de10b'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
