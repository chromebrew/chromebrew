require 'package'

class Py3_distlib < Package
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  @_ver = '0.3.2'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://bitbucket.org/pypa/distlib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2-py3.11_armv7l/py3_distlib-0.3.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2-py3.11_armv7l/py3_distlib-0.3.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2-py3.11_i686/py3_distlib-0.3.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2-py3.11_x86_64/py3_distlib-0.3.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '202eb33f60faebc26b372531fcfe658dfbe0b074cb9468faf7380191893f11b8',
     armv7l: '202eb33f60faebc26b372531fcfe658dfbe0b074cb9468faf7380191893f11b8',
       i686: '85a9b318c24c1c31d1347b6a42381913ce20957356ea59fa5e4172d1262adca1',
     x86_64: 'edb08089d1d9a0610195fde860b88a22d1025beb3ef3f42c5e5fbb023eddae0a'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
