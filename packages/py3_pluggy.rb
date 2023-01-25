require 'package'

class Py3_pluggy < Package
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  @_ver = '1.0.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/pluggy.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0-py3.11_armv7l/py3_pluggy-1.0.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0-py3.11_armv7l/py3_pluggy-1.0.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0-py3.11_i686/py3_pluggy-1.0.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0-py3.11_x86_64/py3_pluggy-1.0.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b9c6dda535fa966376c8876e1ddc6b252390d6701dbe62a84d523c3366712b9e',
     armv7l: 'b9c6dda535fa966376c8876e1ddc6b252390d6701dbe62a84d523c3366712b9e',
       i686: '024465077f9aab8d778e25b659c2504ece1695856f906470edb25c01fa138b9a',
     x86_64: 'f6350fada307225ce3d70b8a8c35ed4cbf281704d45b53abdb85191f0d95c401'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
